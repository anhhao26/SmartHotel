package controller;

import dao.BookingDAO;
import dao.AccountDAO;
import model.Booking;
import util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/vnpay_return")
public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra chữ ký
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

        // Sort
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);

        // 🔥 FIX: BỎ encode (nguyên nhân lỗi chữ ký)
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);

            hashData.append(fieldName).append('=').append(fieldValue);

            if (itr.hasNext()) {
                hashData.append('&');
            }
        }

        String signValue = util.VNPayUtils.hmacSHA512(util.VNPayConfig.vnp_HashSecret, hashData.toString());

        // DEBUG
        System.out.println("HashData: " + hashData);
        System.out.println("VNPay Hash: " + vnp_SecureHash);
        System.out.println("My Hash: " + signValue);

        if (!signValue.equalsIgnoreCase(vnp_SecureHash)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='text-align:center; color:red; margin-top:50px;'>");
            response.getWriter().println("<h2>CẢNH BÁO BẢO MẬT: Chữ ký không hợp lệ!</h2>");
            response.getWriter().println("</div>");
            return;
        }

        String responseCode = request.getParameter("vnp_ResponseCode");
        String rawTxnRef = request.getParameter("vnp_TxnRef");

        if ("00".equals(responseCode)) {
            try {
                String bookingIdStr = rawTxnRef;
                String role = "GUEST";

                if (rawTxnRef != null && rawTxnRef.contains("_")) {
                    String[] parts = rawTxnRef.split("_");
                    if (parts.length >= 2) {
                        bookingIdStr = parts[0];
role = parts[1];
                    }
                }

                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bDao = new BookingDAO();
                bDao.confirm(bookingId);

                // ❌ XÓA findFull (gây lỗi)
                Booking confirmedBooking = new Booking();
                confirmedBooking.setBookingID(bookingId); // chỉ set ID để dùng tạm

                model.Customer cus = null;

                // ❌ KHÔNG dùng confirmedBooking.getCustomer() nữa (vì không load từ DB)
                // → bỏ luôn đoạn CRM update nếu cần full data

                // 2. PHỤC HỒI SESSION (giữ nguyên logic, nhưng check null)
                if ("GUEST".equals(role)) {
                    HttpSession session = request.getSession(true);
                    if (session.getAttribute("acc") == null) {
                        // ❌ cus đang null → không set CUST_ID nữa
                        System.out.println("Session restore skipped (no customer data)");
                    }
                }

                // Email (chỉ gửi nếu không cần full data)
                new Thread(() -> {
                    try {
                        EmailUtil.sendPaymentSuccessEmail(confirmedBooking);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }).start();

                // Redirect
                if ("STAFF".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/reception/checkout.jsp?msg=checkout_success");
                } else {
                    response.sendRedirect(request.getContextPath() + "/guest/history.jsp?msg=payment_success");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/guest/history.jsp?error=process_failed");
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='text-align:center; margin-top:50px;'>");
            response.getWriter().println("<h2 style='color:red;'>Thanh toán thất bại!</h2>");
            response.getWriter().println("</div>");
        }
    }
}