package controller;

import dao.BookingDAO;
import dao.AccountDAO;
import model.Booking;
import util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/vnpay_return")
public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Kiểm tra chữ ký (Signature Verification - An toàn hơn)
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");
        
        // Sắp xếp các tham số để tạo hash
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);
            hashData.append(fieldName).append('=').append(java.net.URLEncoder.encode(fieldValue, java.nio.charset.StandardCharsets.US_ASCII.toString()));
            if (itr.hasNext()) {
                hashData.append('&');
            }
        }
        
        String signValue = util.VNPayUtils.hmacSHA512(util.VNPayConfig.vnp_HashSecret, hashData.toString());
        
        // --- CRITICAL SECURITY FIX: Enforce Signature Verification ---
        if (!signValue.equalsIgnoreCase(vnp_SecureHash)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='text-align:center; color:red; margin-top:50px;'>");
            response.getWriter().println("<h2>CẢNH BÁO BẢO MẬT: Chữ ký không hợp lệ!</h2>");
            response.getWriter().println("<p>Giao dịch có dấu hiệu bị can thiệp. Vui lòng liên hệ quản trị viên.</p>");
            response.getWriter().println("</div>");
            return; 
        }

        String responseCode = request.getParameter("vnp_ResponseCode");
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
                bDao.confirm(bookingId);
                
                Booking confirmedBooking = bDao.find(bookingId);
                if (confirmedBooking != null) {
                    // PHỤC HỒI SESSION NẾU BỊ MẤT (Do SameSite cookie issue trên trình duyệt mới)
                    HttpSession session = request.getSession(true);
                    if (session.getAttribute("acc") == null) {
                        model.Customer cus = confirmedBooking.getCustomer();
                        if (cus != null) {
                            session.setAttribute("CUST_ID", cus.getCustomerID());
                            AccountDAO aDao = new AccountDAO();
                            model.Account acc = aDao.findByCustomerId(cus.getCustomerID());
                            if (acc != null) {
                                session.setAttribute("acc", acc);
                            }
                        }
                    }

                    new Thread(() -> {
                        try {
                            EmailUtil.sendPaymentSuccessEmail(confirmedBooking);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }).start();
                }
                
                response.sendRedirect(request.getContextPath() + "/guest/history.jsp?msg=payment_success");
                
            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("Lỗi xử lý kết quả thanh toán: " + e.getMessage());
            }
        } else {
            // ... (Phần xử lý thất bại giữ nguyên)
            // THANH TOÁN THẤT BẠI
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='text-align:center; margin-top:50px; font-family:sans-serif;'>");
            response.getWriter().println("<h2 style='color:red;'>Giao dịch thanh toán thất bại hoặc đã bị hủy!</h2>");
            response.getWriter().println("<br><a href='" + request.getContextPath() + "/guest/profile.jsp' style='padding:10px 20px; background:#11d493; color:white; text-decoration:none; border-radius:5px;'>Quay lại Hồ Sơ</a>");
            response.getWriter().println("</div>");
        }
    }
}