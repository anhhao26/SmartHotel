<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ page import="dao.BookingDAO" %>
<%@ page import="model.Booking" %>
<%@ page import="model.Customer" %>
                    <%@ page import="java.util.List" %>
                        <% Integer cidObj = (Integer) session.getAttribute("CUST_ID"); if (cidObj == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; } int cid = cidObj; dao.BookingDAO dao = new dao.BookingDAO(); java.util.List<model.Booking> hist = dao.findByCustomerId(cid); %>

                            <!DOCTYPE html>
                            <html lang="vi">

                            <head>
                                <meta charset="utf-8" />
                                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                                <title>SmartHotel - Hành Trình Lưu Trú</title>

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
                                    body {
                                        background-color: #FAF9F6;
                                        color: #2C2722;
                                    }

                                    .card-elegant {
                                        background: #FFFFFF;
                                        border: 1px solid rgba(184, 154, 108, 0.15);
                                        box-shadow: 0 20px 40px -15px rgba(74, 66, 56, 0.08);
                                        transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
                                    }

                                    .card-elegant:hover {
                                        border-color: #B89A6C;
                                        transform: translateX(10px);
                                        box-shadow: 0 30px 60px -20px rgba(184, 154, 108, 0.15);
                                    }

                                    .timeline-line {
                                        background: linear-gradient(to bottom, transparent 0%, #B89A6C 50%, transparent 100%);
                                    }

                                    .status-badge {
                                        padding: 4px 12px;
                                        border-radius: 2px;
                                        font-size: 10px;
                                        font-weight: 700;
                                        text-transform: uppercase;
                                        letter-spacing: 0.1em;
                                    }

                                    .nav-item {
                                        position: relative;
                                        transition: all 0.3s;
                                    }

                                    .nav-item::after {
                                        content: '';
                                        position: absolute;
                                        bottom: -4px;
                                        left: 0;
                                        width: 0;
                                        height: 1.5px;
                                        background: #B89A6C;
                                        transition: all 0.3s;
                                    }

                                    .nav-item:hover::after {
                                        width: 100%;
                                    }

                                    ::-webkit-scrollbar {
                                        width: 4px;
                                    }

                                    ::-webkit-scrollbar-track {
                                        background: transparent;
                                    }

                                    ::-webkit-scrollbar-thumb {
                                        background: #B89A6C;
                                        border-radius: 10px;
                                    }
                                </style>
                            </head>

                            <body class="font-sans antialiased min-h-screen relative bg-hotel-cream">

                                <!-- Premium Navigation -->
                                <header
                                    class="sticky top-0 z-50 w-full border-b border-hotel-gold/10 bg-white/80 backdrop-blur-xl">
                                    <div
                                        class="mx-auto flex h-24 max-w-[1700px] items-center justify-between px-12 md:px-24">
                                        <a href="<%=request.getContextPath()%>/" class="flex items-center gap-5 group">
                                            <div
                                                class="w-12 h-16 rounded-sm bg-hotel-gold/5 border border-hotel-gold/20 flex items-center justify-center transition-transform duration-500">
                                                <span
                                                    class="material-symbols-outlined text-hotel-gold text-3xl">hotel</span>
                                            </div>
                                            <div>
                                                <h2
                                                    class="text-hotel-text text-xl font-serif font-bold tracking-tight uppercase leading-none">
                                                    SmartHotel</h2>
                                                <span
                                                    class="text-xs font-bold text-hotel-gold uppercase tracking-widest">HÀNH
                                                    TRÌNH NGHỈ DƯỠNG</span>
                                            </div>
                                        </a>

                                        <nav class="hidden lg:flex items-center gap-10">
                                            <a href="<%=request.getContextPath()%>/guest/profile.jsp"
                                                class="flex items-center gap-3 group text-hotel-muted hover:text-hotel-gold transition-all">
                                                <span
                                                    class="material-symbols-outlined text-[20px] group-hover:-translate-x-1 transition-transform">arrow_back</span>
                                                <span class="text-sm font-bold uppercase tracking-widest">VỀ HỒ
                                                    SƠ</span>
                                            </a>
                                        </nav>
                                    </div>
                                </header>

                                <main class="max-w-[1300px] mx-auto px-10 md:px-20 py-24 w-full">

                                    <!-- Header Info -->
                                    <div class="mb-32 space-y-6">
                                        <div
                                            class="inline-flex items-center gap-4 px-6 py-2.5 rounded-sm border border-hotel-gold/20 bg-hotel-gold/5 mb-4">
                                            <span class="w-2 h-2 rounded-full bg-hotel-gold"></span>
                                            <span
                                                class="text-sm font-bold text-hotel-gold uppercase tracking-widest">LỊCH
                                                SỬ LƯU TRÚ</span>
                                        </div>
                                        <h1
                                            class="text-7xl font-serif font-bold text-hotel-text tracking-tighter leading-none italic">
                                            Hành Trình <br /><span class="text-hotel-gold not-italic">Của Bạn.</span>
                                        </h1>
                                        <p
                                            class="text-hotel-muted text-xs font-medium uppercase tracking-[0.2em] max-w-xl leading-relaxed">
                                            Nơi ghi dấu những khoảnh khắc nghỉ dưỡng tuyệt vời và trải nghiệm thượng lưu
                                            tại SmartHotel.
                                        </p>
                                    </div>

                                    <!-- Timeline Content -->
                                    <div class="relative pl-16 md:pl-28">
                                        <!-- Spine -->
                                        <div class="absolute left-0 h-full w-[1.5px] timeline-line"></div>

                                        <div class="space-y-20">
                                            <% if (hist !=null && !hist.isEmpty()) { for (model.Booking h
                                                : hist) { String s_status=h.getStatus() !=null ? h.getStatus()
                                                : "Pending" ; boolean isCompleted=s_status.equalsIgnoreCase("Completed")
                                                || s_status.equalsIgnoreCase("Checked-out"); String
                                                checkIn=h.getCheckInDate() !=null ? new
                                                java.text.SimpleDateFormat("dd/MM/yyyy").format(h.getCheckInDate())
                                                : "N/A" ; String checkOut=h.getCheckOutDate() !=null ? new
                                                java.text.SimpleDateFormat("dd/MM/yyyy").format(h.getCheckOutDate())
                                                : "N/A" ; String roomNum=h.getRoom() !=null ?
                                                h.getRoom().getRoomNumber() : "---" ; String total=h.getTotalAmount()
                                                !=null ? String.format("%,.0f", h.getTotalAmount()) : "0" ; String
                                                statusVn="Đang xử lý" ; String
                                                statusColor="bg-hotel-gold/10 text-hotel-gold" ; if
                                                (s_status.equalsIgnoreCase("Completed") ||
                                                s_status.equalsIgnoreCase("Checked-out")) { statusVn="Hoàn tất" ;
                                                statusColor="bg-emerald-50 text-emerald-600" ; } else if
                                                (s_status.equalsIgnoreCase("Confirmed")) { statusVn="Đã xác nhận" ;
                                                statusColor="bg-blue-50 text-blue-600" ; } else if
                                                (s_status.equalsIgnoreCase("Checked-in")) { statusVn="Đã nhận phòng" ;
                                                statusColor="bg-amber-50 text-amber-600" ; } else if
                                                (s_status.equalsIgnoreCase("Cancelled")) { statusVn="Đã hủy" ;
                                                statusColor="bg-red-50 text-red-600" ; } %>
                                                <!-- Booking Entry -->
                                                <div class="relative group">
                                                    <!-- Timeline Marker -->
                                                    <div
                                                        class="absolute -left-[16.5px] md:-left-[28.5px] top-0 w-8 h-8 md:w-12 md:h-16 rounded-full border border-hotel-gold bg-white flex items-center justify-center shadow-lg transition-transform group-hover:scale-110">
                                                        <span
                                                            class="material-symbols-outlined text-[16px] md:text-[24px] text-hotel-gold">
                                                            <%= isCompleted ? "check_circle" : "schedule" %>
                                                        </span>
                                                    </div>

                                                    <!-- Booking Card -->
                                                    <div class="card-elegant rounded-sm p-10 md:p-14 bg-white">
                                                        <div class="flex flex-col xl:flex-row justify-between gap-12">

                                                            <div class="space-y-8 flex-1">
                                                                <div class="flex items-center gap-6">
                                                                    <div
                                                                        class="px-5 py-1.5 rounded-sm bg-hotel-cream border border-hotel-gold/10">
                                                                        <span
                                                                            class="text-sm font-bold text-hotel-gold uppercase tracking-widest">MÃ
                                                                            ĐƠN: #<%= h.getBookingID() %></span>
                                                                    </div>
                                                                    <div class="h-[1px] w-12 bg-hotel-gold/10"></div>
                                                                    <span class="status-badge <%= statusColor %>">
                                                                        <%= statusVn %>
                                                                    </span>
                                                                </div>

                                                                <div class="space-y-2">
                                                                    <h3
                                                                        class="text-4xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                                                                        Phòng <%= roomNum %>
                                                                    </h3>
                                                                    <p
                                                                        class="text-hotel-muted text-sm font-bold uppercase tracking-widest flex items-center gap-2">
                                                                        <span
                                                                            class="material-symbols-outlined text-sm">room_service</span>
                                                                        HẠNG PHÒNG: <%= h.getRoom() !=null ?
                                                                            h.getRoom().getRoomType().getTypeName().toUpperCase()
                                                                            : "DELUXE" %>
                                                                    </p>
                                                                </div>

                                                                <div class="flex items-center gap-12 pt-6">
                                                                    <div class="space-y-1">
                                                                        <p
                                                                            class="text-xs font-bold text-hotel-muted uppercase tracking-widest">
                                                                            CHECK-IN</p>
                                                                        <p
                                                                            class="text-lg font-serif font-bold text-hotel-text border-b border-hotel-gold/30">
                                                                            <%= checkIn %>
                                                                        </p>
                                                                    </div>
                                                                    <div class="w-8 h-[1px] bg-hotel-gold/10"></div>
                                                                    <div class="space-y-1">
                                                                        <p
                                                                            class="text-xs font-bold text-hotel-muted uppercase tracking-widest">
                                                                            CHECK-OUT</p>
                                                                        <p
                                                                            class="text-lg font-serif font-bold text-hotel-muted">
                                                                            <%= checkOut %>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div
                                                                class="xl:text-right flex flex-col justify-between items-start xl:items-end gap-10">
                                                                <div class="space-y-2">
                                                                    <p
                                                                        class="text-sm font-bold text-hotel-muted uppercase tracking-widest">
                                                                        TỔNG THANH TOÁN</p>
                                                                    <p
                                                                        class="text-5xl font-serif font-bold text-hotel-text leading-none tracking-tighter">
                                                                        <%= total %><span
                                                                                class="text-lg ml-2 font-sans text-hotel-gold">đ</span>
                                                                    </p>
                                                                </div>

                                                                <div class="flex gap-4">
                                                                    <a href="<%=request.getContextPath()%>/invoice?bookingId=<%= h.getBookingID() %>"
                                                                        class="h-16 px-8 rounded-sm border border-hotel-gold/20 text-sm font-bold text-hotel-muted uppercase tracking-widest flex items-center gap-3 hover:bg-hotel-gold hover:text-white hover:border-hotel-gold transition-all">
                                                                        XEM CHI TIẾT <span
                                                                            class="material-symbols-outlined text-lg">receipt_long</span>
                                                                    </a>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <% } } else { %>
                                                    <!-- Empty State -->
                                                    <div class="text-center py-48 space-y-8 opacity-40">
                                                        <span
                                                            class="material-symbols-outlined text-[100px] font-light text-hotel-gold/40">bedtime</span>
                                                        <div class="space-y-2">
                                                            <p
                                                                class="text-2xl font-serif font-bold uppercase tracking-widest text-hotel-text">
                                                                Chưa Có Dữ Liệu.</p>
                                                            <p
                                                                class="text-sm font-bold uppercase tracking-widest text-hotel-muted">
                                                                Quý khách chưa có hành trình lưu trú nào tại SmartHotel.
                                                            </p>
                                                        </div>
                                                        <a href="<%=request.getContextPath()%>/rooms"
                                                            class="inline-block px-14 py-5 rounded-sm bg-hotel-gold text-white text-sm font-bold uppercase tracking-widest hover:bg-hotel-text transition-all">
                                                            ĐẶT PHÒNG NGAY
                                                        </a>
                                                    </div>
                                                    <% } %>
                                        </div>
                                    </div>
                                    <!-- Statistical Summary -->
                                    <div class="mt-48 grid grid-cols-1 md:grid-cols-3 gap-12">
                                        <div class="card-elegant p-14 rounded-sm bg-white">
                                            <div
                                                class="w-18 h-18 rounded-sm bg-hotel-gold/5 border border-hotel-gold/20 flex items-center justify-center text-hotel-gold mb-8">
                                                <span class="material-symbols-outlined text-5xl">calendar_month</span>
                                            </div>
                                            <div class="space-y-1">
                                                <p
                                                    class="text-base font-bold text-hotel-muted uppercase tracking-widest">
                                                    TỔNG LẦN LƯU TRÚ</p>
                                                <p
                                                    class="text-5xl font-serif font-bold text-hotel-text tracking-tighter">
                                                    <%= hist !=null ? hist.size() : 0 %>
                                                </p>
                                            </div>
                                        </div>

                                        <div
                                            class="card-elegant p-14 rounded-sm bg-white border-l-4 border-l-hotel-gold">
                                            <div
                                                class="w-18 h-18 rounded-sm bg-hotel-gold/5 flex items-center justify-center text-hotel-gold mb-8">
                                                <span class="material-symbols-outlined text-5xl">verified_user</span>
                                            </div>
                                            <div class="space-y-1">
                                                <p
                                                    class="text-base font-bold text-hotel-muted uppercase tracking-widest">
                                                    LOYALTY STATUS</p>
                                                <p
                                                    class="text-4xl font-serif font-bold text-hotel-text uppercase tracking-tight">
                                                    Hội viên ưu tú</p>
                                            </div>
                                        </div>

                                        <div
                                            class="card-elegant p-14 rounded-sm bg-hotel-cream border border-hotel-gold/10">
                                            <div
                                                class="w-18 h-18 rounded-sm bg-white flex items-center justify-center text-hotel-gold/30 mb-8 border border-hotel-gold/10">
                                                <span class="material-symbols-outlined text-5xl">badge</span>
                                            </div>
                                            <div class="space-y-1">
                                                <p
                                                    class="text-base font-bold text-hotel-muted uppercase tracking-widest">
                                                    MÃ ĐỊNH DANH</p>
                                                <p
                                                    class="text-3xl font-serif font-bold text-hotel-gold italic tracking-widest">
                                                    KH-<%= cid %>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </main>

                                <footer class="bg-white border-t border-hotel-gold/10 py-24 mt-32">
                                    <div
                                        class="max-w-[1600px] mx-auto px-20 flex flex-col md:flex-row justify-between items-center gap-12">
                                        <div class="flex items-center gap-5">
                                            <span
                                                class="material-symbols-outlined text-hotel-gold text-4xl">hotel</span>
                                            <p class="text-base font-bold text-hotel-muted uppercase tracking-widest">
                                                © 2026 SmartHotel - Tuyệt tác nghỉ dưỡng boutique</p>
                                        </div>
                                        <div class="flex gap-16">
                                            <div class="text-right">
                                                <p
                                                    class="text-sm font-bold text-hotel-muted uppercase tracking-widest mb-1">
                                                    DATA SOURCE</p>
                                                <p
                                                    class="text-sm font-bold text-hotel-gold uppercase tracking-widest">
                                                    SYNCED RECOVERY</p>
                                            </div>
                                            <div class="text-right">
                                                <p
                                                    class="text-sm font-bold text-hotel-muted uppercase tracking-widest mb-1">
                                                    MÁY CHỦ</p>
                                                <p
                                                    class="text-sm font-bold text-emerald-600 uppercase tracking-widest flex items-center gap-2">
                                                    LUX-CENTRAL <span
                                                        class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span></p>
                                            </div>
                                        </div>
                                    </div>
                                </footer>

                                <jsp:include page="/common/chat_box.jspf" />
                            </body>

                            </html>