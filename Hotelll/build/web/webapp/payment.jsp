<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>SmartHotel - Cổng Thanh Toán</title>
            <!-- Premium Fonts -->
            <link
                href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&display=swap"
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
                                sans: ["Inter", "sans-serif"],
                            },
                        },
                    },
                }
            </script>
            <style>
                body {
                    background-color: #FAF9F6;
                    color: #2C2722;
                    scroll-behavior: smooth;
                }

                .card-elegant {
                    background: #FFFFFF;
                    border: 1px solid rgba(184, 154, 108, 0.15);
                    box-shadow: 0 40px 80px -20px rgba(74, 66, 56, 0.1);
                }

                .btn-vnpay {
                    background: #B89A6C;
                    color: #FFFFFF;
                    transition: all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
                    box-shadow: 0 10px 30px rgba(184, 154, 108, 0.3);
                }

                .btn-vnpay:hover {
                    background: #4A4238;
                    box-shadow: 0 15px 40px rgba(74, 66, 56, 0.4);
                    transform: translateY(-4px);
                }

                .info-item {
                    border-left: 3px solid rgba(184, 154, 108, 0.3);
                    padding-left: 1.5rem;
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

        <body
            class="font-sans antialiased min-h-screen flex flex-col items-center justify-center p-8 relative bg-hotel-cream">

            <main class="w-full max-w-6xl grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">

                <!-- Content Side -->
                <div class="space-y-10 order-2 lg:order-1">
                    <div class="space-y-6">
                        <div
                            class="inline-flex items-center gap-3 px-5 py-2 rounded-sm bg-white border border-hotel-gold/20">
                            <span class="material-symbols-outlined text-hotel-gold text-[20px]">shield_person</span>
                            <span class="text-hotel-gold text-sm font-bold tracking-[0.3em] uppercase">Thanh Toán Bảo
                                Mật Quốc Tế</span>
                        </div>
                        <h1
                            class="text-6xl md:text-7xl font-serif font-bold text-hotel-text leading-tight tracking-tight">
                            Xác Nhận <br /> <span class="text-hotel-gold italic">Đơn Đặt.</span>
                        </h1>
                        <p class="text-hotel-muted text-xl font-light leading-relaxed max-w-md">
                            Quý khách đang ở bước cuối cùng để hoàn tất kỳ nghỉ tuyệt vời tại SmartHotel. Mọi giao dịch
                            đều được mã hóa và bảo mật tuyệt đối.
                        </p>
                    </div>

                    <div class="grid grid-cols-2 gap-8">
                        <div class="card-elegant p-8 rounded-sm space-y-4 group transition-all">
                            <span class="material-symbols-outlined text-hotel-gold text-4xl">verified</span>
                            <p class="text-hotel-text font-bold text-sm tracking-widest uppercase">Giao Dịch An Toàn
                            </p>
                        </div>
                        <div class="card-elegant p-8 rounded-sm space-y-4 group transition-all">
                            <span class="material-symbols-outlined text-hotel-gold text-4xl">speed</span>
                            <p class="text-hotel-text font-bold text-sm tracking-widest uppercase">Xử Lý Tức Thì</p>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/rooms"
                        class="inline-flex items-center gap-3 text-hotel-muted hover:text-hotel-text transition-all text-sm font-bold tracking-[0.4em] uppercase group">
                        <span
                            class="material-symbols-outlined text-lg group-hover:rotate-90 transition-transform">close</span>
                        Hủy giao dịch
                    </a>
                </div>

                <!-- Payment Detail Card -->
                <div class="relative order-1 lg:order-2">
                    <div class="card-elegant rounded-sm p-10 md:p-14 relative overflow-hidden bg-white">
                        <div class="absolute top-0 right-0 p-12 opacity-[0.03]">
                            <span class="material-symbols-outlined text-[10rem]">receipt_long</span>
                        </div>

                        <div class="space-y-12 relative">
                            <div class="flex justify-between items-start pb-10 border-b border-hotel-gold/10">
                                <div class="space-y-2">
                                    <h3 class="text-hotel-text font-bold text-xl tracking-tight">Thông Tin Đơn Đặt</h3>
                                    <p class="text-sm text-hotel-muted font-bold tracking-[0.3em] uppercase">Mã Đơn:
                                        <span class="text-hotel-gold">#BK-${booking.bookingID}</span></p>
                                </div>
                                <div class="text-right space-y-2">
                                    <p class="text-sm text-hotel-gold font-bold tracking-[0.3em] uppercase">Tổng Tiền
                                    </p>
                                    <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tighter">
                                        <fmt:formatNumber value="${booking.totalAmount}" pattern="#,###" />
                                        <span class="text-lg text-hotel-gold ml-1">₫</span>
                                    </h2>
                                </div>
                            </div>

                            <div class="space-y-8">
                                <div class="grid grid-cols-2 gap-10">
                                    <div class="space-y-2 info-item">
                                        <label class="label-premium">Họ tên khách hàng</label>
                                        <p class="text-base font-bold text-hotel-text uppercase">
                                            ${booking.customer.fullName}</p>
                                    </div>
                                    <div class="space-y-2 info-item">
                                        <label class="label-premium">Phòng chỉ định</label>
                                        <p class="text-base font-bold text-hotel-gold uppercase">Phòng
                                            ${booking.room.roomNumber}</p>
                                    </div>
                                    <div class="col-span-2 space-y-3 info-item">
                                        <label class="label-premium">Thời gian lưu trú dự kiến</label>
                                        <div class="flex items-center gap-4 text-base font-bold text-hotel-text">
                                            <fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy" />
                                            <span
                                                class="material-symbols-outlined text-[18px] text-hotel-gold">arrow_forward</span>
                                            <fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <form action="${pageContext.request.contextPath}/create_payment" method="GET"
                                onsubmit="this.querySelector('button').innerHTML='ĐANG CHUYỂN HƯỚNG...'; this.querySelector('button').disabled=true;">
                                <input type="hidden" name="bookingId" value="${booking.bookingID}">
                                <input type="hidden" name="amount" value="${booking.totalAmount}">

                                <button type="submit"
                                    class="w-full py-6 rounded-sm btn-vnpay font-bold text-xs tracking-[0.4em] uppercase flex items-center justify-center gap-4 active:scale-95">
                                    <span class="material-symbols-outlined">payments</span>
                                    Tiến Hành Thanh Toán
                                </button>
                            </form>

                            <div
                                class="flex items-center justify-between text-sm font-bold tracking-[0.2em] text-hotel-muted/40 pt-6 border-t border-hotel-gold/10 uppercase">
                                <div class="flex items-center gap-2">
                                    <span class="material-symbols-outlined text-[16px]">verified</span>
                                    SmartSecure v4.2
                                </div>
                                <p>Hỗ trợ bởi VNPAY</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer
                class="mt-20 text-hotel-muted/30 text-sm font-bold tracking-[0.6em] uppercase text-center w-full">
                © 2026 SmartHotel Boutique Collection
            </footer>

        </body>

        </html>