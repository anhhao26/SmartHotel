package com.smarthotel.dao;

import com.smarthotel.model.Booking;
import com.smarthotel.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class BookingDAO {
    public static class BookingShort {
        public int bookingID;
        public int roomID;
        public int customerID;
        public String customerName;
        public java.util.Date checkInDate;
        public java.util.Date checkOutDate;
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

    // ĐÃ SỬA LỖI TÀNG HÌNH ĐƠN HÀNG:
    // Mở rộng phễu lấy cả đơn Pending (chưa thanh toán) và Confirmed (đã thanh toán online)
    public List<BookingShort> findPendingBookings() {
        return findBookingsByStatuses(Arrays.asList("Pending", "PENDING", "Confirmed", "CONFIRMED"));
    }

    public List<BookingShort> findCheckedInBookings() {
        return findBookingsByStatuses(Arrays.asList("Checked-in", "CHECKED-IN"));
    }

    // Tối ưu hóa hàm lọc để truyền được nhiều trạng thái cùng lúc (Dùng IN)
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
            
            // Logic chống trùng phòng
            Long conflict = em.createQuery(
            "SELECT COUNT(b) FROM Booking b WHERE b.room.roomID = :roomId " +
            "AND UPPER(b.status) IN ('PENDING', 'CONFIRMED', 'CHECKED-IN') " +
            "AND :checkIn < b.checkOutDate AND :checkOut > b.checkInDate", Long.class)
            .setParameter("roomId", b.getRoom().getRoomID())
            .setParameter("checkIn", b.getCheckInDate())
            .setParameter("checkOut", b.getCheckOutDate())
            .getSingleResult();

            if(conflict > 0){
                em.getTransaction().rollback();
                return false;
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

    public void confirm(int id){
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking b = em.find(Booking.class, id);
            if (b != null) {
                b.setStatus("Confirmed"); 
                em.merge(b);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}