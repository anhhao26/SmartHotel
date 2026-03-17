<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>SmartHotel - Quản Lý Ưu Đãi</title>
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
                    }

                    .card-elegant {
                        background: #FFFFFF;
                        border: 1px solid rgba(184, 154, 108, 0.15);
                        box-shadow: 0 20px 40px -15px rgba(74, 66, 56, 0.08);
                    }

                    .voucher-card {
                        background: #FFFFFF;
                        border: 1px solid rgba(184, 154, 108, 0.1);
                        transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }

                    .voucher-card:hover {
                        border-color: #B89A6C;
                        transform: translateY(-8px);
                        box-shadow: 0 40px 80px -20px rgba(74, 66, 56, 0.15);
                    }

                    .input-elegant {
                        background: #FAF9F6;
                        border: 1px solid rgba(184, 154, 108, 0.2);
                        color: #2C2722;
                        transition: all 0.3s;
                    }

                    .input-elegant:focus {
                        border-color: #B89A6C;
                        background: #FFFFFF;
                        box-shadow: 0 0 20px rgba(184, 154, 108, 0.1);
                        outline: none;
                    }

                    .btn-gold:hover {
                        background: #4A4238;
                        transform: translateY(-2px);
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

            <body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

                <jsp:include page="/common/neural_shell_top.jspf">
                    <jsp:param name="active" value="vouchers" />
                </jsp:include>

                <!-- Voucher Page Content -->
                <div class="flex-1 h-screen overflow-y-auto pb-32">
                    <div class="max-w-7xl mx-auto px-12 animate-[fadeIn_0.5s_ease-out] pt-12">

                    <!-- Header Section -->
                    <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                        <div>
                            <div
                                class="inline-flex items-center gap-2 px-4 py-1.5 rounded-sm bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-[9px] font-bold tracking-[0.3em] uppercase mb-4">
                                Marketing Protocol
                            </div>
                            <h2
                                class="text-6xl font-serif font-bold text-hotel-text tracking-tight leading-tight uppercase">
                                Mã<br /><span class="text-hotel-gold italic">Ưu Đãi.</span></h2>
                            <p class="text-hotel-muted text-lg font-light mt-4">Phát hành và quản trị các chiến dịch
                                kích cầu hội viên cao cấp.</p>
                        </div>
                        <div class="flex gap-4">
                            <div
                                class="card-elegant px-8 py-6 rounded-sm flex items-center gap-5 relative overflow-hidden group">
                                <span
                                    class="material-symbols-outlined text-hotel-gold text-4xl group-hover:rotate-12 transition-transform">confirmation_number</span>
                                <div>
                                    <p class="text-[9px] font-bold text-hotel-muted uppercase tracking-[0.3em] mb-1">
                                        Chiến dịch hiện tại</p>
                                    <p class="text-2xl font-bold text-hotel-text tracking-tight">${voucherList.size()}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div
                            class="p-6 rounded-sm bg-red-50 border border-red-200 text-red-600 font-bold text-[10px] uppercase tracking-[0.2em]">
                            ${errorMessage}</div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div
                            class="p-6 rounded-sm bg-emerald-50 border border-emerald-200 text-emerald-600 font-bold text-[10px] uppercase tracking-[0.2em]">
                            ${successMessage}</div>
                    </c:if>

                    <div class="grid grid-cols-1 xl:grid-cols-12 gap-12">

                        <!-- Form Pane -->
                        <div class="xl:col-span-4">
                            <div class="card-elegant rounded-sm p-10 space-y-10 h-fit bg-white">
                                <div class="space-y-3">
                                    <h3
                                        class="text-2xl font-serif font-bold text-hotel-text tracking-tight uppercase italic">
                                        Tạo Mới</h3>
                                    <p
                                        class="text-[9px] text-hotel-muted font-bold uppercase tracking-[0.2em] leading-relaxed">
                                        Thiết lập mã khuyến mãi mới cho hệ thống khách hàng.</p>
                                </div>

                                <form action="${pageContext.request.contextPath}/VoucherServlet" method="POST"
                                    class="space-y-6">
                                    <input type="hidden" name="action" value="save">

                                    <div class="space-y-6">
                                        <div class="space-y-1">
                                            <label class="label-premium">Mã định danh (Voucher Code)</label>
                                            <input name="voucherCode" required
                                                class="w-full h-14 input-elegant rounded-xl px-6 font-bold text-hotel-text tracking-widest uppercase placeholder:text-hotel-gold/20 text-[11px] border-hotel-gold/10"
                                                placeholder="VD: BOUTIQUE2026" type="text" />
                                        </div>

                                        <div class="space-y-1">
                                            <label class="label-premium">Giá trị đặc quyền (VNĐ)</label>
                                            <input name="discountValue" required
                                                class="w-full h-14 input-elegant rounded-xl px-6 font-serif font-bold text-hotel-gold text-3xl tracking-tighter border-hotel-gold/10"
                                                placeholder="0" type="number" />
                                        </div>

                                        <div class="grid grid-cols-2 gap-5">
                                            <div class="space-y-1">
                                                <label class="label-premium">Ngày kích hoạt</label>
                                                <input name="startDate" required
                                                    class="w-full h-12 input-elegant rounded-xl px-4 text-[10px] font-bold text-hotel-text uppercase border-hotel-gold/10"
                                                    type="datetime-local" />
                                            </div>
                                            <div class="space-y-1">
                                                <label class="label-premium">Ngày hết hạn</label>
                                                <input name="endDate" required
                                                    class="w-full h-12 input-elegant rounded-xl px-4 text-[10px] font-bold text-hotel-text uppercase border-hotel-gold/10"
                                                    type="datetime-local" />
                                            </div>
                                        </div>

                                        <div class="grid grid-cols-2 gap-5">
                                            <div class="space-y-1">
                                                <label class="label-premium">Hạn mức chi tối thiểu</label>
                                                <input name="minOrderValue" value="0"
                                                    class="w-full h-12 input-elegant rounded-xl px-6 font-bold text-hotel-text text-[11px] border-hotel-gold/10"
                                                    type="number" />
                                            </div>
                                            <div class="space-y-1">
                                                <label class="label-premium">Số lượng phát hành</label>
                                                <input name="usageLimit" value="100"
                                                    class="w-full h-12 input-elegant rounded-xl px-6 font-bold text-hotel-text text-[11px] border-hotel-gold/10"
                                                    type="number" />
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit"
                                        class="w-full py-5 rounded-sm btn-gold text-white font-bold text-[9px] tracking-[0.4em] uppercase flex items-center justify-center gap-4">
                                        <span class="material-symbols-outlined text-lg">add_circle</span> PHÁT HÀNH
                                        VOUCHER
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- List Pane -->
                        <div class="xl:col-span-8">
                            <div class="card-elegant rounded-sm p-10 relative overflow-hidden bg-white">
                                <div class="flex items-center justify-between mb-12 relative">
                                    <h3
                                        class="text-xs font-bold text-hotel-muted uppercase tracking-[0.4em] flex items-center">
                                        <span class="w-12 h-[1px] bg-hotel-gold mr-6"></span> Danh sách mã hoạt động
                                    </h3>
                                </div>

                                <div class="grid grid-cols-1 gap-6 relative">
                                    <c:forEach items="${voucherList}" var="v">
                                        <div
                                            class="voucher-card rounded-sm p-8 flex flex-col lg:flex-row lg:items-center justify-between gap-8 group">

                                            <div class="flex items-center gap-6">
                                                <div
                                                    class="w-16 h-16 rounded-sm bg-hotel-gold/5 border border-hotel-gold/10 flex items-center justify-center text-hotel-gold group-hover:bg-hotel-gold group-hover:text-white transition-all duration-500">
                                                    <span class="material-symbols-outlined text-3xl">qr_code_2</span>
                                                </div>
                                                <div>
                                                    <span
                                                        class="text-[10px] font-bold text-hotel-gold tracking-[0.3em] uppercase italic">
                                                        ${v.voucherCode}
                                                    </span>
                                                    <div class="flex items-center gap-4 mt-1">
                                                        <h4
                                                            class="text-3xl font-serif font-bold text-hotel-text tracking-tight">
                                                            <fmt:formatNumber value="${v.discountValue}"
                                                                pattern="#,###" /> <span
                                                                class="text-sm font-sans text-hotel-gold ml-0.5">₫</span>
                                                        </h4>
                                                        <div class="h-6 w-[1px] bg-hotel-gold/10"></div>
                                                        <div class="space-y-0.5">
                                                            <p
                                                                class="text-[8px] font-bold text-hotel-muted uppercase tracking-widest">
                                                                Tối thiểu</p>
                                                            <p
                                                                class="text-[10px] font-bold text-hotel-text tracking-tight">
                                                                <fmt:formatNumber value="${v.minOrderValue}"
                                                                    pattern="#,###" /> <span
                                                                    class="text-[8px] opacity-50">₫</span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div
                                                class="flex-1 flex flex-col gap-3 max-w-sm lg:px-10 border-hotel-gold/10 lg:border-l lg:border-r">
                                                <div
                                                    class="flex justify-between text-[9px] font-bold uppercase tracking-widest">
                                                    <span class="text-hotel-muted">Đã sử dụng: <span
                                                            class="text-hotel-text">${v.usedCount}</span> /
                                                        ${v.usageLimit}</span>
                                                    <span class="text-hotel-gold italic">${String.format("%.1f",
                                                        (v.usedCount / v.usageLimit) * 100)}%</span>
                                                </div>
                                                <div
                                                    class="h-1.5 w-full bg-hotel-gold/10 rounded-full overflow-hidden p-[1px]">
                                                    <div class="h-full bg-hotel-gold rounded-full transition-all duration-1000"
                                                        style="width: ${(v.usedCount / v.usageLimit) * 100}%"></div>
                                                </div>
                                                <div
                                                    class="flex justify-between items-center text-[8px] font-bold text-hotel-muted tracking-widest uppercase italic">
                                                    <span>
                                                        <fmt:formatDate value="${v.startDate}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                    <span
                                                        class="material-symbols-outlined text-[10px]">arrow_right_alt</span>
                                                    <span class="text-hotel-gold/60">
                                                        <fmt:formatDate value="${v.endDate}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="flex items-center justify-end">
                                                <a href="${pageContext.request.contextPath}/VoucherServlet?action=delete&code=${v.voucherCode}"
                                                    onclick="return confirm('Bạn có chắc muốn xóa mã ưu đãi này?');"
                                                    class="w-12 h-12 rounded-sm bg-red-50 text-red-400 flex items-center justify-center hover:bg-red-500 hover:text-white transition-all">
                                                    <span class="material-symbols-outlined text-xl">delete</span>
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <c:if test="${empty voucherList}">
                                        <div
                                            class="py-32 flex flex-col items-center justify-center space-y-4 opacity-20">
                                            <span class="material-symbols-outlined text-6xl">cloud_off</span>
                                            <p class="text-[10px] font-bold uppercase tracking-[0.4em]">Trống</p>
                                        </div>
                                    </c:if>
                        </div>
                    </div>
                </div>

                <jsp:include page="/common/neural_shell_bottom.jspf" />
            </body>

            </html>