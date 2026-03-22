<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Thông Tin Đối Tác - SmartHotel</title>

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

            <!-- Supplier Form Content -->
            <div class="flex-1 h-screen overflow-y-auto pb-32">
                <div class="max-w-2xl mx-auto px-8 py-16 animate-[fadeIn_0.6s_ease-out]">

                    <!-- Header Section -->
                    <div class="text-center mb-16 space-y-4">
                        <div
                            class="inline-flex items-center gap-2 px-4 py-1 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold tracking-[0.3em] uppercase">
                            Hồ Sơ Đối Tác Chiến Lược
                        </div>
                        <h2
                            class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase leading-tight italic">
                            <c:choose>
                                <c:when test="${supplier != null}">Cập Nhật <span class="text-hotel-gold">Đối
                                        Tác.</span></c:when>
                                <c:otherwise>Thêm Mới <span class="text-hotel-gold">Đối Tác.</span></c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="text-hotel-muted text-sm font-medium uppercase tracking-[0.2em] opacity-60">
                            Quản lý thông tin liên hệ và mạng lưới cung ứng vật tư
                        </p>
                    </div>

                    <div class="card-elegant rounded-[3rem] p-12 lg:p-14 relative overflow-hidden shadow-2xl">
                        <div
                            class="absolute top-0 right-0 w-48 h-48 bg-hotel-gold/5 blur-[80px] rounded-full pointer-events-none">
                        </div>

                        <form action="products" method="post" class="space-y-10 relative z-10">
                            <input type="hidden" name="action" value="saveSupplier">
                            <c:if test="${supplier != null}">
                                <input type="hidden" name="id" value="${supplier.supplierID}">
                            </c:if>

                            <div class="space-y-8">
                                <div class="space-y-1">
                                    <label class="label-premium px-2">Danh xưng nghiệp vụ (Entity Name)</label>
                                    <input type="text" name="name"
                                        class="w-full h-20 input-elegant rounded-2xl px-10 font-serif font-bold text-hotel-text text-2xl tracking-tight uppercase placeholder-hotel-muted/20 italic border-hotel-gold/10"
                                        placeholder="NHẬP TÊN ĐỐI TÁC..." value="${supplier.supplierName}"
                                        required>
                                </div>

                                <div class="space-y-1">
                                    <label class="label-premium px-2">Liên lạc nghiệp vụ (Phone)</label>
                                    <div class="relative flex items-center group">
                                        <span
                                            class="material-symbols-outlined absolute left-8 text-hotel-gold opacity-30 group-focus-within:opacity-100 transition-opacity">call</span>
                                        <input type="text" name="phone"
                                            class="w-full h-18 input-elegant rounded-xl pl-18 pr-8 font-bold text-hotel-text text-[15px] tracking-widest"
                                            value="${supplier.contactPhone}" placeholder="+84 ...">
                                    </div>
                                </div>

                                <div class="space-y-1">
                                    <label class="label-premium px-2">Bản quán văn phòng (Address)</label>
                                    <div class="relative flex items-center group">
                                        <span
                                            class="material-symbols-outlined absolute left-8 text-hotel-gold opacity-30 group-focus-within:opacity-100 transition-opacity">location_on</span>
                                        <input type="text" name="address"
                                            class="w-full h-18 input-elegant rounded-xl pl-18 pr-8 font-semibold text-hotel-muted text-[13px]"
                                            value="${supplier.address}" placeholder="VD: QUẬN 1, TP. HỒ CHÍ MINH">
                                    </div>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 pt-10">
                                <button type="submit"
                                    class="h-16 btn-gold font-bold text-base tracking-[0.3em] uppercase rounded-2xl shadow-lg active:scale-95 flex items-center justify-center gap-2 group">
                                    <span
                                        class="material-symbols-outlined group-hover:scale-110 transition-transform">save</span>
                                    Lưu Thông Tin
                                </button>
                                <a href="products?action=listSuppliers"
                                    class="h-16 bg-hotel-muted/5 border border-hotel-muted/10 flex items-center justify-center font-bold text-base tracking-[0.3em] uppercase rounded-2xl hover:bg-hotel-muted hover:text-white transition-all text-hotel-muted">
                                    Quay Lại
                                </a>
                            </div>
                        </form>
                    </div>

                    <div class="text-center opacity-40 py-12">
                        <p class="font-serif italic text-hotel-muted text-base tracking-[0.5em] uppercase">SmartHotel
                            Luxury Management System • Supplier Profile v2.0</p>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/neural_shell_bottom.jspf" />
        </body>

        </html>