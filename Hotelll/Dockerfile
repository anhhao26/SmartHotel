# ========== STAGE 1: Build - Compile Java Source ==========
FROM eclipse-temurin:17-jdk AS builder

# Cài ant để compile project NetBeans (không cần NetBeans IDE)
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy toàn bộ dự án vào container
COPY Hotelll/ .

# Copy thư viện jar của Tomcat vào để compile
COPY --from=tomcat:10.1-jdk17 /usr/local/tomcat/lib /tomcat-lib

# Compile tất cả file Java từ src/
RUN mkdir -p build/web/WEB-INF/classes && \
    find src/java -name "*.java" | xargs javac \
      -encoding UTF-8 \
      -cp "build/web/WEB-INF/lib/*:/tomcat-lib/*" \
      -d build/web/WEB-INF/classes

# ========== STAGE 2: Run - Tomcat ==========
FROM tomcat:10.1-jdk17

# Đổi port Tomcat sang 8000 cho Koyeb Health Check
RUN sed -i 's/port="8080"/port="8000"/g' /usr/local/tomcat/conf/server.xml

# Xóa app mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy toàn bộ web app (JSP, assets, WEB-INF/lib...) từ stage 1
COPY --from=builder /app/build/web /usr/local/tomcat/webapps/ROOT/

# Xóa jakarta ee jar tránh xung đột với thư viện lõi của Tomcat
RUN rm -f /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/jakarta.jakartaee-web-api-*.jar

# Xóa context.xml để chạy ở thư mục gốc (/) thay vì (/Hotelll)
RUN rm -f /usr/local/tomcat/webapps/ROOT/META-INF/context.xml

# Bật log Tomcat ra Console
RUN sed -i 's/2localhost.org.apache.juli.AsyncFileHandler/java.util.logging.ConsoleHandler/g' /usr/local/tomcat/conf/logging.properties

EXPOSE 8000
CMD ["catalina.sh", "run"]
