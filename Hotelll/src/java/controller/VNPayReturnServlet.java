package controller;

import com.smarthotel.dao.BookingDAO;
import com.smarthotel.model.Booking;
import com.smarthotel.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/vnpay_return")
public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String responseCode = request.getParameter("vnp_ResponseCode");
        
        // TxnRef lúc này có dạng: 123_1709456789000 -> ta chỉ cần lấy số 123 ở đầu
        String rawTxnRef = request.getParameter("vnp_TxnRef");
        String bookingIdStr = rawTxnRef;
        
        if (rawTxnRef != null && rawTxnRef.contains("_")) {
            bookingIdStr = rawTxnRef.substring(0, rawTxnRef.indexOf("_"));
        }

        if ("00".equals(responseCode)) {
            // THANH TOÁN THÀNH CÔNG
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bDao = new BookingDAO();
                
                // 1. Gọi hàm confirm để đổi trạng thái Đơn hàng
                bDao.confirm(bookingId);
                
                // ==========================================
                // 2. GỬI EMAIL CHẠY NGẦM (Giúp web mượt, không bị đơ)
                // ==========================================
                Booking confirmedBooking = bDao.find(bookingId);
                if (confirmedBooking != null) {
                    new Thread(() -> {
                        try {
                            EmailUtil.sendPaymentSuccessEmail(confirmedBooking);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }).start();
                }
                // ==========================================
                
                // 3. CHUYỂN HƯỚNG VỀ TRANG ROOMS ĐỂ TRÁNH MẤT SESSION VÀ HIỆN THÔNG BÁO
                response.sendRedirect(request.getContextPath() + "/rooms?success=true");
                
            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("Lỗi cập nhật CSDL: " + e.getMessage());
            }
        } else {
            // THANH TOÁN THẤT BẠI
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='text-align:center; margin-top:50px; font-family:sans-serif;'>");
            response.getWriter().println("<h2 style='color:red;'>Giao dịch thanh toán thất bại hoặc đã bị hủy!</h2>");
            response.getWriter().println("<br><a href='" + request.getContextPath() + "/rooms' style='padding:10px 20px; background:#1069f9; color:white; text-decoration:none; border-radius:5px;'>Quay lại Chọn phòng</a>");
            response.getWriter().println("</div>");
        }
    }
}