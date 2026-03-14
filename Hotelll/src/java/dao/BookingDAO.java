package com.smarthotel.dao;

import com.smarthotel.model.Booking;
import com.smarthotel.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
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

    // Mở rộng phễu lấy cả đơn Pending và Confirmed
    public List<BookingShort> findPendingBookings() {
        return findBookingsByStatuses(Arrays.asList("Pending", "PENDING", "Confirmed", "CONFIRMED"));
    }

    public List<BookingShort> findCheckedInBookings() {
        return findBookingsByStatuses(Arrays.asList("Checked-in", "CHECKED-IN"));
    }

    // Tối ưu hóa hàm lọc để truyền được nhiều trạng thái cùng lúc
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
    
    public boolean saveBooking(Booking b){
        EntityManager em = JPAUtil.getEntityManager();
        try{
            em.getTransaction().begin();
            
            // LOGIC CHỐNG TRÙNG PHÒNG 15 PHÚT (Dùng Native SQL để không bị lỗi getCreatedAt)
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MINUTE, -15);
            Date timeLimit = cal.getTime();

            String sql = "SELECT COUNT(*) FROM Bookings WHERE RoomID = ? " +
                         "AND (Status IN ('Confirmed', 'Checked-in') " +
                         "     OR (Status = 'Pending' AND CreatedAt >= ?)) " +
                         "AND CheckInDate < ? AND CheckOutDate > ?";

            Number conflict = (Number) em.createNativeQuery(sql)
                    .setParameter(1, b.getRoom().getRoomID())
                    .setParameter(2, timeLimit)
                    .setParameter(3, b.getCheckOutDate())
                    .setParameter(4, b.getCheckInDate())
                    .getSingleResult();

            if(conflict.intValue() > 0){
                em.getTransaction().rollback();
                return false; // Phát hiện có người đã đặt -> Hủy việc lưu
            }

            em.persist(b);
            em.getTransaction().commit();
            return true;
        }catch(Exception e){
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }finally{
            em.close();
        }
    }

    // Hàm kiểm tra lịch trống dành cho Controller (Dùng quy tắc 15 phút - Native SQL)
    public boolean isRoomAvailable(String roomNumber, Date reqCheckIn, Date reqCheckOut) {
        EntityManager em = JPAUtil.getEntityManager(); 
        try {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MINUTE, -15);
            Date timeLimit = cal.getTime();

            String sql = "SELECT COUNT(*) FROM Bookings b JOIN Rooms r ON b.RoomID = r.RoomID " +
                         "WHERE r.RoomNumber = ? " +
                         "AND (b.Status IN ('Confirmed', 'Checked-in') " +
                         "     OR (b.Status = 'Pending' AND b.CreatedAt >= ?)) " +
                         "AND b.CheckInDate < ? AND b.CheckOutDate > ?";
            
            Number count = (Number) em.createNativeQuery(sql)
                           .setParameter(1, roomNumber)
                           .setParameter(2, timeLimit)
                           .setParameter(3, reqCheckOut)
                           .setParameter(4, reqCheckIn)
                           .getSingleResult();
                           
            return count.intValue() == 0; 
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ĐÃ FIX: Chỉ đổi Booking -> Confirmed, KHÔNG khóa phòng, KHÔNG cộng điểm
    public void confirm(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking b = em.find(Booking.class, id);
            
            if (b != null) {
                // 1. Cập nhật hóa đơn thành Đã Thanh Toán (Confirmed)
                b.setStatus("Confirmed"); 
                
                // (Đã xóa logic cộng điểm thưởng và đổi trạng thái phòng Occupied)
                
                em.merge(b);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    
    // Lấy lịch sử đặt phòng của một khách hàng cụ thể
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
}