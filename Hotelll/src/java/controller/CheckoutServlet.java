package controller;

import dao.BookingDAO;
import dao.VoucherDAO;
import model.Booking;
import model.CartItem;
import model.Voucher;
import service.BillingService;
import service.VoucherService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    private final BillingService billingService = new BillingService();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if ("checkin".equalsIgnoreCase(action)) {
                int bid = Integer.parseInt(req.getParameter("bid"));
                boolean ok = billingService.processCheckIn(bid);
                
                String requestedWith = req.getHeader("X-Requested-With");
                if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
                    resp.setContentType("text/plain");
                    if (ok) resp.getWriter().write("OK");
                    else resp.getWriter().write("FAIL");
                } else {
                    if (ok) resp.sendRedirect(req.getContextPath() + "/reception/home.jsp?msg=Check-in Success");
                    else resp.getWriter().println("Check-in Failed!");
                }
                return;
            }

            if ("checkout".equalsIgnoreCase(action)) {
                int bid = Integer.parseInt(req.getParameter("bid"));
                int cid = Integer.parseInt(req.getParameter("cid"));
                int rid = Integer.parseInt(req.getParameter("rid"));
                
                // 1. LẤY TIỀN MINIBAR (Phụ phí) TỪ FORM
                double minibarPrice = Double.parseDouble(req.getParameter("price"));
                String voucherCode = req.getParameter("voucherCode");

                // 2. LẤY LẠI GIÁ PHÒNG TỪ DATABASE
                Booking b = bookingDAO.find(bid);
                double roomPrice = b.getTotalAmount(); 
                
                // 3. TỔNG CỘNG TIỀN PHẢI TRẢ = Giá phòng + Phụ phí
                double finalPrice = roomPrice + minibarPrice;

                // 4. ÁP DỤNG VOUCHER (Nếu có)
                if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                    VoucherService voucherService = new VoucherService();
                    String voucherMsg = voucherService.checkVoucherValid(voucherCode, BigDecimal.valueOf(finalPrice));

                    if (!"OK".equals(voucherMsg)) {
                        // Nếu voucher lỗi, báo lỗi và dừng lại
                        resp.sendRedirect(req.getContextPath() + "/reception/checkout.jsp?error=" + java.net.URLEncoder.encode(voucherMsg, "UTF-8"));
                        return;
                    }

                    VoucherDAO vdao = new VoucherDAO();
                    Voucher v = vdao.findById(voucherCode);
                    if (v != null) {
                        // Trừ tiền Voucher vào TỔNG TIỀN
                        finalPrice = finalPrice - v.getDiscountValue().doubleValue();
                        if (finalPrice < 0) finalPrice = 0;
                        
                        // Tăng số lần sử dụng của Voucher lên 1
                        v.setUsedCount(v.getUsedCount() + 1);
                        vdao.update(v);
                    }
                }

                // --- LOGIC LƯU MINIBAR ---
                List<CartItem> items = new ArrayList<>();
                String[] itemIds = req.getParameterValues("itemId");
                if (itemIds != null) {
                    for (String sId : itemIds) {
                        int itemId = Integer.parseInt(sId);
                        String qtyParam = req.getParameter("qty_" + itemId);
                        int q = 1;
                        if (qtyParam != null && !qtyParam.isEmpty()) {
                            try { q = Integer.parseInt(qtyParam); } catch (NumberFormatException ex) {}
                        }
                        if (q > 0) items.add(new CartItem(itemId, q));
                    }
                }

                // Lưu lại thông tin thanh toán vào DB
                boolean ok = billingService.processCheckOut(bid, cid, rid, items, finalPrice);
                
                if (ok) {
                    if (finalPrice > 0) {
                        // Cập nhật lại tổng tiền cuối cùng vào Booking để đẩy qua VNPay
                        b.setTotalAmount(finalPrice); 
                        req.setAttribute("booking", b);
                        req.getRequestDispatcher("/webapp/payment.jsp").forward(req, resp);
                    } else {
                        // Nếu tổng tiền = 0 (khách xài Voucher che hết tiền), cho Checkout luôn
                        resp.sendRedirect(req.getContextPath() + "/reception/home.jsp?msg=Checkout Success - Room is Cleaning");
                    }
                } else {
                    resp.getWriter().println("Payment Failed (Rollback)!");
                }
                return;
            }

            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.getWriter().println("Error: " + ex.getMessage());
        }
    }
}