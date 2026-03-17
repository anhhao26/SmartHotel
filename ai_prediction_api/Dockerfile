# Sử dụng Python 3.10 slim
FROM python:3.10-slim

# Cài đặt các gói cần thiết cho hệ điều hành (Bao gồm Microsoft ODBC Driver 17)
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unixodbc \
    unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy requirement và cài đặt thư viện python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy bộ source code
COPY . .

# Mở port 5000 
EXPOSE 5000

# Lệnh chạy ứng dụng bằng Gunicorn thay vì Flask default
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]
