package service;

import dao.InventoryDAO;
import dao.BookingDAO;
import model.*;
import util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import java.util.Date;
import java.util.List;

public class BillingService {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final InventoryDAO inventoryDAO = new InventoryDAO();

    /**
     * Process check-in: 
     * - Cập nhật booking.status = "Checked-in"
     * - TUYỆT ĐỐI KHÔNG ĐỔI TRẠNG THÁI PHÒNG (Để phòng luôn Available trên web cho người khác đặt ngày khác)
     */
    public boolean processCheckIn(int bookingId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Booking b = em.find(Booking.class, bookingId);
            if (b == null) { 
                em.getTransaction().rollback(); 
                return false; 
            }
            
            // Chỉ đổi trạng thái của Hóa đơn thành Đang ở
            b.setStatus("Checked-in"); 

            // =========================================================
            // ĐÃ BẮT TẬN TAY VÀ XÓA BỎ LỆNH KHÓA PHÒNG Ở ĐÂY!
            // Room rm = b.getRoom();
            // if (rm != null) {
            //     rm.setStatus("Occupied");
            //     em.merge(rm);
            // }
            // =========================================================
            
            em.merge(b);
            em.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Process checkout:
     * - update booking.status -> Checked-out
     * - update room status -> Cleaning
     * - deduct inventory quantities (with pessimistic lock)
     * - CRM: Tích điểm & Lên VIP
     */
    public boolean processCheckOut(int bookingId, int customerId, int roomId, List<CartItem> items, double roomPrice) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            // 1) Load booking and set status
            Booking booking = em.find(Booking.class, bookingId);
            if (booking == null) { 
                em.getTransaction().rollback(); 
                return false; 
            }
            // booking.setStatus("Checked-out"); // ĐÃ XÓA: Trạng thái sẽ được cập nhật trong Servlet tùy theo flow thanh toán
            em.merge(booking);

            // 2) Load Customer & Initialize Invoice
            Customer cust = em.find(Customer.class, customerId);
            Invoice inv = new Invoice();
            inv.setBooking(booking);
            inv.setCustomer(cust);
            inv.setCreatedDate(new Date());
            
            double subtotal = 0.0;

            // Kiểm tra VIP để giảm giá tiền phòng
            double discount = 0.0;
            if (cust != null && "VIP".equalsIgnoreCase(cust.getMemberType())) {
                discount = roomPrice * 0.20; // VIP giảm 20%
            }

            // Tiền phòng (sau khi trừ chiết khấu nếu có)
            double finalRoomPrice = roomPrice - discount;
            
            // Removed room price from checkout invoice as requested: Payment is item-based only
            /*
            InvoiceItem roomLine = new InvoiceItem();
            roomLine.setQuantity(1);
            roomLine.setUnitPrice(finalRoomPrice);
            roomLine.setInventory(null);
            inv.addItem(roomLine);
            
            subtotal += finalRoomPrice;
            */

            // 3) Tính tiền items từ Minibar & Trừ kho
            if (items != null) {
                for (CartItem ci : items) {
                    int iid = ci.getItemID();
                    int qty = ci.getQuantity();

                    // Lấy inventory kèm khóa bi quan (Pessimistic Lock) để chống lỗi đồng thời
                    Inventory invEntity = em.find(Inventory.class, iid, LockModeType.PESSIMISTIC_WRITE);
                    if (invEntity == null) {
                        throw new RuntimeException("Inventory item not found: " + iid);
                    }
                    if (invEntity.getQuantity() < qty) {
                        throw new RuntimeException("Not enough inventory for item " + iid);
                    }
                    
                    // Trừ kho
                    invEntity.setQuantity(invEntity.getQuantity() - qty);
                    em.merge(invEntity);

                    // Thêm vào chi tiết hóa đơn
                    InvoiceItem ii = new InvoiceItem();
                    ii.setInventory(invEntity);
                    ii.setQuantity(qty);
                    ii.setUnitPrice(invEntity.getSellingPrice());
                    inv.addItem(ii);
                    
                    subtotal += (invEntity.getSellingPrice() * qty);
                }
            }

            inv.setTotalAmount(subtotal);
            inv.setDiscount(discount);
            em.persist(inv);

            // 4) Update Room status -> Cleaning (DELIVERED TO BookingDAO.confirm)
            /*
            Room rm = booking.getRoom();
            if (rm == null) {
                rm = em.find(Room.class, roomId);
            }
            if (rm != null) {
                rm.setStatus("Cleaning");
                em.merge(rm);
            }
            */

            // 5) Update Customer status (CRM logic is now centralized in BookingDAO.confirm)
            /*
            if (cust != null) {
                double prevTotal = cust.getTotalSpending() == null ? 0.0 : cust.getTotalSpending();
                double newTotal = prevTotal + subtotal;
                cust.setTotalSpending(newTotal);
                
                // Tích điểm: 100,000 VNĐ => 1 điểm
                int addedPoints = (int) Math.floor(subtotal / 100_000.0);
                int currentPoints = cust.getPoints() == null ? 0 : cust.getPoints();
                cust.setPoints(currentPoints + addedPoints);
                
                // Tự động lên VIP nếu chi tiêu >= 10.000.000
                if (newTotal >= 10_000_000.0) {
                    cust.setMemberType("VIP");
                } else if (newTotal > 0 && !"VIP".equalsIgnoreCase(cust.getMemberType())) {
                    cust.setMemberType("Member");
                }
                em.merge(cust);
            }
            */

            em.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }
}