package controller;

import dao.BookingDAO;
import dao.VoucherDAO;
import model.Booking;
import model.CartItem;
import model.Voucher;
import model.Inventory;
import dao.InventoryDAO;
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
    private final dao.CustomerDAO customerDAO = new dao.CustomerDAO();
    private final dao.InventoryDAO inventoryDAO = new dao.InventoryDAO();
    private final service.VoucherService voucherService = new service.VoucherService();
    private final dao.VoucherDAO voucherDAO = new dao.VoucherDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if ("checkin".equalsIgnoreCase(action) || "confirm".equalsIgnoreCase(action)) {
                int bid = Integer.parseInt(req.getParameter("bid"));
                boolean ok = true;
                if ("checkin".equalsIgnoreCase(action)) {
                    ok = billingService.processCheckIn(bid);
                } else if ("confirm".equalsIgnoreCase(action)) {
                    // XÁC NHẬN THANH TOÁN THỦ CÔNG (TẠI QUẦY)
                    ok = bookingDAO.confirm(bid);
                    if (ok) {
                        Booking b = bookingDAO.find(bid);
                        if (b != null && b.getCustomer() != null && b.getTotalAmount() != null) {
                            // ĐÃ FIX: Fetch lại Customer để tránh LazyInitializationException
                            model.Customer actualCus = customerDAO.findById(b.getCustomer().getCustomerID());
                            
                            if (actualCus != null) {
                                double amount = b.getTotalAmount();
                                double current = actualCus.getTotalSpending() != null ? actualCus.getTotalSpending() : 0.0;
                                double next = current + amount;
                                actualCus.setTotalSpending(next);
                                
                                int pts = actualCus.getPoints() != null ? actualCus.getPoints() : 0;
                                int added = (int)(amount / 100000.0);
                                actualCus.setPoints(pts + added);
                                
                                if (next >= 10000000.0) actualCus.setMemberType("VIP");
                                else if (next > 0 && !"VIP".equalsIgnoreCase(actualCus.getMemberType())) actualCus.setMemberType("Member");
                                
                                customerDAO.update(actualCus);
                                System.out.println("[Manual] Updated CRM for Cust #" + actualCus.getCustomerID() + ": +" + amount + " VND, +" + added + " pts");
                            }
                        }
                    }
                }
                
                String requestedWith = req.getHeader("X-Requested-With");
                if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
                    resp.setContentType("text/plain");
                    if (ok) resp.getWriter().write("OK");
                    else resp.getWriter().write("FAIL");
                } else {
                    if (ok) resp.sendRedirect(req.getContextPath() + "/reception/checkout.jsp?msg=Action Success");
                    else resp.getWriter().println("Action Failed!");
                }
                return;
            }

            if ("checkout".equalsIgnoreCase(action)) {
                int bid = Integer.parseInt(req.getParameter("bid"));
                int cid = Integer.parseInt(req.getParameter("cid"));
                int rid = Integer.parseInt(req.getParameter("rid"));
                
                // 1. CHỈ TÍNH TIỀN VẬT DỤNG/DỊCH VỤ (Excluding room price)
                double itemTotal = 0.0;
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
                        if (q > 0) {
                            items.add(new CartItem(itemId, q));
                            model.Inventory inv = inventoryDAO.find(itemId);
                            if (inv != null) {
                                itemTotal += (inv.getSellingPrice() * q);
                            }
                        }
                    }
                }

                double finalPrice = itemTotal;
                String voucherCode = req.getParameter("voucherCode");

                // 2. ÁP DỤNG VOUCHER (Nếu có)
                if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                    String voucherMsg = voucherService.checkVoucherValid(voucherCode, BigDecimal.valueOf(finalPrice));

                    if (!"OK".equals(voucherMsg)) {
                        resp.sendRedirect(req.getContextPath() + "/reception/checkout.jsp?error=" + java.net.URLEncoder.encode(voucherMsg, "UTF-8"));
                        return;
                    }

                    Voucher v = voucherDAO.findById(voucherCode);
                    if (v != null) {
                        finalPrice = finalPrice - v.getDiscountValue().doubleValue();
                        if (finalPrice < 0) finalPrice = 0;
                        
                        v.setUsedCount(v.getUsedCount() + 1);
                        voucherDAO.update(v);
                    }
                }
                
                // 3. LẤY THÔNG TIN ĐẶT PHÒNG ĐỂ ĐIỀU HƯỚNG
                Booking b = bookingDAO.find(bid);
                if (b == null) {
                    resp.sendRedirect(req.getContextPath() + "/reception/checkout.jsp?error=" + java.net.URLEncoder.encode("Không tìm thấy thông tin đặt phòng!", "UTF-8"));
                    return;
                }

                // KIỂM TRA NẾU ĐANG ĐỢI THANH TOÁN (Retry Flow)
                // Nếu khách đang 'Payment Pending' và không thêm vật dụng gì mới -> Đi thẳng tới thanh toán với số tiền cũ
                boolean ok = true;
                if ("Payment Pending".equalsIgnoreCase(b.getStatus()) && items.isEmpty()) {
                    finalPrice = b.getTotalAmount() != null ? b.getTotalAmount() : 0.0;
                    System.out.println("[Checkout] Retry payment for Booking #" + bid + " (Total: " + finalPrice + ")");
                } else {
                    // Lưu lại thông tin thanh toán vào DB (Deduct items, create invoice)
                    ok = billingService.processCheckOut(bid, cid, rid, items, finalPrice);
                }
                
                if (ok) {
                    // Nếu đã thanh toán thành công (hoặc bypass processCheckOut), 
                    // ta set trạng thái Booking tạm thời là 'Payment Pending' để vẫn hiển thị trên Console
                    if (finalPrice > 0) {
                        b.setStatus("Payment Pending");
                        b.setTotalAmount(finalPrice); // Cập nhật lại tổng tiền cuối cùng vào Booking để đẩy qua VNPay
                        bookingDAO.update(b); 
                        
                        req.setAttribute("booking", b);
                        req.getRequestDispatcher("/webapp/payment.jsp").forward(req, resp);
                    } else {
                        // Nếu tổng tiền = 0 (khách xài Voucher che hết tiền hoặc không có gì thanh toán), xác nhận thanh toán luôn
                        b.setStatus("Checked-out"); 
                        bookingDAO.update(b);
                        bookingDAO.confirm(bid); // Finalize CRM & Room Status
                        resp.sendRedirect(req.getContextPath() + "/reception/checkout.jsp?msg=Checkout Success - Room is Cleaning");
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