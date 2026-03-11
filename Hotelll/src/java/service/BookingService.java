package com.smarthotel.service;

import com.smarthotel.dao.BookingDAO;
import com.smarthotel.model.Booking;
import java.util.Calendar;
import java.util.Date;

public class BookingService {
    private final BookingDAO dao = new BookingDAO();

    public String book(Booking b){
        if(b.getCheckInDate() == null || b.getCheckOutDate() == null)
            return "Thiếu ngày nhận/trả phòng";

        // =========================================================
        // 1. KIỂM TRA QUÁ KHỨ: Không cho đặt phòng trước ngày hôm nay
        // =========================================================
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date today = cal.getTime();

        if (b.getCheckInDate().before(today)) {
            return "Không thể đặt phòng cho những ngày trong quá khứ!";
        }

        // =========================================================
        // 2. KIỂM TRA NGÀY TRẢ: Phải lớn hơn ngày nhận (không được bằng)
        // =========================================================
        if(b.getCheckOutDate().before(b.getCheckInDate()) || b.getCheckOutDate().equals(b.getCheckInDate()))
            return "Ngày trả phòng phải sau ngày nhận phòng";

        // =========================================================
        // 3. KIỂM TRA TRÙNG LỊCH TRƯỚC KHI LƯU
        // =========================================================
        if (b.getRoom() != null && b.getRoom().getRoomNumber() != null) {
            boolean isAvailable = dao.isRoomAvailable(b.getRoom().getRoomNumber(), b.getCheckInDate(), b.getCheckOutDate());
            if (!isAvailable) {
                return "Rất tiếc, phòng này đã có người đặt trong khoảng thời gian bạn chọn. Vui lòng chọn ngày khác!";
            }
        }
        // =========================================================

        boolean ok = dao.saveBooking(b);

        if(!ok)
            return "Rất tiếc, phòng đã có người đặt trong thời gian này!";

        return "OK";
    }
}