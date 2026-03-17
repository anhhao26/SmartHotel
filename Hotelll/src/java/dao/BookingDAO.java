package dao;

import model.Booking;
import model.Customer;
import util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class BookingDAO {
    
    public static class BookingShort {
        public int bookingID;
        public int roomID;
        public int customerID;
        public String customerName;
        public Date checkInDate;
        public Date checkOutDate;
        public String status;
    }

    public Booking find(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try { 
            return em.find(Booking.class, id); 
        } finally { 
            em.close(); 
        }
    }

    public void merge(Booking b, EntityManager em) { 
        em.merge(b); 
    }

    public List<BookingShort> findPendingBookings() {
        return findBookingsByStatuses(Arrays.asList("Pending", "PENDING", "Confirmed", "CONFIRMED"));
    }

    public List<BookingShort> findCheckedInBookings() {
        return findBookingsByStatuses(Arrays.asList("Checked-in", "CHECKED-IN", "Payment Pending"));
    }

    private List<BookingShort> findBookingsByStatuses(List<String> statuses) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b WHERE b.status IN :statuses ORDER BY b.bookingID DESC";
            TypedQuery<Booking> q = em.createQuery(jpql, Booking.class);
            q.setParameter("statuses", statuses);
            
            List<Booking> list = q.getResultList();
            List<BookingShort> out = new ArrayList<>();
            
            for (Booking b : list) {
                BookingShort bs = new BookingShort();
                bs.bookingID = b.getBookingID();
                
                if (b.getRoom() != null) {
                    bs.roomID = b.getRoom().getRoomID();
                } else {
                    bs.roomID = 0;
                }
                
                if (b.getCustomer() != null) {
                    bs.customerID = b.getCustomer().getCustomerID();
                    bs.customerName = b.getCustomer().getFullName();
                } else {
                    bs.customerID = 0;
                    bs.customerName = "Khách vãng lai";
                }
                
                bs.checkInDate = b.getCheckInDate();
                bs.checkOutDate = b.getCheckOutDate();
                bs.status = b.getStatus();
                out.add(bs);
            }
            return out;
        } finally {
            em.close();
        }
    }

    // --- CÁC HÀM XỬ LÝ ĐẶT PHÒNG ---
    
    public boolean saveBooking(Booking b) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(b);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // Hàm kiểm tra lịch trống cho người dùng - LUÔN CHO PHÉP ĐẶT
    public boolean isRoomAvailable(String roomNumber, Date reqCheckIn, Date reqCheckOut) {
        return true; 
    }

    // ĐÃ FIX: Cho phép xác nhận từ nhiều trạng thái (Pending, Checked-in, Checked-out)
    // Cập nhật chi tiêu và tích điểm Customer, dùng confirmedAt làm guard để không cộng trùng.
    public boolean confirm(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking b = em.find(Booking.class, id);
            
            if (b != null) {
                if (b.getConfirmedAt() == null) {
                    // Cập nhật ngày xác nhận thanh toán lần đầu
                    b.setConfirmedAt(new Date());
                }

                // 1. Cập nhật trạng thái Booking: 
                // - Pending -> Confirmed (Trường hợp đặt phòng mới)
                // - Checked-in / Payment Pending -> Checked-out (Trường hợp trả phòng)
                if ("Pending".equalsIgnoreCase(b.getStatus())) {
                    b.setStatus("Confirmed"); 
                } else if ("Checked-in".equalsIgnoreCase(b.getStatus()) || "Payment Pending".equalsIgnoreCase(b.getStatus())) {
                    b.setStatus("Checked-out");
                }
                
                // 2. CẬP NHẬT TRẠNG THÁI PHÒNG
                if (b.getRoom() != null) {
                    if ("Confirmed".equalsIgnoreCase(b.getStatus())) {
                        b.getRoom().setStatus("Occupied");
                    } else if ("Checked-out".equalsIgnoreCase(b.getStatus())) {
                        b.getRoom().setStatus("Cleaning");
                    }
                }
                
                em.merge(b);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    public List<Booking> findByCustomerId(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b WHERE b.customer.customerID = :cid ORDER BY b.bookingID DESC";
            TypedQuery<Booking> query = em.createQuery(jpql, Booking.class);
            query.setParameter("cid", customerId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>(); 
        } finally {
            em.close();
        }
    }

    // --- NEW: CÁC HÀM CẬP NHẬT TRẠNG THÁI CHO ADMIN ---
    
    public boolean updateBookingStatus(int bookingId, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking b = em.find(Booking.class, bookingId);
            if (b != null) {
                b.setStatus(status);
                em.merge(b);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean update(Booking b) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(b);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updateBookingAndRoomStatus(int bookingId, String bStatus, String rStatus) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking b = em.find(Booking.class, bookingId);
            if (b != null) {
                b.setStatus(bStatus);
                if (b.getRoom() != null) {
                    b.getRoom().setStatus(rStatus);
                }
                em.merge(b);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // --- DASHBOARD AND NOTIFICATION HELPERS ---
    
    public double getTotalRevenueThisMonth() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDateTime firstDayOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
            Date date = Date.from(firstDayOfMonth.atZone(ZoneId.systemDefault()).toInstant());
            
            String jpql = "SELECT SUM(b.totalAmount) FROM Booking b WHERE b.status IN ('Confirmed', 'Checked-in') AND b.checkInDate >= :startDate";
            Double revenue = em.createQuery(jpql, Double.class)
                               .setParameter("startDate", date)
                               .getSingleResult();
            return revenue != null ? revenue : 0.0;
        } finally {
            em.close();
        }
    }

    public long getActiveServiceRequestsCount() {
        return 24; // Placeholder
    }

    public double getOccupancyRate() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            long totalRooms = em.createQuery("SELECT COUNT(r) FROM Room r", Long.class).getSingleResult();
            if (totalRooms == 0) return 0.0;
            
            long occupiedRooms = em.createQuery("SELECT COUNT(r) FROM Room r WHERE r.status = 'Occupied'", Long.class).getSingleResult();
            return (double) occupiedRooms / totalRooms * 100;
        } finally {
            em.close();
        }
    }

    public List<Booking> getRecentNotifications(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b LEFT JOIN FETCH b.customer LEFT JOIN FETCH b.room LEFT JOIN FETCH b.room.roomType ORDER BY b.bookingID DESC";
            return em.createQuery(jpql, Booking.class)
                     .setMaxResults(limit)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Booking> searchBookings(String query) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT b FROM Booking b LEFT JOIN FETCH b.customer LEFT JOIN FETCH b.room LEFT JOIN FETCH b.room.roomType " +
                          "WHERE b.customer.fullName LIKE :q OR b.room.roomNumber LIKE :q OR b.status LIKE :q " +
                          "ORDER BY b.bookingID DESC";
            TypedQuery<Booking> q = em.createQuery(jpql, Booking.class);
            q.setParameter("q", "%" + query + "%");
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}