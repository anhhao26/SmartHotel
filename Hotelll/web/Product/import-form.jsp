<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Lệnh Nhập Kho - SmartHotel</title>

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
                                    amber: "#D97706"
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
                    box-shadow: 0 20px 40px -15px rgba(74, 66, 56, 0.05);
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .input-elegant {
                    background: #FFFFFF;
                    border: 1px solid rgba(184, 154, 108, 0.1);
                    color: #2C2722;
                    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                    font-family: 'Inter', sans-serif;
                }

                .input-elegant:focus {
                    border-color: #B89A6C;
                    background: #FFFFFF;
                    box-shadow: 0 15px 30px -10px rgba(184, 154, 108, 0.1);
                    transform: translateY(-2px);
                    outline: none;
                }

                .label-premium {
                    font-family: 'Inter', sans-serif;
                    font-size: 10px;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.25em;
                    color: #70685F;
                    margin-bottom: 0.75rem;
                    display: block;
                    opacity: 0.8;
                }

                .input-elegant[disabled] {
                    background: rgba(112, 104, 95, 0.03);
                    border-color: rgba(112, 104, 95, 0.08);
                    color: rgba(44, 39, 34, 0.3);
                    cursor: not-allowed;
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

        <body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

            <jsp:include page="/common/neural_shell_top.jspf">
                <jsp:param name="active" value="inventory" />
            </jsp:include>

            <!-- Import Form Content -->
            <div class="flex-1 h-screen overflow-y-auto pb-32">
                <div class="max-w-2xl mx-auto px-8 py-16 animate-[fadeIn_0.6s_ease-out]">

                    <!-- Header Section -->
                    <div class="text-center mb-16 space-y-4">
                        <div
                            class="inline-flex items-center gap-2 px-4 py-1 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold tracking-[0.3em] uppercase">
                            Giao Thức Tái Cung Ứng Vật Tư
                        </div>
                        <h2
                            class="text-4xl lg:text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase leading-tight italic">
                            Lệnh Nhập Kho:<br /><span
                                class="text-hotel-gold underline decoration-hotel-gold/20 underline-offset-8">${product.itemName}</span>
                        </h2>
                        <p class="text-hotel-muted text-sm font-medium uppercase tracking-[0.2em] opacity-60">
                            Bổ sung hàng tồn kho và cập nhật giá trị vốn vật tư
                        </p>
                    </div>

                    <div class="card-elegant rounded-[3rem] p-12 lg:p-14 relative overflow-hidden shadow-2xl">
                        <div
                            class="absolute -bottom-20 -left-20 w-80 h-80 bg-hotel-gold/5 blur-[120px] rounded-full pointer-events-none">
                        </div>

                        <form action="products" method="post" class="space-y-10 relative z-10">
                            <input type="hidden" name="action" value="saveImport">
                            <input type="hidden" name="id" value="${product.itemID}">

                            <div class="space-y-8">
                                <div class="space-y-4">
                                    <label
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Số
                                        lượng tồn hiện tại (Current Stock)</label>
                                    <div class="relative flex items-center">
                                        <input type="text"
                                            class="w-full h-16 input-elegant rounded-xl px-8 font-bold text-hotel-muted/40 text-xl italic"
                                            value="${product.quantity} ${product.unit}" disabled>
                                        <span
                                            class="material-symbols-outlined absolute right-8 text-hotel-gold/20">inventory_2</span>
                                    </div>
                                </div>

                                <div class="space-y-4">
                                    <label
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Số
                                        lượng NHẬP THÊM (*)</label>
                                    <div class="relative">
                                        <input type="number" name="quantityToAdd"
                                            class="w-full h-24 input-elegant rounded-[2rem] px-10 font-serif font-bold text-hotel-gold text-5xl tracking-tighter border-hotel-gold/20 shadow-sm"
                                            min="1" required placeholder="0">
                                        <p
                                            class="text-sm font-bold text-hotel-muted uppercase tracking-[0.2em] italic mt-3 px-2 opacity-60">
                                            Vui lòng xác nhận số lượng thực tế kiểm kê tại kho.</p>
                                    </div>
                                </div>

                                <div class="space-y-1">
                                    <label class="label-premium px-2">Nhân số vốn nhập (*)</label>
                                    <div class="relative flex items-center">
                                        <span
                                            class="material-symbols-outlined absolute left-8 text-hotel-gold/40">payments</span>
                                        <input type="number" name="costPrice"
                                            class="w-full h-24 input-elegant rounded-[2rem] pl-20 pr-8 font-serif font-bold text-hotel-text text-4xl"
                                            value="${product.costPrice}" required>
                                        <span
                                            class="absolute right-10 text-sm font-bold text-hotel-gold uppercase tracking-widest opacity-40 italic">VNĐ
                                            / Đơn vị</span>
                                    </div>
                                </div>
                                    <p
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-[0.2em] italic px-2 opacity-60">
                                        Điều chỉnh đơn giá vốn nếu có thay đổi từ nhà cung cấp.</p>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 gap-6 pt-10">
                                <button type="submit"
                                    class="h-24 btn-gold font-bold text-sm tracking-[0.4em] uppercase rounded-[2.5rem] shadow-xl hover:scale-[1.02] active:scale-95 transition-all flex items-center justify-center gap-4 group">
                                    <span
                                        class="material-symbols-outlined text-3xl group-hover:rotate-12 transition-transform">check_circle</span>
                                    Xác Nhận Nhập Kho
                                </button>
                                <a href="products"
                                    class="h-10 flex items-center justify-center font-bold text-sm text-hotel-muted/30 hover:text-hotel-gold transition-colors uppercase tracking-[0.4em]">
                                    Hủy Bỏ Giao Thức
                                </a>
                            </div>
                        </form>
                    </div>

                    <div class="text-center opacity-40 py-12">
                        <p class="font-serif italic text-hotel-muted text-base tracking-[0.5em] uppercase">SmartHotel
                            Luxury Management System • Stock Re-Injection v2.0</p>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/neural_shell_bottom.jspf" />
        </body>

        </html>