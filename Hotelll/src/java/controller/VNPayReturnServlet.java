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
                bDao.confirm(bookingId); // Cập nhật trạng thái booking/phòng
                
                Booking confirmedBooking = bDao.find(bookingId);
                if (confirmedBooking != null) {
                    model.Customer cus = confirmedBooking.getCustomer();
                    if (cus != null) {
                        // 1. CẬP NHẬT CHI TIÊU & ĐIỂM (Dựa trên số tiền thực trả từ VNPay)
                        String amountStr = request.getParameter("vnp_Amount");
                        if (amountStr != null) {
                            double amountPaid = Double.parseDouble(amountStr) / 100.0;
                            
                            // Tránh cộng trùng nếu refresh trang (Dùng session để check txnRef)
                            HttpSession session = request.getSession();
                            Set<String> processed = (Set<String>) session.getAttribute("PROCESSED_VNPAY");
                            if (processed == null) processed = new HashSet<>();
                            
                            if (!processed.contains(rawTxnRef)) {
                                dao.CustomerDAO cDao = new dao.CustomerDAO();
                                // ĐÃ FIX: Fetch lại Customer để tránh LazyInitializationException khi EM đã đóng
                                model.Customer actualCus = cDao.findById(cus.getCustomerID());
                                
                                if (actualCus != null) {
                                    double currentTotal = actualCus.getTotalSpending() != null ? actualCus.getTotalSpending() : 0.0;
                                    double newTotal = currentTotal + amountPaid;
                                    actualCus.setTotalSpending(newTotal);
                                    
                                    int currentPoints = actualCus.getPoints() != null ? actualCus.getPoints() : 0;
                                    int addedPoints = (int) (amountPaid / 100000.0);
                                    actualCus.setPoints(currentPoints + addedPoints);
                                    
                                    if (newTotal >= 10000000.0) actualCus.setMemberType("VIP");
                                    else if (newTotal > 0 && !"VIP".equalsIgnoreCase(actualCus.getMemberType())) actualCus.setMemberType("Member");
                                    
                                    cDao.update(actualCus);
                                    System.out.println("[VNPay] Updated CRM for Cust #" + actualCus.getCustomerID() + ": +" + amountPaid + " VND, +" + addedPoints + " pts");
                                    
                                    processed.add(rawTxnRef);
                                    session.setAttribute("PROCESSED_VNPAY", processed);
                                }
                            }
                        }

                        // 2. PHỤC HỒI SESSION NẾU BỊ MẤT (Chỉ cho Khách)
                        if ("GUEST".equals(role)) {
                            HttpSession session = request.getSession(true);
                            if (session.getAttribute("acc") == null) {
                                session.setAttribute("CUST_ID", cus.getCustomerID());
                                dao.AccountDAO aDao = new dao.AccountDAO();
                                model.Account acc = aDao.findByCustomerId(cus.getCustomerID());
                                if (acc != null) session.setAttribute("acc", acc);
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
                
                // ROLE-BASED REDIRECT
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
            // PAYMENT FAILED
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='text-align:center; margin-top:50px; font-family:sans-serif;'>");
            response.getWriter().println("<h2 style='color:red;'>Giao dịch thanh toán thất bại hoặc đã bị hủy!</h2>");
            response.getWriter().println("<br><a href='" + request.getContextPath() + "/guest/profile.jsp' style='padding:10px 20px; background:#11d493; color:white; text-decoration:none; border-radius:5px;'>Quay lại Hồ Sơ</a>");
            response.getWriter().println("</div>");
        }
    }
}
