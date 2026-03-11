package com.smarthotel.util;

import com.smarthotel.model.Booking;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.text.SimpleDateFormat;
import java.util.Properties;

public class EmailUtil {

    // ⚠️ QUAN TRỌNG: Cấu hình email của hệ thống Khách sạn
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    private static final String EMAIL = "anhhaoqk@gmail.com"; 
    private static final String PASSWORD = "wjofjosclewtcpky"; // Mật khẩu ứng dụng đã chuẩn hóa

    public static boolean sendPaymentSuccessEmail(Booking booking) {
        // Kiểm tra xem khách có email không, nếu không thì bỏ qua
        if (booking.getCustomer() == null || booking.getCustomer().getEmail() == null || booking.getCustomer().getEmail().isEmpty()) {
            System.err.println("Không thể gửi email: Khách hàng chưa cập nhật địa chỉ email!");
            return false;
        }

        String toEmail = booking.getCustomer().getEmail();
        String customerName = booking.getCustomer().getFullName();
        String roomNumber = booking.getRoom().getRoomNumber();
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String checkIn = sdf.format(booking.getCheckInDate());
        String checkOut = sdf.format(booking.getCheckOutDate());

        Properties props = new Properties();
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        
        // BẮT BUỘC THÊM 2 DÒNG NÀY ĐỂ VƯỢ QUA BẢO MẬT GOOGLE
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(EMAIL, "SmartHotel System"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject("Xác nhận thanh toán thành công - SmartHotel");
            msg.setHeader("Content-Type", "text/html; charset=UTF-8");

            // Thiết kế giao diện nội dung Email (HTML)
            String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden;'>"
                    + "<div style='background-color: #1069f9; padding: 20px; text-align: center; color: white;'>"
                    + "<h2 style='margin: 0;'>Xác nhận Đặt phòng & Thanh toán</h2>"
                    + "</div>"
                    + "<div style='padding: 20px;'>"
                    + "<p>Kính chào <b>" + customerName + "</b>,</p>"
                    + "<p>Cảm ơn bạn đã lựa chọn SmartHotel. Chúng tôi xin thông báo giao dịch thanh toán qua VNPay của bạn đã <b>THÀNH CÔNG</b>.</p>"
                    + "<table style='width: 100%; border-collapse: collapse; margin-top: 15px;'>"
                    + "<tr><td style='padding: 8px; border-bottom: 1px solid #ddd;'><b>Mã hóa đơn:</b></td><td style='padding: 8px; border-bottom: 1px solid #ddd;'>#BK-" + booking.getBookingID() + "</td></tr>"
                    + "<tr><td style='padding: 8px; border-bottom: 1px solid #ddd;'><b>Phòng:</b></td><td style='padding: 8px; border-bottom: 1px solid #ddd;'>P." + roomNumber + "</td></tr>"
                    + "<tr><td style='padding: 8px; border-bottom: 1px solid #ddd;'><b>Thời gian:</b></td><td style='padding: 8px; border-bottom: 1px solid #ddd;'>Từ " + checkIn + " đến " + checkOut + "</td></tr>"
                    + "<tr><td style='padding: 8px; border-bottom: 1px solid #ddd;'><b>Tổng thanh toán:</b></td><td style='padding: 8px; border-bottom: 1px solid #ddd; color: #10b981; font-weight: bold;'>" + String.format("%,.0f", booking.getTotalAmount()) + " VNĐ</td></tr>"
                    + "</table>"
                    + "<p style='margin-top: 20px;'>Khi đến nhận phòng, vui lòng đọc số điện thoại hoặc CCCD tại quầy lễ tân.</p>"
                    + "<p>Chúc bạn có một kỳ nghỉ tuyệt vời!</p>"
                    + "</div>"
                    + "<div style='background-color: #f6f8f7; padding: 15px; text-align: center; font-size: 12px; color: #888;'>"
                    + "Trân trọng, <br><b>Đội ngũ SmartHotel</b>"
                    + "</div>"
                    + "</div>";

            msg.setContent(htmlContent, "text/html; charset=UTF-8");
            
            System.out.println("Đang kết nối SMTP gửi mail cho: " + toEmail + "...");
            Transport.send(msg);
            System.out.println("GỬI MAIL THÀNH CÔNG CHO: " + toEmail);
            
            return true;
        } catch (Exception e) {
            System.err.println("LỖI GỬI EMAIL: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}