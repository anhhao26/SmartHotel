<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="model.Booking" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Chỉnh Sửa Đặt Phòng - SmartHotel</title>

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
        .form-card {
            background: #FFFFFF;
            border: 1px solid rgba(184, 154, 108, 0.15);
            box-shadow: 0 40px 100px -20px rgba(74, 66, 56, 0.12);
        }

        .input-premium {
            background: #FDFCFB;
            border: 1px solid rgba(184, 154, 108, 0.15);
            transition: all 0.3s ease;
        }

        .input-premium:focus {
            border-color: #B89A6C;
            background: #FFFFFF;
            box-shadow: 0 0 0 4px rgba(184, 154, 108, 0.05);
            outline: none;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

    <jsp:include page="/common/neural_shell_top.jspf">
        <jsp:param name="active" value="bookings" />
    </jsp:include>

    <%
        Booking b = (Booking) request.getAttribute("booking");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    %>

    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-4xl mx-auto px-6 py-12 animate-[slideUp_0.6s_ease-out]">
            
            <!-- Breadcrumb / Back Link -->
            <a href="${pageContext.request.contextPath}/admin/bookings" 
               class="inline-flex items-center gap-2 mb-8 text-[10px] font-bold tracking-[0.2em] uppercase text-hotel-muted hover:text-hotel-gold transition-colors group">
                <span class="material-symbols-outlined text-lg group-hover:-translate-x-1 transition-transform">arrow_back</span>
                Trở lại danh sách
            </a>

            <div class="form-card rounded-[2.5rem] p-12 md:p-16 space-y-12">
                <header class="space-y-4">
                    <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-[9px] font-bold uppercase tracking-widest">
                        Cập nhật thông tin lưu trú
                    </div>
                    <h1 class="text-4xl font-serif font-bold italic tracking-tight uppercase">Chỉnh Sửa <span class="text-hotel-gold">Đặt Phòng.</span></h1>
                    <p class="text-hotel-muted text-sm italic opacity-70">Thay đổi thông tin chi tiết cho mã đặt phòng #BK-<%= b.getBookingID() %></p>
                </header>

                <form action="${pageContext.request.contextPath}/admin/bookings" method="post" class="space-y-10">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="bookingId" value="<%= b.getBookingID() %>" />

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
                        <!-- Client Info (Read Only for safety in this simple edit) -->
                        <div class="space-y-2">
                            <label class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest block ml-1">Khách hàng</label>
                            <div class="p-4 rounded-2xl bg-hotel-bone border border-hotel-gold/5 text-hotel-chocolate font-serif font-bold italic text-lg uppercase tracking-wide">
                                <%= b.getCustomer().getFullName() %>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest block ml-1">Phòng hiện tại</label>
                            <div class="p-4 rounded-2xl bg-hotel-bone border border-hotel-gold/5 text-hotel-chocolate font-serif font-bold italic text-lg uppercase tracking-wide">
                                Room <%= b.getRoom().getRoomNumber() %>
                            </div>
                        </div>

                        <!-- Date Selection -->
                        <div class="space-y-2">
                            <label for="checkIn" class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest block ml-1">Ngày Check-in</label>
                            <input type="date" id="checkIn" name="checkIn" required 
                                   value="<%= sdf.format(b.getCheckInDate()) %>"
                                   class="w-full p-4 rounded-2xl input-premium font-bold text-hotel-text tracking-tight uppercase text-sm" />
                        </div>

                        <div class="space-y-2">
                            <label for="checkOut" class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest block ml-1">Ngày Check-out</label>
                            <input type="date" id="checkOut" name="checkOut" required 
                                   value="<%= sdf.format(b.getCheckOutDate()) %>"
                                   class="w-full p-4 rounded-2xl input-premium font-bold text-hotel-text tracking-tight uppercase text-sm" />
                        </div>

                        <!-- Status Selection -->
                        <div class="space-y-2 md:col-span-2">
                            <label for="status" class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest block ml-1">Trạng thái đặt phòng</label>
                            <select id="status" name="status" 
                                    class="w-full p-4 rounded-2xl input-premium font-bold text-hotel-text uppercase text-sm cursor-pointer appearance-none">
                                <option value="Pending" <%= "Pending".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Đang Chờ (Pending)</option>
                                <option value="Confirmed" <%= "Confirmed".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Đã Xác Nhận (Confirmed)</option>
                                <option value="Checked-in" <%= "Checked-in".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Đã Nhận Phòng (Checked-in)</option>
                                <option value="Completed" <%= "Completed".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Đã Hoàn Thành (Completed)</option>
                                <option value="Cancelled" <%= "Cancelled".equalsIgnoreCase(b.getStatus()) ? "selected" : "" %>>Đã Hủy (Cancelled)</option>
                            </select>
                        </div>
                    </div>

                    <div class="pt-8 flex flex-col md:flex-row gap-4">
                        <button type="submit" 
                                class="flex-1 bg-hotel-gold text-white px-10 py-5 rounded-2xl font-bold text-[11px] tracking-[0.3em] uppercase hover:bg-hotel-chocolate transition-all shadow-lg active:scale-[0.98]">
                            Lưu thay đổi hệ thống
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/bookings" 
                           class="px-10 py-5 rounded-2xl border border-hotel-gold/20 text-hotel-muted font-bold text-[11px] tracking-[0.3em] uppercase hover:bg-white text-center transition-all">
                            Hủy bỏ
                        </a>
                    </div>
                </form>

                <footer class="pt-8 border-t border-hotel-gold/10 text-center">
                    <p class="text-[9px] font-medium tracking-[0.5em] text-hotel-muted/40 uppercase italic">
                        SmartHotel • Intelligence Engine Layer v2.0
                    </p>
                </footer>
            </div>
        </div>
    </div>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>
