package controller;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.TimeZone;

/**
 * Listener này chạy ngay khi Tomcat khởi động ứng dụng.
 * Mục đích: Set JVM timezone = "Asia/Ho_Chi_Minh" (UTC+7)
 * để VNPay không bị lỗi code=15 (Giao dịch hết hạn) khi
 * deploy trên server nước ngoài (Koyeb, Render, v.v.) - UTC+0.
 */
@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
        System.out.println("[SmartHotel] JVM Default TimeZone set to: "
                + TimeZone.getDefault().getID()
                + " (UTC+7 Vietnam)");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // nothing
    }
}
