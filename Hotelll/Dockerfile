# Sử dụng Tomcat 10 (tương thích Jakarta EE 9/10)
FROM tomcat:10.1-jdk17

# Xóa các app mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy toàn bộ cấu trúc dự án Java Web vào thư mục ROOT của Tomcat
# Chú ý: Cấu trúc của NetBeans/Ant đôi khi cần build ra file .war
# Tuy nhiên, Koyeb hỗ trợ copy trực tiếp thư mục `build/web` (nếu bạn đã build)
COPY ./build/web /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
