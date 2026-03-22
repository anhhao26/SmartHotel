<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Phân Tích Khách Hàng - SmartHotel</title>

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

            <jsp:include page="/common/neural_shell_top.jspf">
                <jsp:param name="active" value="crm" />
            </jsp:include>

            <!-- CRM Content -->
            <div class="flex-1 h-screen overflow-y-auto pb-32">
                <div class="max-w-7xl mx-auto px-8 lg:px-12 py-12 animate-[fadeIn_0.8s_ease-out] space-y-16">

                    <!-- Header Section -->
                    <div
                        class="flex flex-col md:flex-row md:items-end justify-between gap-8 border-b border-hotel-gold/10 pb-12">
                        <div class="space-y-4">
                            <div
                                class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold uppercase tracking-[0.3em]">
                                Hệ Thống Phân Tích Chuyên Sâu
                            </div>
                            <h2
                                class="text-6xl font-serif font-bold text-hotel-text tracking-tight uppercase leading-tight">
                                Hành Vi<br /><span class="text-hotel-gold italic">Khách Hàng.</span>
                            </h2>
                        </div>
                        <div class="flex gap-4">
                            <div
                                class="h-20 px-8 card-elegant rounded-2xl flex flex-col justify-center border-hotel-gold/10">
                                <p class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-60">
                                    Lượt Truy Cập</p>
                                <p class="text-3xl font-serif font-bold text-accent-emerald">142 <span
                                        class="text-sm text-hotel-muted font-sans opacity-40">/ms</span></p>
                            </div>
                            <div
                                class="h-20 px-8 card-elegant rounded-2xl flex flex-col justify-center border-hotel-gold/10">
                                <p class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-60">
                                    Tăng Trưởng Doanh Thu</p>
                                <p class="text-3xl font-serif font-bold text-hotel-gold">+24.8%</p>
                            </div>
                        </div>
                    </div>

                    <!-- CRM Main Interface -->
                    <div class="grid grid-cols-1 md:grid-cols-12 gap-10">

                        <!-- CRM Status Card -->
                        <div
                            class="md:col-span-12 card-elegant rounded-[4rem] p-16 border-dashed border-hotel-gold/20 relative overflow-hidden group bg-hotel-bone/30">
                            <div
                                class="absolute inset-0 bg-gradient-to-br from-hotel-gold/[0.02] to-transparent pointer-events-none">
                            </div>

                            <div class="relative z-10 flex flex-col items-center text-center space-y-10">
                                <div
                                    class="w-24 h-24 rounded-[2rem] bg-white border border-hotel-gold/10 flex items-center justify-center text-hotel-gold shadow-xl group-hover:rotate-6 transition-transform">
                                    <span class="material-symbols-outlined text-5xl">analytics</span>
                                </div>
                                <div class="space-y-6 max-w-3xl">
                                    <h3
                                        class="text-3xl font-serif font-bold text-hotel-text uppercase tracking-tight italic">
                                        Trung Tâm Phân Tích Dữ Liệu</h3>
                                    <p class="text-hotel-muted text-base leading-relaxed font-light italic opacity-80">
                                        Hệ thống đang tổng hợp và phân tích dữ liệu hành trình khách hàng theo thời gian
                                        thực.
                                        Tại đây, bộ phận quản trị có thể theo dõi <strong>chỉ số tích lũy</strong>,
                                        phân tích <strong>xu hướng tiêu dùng</strong> và thực thi các giao thức
                                        <strong>ưu đãi hội viên</strong>
                                        dựa trên mô hình trí tuệ nhân tạo SmartHotel BI.
                                    </p>
                                </div>
                                <div class="flex gap-6 pt-6">
                                    <a href="${pageContext.request.contextPath}/admin/customers"
                                        class="h-16 px-12 btn-gold text-white font-bold text-sm tracking-[0.2em] uppercase rounded-xl shadow-lg transition-all flex items-center justify-center">
                                        Xem Danh Sách Hội Viên
                                    </a>
                                    <button
                                        class="h-16 px-12 bg-white border border-hotel-gold/20 text-hotel-muted font-bold text-sm tracking-[0.2em] uppercase rounded-xl hover:bg-hotel-cream transition-all">
                                        Xuất Báo Cáo Chuyên Sâu
                                    </button>
                                </div>
                            </div>

                            <div
                                class="absolute -bottom-20 -right-20 w-80 h-80 bg-hotel-gold/5 blur-[100px] rounded-full pointer-events-none">
                            </div>
                        </div>

                        <!-- Analytics Cards -->
                        <div class="md:col-span-4 card-elegant rounded-[2.5rem] p-12 border-hotel-gold/10 space-y-8">
                            <div class="flex items-center justify-between">
                                <span class="material-symbols-outlined text-hotel-gold text-3xl">stars</span>
                                <span
                                    class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-40">Phân
                                    Phối Hạng Thành Viên</span>
                            </div>
                            <div class="space-y-4">
                                <div class="flex justify-between items-end">
                                    <p class="text-xs font-bold text-hotel-text uppercase tracking-tight">VIP Elite &
                                        Diamond</p>
                                    <p class="text-2xl font-serif font-bold text-hotel-text">42%</p>
                                </div>
                                <div class="w-full h-1.5 bg-hotel-bone rounded-full overflow-hidden">
                                    <div class="h-full bg-hotel-gold" style="width: 42%"></div>
                                </div>
                            </div>
                        </div>

                        <div class="md:col-span-4 card-elegant rounded-[2.5rem] p-12 border-hotel-gold/10 space-y-8">
                            <div class="flex items-center justify-between">
                                <span class="material-symbols-outlined text-hotel-chocolate text-3xl">favorite</span>
                                <span
                                    class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-40">Chỉ
                                    Số Trung Thành</span>
                            </div>
                            <div class="space-y-4">
                                <div class="flex justify-between items-end">
                                    <p class="text-xs font-bold text-hotel-text uppercase tracking-tight">Loyalty
                                        Retention</p>
                                    <p class="text-2xl font-serif font-bold text-hotel-text">8.9<span
                                            class="text-sm text-hotel-muted font-sans ml-2 opacity-30">/10</span>
                                    </p>
                                </div>
                                <div class="w-full h-1.5 bg-hotel-bone rounded-full overflow-hidden">
                                    <div class="h-full bg-hotel-chocolate" style="width: 89%"></div>
                                </div>
                            </div>
                        </div>

                        <div class="md:col-span-4 card-elegant rounded-[2.5rem] p-12 border-hotel-gold/10 space-y-8">
                            <div class="flex items-center justify-between">
                                <span class="material-symbols-outlined text-accent-emerald text-3xl">payments</span>
                                <span
                                    class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-40">Giá
                                    Trị Trọn Đời (LTV)</span>
                            </div>
                            <div class="space-y-4">
                                <div class="flex justify-between items-end">
                                    <p class="text-xs font-bold text-hotel-text uppercase tracking-tight">Giá Trị Trung
                                        Bình</p>
                                    <p class="text-2xl font-serif font-bold text-hotel-text">12.5M</p>
                                </div>
                                <div class="w-full h-1.5 bg-hotel-bone rounded-full overflow-hidden">
                                    <div class="h-full bg-accent-emerald" style="width: 65%"></div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="text-center opacity-30 pt-12">
                        <p class="font-serif italic text-hotel-muted text-base tracking-[0.5em] uppercase">SmartHotel
                            Intelligence Hub • Guest Data Insights v4.0</p>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/neural_shell_bottom.jspf" />

        </body>

        </html>