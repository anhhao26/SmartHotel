<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="model.*" %>
<%@ page import="util.*" %>
<%@ page import="jakarta.persistence.*" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>SmartHotel - Đặt Phòng Trực Tuyến</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        hotel: {
                            gold: "#B89A6C", cream: "#FAF9F6", bone: "#FDFCFB",
                            text: "#2C2722", muted: "#70685F", chocolate: "#4A4238",
                        }
                    },
                    fontFamily: {
                        serif: ["Cormorant Garamond", "serif"],
                        sans: ["Inter", "sans-serif"],
                    },
                },
            },
        }
    </script>
    <style>
        body { background-color: #FAF9F6; color: #2C2722; }
        .glass-panel { background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border: 1px solid rgba(184, 154, 108, 0.15); box-shadow: 0 40px 100px -20px rgba(74, 66, 56, 0.12); }
        .input-elegant { background: #FFFFFF; border: 1px solid rgba(184, 154, 108, 0.2); color: #2C2722; transition: all 0.4s cubic-bezier(0.165, 1, 0.3, 1); cursor: pointer; }
        .input-elegant:focus { outline: none; border-color: #B89A6C; box-shadow: 0 10px 20px -5px rgba(184, 154, 108, 0.1); }
        .btn-gold { background-color: #B89A6C; color: #FFFFFF; }
        .btn-gold:hover { background: #4A4238; transform: translateY(-2px); box-shadow: 0 15px 30px -10px rgba(74, 66, 56, 0.3); }
        .label-premium { font-family: 'Inter', sans-serif; font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.25em; color: #70685F; margin-bottom: 0.5rem; display: block; opacity: 0.8; }
        .hero-bg { position: fixed; inset: 0; z-index: -2; background-image: url('https://images.unsplash.com/photo-1542314831-c6a4d14d8373?q=80&w=3000'); background-size: cover; background-position: center; opacity: 0.1; }
    </style>
</head>
<body class="font-sans antialiased min-h-screen flex flex-col items-center justify-center p-6 relative">
    
    <%
        // KHỐI LOGIC: LẤY LỊCH TỪ DATABASE VÀ TÍNH TOÁN NGÀY BỊ KHÓA
        String roomIdStr = request.getParameter("roomId");
        List<Booking> bookedList = new ArrayList<>();
        
        if (roomIdStr != null && !roomIdStr.isEmpty()) {
            EntityManager em = JPAUtil.getEntityManager();
            try {
                // ĐÃ FIX: CHỈ LẤY NHỮNG ĐƠN ĐÃ XÁC NHẬN HOẶC ĐANG Ở (BỎ QUA PENDING)
                bookedList = em.createQuery("SELECT b FROM Booking b WHERE b.room.roomNumber = :rm AND b.status IN ('Confirmed', 'CONFIRMED', 'Checked-in', 'CHECKED-IN')", Booking.class)
                               .setParameter("rm", roomIdStr).getResultList();
            } catch(Exception e) { 
                e.printStackTrace(); 
            } finally { 
                em.close(); 
            }
        }
        
        StringBuilder disableCheckIn = new StringBuilder("[");
        StringBuilder disableCheckOut = new StringBuilder("[");
        SimpleDateFormat sdfJS = new SimpleDateFormat("yyyy-MM-dd");
        
        for (int i = 0; i < bookedList.size(); i++) {
            Booking b = bookedList.get(i);
            Calendar c = Calendar.getInstance();
            
            // 1. Ô Check-In: Khóa từ [Ngày Nhận] đến [Ngày Trả - 1 ngày]
            String ciFrom = sdfJS.format(b.getCheckInDate());
            c.setTime(b.getCheckOutDate());
            c.add(Calendar.DATE, -1);
            String ciTo = sdfJS.format(c.getTime());
            disableCheckIn.append("{ from: '").append(ciFrom).append("', to: '").append(ciTo).append("' }");
            
            // 2. Ô Check-Out: Khóa từ [Ngày Nhận + 1 ngày] đến [Ngày Trả]
            c.setTime(b.getCheckInDate());
            c.add(Calendar.DATE, 1);
            String coFrom = sdfJS.format(c.getTime());
            String coTo = sdfJS.format(b.getCheckOutDate());
            disableCheckOut.append("{ from: '").append(coFrom).append("', to: '").append(coTo).append("' }");
            
            if (i < bookedList.size() - 1) {
                disableCheckIn.append(", ");
                disableCheckOut.append(", ");
            }
        }
        disableCheckIn.append("]");
        disableCheckOut.append("]");
    %>

    <div class="hero-bg"></div>

    <a href="${pageContext.request.contextPath}/rooms" class="absolute top-12 left-12 flex items-center gap-3 text-hotel-muted hover:text-hotel-gold transition-all font-bold text-[10px] tracking-[0.4em] uppercase z-10 group">
        <span class="material-symbols-outlined text-lg group-hover:-translate-x-1 transition-transform">west</span> Quay lại
    </a>

    <main class="w-full max-w-2xl relative z-10">
        <div class="text-center mb-12 space-y-4">
            <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-hotel-gold/10 border border-hotel-gold/20 text-hotel-gold mb-2">
                <span class="material-symbols-outlined text-3xl">key</span>
            </div>
            <h1 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">Yêu Cầu <span class="text-hotel-gold italic">Đặt Phòng.</span></h1>
            <p class="text-hotel-muted font-bold text-[9px] tracking-[0.4em] uppercase border-t border-hotel-gold/10 pt-6 inline-block">Khởi tạo trải nghiệm lưu trú của bạn</p>
        </div>

        <div class="glass-panel p-10 md:p-14 rounded-sm relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-hotel-gold/40 to-transparent"></div>

            <c:if test="${not empty error}">
                <div class="mb-8 p-6 rounded-sm bg-red-50/50 border border-red-100 text-red-600 text-[10px] font-bold tracking-widest uppercase flex items-center gap-4">
                    <span class="material-symbols-outlined">error</span> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/booking" method="post" onsubmit="this.querySelector('button[type=submit]').innerHTML='ĐANG XỬ LÝ...'; this.querySelector('button[type=submit]').disabled=true;" class="space-y-10">
                <div class="relative group">
                    <label class="label-premium ml-1">Mã định danh không gian (Room Id)</label>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-6 top-1/2 -translate-y-1/2 text-hotel-gold/50">door_front</span>
                        <input type="text" class="w-full pl-16 pr-6 h-16 input-elegant rounded-xl font-bold text-hotel-gold text-lg tracking-widest cursor-not-allowed uppercase border-hotel-gold/10" name="roomId" value="${param.roomId}" readonly required>
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-8">
                    <div class="space-y-1">
                        <label class="label-premium ml-1">Thời điểm nhận phòng (Check-In)</label>
                        <div class="relative">
                            <input type="text" id="checkIn" class="w-full h-16 px-6 input-elegant rounded-xl font-bold text-hotel-text text-sm tracking-widest border-hotel-gold/10" name="checkIn" placeholder="Chọn ngày" readonly required>
                        </div>
                    </div>
                    <div class="space-y-1">
                        <label class="label-premium ml-1">Thời điểm trả phòng (Check-Out)</label>
                        <div class="relative">
                            <input type="text" id="checkOut" class="w-full h-16 px-6 input-elegant rounded-xl font-bold text-hotel-text text-sm tracking-widest border-hotel-gold/10" name="checkOut" placeholder="Chọn ngày" readonly required>
                        </div>
                    </div>
                </div>

                <div class="space-y-1">
                    <label class="label-premium ml-1 flex items-center gap-2">
                        <span class="material-symbols-outlined text-sm">confirmation_number</span>
                        Quyền lợi ưu đãi (Voucher Code)
                    </label>
                    <input type="text" class="w-full h-16 px-6 input-elegant rounded-xl font-bold text-hotel-text tracking-widest uppercase placeholder:text-hotel-gold/20 text-sm border-hotel-gold/10" name="voucherCode" placeholder="NHẬP MÃ TẠI ĐÂY...">
                </div>

                <div class="pt-6">
                    <button type="submit" class="w-full h-16 rounded-sm font-bold text-[11px] tracking-[0.4em] uppercase btn-gold flex items-center justify-center gap-4 group">
                        Xác nhận thông tin <span class="material-symbols-outlined group-hover:translate-x-2 transition-transform">east</span>
                    </button>
                </div>
            </form>
        </div>
    </main>

    <footer class="mt-20 text-hotel-muted/30 text-[9px] font-bold tracking-[0.4em] uppercase">
        © 2026 SmartHotel Boutique Collection
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const disableForCheckIn = <%= disableCheckIn.toString() %>;
            const disableForCheckOut = <%= disableCheckOut.toString() %>;

            // Mảng lưu trữ các khoảng thời gian đã bị đặt (Chỉ tính Confirmed/Checked-in)
            const bookedRanges = [
                <% for(int i=0; i<bookedList.size(); i++) {
                    Booking b = bookedList.get(i); %>
                    { 
                        in: new Date('<%= sdfJS.format(b.getCheckInDate()) %>T00:00:00'), 
                        out: new Date('<%= sdfJS.format(b.getCheckOutDate()) %>T00:00:00') 
                    }<%= (i < bookedList.size() - 1) ? "," : "" %>
                <% } %>
            ];
            bookedRanges.sort((a, b) => a.in - b.in);

            const checkOutPicker = flatpickr("#checkOut", {
                dateFormat: "Y-m-d",
                minDate: "today",
                disable: disableForCheckOut,
                allowInput: false
            });

            const checkInPicker = flatpickr("#checkIn", {
                dateFormat: "Y-m-d",
                minDate: "today",
                disable: disableForCheckIn,
                allowInput: false,
                onChange: function(selectedDates, dateStr, instance) {
                    if (selectedDates.length > 0) {
                        let ciDate = selectedDates[0];
                        
                        let minOut = new Date(ciDate);
                        minOut.setDate(minOut.getDate() + 1);
                        checkOutPicker.set("minDate", minOut);

                        let closestBooking = bookedRanges.find(b => b.in > ciDate);
                        
                        if (closestBooking) {
                            checkOutPicker.set("maxDate", closestBooking.in);
                        } else {
                            checkOutPicker.set("maxDate", null); 
                        }
                        
                        if(checkOutPicker.selectedDates.length > 0 && checkOutPicker.selectedDates[0] <= ciDate) {
                            checkOutPicker.clear();
                        }
                        if(checkOutPicker.selectedDates.length > 0 && closestBooking && checkOutPicker.selectedDates[0] > closestBooking.in) {
                            checkOutPicker.clear();
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
