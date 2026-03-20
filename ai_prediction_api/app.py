import os
from flask import Flask, jsonify
from flask_cors import CORS
import pyodbc
from flask import request
import google.generativeai as genai
from google.api_core.exceptions import ResourceExhausted
from dotenv import load_dotenv

# Load các biến môi trường từ file .env
load_dotenv()

# ==========================================
# CẤU HÌNH NHIỀU API KEY (LUÂN PHIÊN KHI HẾT HẠN MỨC)
# ==========================================
# Lấy danh sách key từ file .env (cách nhau bởi dấu phẩy)
api_keys_env = os.environ.get("GEMINI_API_KEYS", os.environ.get("GEMINI_API_KEY", ""))
GEMINI_API_KEYS = [k.strip() for k in api_keys_env.split(",") if k.strip()]
current_key_index = 0

if GEMINI_API_KEYS:
    genai.configure(api_key=GEMINI_API_KEYS[current_key_index])
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from datetime import datetime
from dateutil.relativedelta import relativedelta
import time

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
        r"TrustServerCertificate=yes;"
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

# Cache dữ liệu DB trong 5 phút để tránh quá tải SQL Server
CONTEXT_CACHE_TTL = 300
_cached_context = None
_context_last_updated = 0

def get_hotel_context():
    """Hàm lấy thông tin mô tả khách sạn và tình trạng phòng từ DB để huấn luyện AI"""
    global _cached_context, _context_last_updated
    current_time = time.time()
    
    # Nếu cache vẫn còn hạn (dưới 5 phút) thì dùng luôn, không truy vấn DB nữa
    if _cached_context and (current_time - _context_last_updated) < CONTEXT_CACHE_TTL:
        return _cached_context

    try:
        # 1. Lấy thông tin phòng
        query_rooms = """
            SELECT t.TypeName, r.Price, COUNT(r.RoomID) as AvailableCount
            FROM RoomTypes t
            JOIN Rooms r ON t.RoomTypeID = r.RoomTypeID AND r.Status = 'Available'
            GROUP BY t.TypeName, r.Price
        """
        df_rooms = execute_query(query_rooms)
        rooms_info = []
        total_available = 0
        for index, row in df_rooms.iterrows():
            price = row['Price']
            count = int(row['AvailableCount'])
            total_available += count
            
            if pd.notna(price):
                formatted_price = "{:,.0f} VNĐ".format(float(price))
            else:
                formatted_price = "Liên hệ"
                
            rooms_info.append(f"- Loại phòng: {row['TypeName']} | Giá: {formatted_price} | Hiện còn trống: {count} phòng")
        
        rooms_str = "\n".join(rooms_info)

        # 2. Lấy thông tin hàng hóa (Mặt hàng thương mại / Đang bán)
        query_inventory = """
            SELECT ItemName, SellingPrice, Quantity 
            FROM Inventory 
            WHERE IsTradeGood = 1 AND Quantity > 0
        """
        df_inv = execute_query(query_inventory)
        items_info = []
        for index, row in df_inv.iterrows():
            selling_price = row['SellingPrice']
            qty = int(row['Quantity'])
            if pd.notna(selling_price):
                formatted_price = "{:,.0f} VNĐ".format(float(selling_price))
            else:
                formatted_price = "Liên hệ"
            items_info.append(f"- Hàng hóa: {row['ItemName']} | Giá bán: {formatted_price} | Còn: {qty} sản phẩm")
            
        items_str = "\n".join(items_info)
        if not items_info:
            items_str = "- Hiện tại khách sạn không kinh doanh hoặc tạm hết hàng hóa/quà lưu niệm."

        # 3. Lấy thông tin lịch đặt phòng sắp tới (30 ngày tới) để báo lịch trống
        query_bookings = """
            SELECT r.RoomNumber, t.TypeName, b.CheckInDate, b.CheckOutDate
            FROM Bookings b
            JOIN Rooms r ON b.RoomID = r.RoomID
            JOIN RoomTypes t ON r.RoomTypeID = t.RoomTypeID
            WHERE b.Status IN ('Pending', 'Confirmed', 'Checked-in')
              AND b.CheckOutDate >= CAST(GETDATE() AS DATE)
              AND b.CheckInDate <= DATEADD(day, 30, CAST(GETDATE() AS DATE))
            ORDER BY b.CheckInDate
        """
        df_bookings = execute_query(query_bookings)
        bookings_info = []
        for index, row in df_bookings.iterrows():
            check_in = row['CheckInDate'].strftime("%d/%m") if pd.notnull(row['CheckInDate']) else ""
            check_out = row['CheckOutDate'].strftime("%d/%m") if pd.notnull(row['CheckOutDate']) else ""
            bookings_info.append(f"- Phòng {row['RoomNumber']} ({row['TypeName']}) ĐÃ KÍN từ {check_in} đến {check_out}.")
        
        bookings_str = "\n".join(bookings_info)
        if not bookings_info:
            bookings_str = "- Trong 30 ngày tới, tất cả các phòng đều đang hoàn toàn trống và có thể đặt tự do."

        context = f"""
Thông tin về SmartHotel (Hôm nay: {datetime.now().strftime('%d/%m/%Y')}):
1. Hiện trạng phòng NGAY TẠI TRƯỜNG HỢP HIỆN TẠI (Tổng số CÒN TRỐNG: {total_available} phòng):
{rooms_str}

2. Lịch đặt phòng ĐÃ KÍN trong 30 ngày tới (Người dùng muốn hỏi lịch trống thì phải trừ đi các ngày này):
{bookings_str}

3. Danh sách dịch vụ/hàng hóa đang bán tại khách sạn:
{items_str}

- Các dịch vụ khác: Hồ bơi, Nhà hàng, Spa.
- Check-in: 14:00, Check-out: 12:00.
"""
        # Lưu vào cache
        _cached_context = context
        _context_last_updated = current_time
        return context
    except Exception as e:
        print("LDB:", e)
        # Nếu SQL lỗi nhưng có cache cũ, trả về thông tin cũ thay vì báo lỗi cứng ngắc
        if _cached_context:
            return _cached_context
        return "SmartHotel là một khách sạn cao cấp. Lỗi kết nối CSDL khi kiểm tra phòng trống."

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

# ==========================================
# API 3: XỬ LÝ CHATBOT AI
# ==========================================
@app.route('/api/chat', methods=['POST', 'OPTIONS'])
def chat():
    # CORS (Xử lý preflight request từ Vue/React/Fetch API)
    if request.method == "OPTIONS":
        return jsonify({"status": "success"}), 200

    try:
        data = request.json
        user_message = data.get("message", "")
        history_data = data.get("history", [])

        if not user_message:
            return jsonify({"status": "error", "message": "Tin nhắn không được bỏ trống"}), 400

        if not GEMINI_API_KEYS:
            return jsonify({"status": "error", "message": "Chưa cấu hình GEMINI_API_KEYS"}), 500

        # Lấy thông tin ngữ cảnh khách sạn từ Database
        hotel_context = get_hotel_context()

        system_prompt = f"""Bạn là trợ lý ảo lịch sự của khách sạn SmartHotel. 
Quy tắc: 
1. Chỉ trả lời các câu hỏi liên quan đến khách sạn, dịch vụ, thông tin phòng,. 
2. KHÔNG trả lời hay yêu cầu mã CCCD, thẻ tín dụng, thông tin cá nhân của khách. 
3. Dưới đây là thông tin hiện tại của hệ thống khách sạn mà bạn cần ghi nhớ để tư vấn:
{hotel_context}"""

        # Chuẩn hoá history data
        formatted_history = []
        for msg in history_data:
            role = msg.get("role", "user")
            parts = msg.get("parts", [])
            if parts:
                formatted_history.append({"role": role, "parts": parts})
                
        # [TỐI ƯU CỰC KỲ QUAN TRỌNG] - Cắt giảm memory để AI không bị tốn Token
        # Chỉ giữ lại 10 đoạn hội thoại gần nhất (5 câu hỏi - 5 câu trả lời)
        formatted_history = formatted_history[-10:]

        global current_key_index
        attempts = 0
        total_keys = len(GEMINI_API_KEYS)
        
        while attempts < total_keys:
            try:
                # Thử gọi API với key hiện tại
                model = genai.GenerativeModel('gemini-2.5-flash', system_instruction=system_prompt)
                
                # Khởi tạo chat session với lịch sử hội thoại
                chat_session = model.start_chat(history=formatted_history)
                response = chat_session.send_message(user_message, generation_config={"temperature": 0.7, "max_output_tokens": 300})
                
                reply = response.text.strip()
                return jsonify({
                    "status": "success",
                    "reply": reply
                })
            
            except ResourceExhausted:
                # Nếu bị lỗi hết hạn mức (Quota 429), chuyển sang key tiếp theo
                print(f"Key thứ {current_key_index + 1} hết hạn mức, đang đổi sang key khác...")
                current_key_index = (current_key_index + 1) % total_keys
                genai.configure(api_key=GEMINI_API_KEYS[current_key_index])
                attempts += 1
            except ValueError as ve:
                # Xử lý block an toàn (Safety Ratings)
                if "safety" in str(ve).lower() or "part" in str(ve).lower():
                    return jsonify({
                        "status": "error",
                        "reply": "Rất xin lỗi, câu hỏi này chứa nội dung vi phạm chính sách an toàn nên tôi không thể trả lời.",
                        "message": "Nội dung bị chặn bởi Safety Policy của Gemini."
                    }), 400
                raise ve
            except Exception as e:
                # Các lỗi khác (Không phải do quota) thì ném ra ngay
                raise e

        # Nếu vòng lặp kết thúc mà vẫn fail -> Tất cả key đều hết hạn mức
        return jsonify({
            "status": "error", 
            "reply": "Rất tiếc, hệ thống tổng đài AI hiện tại đang quá tải (Tất cả tài khoản đều đã hết hạn mức). Vui lòng thử lại sau.",
            "message": "Hệ thống AI quá tải / Hết hạn mức API."
        }), 429

    except Exception as e:
        print(f"Lỗi AI: {str(e)}")
        return jsonify({
            "status": "error", 
            "reply": "Xin lỗi, hệ thống AI đang bảo trì hoặc gặp lỗi. Vui lòng liên hệ lễ tân.",
            "message": "Lỗi phần mềm AI Server.",
            "details": str(e)
        }), 500

if __name__ == '__main__':
    # THIẾT LẬP DEPLOY MODE
    port = int(os.environ.get("PORT", 5000))
    debug_mode = os.environ.get("FLASK_DEBUG", "True").lower() in ['true', '1']
    
    # Sử dụng host='0.0.0.0' để app có thể nhận request từ bên ngoài container (Ví dụ: Docker, VPS)
    app.run(host='0.0.0.0', port=port, debug=debug_mode)

