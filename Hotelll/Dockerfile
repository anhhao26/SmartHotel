# Sử dụng Tomcat 10 (tương thích Jakarta EE 9/10)
FROM tomcat:10.1-jdk17

# Đổi port Tomcat từ 8080 sang 8000 để phù hợp với mặc định của Koyeb Health Check
RUN sed -i 's/port="8080"/port="8000"/g' /usr/local/tomcat/conf/server.xml

# Xóa các app mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy toàn bộ cấu trúc dự án Java Web vào thư mục ROOT của Tomcat
COPY ./build/web /usr/local/tomcat/webapps/ROOT/

# XÓA file jakartaee-web-api.jar để tránh xung đột với thư viện lõi của Tomcat (Nguyên nhân gây lỗi Filter)
RUN rm -f /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/jakarta.jakartaee-web-api-*.jar

# XÓA file context.xml để ép Tomcat chạy Web ở thư mục Gốc (/) thay vì (/Hotelll)
RUN rm -f /usr/local/tomcat/webapps/ROOT/META-INF/context.xml

EXPOSE 8000
CMD ["catalina.sh", "run"]
