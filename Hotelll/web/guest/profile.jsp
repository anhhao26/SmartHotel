<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="service.CustomerService" %>
<%@ page import="model.Customer" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <title>SmartHotel - Hồ Sơ Hội Viên</title>

                    <!-- Premium Fonts -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap"
                        rel="stylesheet">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                        rel="stylesheet" />
                    <script src="https://unpkg.com/alpinejs" defer></script>

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
                            transform: translateY(-8px);
                            box-shadow: 0 30px 60px -20px rgba(184, 154, 108, 0.15);
                        }

                        .input-elegant {
                            background: #FDFCFB;
                            border: 1px solid rgba(184, 154, 108, 0.1);
                            color: #2C2722;
                            transition: all 0.4s ease;
                        }

                        .input-elegant:focus {
                            outline: none;
                            border-color: #B89A6C;
                            background: #FFFFFF;
                            box-shadow: 0 0 20px rgba(184, 154, 108, 0.1);
                        }

                        .avatar-frame {
                            position: relative;
                            padding: 8px;
                            background: linear-gradient(135deg, #B89A6C 0%, #FAF9F6 100%);
                            border-radius: 50%;
                        }

                        .btn-hotel-gold {
                            background: #B89A6C;
                            color: white;
                            transition: all 0.4s ease;
                        }

                        .btn-hotel-gold:hover {
                            background: #2C2722;
                            transform: translateY(-2px);
                            box-shadow: 0 10px 20px rgba(184, 154, 108, 0.2);
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

                        ::-webkit-scrollbar-thumb {
                            background: #B89A6C;
                            border-radius: 10px;
                        }

                        .label-premium {
                            font-family: 'Inter', sans-serif;
                            font-size: 10px;
                            font-weight: 700;
                            text-transform: uppercase;
                            letter-spacing: 0.25em;
                            color: #70685F;
                            margin-bottom: 0.5rem;
                            display: block;
                            opacity: 0.8;
                        }
                    </style>
                </head>

                <body class="font-sans antialiased min-h-screen relative bg-hotel-cream">


                <% Object logSession = session.getAttribute("acc"); if (logSession == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; } Integer cid = (Integer) session.getAttribute("CUST_ID"); if (cid == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; } service.CustomerService cs = new service.CustomerService(); model.Customer cus = cs.getById(cid); if (cus == null) { out.print("<div class='p-24 text-center text-hotel-gold font-serif text-3xl italic tracking-tight'>Không tìm thấy thông tin hội viên.</div>"); return; } %>


                        <!-- Premium Navigation -->
                        <header
                            class="sticky top-0 z-50 w-full border-b border-hotel-gold/10 bg-white/80 backdrop-blur-xl">
                            <div class="mx-auto flex h-24 max-w-[1700px] items-center justify-between px-12 md:px-24">
                                <a href="<%=request.getContextPath()%>/" class="flex items-center gap-5 group">
                                    <div
                                        class="w-12 h-12 rounded-sm bg-hotel-gold/5 border border-hotel-gold/20 flex items-center justify-center transition-transform duration-500">
                                        <span class="material-symbols-outlined text-hotel-gold text-3xl">hotel</span>
                                    </div>
                                    <div>
                                        <h2
                                            class="text-hotel-text text-xl font-serif font-bold tracking-tight uppercase leading-none">
                                            SmartHotel</h2>
                                        <span class="text-[8px] font-bold text-hotel-gold uppercase tracking-widest">HỒ
                                            SƠ HỘI VIÊN</span>
                                    </div>
                                </a>

                                <nav class="hidden lg:flex items-center gap-16">
                                    <a href="<%=request.getContextPath()%>/rooms"
                                        class="nav-item text-[10px] font-bold uppercase tracking-widest text-hotel-muted hover:text-hotel-gold">KHÁCH
                                        SẠN</a>
                                    <a href="<%=request.getContextPath()%>/guest/history.jsp"
                                        class="nav-item text-[10px] font-bold uppercase tracking-widest text-hotel-muted hover:text-hotel-gold">LỊCH
                                        SỬ</a>
                                    <div class="h-6 w-[1px] bg-hotel-gold/20"></div>
                                    <a href="<%=request.getContextPath()%>/logout"
                                        class="flex items-center gap-3 text-red-500/60 hover:text-red-600 transition-all group">
                                        <span class="text-[10px] font-bold uppercase tracking-widest">ĐĂNG XUẤT</span>
                                        <span
                                            class="material-symbols-outlined text-xl group-hover:rotate-90 transition-transform">logout</span>
                                    </a>
                                </nav>
                            </div>
                        </header>

                        <main class="max-w-[1700px] mx-auto px-12 md:px-24 py-24 w-full">

                            <div class="flex flex-col lg:flex-row gap-20">

                                <!-- Left Pillar: Member Profile -->
                                <div class="w-full lg:w-[450px] space-y-12">

                                    <!-- Avatar Card -->
                                    <div class="card-elegant rounded-sm p-16 relative overflow-hidden bg-white">
                                        <div class="flex flex-col items-center space-y-10 relative z-10">
                                            <div class="relative w-56 h-56 group/avatar">
                                                <div class="avatar-frame w-full h-full">
                                                    <div
                                                        class="w-full h-full rounded-full bg-hotel-bone border-2 border-white flex items-center justify-center relative overflow-hidden p-1 shadow-inner">
                                                        <span
                                                            class="material-symbols-outlined text-9xl text-hotel-gold/10">person</span>
                                                        <div
                                                            class="absolute inset-0 bg-hotel-gold/10 flex items-center justify-center opacity-0 group-hover/avatar:opacity-100 transition-opacity cursor-pointer backdrop-blur-sm">
                                                            <span
                                                                class="material-symbols-outlined text-hotel-gold text-4xl">photo_camera</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div
                                                    class="absolute bottom-4 right-4 w-12 h-12 rounded-full bg-hotel-gold border-4 border-white flex items-center justify-center shadow-lg">
                                                    <span
                                                        class="material-symbols-outlined text-sm text-white font-bold">verified</span>
                                                </div>
                                            </div>

                                            <div class="text-center space-y-4">
                                                <h2
                                                    class="text-4xl font-serif font-bold text-hotel-text tracking-tight uppercase leading-tight">
                                                    <%= cus.getFullName() !=null ? cus.getFullName() : "CHƯA CẬP NHẬT"
                                                        %>
                                                </h2>
                                                <div
                                                    class="inline-flex items-center px-8 py-2.5 rounded-sm border border-hotel-gold/30 bg-hotel-gold/5">
                                                    <span
                                                        class="text-[10px] font-bold text-hotel-gold uppercase tracking-widest">
                                                        <%= cus.getMemberType() !=null ?
                                                            cus.getMemberType().toUpperCase() : "HỘI VIÊN TIÊU CHUẨN" %>
                                                    </span>
                                                </div>
                                            </div>

                                            <!-- Member Metrics -->
                                            <div
                                                class="grid grid-cols-2 gap-6 w-full pt-12 border-t border-hotel-gold/10">
                                                <div class="text-center">
                                                    <p
                                                        class="text-[9px] text-hotel-muted font-bold tracking-widest uppercase mb-2">
                                                        ĐIỂM THƯỞNG</p>
                                                    <p class="text-3xl font-serif font-bold text-hotel-gold">
                                                        <%= cus.getPoints() !=null ? cus.getPoints() : 0 %>
                                                    </p>
                                                </div>
                                                <div class="text-center">
                                                    <p
                                                        class="text-[9px] text-hotel-muted font-bold tracking-widest uppercase mb-2">
                                                        CHI TIÊU</p>
                                                    <p class="text-2xl font-serif font-bold text-hotel-text">
                                                        <%= cus.getTotalSpending() !=null ? String.format("%,.0f",
                                                            cus.getTotalSpending()) : "0" %><span
                                                                class="text-xs ml-1 text-hotel-gold font-sans">đ</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Strategic Shortcuts -->
                                    <div
                                        class="card-elegant rounded-sm p-12 space-y-8 border-l-4 border-l-hotel-gold relative bg-white">
                                        <h3
                                            class="text-xs font-serif font-bold text-hotel-text uppercase tracking-widest flex items-center gap-3">
                                            <span class="w-2 h-2 rounded-full bg-hotel-gold"></span>
                                            TIỆN ÍCH NHANH
                                        </h3>
                                        <div class="grid grid-cols-1 gap-4">
                                            <a href="<%=request.getContextPath()%>/rooms"
                                                class="w-full h-18 py-5 rounded-sm bg-hotel-gold text-white font-bold text-[10px] tracking-widest uppercase flex items-center justify-center gap-4 hover:bg-hotel-text transition-all active:scale-95 group">
                                                KHÁM PHÁ PHÒNG <span
                                                    class="material-symbols-outlined text-lg group-hover:translate-x-1 transition-transform">king_bed</span>
                                            </a>
                                            <a href="<%=request.getContextPath()%>/guest/history.jsp"
                                                class="w-full h-18 py-5 rounded-sm border border-hotel-gold/20 text-hotel-muted font-bold text-[10px] tracking-widest uppercase flex items-center justify-center gap-4 hover:bg-hotel-gold/5 hover:text-hotel-gold transition-all group">
                                                LỊCH SỬ ĐẶT PHÒNG <span
                                                    class="material-symbols-outlined text-lg">calendar_month</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Right Pillar: Infomation Nucleus -->
                                <div class="flex-1 space-y-12">

                                    <div class="card-elegant rounded-sm overflow-hidden bg-white">
                                        <div
                                            class="px-16 py-10 bg-hotel-gold/5 border-b border-hotel-gold/10 flex items-center justify-between">
                                            <div class="flex items-center gap-5">
                                                <span
                                                    class="material-symbols-outlined text-hotel-gold text-3xl">badge</span>
                                                <div>
                                                    <h3
                                                        class="text-[11px] font-bold text-hotel-text uppercase tracking-widest">
                                                        THÔNG TIN CƠ BẢN</h3>
                                                    <p
                                                        class="text-[8px] text-hotel-gold font-bold uppercase tracking-widest mt-1">
                                                        Trạng thái: Đã xác thực thông tin</p>
                                                </div>
                                            </div>
                                            <div
                                                class="flex items-center gap-2 text-hotel-gold font-bold text-[9px] tracking-widest opacity-60">
                                                Dữ liệu bảo mật <span
                                                    class="material-symbols-outlined text-xs">verified_user</span>
                                            </div>
                                        </div>

                                        <div class="p-16 lg:p-20">
                                            <form action="${pageContext.request.contextPath}/updateProfile"
                                                method="post" class="space-y-16">
                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-x-16 gap-y-12">
                                                    <div class="space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Danh xưng hội viên (Full Name)</label>
                                                        <input name="fullName"
                                                            value="<%= cus.getFullName() != null ? cus.getFullName() : "" %>"
                                                            required
                                                            class="w-full h-18 px-10 rounded-xl input-elegant font-serif font-bold text-2xl tracking-tight text-hotel-text border-hotel-gold/10"
                                                            type="text" />
                                                    </div>

                                                    <div class="space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Định danh pháp lý (ID / Passport)</label>
                                                        <input name="cccd"
                                                            value="<%= cus.getCccdPassport() != null ? cus.getCccdPassport() : "" %>"
                                                            class="w-full h-18 px-10 rounded-xl input-elegant font-bold text-xl tracking-widest uppercase text-hotel-text border-hotel-gold/10"
                                                            type="text" placeholder="CHƯA CẬP NHẬT" />
                                                    </div>

                                                    <div class="space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Liên lạc di động (Phone)</label>
                                                        <div class="relative">
                                                            <input name="phone"
                                                                value="<%= cus.getPhone() != null ? cus.getPhone() : "" %>"
                                                                class="w-full h-18 px-10 rounded-xl input-elegant font-bold text-xl tracking-wide text-hotel-text border-hotel-gold/10"
                                                                type="text" />
                                                            <span
                                                                class="material-symbols-outlined absolute right-10 top-1/2 -translate-y-1/2 text-hotel-gold/30 group-focus-within:text-hotel-gold transition-colors">phone_iphone</span>
                                                        </div>
                                                    </div>

                                                    <div class="space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Địa chỉ thư điện tử (Email)</label>
                                                        <div class="relative">
                                                            <input name="email"
                                                                value="<%= cus.getEmail() != null ? cus.getEmail() : "" %>"
                                                                class="w-full h-18 px-10 rounded-xl input-elegant font-bold text-lg text-hotel-text border-hotel-gold/10"
                                                                type="email" />
                                                            <span
                                                                class="material-symbols-outlined absolute right-10 top-1/2 -translate-y-1/2 text-hotel-gold/30 group-focus-within:text-hotel-gold transition-colors">mail</span>
                                                        </div>
                                                    </div>

                                                    <div class="space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Quốc tịch (Nationality)</label>
                                                        <input name="nationality"
                                                            value="<%= cus.getNationality() != null ? cus.getNationality() : "" %>"
                                                            class="w-full h-18 px-10 rounded-xl input-elegant font-bold text-xl uppercase tracking-widest text-hotel-text border-hotel-gold/10"
                                                            type="text" placeholder="VIỆT NAM" />
                                                    </div>

                                                    <div class="space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Ngày sinh nhật (Birth Date)</label>
                                                        <% String birthVal="" ; if (cus.getDateOfBirth() !=null) {
                                                            birthVal=new
                                                            java.text.SimpleDateFormat("yyyy-MM-dd").format(cus.getDateOfBirth());
                                                            } %>
                                                            <input name="dob" value="<%= birthVal %>"
                                                                class="w-full h-18 px-10 rounded-xl input-elegant font-bold text-hotel-muted text-xl border-hotel-gold/10"
                                                                type="date" />
                                                    </div>

                                                    <div class="md:col-span-2 space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Địa chỉ liên hệ (Permanent Address)</label>
                                                        <input name="address"
                                                            value="<%= cus.getAddress() != null ? cus.getAddress() : "" %>"
                                                            class="w-full h-18 px-10 rounded-xl input-elegant font-bold text-lg text-hotel-text border-hotel-gold/10"
                                                            type="text" placeholder="CHƯA CẬP NHẬT" />
                                                    </div>

                                                    <div class="md:col-span-2 space-y-1 group">
                                                        <label class="label-premium ml-1 group-focus-within:text-hotel-gold transition-colors">Đặc quyền & Ghi chú (Preferences)</label>
                                                        <textarea name="preferences" rows="5"
                                                            class="w-full p-10 rounded-xl input-elegant font-bold text-lg resize-none placeholder:text-hotel-muted/20 text-hotel-text border-hotel-gold/10"
                                                            placeholder="VD: Phòng hướng biển, ít tiếng ồn, trà xanh..."><%= cus.getPreferences() != null ? cus.getPreferences() : "" %></textarea>
                                                    </div>
                                                </div>

                                                <div class="pt-12 flex justify-end">
                                                    <button type="submit"
                                                        class="h-24 px-20 rounded-sm bg-hotel-gold text-white font-bold text-[11px] tracking-widest uppercase hover:bg-hotel-text transition-all flex items-center gap-5 active:scale-95 group">
                                                        LƯU THÔNG TIN <span
                                                            class="material-symbols-outlined text-2xl group-hover:rotate-12 transition-transform">content_copy</span>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>

                        <footer class="bg-white border-t border-hotel-gold/10 py-24 mt-32">
                            <div
                                class="max-w-[1700px] mx-auto px-24 flex flex-col md:flex-row justify-between items-center gap-12">
                                <div class="flex flex-col items-center md:items-start gap-4">
                                    <div class="flex items-center gap-4 text-hotel-gold">
                                        <span class="material-symbols-outlined text-3xl">hotel</span>
                                        <h4
                                            class="font-serif font-bold text-2xl tracking-tight uppercase text-hotel-text">
                                            SmartHotel</h4>
                                    </div>
                                    <p class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest">© 2026
                                        SmartHotel - Tôn vinh trải nghiệm nghỉ dưỡng thượng lưu</p>
                                </div>

                                <div class="flex gap-16">
                                    <div class="space-y-4 text-center md:text-right">
                                        <p class="text-[8px] font-bold text-hotel-muted uppercase tracking-widest">HỆ
                                            THỐNG</p>
                                        <p class="text-[9px] font-bold text-hotel-gold uppercase tracking-widest">PHIÊN
                                            BẢN 2.0 (MODERN LUXURY)</p>
                                    </div>
                                    <div class="space-y-4 text-center md:text-right">
                                        <p class="text-[8px] font-bold text-hotel-muted uppercase tracking-widest">TRẠNG
                                            THÁI</p>
                                        <p
                                            class="text-[9px] font-bold text-emerald-600 uppercase tracking-widest flex items-center gap-2">
                                            ĐÃ KẾT NỐI <span
                                                class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></span></p>
                                    </div>
                                </div>
                            </div>
                        </footer>
                        <jsp:include page="/common/chat_box.jspf" />
                </body>

                </html>