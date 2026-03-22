<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>SmartHotel Reception - Trung Tâm Lễ Tân</title>

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
                <jsp:param name="active" value="reception" />
            </jsp:include>

            <!-- Reception Page Content -->
            <div class="flex-1 h-screen overflow-y-auto pb-32">
                <div class="max-w-6xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">

                    <!-- Welcome Section -->
                    <div class="text-center py-20">
                        <div
                            class="inline-flex items-center gap-3 px-6 py-2 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-sm font-bold tracking-[0.4em] uppercase mb-8">
                            <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                            Phân Hệ Tiếp Tân Cao Cấp v4.0
                        </div>
                        <h2
                            class="text-7xl font-serif font-bold text-hotel-text tracking-tight mb-6 leading-tight uppercase">
                            Trung Tâm<br /><span class="text-hotel-gold italic">Lễ Tân.</span>
                        </h2>
                        <p class="text-hotel-muted text-xl font-medium italic tracking-tight max-w-2xl mx-auto">
                            Hệ thống quản trị chuyên sâu dành cho nghiệp vụ đón tiếp,
                            thanh toán và điều phối trải nghiệm khách lưu trú.
                        </p>
                    </div>

                    <!-- Main Action Portal -->
                    <div class="grid grid-cols-1 gap-12">

                        <div
                            class="card-elegant rounded-[3rem] p-16 flex flex-col md:flex-row items-center gap-16 relative overflow-hidden group">
                            <div
                                class="absolute inset-0 bg-gradient-to-br from-hotel-gold/[0.02] to-transparent pointer-events-none">
                            </div>

                            <div
                                class="w-56 h-56 rounded-[3.5rem] bg-hotel-gold/5 border border-hotel-gold/10 flex items-center justify-center text-hotel-gold group-hover:bg-hotel-gold group-hover:text-white transition-all duration-700 relative z-10 shadow-sm">
                                <span class="material-symbols-outlined text-8xl font-light">concierge</span>
                            </div>

                            <div class="flex-1 space-y-10 relative z-10">
                                <div class="space-y-4 text-center md:text-left">
                                    <h3
                                        class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase group-hover:text-hotel-gold transition-colors">
                                        Nghiệp Vụ <span class="italic font-normal opacity-60">Dashboard</span>
                                    </h3>
                                    <p class="text-hotel-muted text-lg font-medium leading-relaxed max-w-xl italic">
                                        Xử lý quy trình nhận phòng, kết toán hóa đơn và cập nhật trạng thái phòng nghỉ
                                        tức thời trên hệ thống.
                                    </p>
                                </div>

                                <div class="flex flex-wrap gap-5 justify-center md:justify-start">
                                    <div
                                        class="px-8 py-4 rounded-xl bg-hotel-bone border border-hotel-gold/5 flex items-center gap-4 group/item hover:border-hotel-gold/30 transition-all">
                                        <span
                                            class="material-symbols-outlined text-hotel-gold text-2xl">receipt_long</span>
                                        <span
                                            class="text-sm font-bold text-hotel-muted group-hover/item:text-hotel-text transition-colors tracking-widest uppercase">Thanh
                                            Toán</span>
                                    </div>
                                    <div
                                        class="px-8 py-4 rounded-xl bg-hotel-bone border border-hotel-gold/5 flex items-center gap-4 group/item hover:border-hotel-gold/30 transition-all">
                                        <span
                                            class="material-symbols-outlined text-hotel-gold text-2xl">room_service</span>
                                        <span
                                            class="text-sm font-bold text-hotel-muted group-hover/item:text-hotel-text transition-colors tracking-widest uppercase">Dịch
                                            Vụ</span>
                                    </div>
                                </div>

                                <div class="flex justify-center md:justify-start pt-6">
                                    <a href="${pageContext.request.contextPath}/reception/checkout.jsp"
                                        class="inline-flex items-center gap-5 bg-hotel-gold text-white px-14 py-6 rounded-xl font-bold text-base tracking-[0.3em] uppercase hover:bg-hotel-text hover:shadow-xl hover:shadow-hotel-gold/20 transition-all hover:scale-105 active:scale-95">
                                        KHỞI CHẠY NGHIỆP VỤ <span class="material-symbols-outlined">point_of_sale</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Abstract Decor -->
                            <div
                                class="absolute -right-24 -bottom-24 w-96 h-96 bg-hotel-gold/[0.03] blur-[120px] rounded-full group-hover:bg-hotel-gold/[0.06] transition-all duration-1000">
                            </div>
                        </div>

                        <!-- System Advisory -->
                        <div
                            class="card-elegant rounded-[3rem] p-12 border-dashed flex items-start gap-12 bg-white/50 group relative overflow-hidden">
                            <div class="absolute inset-0 bg-hotel-gold/[0.01] pointer-events-none"></div>
                            <div
                                class="p-6 bg-hotel-gold/10 rounded-2xl border border-hotel-gold/20 relative z-10 group-hover:scale-110 transition-transform">
                                <span class="material-symbols-outlined text-4xl text-hotel-gold">verified_user</span>
                            </div>
                            <div class="space-y-4 relative z-10">
                                <h4 class="text-base font-bold text-hotel-gold uppercase tracking-[0.5em]">Thông báo
                                    hệ thống: Quy trình Checkout</h4>
                                <p
                                    class="text-hotel-muted text-base font-medium leading-relaxed italic max-w-4xl uppercase tracking-widest opacity-80">
                                    Khi kích hoạt quy trình <span class="text-hotel-text font-bold">Trả Phòng</span>, hệ
                                    thống sẽ tự động thực hiện:
                                    (1) Kết xuất hóa đơn điện tử, (2) Khấu trừ tồn kho Minibar,
                                    (3) Chuyển trạng thái phòng sang <span class="text-hotel-gold font-bold">Đang Dọn
                                        Dẹp</span> trên toàn hệ thống sơ đồ phòng.
                                </p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <jsp:include page="/common/neural_shell_bottom.jspf" />
        </body>

        </html>