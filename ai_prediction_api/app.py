import os
from flask import Flask, jsonify
from flask_cors import CORS
import pyodbc
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from datetime import datetime
from dateutil.relativedelta import relativedelta

app = Flask(__name__)
CORS(app) # Cho phép Java hoặc giao diện Web gọi API này

# ==========================================
# CẤU HÌNH KẾT NỐI SQL SERVER (TỐI ƯU CHO DEPLOY)
# ==========================================
# Sử dụng biến môi trường (Environment Variables) để bảo mật khi deploy
# Không để lộ thông tin nhạy cảm (Username/Password) trên GitHub
DB_SERVER = os.environ.get("DB_SERVER", "localhost")  # Tên server mặc định khi chạy local
DB_NAME = os.environ.get("DB_NAME", "ASMDB_nhom5")
DB_USER = os.environ.get("DB_USER", "")
DB_PASS = os.environ.get("DB_PASS", "")

if DB_USER and DB_PASS:
    # Chuỗi kết nối dùng SQL Server Authentication (Phổ biến khi deploy lên máy chủ)
    DB_CONN_STR = (
        r"Driver={ODBC Driver 17 for SQL Server};"
        f"Server={DB_SERVER};"
        f"Database={DB_NAME};"
        f"UID={DB_USER};"
        f"PWD={DB_PASS};"
    )
else:
    # Chuỗi kết nối dùng Windows Authentication (Chạy cục bộ)
    DB_CONN_STR = (
        r"Driver={ODBC Driver 17 for SQL Server};"
        f"Server={DB_SERVER};"
        f"Database={DB_NAME};"
        r"Trusted_Connection=yes;"
    )

def execute_query(query):
    """
    Hàm chung để thực thi query và trả về DataFrame.
    Sử dụng try-finally để đảm bảo luôn đóng kết nối (Tránh lỗi tràn connection pool khi deploy).
    """
    conn = pyodbc.connect(DB_CONN_STR)
    try:
        df = pd.read_sql(query, conn)
    finally:
        conn.close()
    return df

def predict_time_series(df, target_column, is_integer_output=False):
    """
    [TỐI ƯU HÓA] - Đóng gói logic huấn luyện AI thành một hàm dùng chung
    áp dụng DRY (Don't Repeat Yourself) giúp bảo trì dễ dàng hơn.
    """
    if len(df) < 2:
        raise ValueError("Không đủ dữ liệu lịch sử để dự đoán (cần ít nhất 2 tháng có dữ liệu).")

    # Tạo cột ngày mùng 1 của từng tháng để dễ xử lý
    df['Date'] = pd.to_datetime(df[['Year', 'Month']].assign(DAY=1))
    
    # [FIX: XỬ LÝ LỖI TRỐNG THÁNG] 
    # Nếu có tháng không có khách sạn nào được đặt, DB sẽ không trả về dòng của tháng đó.
    # Cần phải chèn các tháng bị thiếu vào DataFrame với giá trị 0.
    df.set_index('Date', inplace=True)
    all_months = pd.date_range(start=df.index.min(), end=df.index.max(), freq='MS') # MS = Month Start
    df = df.reindex(all_months)
    df.index.name = 'Date'
    df = df.reset_index()
    
    df['Year'] = df['Date'].dt.year
    df['Month'] = df['Date'].dt.month
    df[target_column] = df[target_column].fillna(0)

    df['TimeIndex'] = np.arange(len(df)) # Đánh số thứ tự để nhận biết xu hướng (Trend)
    
    # [NÂNG CẤP AI] - Giải quyết bài toán mùa vụ (Seasonality) bằng One-Hot Encoding
    for m in range(1, 13):
        df[f'Month_{m}'] = (df['Month'] == m).astype(int)
        
    features = ['TimeIndex'] + [f'Month_{m}' for m in range(1, 13)]
    
    # 1. Huấn luyện AI model (Linear Regression)
    X = df[features]
    y = df[target_column]
    
    model = LinearRegression()
    model.fit(X, y)
    
    # 2. Xử lý yêu cầu: 3 tháng trước + tháng hiện tại (Tối đa 4 tháng thực tế gần nhất để vẽ chart)
    last_n_months_df = df.tail(min(4, len(df))).copy()
    
    # 3. Dự đoán 12 tháng tiếp theo
    last_date = df['Date'].iloc[-1]
    last_index = df['TimeIndex'].iloc[-1]
    
    future_dates = [last_date + relativedelta(months=i) for i in range(1, 13)]
    future_indices = [last_index + i for i in range(1, 13)]
    future_months = [d.month for d in future_dates]
    
    X_future = pd.DataFrame({'TimeIndex': future_indices, 'Month': future_months})
    for m in range(1, 13):
        X_future[f'Month_{m}'] = (X_future['Month'] == m).astype(int)
        
    predictions = model.predict(X_future[features])
    
    # Làm tròn và đảm bảo giá trị không bị âm
    if is_integer_output:
        predictions = [max(0, int(round(val, 0))) for val in predictions]
    else:
        predictions = [max(0, round(val, 2))] if target_column == 'something' else [max(0, round(val, 0)) for val in predictions]

    # 4. Gom dữ liệu để trả về dạng JSON để vẽ đồ thị
    labels = []
    actual_data = []    
    predict_data = []   

    for index, row in last_n_months_df.iterrows():
        labels.append(row['Date'].strftime("%m/%Y"))
        val = int(row[target_column]) if is_integer_output else float(row[target_column])
        actual_data.append(val)
        predict_data.append(None) 
        
    # Điểm nối quan trọng: điểm cuối cùng của đường thực tế sẽ là điểm bắt đầu của đường dự đoán
    predict_data[-1] = actual_data[-1]

    for i, dt in enumerate(future_dates):
        labels.append(dt.strftime("%m/%Y"))
        actual_data.append(None) 
        predict_data.append(predictions[i])
        
    return labels, actual_data, predict_data

# ==========================================
# API 1: DỰ ĐOÁN DOANH THU
# ==========================================
@app.route('/api/predict-revenue', methods=['GET'])
def predict_revenue():
    try:
        query = """
            SELECT 
                YEAR(CheckInDate) AS Year, 
                MONTH(CheckInDate) AS Month, 
                SUM(TotalAmount) AS MonthlyRevenue
            FROM Bookings
            WHERE Status != 'Cancelled' AND TotalAmount IS NOT NULL
            GROUP BY YEAR(CheckInDate), MONTH(CheckInDate)
            ORDER BY Year, Month
        """
        df = execute_query(query)
        labels, actual_data, predict_data = predict_time_series(df, 'MonthlyRevenue', is_integer_output=False)

        return jsonify({
            "status": "success",
            "data": {
                "labels": labels,
                "actual_revenue": actual_data,
                "predicted_revenue": predict_data
            }
        })
    except ValueError as ve:
        return jsonify({"status": "error", "message": str(ve)}), 400
    except Exception as e:
        return jsonify({"status": "error", "message": f"Lỗi hệ thống: {str(e)}"}), 500

# ==========================================
# API 2: DỰ ĐOÁN SỐ LƯỢNG PHÒNG ĐƯỢC ĐẶT
# ==========================================
@app.route('/api/predict-bookings', methods=['GET'])
def predict_bookings():
    try:
        query = """
            SELECT 
                YEAR(CheckInDate) AS Year, 
                MONTH(CheckInDate) AS Month, 
                COUNT(BookingID) AS MonthlyBookings
            FROM Bookings
            WHERE Status != 'Cancelled'
            GROUP BY YEAR(CheckInDate), MONTH(CheckInDate)
            ORDER BY Year, Month
        """
        df = execute_query(query)
        labels, actual_data, predict_data = predict_time_series(df, 'MonthlyBookings', is_integer_output=True)

        return jsonify({
            "status": "success",
            "data": {
                "labels": labels,
                "actual_bookings": actual_data,
                "predicted_bookings": predict_data
            }
        })
    except ValueError as ve:
        return jsonify({"status": "error", "message": str(ve)}), 400
    except Exception as e:
        return jsonify({"status": "error", "message": f"Lỗi hệ thống: {str(e)}"}), 500

if __name__ == '__main__':
    # THIẾT LẬP DEPLOY MODE
    port = int(os.environ.get("PORT", 5000))
    debug_mode = os.environ.get("FLASK_DEBUG", "True").lower() in ['true', '1']
    
    # Sử dụng host='0.0.0.0' để app có thể nhận request từ bên ngoài container (Ví dụ: Docker, VPS)
    app.run(host='0.0.0.0', port=port, debug=debug_mode)

