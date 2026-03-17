<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="util.JPAUtil" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="model.Booking" %>
<%@ page import="model.Invoice" %>
<%@ page import="model.InvoiceItem" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Hóa Đơn Thanh Toán - SmartHotel</title>

    <!-- Premium Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap"
        rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
        rel="stylesheet" />

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        hotel: {
                            gold: "#B89A6C",
                            cream: "#FAF9F6",
                            bone: "#FDFCFB",
                            text: "#2C2722",
                            muted: "#70685F",
                            chocolate: "#4A4238",
                        },
                        accent: {
                            emerald: "#4F7942",
                            ruby: "#8B0000"
                        }
                    },
                    fontFamily: {
                        serif: ["Cormorant Garamond", "serif"],
                        sans: ["Inter", "Be Vietnam Pro", "sans-serif"],
                    }
                },
            },
        }
    </script>
    <style>
        .card-invoice {
            background: #FFFFFF;
            border: 1px solid rgba(184, 154, 108, 0.15);
            box-shadow: 0 40px 100px -20px rgba(74, 66, 56, 0.12);
            position: relative;
        }

        /* Decorative corner */
        .card-invoice::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 80px;
            height: 80px;
            background: linear-gradient(225deg, #B89A6C 0%, #B89A6C 50%, transparent 50%);
            opacity: 0.05;
        }

        @media print {
            .no-print {
                display: none !important;
            }

            body {
                background: white !important;
                color: black !important;
                padding: 0 !important;
                overflow: visible !important;
            }

            .card-invoice {
                box-shadow: none !important;
                border: 1px solid #E5E7EB !important;
                width: 100% !important;
                margin: 0 !important;
                border-radius: 0 !important;
                padding: 20px !important;
            }

            .flex-1 {
                overflow: visible !important;
                height: auto !important;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body
    class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

    <jsp:include page="/common/neural_shell_top.jspf">
        <jsp:param name="active" value="reception" />
    </jsp:include>

    <% 
        Invoice inv = (Invoice) request.getAttribute("foundInvoice");
        Booking booking = (Booking) request.getAttribute("foundBooking");
        
        if (inv == null && booking == null) {
            String sid = request.getParameter("invoiceId");
            if (sid != null && !sid.isEmpty()) {
                try {
                    int iid = Integer.parseInt(sid);
                    EntityManager em = JPAUtil.getEntityManager();
                    try {
                        inv = em.find(Invoice.class, iid);
                        if (inv != null) booking = inv.getBooking();
                    } finally {
                        em.close();
                    }
                } catch (Exception e) {
                    inv = null;
                }
            }
            
            // If still null, check for bookingId param (direct access)
            if (inv == null && booking == null) {
                String bid = request.getParameter("bookingId");
                if (bid != null && !bid.isEmpty()) {
                    try {
                        int bId = Integer.parseInt(bid);
                        EntityManager em = JPAUtil.getEntityManager();
                        try {
                            booking = em.find(Booking.class, bId);
                            // Also try to find invoice for this booking
                            List<Invoice> invs = em.createQuery("SELECT i FROM Invoice i WHERE i.booking.bookingID = :bid", Invoice.class)
                                .setParameter("bid", bId).getResultList();
                            if (!invs.isEmpty()) inv = invs.get(0);
                        } finally {
                            em.close();
                        }
                    } catch (Exception e) {}
                }
            }
        } else if (inv != null && booking == null) {
            booking = inv.getBooking();
        }
    %>

    <!-- Invoice Portal Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-4xl mx-auto px-6 py-12 animate-[fadeIn_0.6s_ease-out] w-full">

            <!-- Control Bar -->
            <div
                class="no-print flex justify-between items-center mb-8 bg-white/50 backdrop-blur-md px-8 py-4 rounded-2xl border border-hotel-gold/10">
                <c:choose>
                    <c:when test="${isStaffView}">
                        <a href="${pageContext.request.contextPath}/admin/bookings"
                            class="flex items-center gap-2 text-[10px] font-bold tracking-[0.2em] uppercase text-hotel-muted hover:text-hotel-gold transition-colors">
                            <span class="material-symbols-outlined text-lg">arrow_back</span>
                            Quay lại Quản Lý Đặt Phòng
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/guest/history.jsp"
                            class="flex items-center gap-2 text-[10px] font-bold tracking-[0.2em] uppercase text-hotel-muted hover:text-hotel-gold transition-colors">
                            <span class="material-symbols-outlined text-lg">arrow_back</span>
                            Quay lại Lịch Sử Đặt Phòng
                        </a>
                    </c:otherwise>
                </c:choose>
                <button onclick="window.print()"
                    class="flex items-center gap-3 bg-hotel-gold text-white px-8 py-3 rounded-xl font-bold text-[10px] tracking-[0.2em] uppercase hover:bg-hotel-chocolate transition-all group active:scale-95 shadow-md">
                    <span
                        class="material-symbols-outlined text-xl group-hover:scale-110 transition-transform">print</span>
                    In Thông Tin
                </button>
            </div>

            <div class="card-invoice p-12 md:p-16 rounded-[2rem] space-y-16">

                <% if (inv == null && booking == null) { %>
                    <div class="text-center py-40 space-y-8 opacity-40">
                        <span
                            class="material-symbols-outlined text-9xl text-hotel-gold">receipt_long</span>
                        <p
                            class="text-2xl font-serif italic text-hotel-text tracking-widest uppercase">
                            Hóa đơn không tồn tại</p>
                        <p
                            class="text-hotel-muted uppercase text-[10px] tracking-widest">
                            Hệ thống không tìm thấy dữ liệu đặt phòng hoặc hóa đơn này</p>
                    </div>
                <% } else { %>

                    <!-- Header -->
                    <header
                        class="flex flex-col md:flex-row justify-between items-start gap-12 border-b border-hotel-gold/10 pb-12">
                        <div class="space-y-6">
                            <div class="flex items-center gap-5">
                                <div
                                    class="w-16 h-16 bg-hotel-gold/10 rounded-2xl flex items-center justify-center text-hotel-gold">
                                    <span
                                        class="material-symbols-outlined text-4xl">hotel_class</span>
                                </div>
                                <div>
                                    <h1
                                        class="text-4xl font-serif font-bold text-hotel-text tracking-tight uppercase italic">
                                        SmartHotel</h1>
                                    <p
                                        class="text-[10px] font-bold text-hotel-gold tracking-[0.4em] uppercase mt-1">
                                        Trải Nghệm Đẳng Cấp Thượng Lưu</p>
                                </div>
                            </div>
                            <div
                                class="text-[11px] font-medium tracking-wide text-hotel-muted uppercase space-y-1 italic">
                                <p>Địa chỉ: 01 Nguyễn Văn Linh, Hải Châu, Đà Nẵng
                                </p>
                                <p>Hotline: (+84) 123 456 789 | Email:
                                    contact@smarthotel.luxury</p>
                            </div>
                        </div>
                        <div class="md:text-right space-y-4">
                            <div
                                class="inline-flex px-6 py-2 rounded-full <%= (inv != null || (booking != null && "Confirmed".equalsIgnoreCase(booking.getStatus()))) ? "bg-accent-emerald/5 border border-accent-emerald/20 text-accent-emerald" : "bg-amber-500/5 border border-amber-500/20 text-amber-500" %> text-[11px] font-bold tracking-[0.3em] uppercase">
                                <%= (inv != null || (booking != null && "Confirmed".equalsIgnoreCase(booking.getStatus()))) ? "ĐÃ THANH TOÁN" : "CHƯA THANH TOÁN" %>
                            </div>
                            <p
                                class="text-[10px] font-medium tracking-widest text-hotel-muted uppercase italic">
                                <%= (inv != null || (booking != null && "Confirmed".equalsIgnoreCase(booking.getStatus()))) ? "Giao dịch đã được hệ thống xác thực" : "Thông tin đặt phòng hiện tại" %></p>
                        </div>
                    </header>

                    <!-- Client Info Section -->
                    <section class="grid grid-cols-1 md:grid-cols-2 gap-16">
                        <div class="space-y-8">
                            <div class="space-y-3">
                                <p
                                    class="text-[10px] font-bold text-hotel-muted tracking-[0.3em] uppercase border-b border-hotel-gold/10 pb-2">
                                    Người nhận thanh toán</p>
                                <h3
                                    class="text-2xl font-serif font-bold text-hotel-text uppercase italic tracking-tight">
                                    <%= (booking != null && booking.getCustomer() != null) ? 
                                        booking.getCustomer().getFullName() : 
                                        (inv != null && inv.getCustomer() != null ? inv.getCustomer().getFullName() : "Khách Hàng") %>
                                </h3>
                                <div class="flex items-center gap-3">
                                    <span
                                        class="text-hotel-gold text-[11px] font-bold tracking-[0.2em] uppercase">
                                        Mã số khách: #<%= (booking != null && booking.getCustomer() != null) ? 
                                            booking.getCustomer().getCustomerID() : 
                                            (inv != null && inv.getCustomer() != null ? inv.getCustomer().getCustomerID() : "---") %>
                                    </span>
                                </div>
                            </div>
                            <div class="space-y-2">
                                <p
                                    class="text-[10px] font-bold text-hotel-muted tracking-[0.3em] uppercase">
                                    Mã đặt phòng tham chiếu</p>
                                <p
                                    class="text-hotel-chocolate font-serif font-bold text-xl tracking-widest italic uppercase">
                                    #BK-<%= (booking != null) ? booking.getBookingID() : (inv != null && inv.getBooking() != null ? inv.getBooking().getBookingID() : "VOID") %>
                                </p>
                            </div>
                        </div>
                        <div class="md:text-right space-y-8">
                            <div class="space-y-2">
                                <p
                                    class="text-[10px] font-bold text-hotel-muted tracking-[0.3em] uppercase">
                                    Số hóa đơn định danh</p>
                                <p
                                    class="text-hotel-text font-serif font-bold text-4xl tracking-tighter uppercase italic">
                                    INV-<span
                                        class="text-hotel-gold"><%= (inv != null) ? inv.getInvoiceID() : "DRAFT" %></span>
                                </p>
                            </div>
                            <div class="space-y-2">
                                <p
                                    class="text-[10px] font-bold text-hotel-muted tracking-[0.3em] uppercase">
                                    Ngày khởi tạo</p>
                                <p
                                    class="text-hotel-text font-bold text-[13px] uppercase tracking-widest italic">
                                    <%= (inv != null && inv.getCreatedDate() != null) ? 
                                        new java.text.SimpleDateFormat("dd/MM/yyyy · HH:mm:ss").format(inv.getCreatedDate()) : 
                                        (booking != null && booking.getCheckInDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(booking.getCheckInDate()) : "N/A") %>
                                </p>
                            </div>
                        </div>
                    </section>

                    <!-- Services Detail Table -->
                    <section
                        class="rounded-2xl overflow-hidden border border-hotel-gold/10">
                        <table class="w-full text-left">
                            <thead>
                                <tr
                                    class="bg-hotel-gold/5 border-b border-hotel-gold/10">
                                    <th
                                        class="py-6 px-10 text-[10px] font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                        STT</th>
                                    <th
                                        class="py-6 px-10 text-[10px] font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                        Dịch Vụ & Tiện Ích</th>
                                    <th
                                        class="py-6 px-10 text-[10px] font-bold text-hotel-chocolate uppercase tracking-[0.4em] text-center">
                                        SL</th>
                                    <th
                                        class="py-6 px-10 text-[10px] font-bold text-hotel-chocolate uppercase tracking-[0.4em] text-right">
                                        Đơn Giá</th>
                                    <th
                                        class="py-6 px-10 text-[10px] font-bold text-hotel-chocolate uppercase tracking-[0.4em] text-right">
                                        Thành Tiền</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-hotel-gold/5">
                                <% 
                                   double subtotalVal = 0;
                                   double discountVal = 0;
                                   
                                   if (inv != null) {
                                       discountVal = (inv.getDiscount() != null) ? inv.getDiscount() : 0.0;
                                       List<InvoiceItem> items = inv.getItems();
                                       int idx = 1;
                                       for (InvoiceItem it : items) {
                                           double line = (it.getUnitPrice() != null ? it.getUnitPrice() : 0.0) * (it.getQuantity() != null ? it.getQuantity() : 0);
                                           subtotalVal += line;
                                   %>
                                   <tr class="hover:bg-hotel-gold/5 transition-colors group">
                                       <td class="py-6 px-10 text-[12px] font-medium text-hotel-muted opacity-50 group-hover:opacity-100 italic transition-all">
                                           <%= String.format("%02d", idx++) %>
                                       </td>
                                       <td class="py-6 px-10 font-serif font-bold text-hotel-text text-[14px] uppercase tracking-wide italic">
                                           <%= it.getInventory() != null ? it.getInventory().getItemName() : "Dịch vụ phòng / Nghỉ dưỡng" %>
                                       </td>
                                       <td class="py-6 px-10 text-center text-hotel-gold font-bold text-[14px]">
                                           <%= it.getQuantity() != null ? it.getQuantity() : 0 %>
                                       </td>
                                       <td class="py-6 px-10 text-right text-hotel-muted font-medium text-[13px]">
                                           <%= String.format("%,.0f", it.getUnitPrice() != null ? it.getUnitPrice() : 0.0) %>
                                       </td>
                                       <td class="py-6 px-10 text-right text-hotel-text font-bold text-[14px] tabular-nums">
                                           <%= String.format("%,.0f", line) %>
                                           <span class="text-[10px] font-normal text-hotel-muted ml-1">VND</span>
                                       </td>
                                   </tr>
                                   <% } 
                                   } else if (booking != null) { 
                                       long diff = booking.getCheckOutDate().getTime() - booking.getCheckInDate().getTime();
                                       long days = diff / (1000 * 60 * 60 * 24);
                                       if (days <= 0) days = 1;
                                       double originalPrice = booking.getRoom().getPrice() * days;
                                       subtotalVal = originalPrice;
                                       discountVal = originalPrice - booking.getTotalAmount();
                                       if (discountVal < 0) discountVal = 0; // Tránh số âm nếu nhỡ có lỗi logic đâu đó
                                   %>
                                   <tr class="hover:bg-hotel-gold/5 transition-colors group">
                                       <td class="py-6 px-10 text-[12px] font-medium text-hotel-muted opacity-50 group-hover:opacity-100 italic transition-all">01</td>
                                       <td class="py-6 px-10 font-serif font-bold text-hotel-text text-[14px] uppercase tracking-wide italic">Dịch vụ đặt phòng (Dự kiến)</td>
                                       <td class="py-6 px-10 text-center text-hotel-gold font-bold text-[14px]"><%= days %></td>
                                       <td class="py-6 px-10 text-right text-hotel-muted font-medium text-[13px]"><%= String.format("%,.0f", booking.getRoom().getPrice()) %></td>
                                       <td class="py-6 px-10 text-right text-hotel-text font-bold text-[14px] tabular-nums"><%= String.format("%,.0f", originalPrice) %> <span class="text-[10px] font-normal text-hotel-muted ml-1">VND</span></td>
                                   </tr>
                                   <% } %>
                            </tbody>
                        </table>
                    </section>

                    <!-- Summary & Totals -->
                    <section
                        class="flex flex-col md:flex-row justify-between gap-16 pt-8">
                        <div class="max-w-md space-y-4">
                            <p
                                class="text-[10px] font-bold text-hotel-muted tracking-[0.3em] uppercase">
                                Ghi Chú</p>
                            <p
                                class="text-hotel-muted text-[11px] leading-relaxed font-medium uppercase italic tracking-widest opacity-80 decoration-hotel-gold/30">
                                Hóa đơn này được xác thực tự động bởi hệ thống quản
                                lý SmartHotel ngay sau khi giao dịch thành công.
                                Mọi chi tiết về dịch vụ thượng lưu (Elite Benefits)
                                đã được đồng bộ hóa trên toàn hệ thống.
                            </p>
                        </div>
                        <div class="w-full md:w-80 space-y-6 pt-4">
                            <div
                                class="flex justify-between items-center text-[11px] font-bold uppercase tracking-wider">
                                <span class="text-hotel-muted">Tổng phí dịch
                                    vụ</span>
                                <span class="text-hotel-text">
                                    <%= String.format("%,.0f", subtotalVal) %> <span
                                            class="text-[9px] font-normal">VND</span>
                                </span>
                            </div>
                            <div
                                class="flex justify-between items-center text-[11px] font-bold uppercase tracking-wider text-accent-emerald">
                                <span class="flex items-center gap-2">Khuyến mãi /
                                    Giảm trừ</span>
                                <span>- <%= String.format("%,.0f", discountVal) %> <span
                                            class="text-[9px] font-normal">VND</span></span>
                            </div>
                            <div class="h-px bg-hotel-gold/20"></div>
                            <div class="flex justify-between items-end">
                                <div class="space-y-1">
                                    <span
                                        class="text-[9px] font-bold text-hotel-gold tracking-[0.4em] uppercase block">Tổng
                                        thanh toán</span>
                                    <span
                                        class="text-4xl font-serif font-bold text-hotel-text tracking-widest uppercase italic leading-none">
                                    <%= String.format("%,.0f", (inv != null) ? inv.getTotalAmount() : (booking != null ? booking.getTotalAmount() : subtotalVal)) %>
                                    </span>
                                </div>
                                <span
                                    class="text-xs font-bold text-hotel-muted uppercase pb-1">VND</span>
                            </div>
                        </div>
                    </section>

                    <!-- Verification & Signoff -->
                    <footer class="pt-24 border-t border-hotel-gold/10">
                        <div class="grid grid-cols-2 gap-20">
                            <div class="space-y-6">
                                <p
                                    class="text-[9px] font-bold tracking-[0.4em] text-hotel-muted uppercase italic">
                                    Đại diện khách sạn</p>
                                <div class="w-full h-[1px] bg-hotel-gold/10 mb-8">
                                </div>
                                <div class="text-center">
                                    <p
                                        class="font-serif italic text-hotel-gold text-2xl">
                                        Quản lý hệ thống</p>
                                    <p
                                        class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest mt-2">
                                        SmartHotel Administration</p>
                                </div>
                            </div>
                            <div class="space-y-6 text-right">
                                <p
                                    class="text-[9px] font-bold tracking-[0.4em] text-hotel-muted uppercase italic">
                                    Xác nhận của Khách hàng</p>
                                <div class="w-full h-[1px] bg-hotel-gold/10 mb-8">
                                </div>
                                <p
                                    class="text-xl font-serif italic text-hotel-text uppercase tracking-widest">
                                    <%= (booking != null && booking.getCustomer() != null) ? 
                                        booking.getCustomer().getFullName() : 
                                        (inv != null && inv.getCustomer() != null ? inv.getCustomer().getFullName() : "Thành Viên Được Xác Thực") %>
                                </p>
                            </div>
                        </div>
                        <div class="pt-24 text-center space-y-6">
                            <p
                                class="text-[10px] font-bold tracking-[1em] text-hotel-muted uppercase italic opacity-60">
                                Cảm ơn quý khách đã tin tưởng và sử dụng dịch vụ</p>
                            <div
                                class="flex justify-center gap-8 text-[9px] font-bold text-hotel-gold tracking-[0.3em] uppercase">
                                <span>Lưu Trú Nghệ Thuật</span>
                                <span class="opacity-30">•</span>
                                <span>Tiện Nghi Đẳng Cấp</span>
                                <span class="opacity-30">•</span>
                                <span>Phục Vụ Tận Tâm</span>
                            </div>
                        </div>
                    </footer>
                <% } %>
            </div>
        </div>
    </div>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>

</html>