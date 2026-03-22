<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>SmartHotel - Quản Trị Khách Sạn</title>

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
                .card-elegant {
                    background: #FFFFFF;
                    border: 1px solid rgba(184, 154, 108, 0.1);
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.02);
                    transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
                }

                .card-elegant:hover {
                    transform: translateY(-5px);
                    border-color: rgba(184, 154, 108, 0.3);
                    box-shadow: 0 20px 60px rgba(184, 154, 108, 0.08);
                }

                .btn-gold {
                    background: #B89A6C;
                    color: white;
                    transition: all 0.3s ease;
                }

                .btn-gold:hover {
                    background: #4A4238;
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px -5px rgba(184, 154, 108, 0.3);
                }

                .stat-card {
                    background: #FFFFFF;
                    border-left: 4px solid #B89A6C;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
                    transition: all 0.3s ease;
                }

                .stat-card:hover {
                    transform: scale(1.02);
                    box-shadow: 0 15px 30px rgba(184, 154, 108, 0.1);
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            </style>
        </head>

        <body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

            <c:set var="active" value="dashboard" scope="request" />
            <%@ include file="/common/neural_shell_top.jspf" %>

                <div class="flex-1 h-screen overflow-y-auto pb-32">
                    <div class="max-w-7xl mx-auto px-8 lg:px-12 py-12 animate-[fadeIn_0.8s_ease-out] space-y-16">

                        <!-- Welcome Section -->
                        <div
                            class="flex flex-col md:flex-row md:items-end justify-between gap-8 border-b border-hotel-gold/10 pb-12">
                            <div class="space-y-4">
                                <div
                                    class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold uppercase tracking-[0.3em]">
                                    <span class="w-2 h-2 rounded-full bg-hotel-gold animate-pulse"></span>
                                    Hệ Thống Quản Trị Cao Cấp
                                </div>
                                <h2
                                    class="text-6xl font-serif font-bold text-hotel-text leading-tight uppercase tracking-tight">
                                    Bảng Điều Khiển<br /><span class="text-hotel-gold italic">Trung Tâm.</span>
                                </h2>
                                <p class="text-hotel-muted text-lg font-light max-w-xl italic">
                                    Tối ưu hóa vận hành, quản trị doanh thu và nâng tầm trải nghiệm khách hàng tại
                                    SmartHotel.
                                </p>
                            </div>
                            <div class="flex gap-4">
                                <button
                                    class="px-8 py-4 rounded-xl border border-hotel-gold/20 text-hotel-muted text-sm font-bold uppercase tracking-[0.2em] hover:bg-white transition-all">
                                    Xuất báo cáo
                                </button>
                                <button
                                    class="px-8 py-4 rounded-xl btn-gold font-bold text-sm uppercase tracking-[0.2em] shadow-lg">
                                    Cấu hình hệ thống
                                </button>
                            </div>
                        </div>

                        <!-- Stats Grid -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                            <div class="stat-card p-8 rounded-2xl">
                                <div class="flex items-center justify-between mb-8">
                                    <div
                                        class="w-14 h-16 rounded-2xl bg-hotel-gold/5 flex items-center justify-center text-hotel-gold border border-hotel-gold/10">
                                        <span class="material-symbols-outlined text-3xl">payments</span>
                                    </div>
                                    <span
                                        class="text-sm font-bold text-emerald-600 bg-emerald-50 px-3 py-1 rounded-full">+12.5%</span>
                                </div>
                                <p
                                    class="text-hotel-muted text-sm font-bold uppercase tracking-[0.3em] mb-2 opacity-60">
                                    Doanh thu tháng</p>
                                <h3 class="text-4xl font-serif font-bold text-hotel-text tracking-tight">
                                    <fmt:formatNumber value="${monthlyRevenue / 1000000}" pattern="#,##0.0"/>M 
                                    <span class="text-xs text-hotel-muted font-sans ml-1 opacity-40">VND</span>
                                </h3>
                            </div>

                            <div class="stat-card p-8 rounded-2xl border-l-hotel-muted">
                                <div class="flex items-center justify-between mb-8">
                                    <div
                                        class="w-14 h-16 rounded-2xl bg-hotel-muted/5 flex items-center justify-center text-hotel-muted border border-hotel-muted/10">
                                        <span class="material-symbols-outlined text-3xl">bed</span>
                                    </div>
                                    <span
                                        class="text-sm font-bold text-hotel-gold bg-hotel-gold/5 px-3 py-1 rounded-full uppercase tracking-tighter">Cao
                                        điểm</span>
                                </div>
                                <p
                                    class="text-hotel-muted text-sm font-bold uppercase tracking-[0.3em] mb-2 opacity-60">
                                    Công suất phòng</p>
                                <h3 class="text-4xl font-serif font-bold text-hotel-text tracking-tight">
                                    <fmt:formatNumber value="${occupancyRate}" pattern="#,##0.0"/>%
                                </h3>
                            </div>

                            <div class="stat-card p-8 rounded-2xl border-l-hotel-gold/40">
                                <div class="flex items-center justify-between mb-8">
                                    <div
                                        class="w-14 h-16 rounded-2xl bg-hotel-gold/5 flex items-center justify-center text-hotel-gold border border-hotel-gold/10">
                                        <span class="material-symbols-outlined text-3xl">person_check</span>
                                    </div>
                                    <span
                                        class="text-sm font-bold text-hotel-muted bg-hotel-bone px-3 py-1 rounded-full italic">Hôm
                                        nay</span>
                                </div>
                                <p
                                    class="text-hotel-muted text-sm font-bold uppercase tracking-[0.3em] mb-2 opacity-60">
                                    Yêu cầu phục vụ</p>
                                <h3 class="text-4xl font-serif font-bold text-hotel-text tracking-tight">${serviceRequests} <span
                                        class="text-xs text-hotel-muted font-sans ml-1 opacity-40">Phục vụ</span></h3>
                            </div>

                            <div class="stat-card p-8 rounded-2xl">
                                <div class="flex items-center justify-between mb-8">
                                    <div
                                        class="w-14 h-16 rounded-2xl bg-hotel-gold/5 flex items-center justify-center text-hotel-gold border border-hotel-gold/10">
                                        <span class="material-symbols-outlined text-3xl">auto_graph</span>
                                    </div>
                                    <div class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></div>
                                </div>
                                <p
                                    class="text-hotel-muted text-sm font-bold uppercase tracking-[0.3em] mb-2 opacity-60">
                                    Dự báo tăng trưởng</p>
                                <h3 class="text-4xl font-serif font-bold text-hotel-text tracking-tight">
                                    <fmt:formatNumber value="${monthlyRevenue * 1.2 / 1000000}" pattern="#,##0.0"/>M 
                                    <span class="text-xs text-hotel-muted font-sans ml-1 opacity-40">Mục tiêu</span>
                                </h3>
                            </div>
                        </div>

                        <!-- Management Portals -->
                        <div class="space-y-10">
                            <div class="flex items-center gap-6">
                                <h3
                                    class="text-base font-bold text-hotel-muted/40 uppercase tracking-[0.5em] whitespace-nowrap">
                                    Hệ Sinh Thái Quản Trị</h3>
                                <div class="w-full h-[1px] bg-hotel-gold/10"></div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-10">
                                <div
                                    class="card-elegant p-12 rounded-[2.5rem] flex flex-col group relative overflow-hidden">
                                    <div
                                        class="absolute inset-0 bg-hotel-gold/[0.02] opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
                                    </div>
                                    <div
                                        class="w-20 h-20 rounded-3xl bg-hotel-gold/5 flex items-center justify-center text-hotel-gold mb-10 border border-hotel-gold/10 group-hover:scale-110 transition-transform">
                                        <span class="material-symbols-outlined text-4xl">groups</span>
                                    </div>
                                    <h4 class="text-3xl font-serif font-bold text-hotel-text mb-4">Quản Lý Khách</h4>
                                    <p class="text-hotel-muted text-sm font-light leading-relaxed mb-12 flex-1 italic">
                                        Hợp nhất hồ sơ khách hàng, phân hạng thành viên và quản lý lịch sử lưu trú cao
                                        cấp tại SmartHotel.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/admin/customers"
                                        class="w-full py-5 rounded-2xl bg-hotel-gold text-white font-bold text-sm uppercase tracking-[0.3em] text-center hover:bg-hotel-chocolate transition-all shadow-md">
                                        Truy cập CRM
                                    </a>
                                </div>

                                <div
                                    class="card-elegant p-12 rounded-[2.5rem] flex flex-col group relative overflow-hidden">
                                    <div
                                        class="absolute inset-0 bg-hotel-chocolate/[0.02] opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
                                    </div>
                                    <div
                                        class="w-20 h-20 rounded-3xl bg-hotel-chocolate/5 flex items-center justify-center text-hotel-chocolate mb-10 border border-hotel-chocolate/10 group-hover:scale-110 transition-transform">
                                        <span class="material-symbols-outlined text-4xl">grid_view</span>
                                    </div>
                                    <h4 class="text-3xl font-serif font-bold text-hotel-text mb-4">Sơ Đồ Phòng</h4>
                                    <p class="text-hotel-muted text-sm font-light leading-relaxed mb-12 flex-1 italic">
                                        Trực quan hóa sơ đồ tầng, trạng thái phòng thực tế và tối ưu điều phối tài
                                        nguyên buồng phòng.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/RoomServlet"
                                        class="w-full py-5 rounded-2xl border border-hotel-gold text-hotel-gold font-bold text-sm uppercase tracking-[0.3em] text-center hover:bg-hotel-gold hover:text-white transition-all">
                                        Xem sơ đồ
                                    </a>
                                </div>

                                <div
                                    class="card-elegant p-12 rounded-[2.5rem] flex flex-col group relative overflow-hidden">
                                    <div
                                        class="absolute inset-0 bg-hotel-muted/[0.02] opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
                                    </div>
                                    <div
                                        class="w-20 h-20 rounded-3xl bg-hotel-muted/5 flex items-center justify-center text-hotel-muted mb-10 border border-hotel-muted/10 group-hover:scale-110 transition-transform">
                                        <span class="material-symbols-outlined text-4xl">inventory</span>
                                    </div>
                                    <h4 class="text-3xl font-serif font-bold text-hotel-text mb-4">Hậu Cần & Kho</h4>
                                    <p class="text-hotel-muted text-sm font-light leading-relaxed mb-12 flex-1 italic">
                                        Kiểm soát định mức vật tư, quản trị chuỗi cung ứng và vận hành kho vận tinh gọn
                                        chuyên nghiệp.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/products"
                                        class="w-full py-5 rounded-2xl bg-hotel-bone border border-hotel-gold/10 text-hotel-muted font-bold text-sm uppercase tracking-[0.3em] text-center hover:bg-hotel-gold hover:text-white transition-all shadow-sm">
                                        Hệ thống kho
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="text-center opacity-30 pt-12 pb-8 border-t border-hotel-gold/5">
                            <p class="font-serif italic text-hotel-muted text-base tracking-[0.6em] uppercase">
                                SmartHotel Luxury Management Hub • Corporate Edition v2.5</p>
                        </div>
                    </div>
                </div>

                <%@ include file="/common/neural_shell_bottom.jspf" %>
        </body>

        </html>