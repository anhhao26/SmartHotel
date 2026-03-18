# Đổi sang dùng eclipse-temurin:17-jdk và cài ant thủ công
FROM eclipse-temurin:17-jdk AS build

# Cài đặt Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy mã nguồn dự án vào container
COPY . .

# Chạy lệnh Build của NetBeans (Ant)
RUN ant -f build.xml default

# 2. Môi trường Chạy dùng Tomcat 10
FROM tomcat:10.1-jdk17

# Xóa các app mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Lấy kết quả đã build từ bước 1 (thư mục build/web) đưa vào Tomcat ROOT
COPY --from=build /app/build/web /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
