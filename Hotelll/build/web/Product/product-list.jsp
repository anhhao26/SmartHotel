<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Quản Lý Kho Vật Tư - SmartHotel</title>

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
                        box-shadow: 0 20px 40px -15px rgba(74, 66, 56, 0.05);
                        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                    }

                    .card-elegant:hover {
                        border-color: rgba(184, 154, 108, 0.3);
                        transform: translateY(-2px);
                        box-shadow: 0 30px 60px -20px rgba(74, 66, 56, 0.1);
                    }

                    .btn-gold {
                        background: #B89A6C;
                        color: white;
                        transition: all 0.3s ease;
                    }

                    .btn-gold:hover {
                        background: #4A4238;
                        transform: translateY(-1px);
                    }

                    .table-header {
                        background: rgba(184, 154, 108, 0.03);
                        border-bottom: 2px solid rgba(184, 154, 108, 0.1);
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

                <!-- Logistics Content -->
                <div class="flex-1 h-screen overflow-y-auto pb-32">
                    <div class="max-w-7xl mx-auto px-8 py-12 animate-[fadeIn_0.6s_ease-out] space-y-12">

                        <!-- Header Section -->
                        <div class="flex flex-col md:flex-row md:items-end justify-between gap-8">
                            <div class="space-y-4">
                                <div
                                    class="inline-flex items-center gap-2 px-4 py-1 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold tracking-[0.2em] uppercase">
                                    Hệ Thống Quản Trị Kho Vận
                                </div>
                                <h2
                                    class="text-6xl font-serif font-bold text-hotel-text tracking-tight leading-tight italic uppercase">
                                    Quản Lý <span class="text-hotel-gold">Kho Vật Tư.</span>
                                </h2>
                                <p
                                    class="text-hotel-muted text-lg font-medium tracking-tight border-l-2 border-hotel-gold pl-6 py-1 opacity-80">
                                    Tối ưu hóa nguồn lực và quản lý vật tư vận hành khách sạn một cách chuyên nghiệp.
                                </p>
                            </div>
                            <div class="flex gap-4">
                                <a href="products?action=listSuppliers"
                                    class="px-8 py-4 rounded-xl bg-white border border-hotel-gold/20 text-hotel-chocolate font-bold text-sm tracking-[0.2em] uppercase hover:bg-hotel-gold/5 flex items-center gap-3 transition-all shadow-sm">
                                    <span class="material-symbols-outlined text-lg">local_shipping</span> Danh sách đối
                                    tác
                                </a>
                                <a href="${pageContext.request.contextPath}/products?action=new"
                                    class="px-8 py-4 rounded-xl btn-gold font-bold text-sm tracking-[0.2em] uppercase flex items-center gap-3 shadow-lg">
                                    <span class="material-symbols-outlined text-lg text-white/80">add_box</span> Thêm
                                    vật tư mới
                                </a>
                            </div>
                        </div>

                        <!-- Dashboard Stats -->
                        <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
                            <div
                                class="card-elegant rounded-3xl p-8 col-span-1 lg:col-span-3 flex items-center justify-between">
                                <form action="products" method="get" class="flex items-center gap-8">
                                    <input type="hidden" name="action" value="list">
                                    <label class="relative inline-flex items-center cursor-pointer group">
                                        <input type="checkbox" name="showHidden" value="true" ${isShowHidden ? 'checked'
                                            : '' } onchange="this.form.submit()" class="sr-only peer">
                                        <div
                                            class="w-14 h-7 bg-hotel-gold/10 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[4px] after:left-[4px] after:bg-hotel-gold/20 after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:after:bg-white peer-checked:bg-hotel-gold shadow-inner">
                                        </div>
                                        <span
                                            class="ml-4 text-sm font-bold text-hotel-muted group-hover:text-hotel-gold transition-colors uppercase tracking-[0.2em]">Hiển
                                            thị hàng đã ẩn</span>
                                    </label>
                                </form>
                                <div
                                    class="flex items-center gap-4 py-3 px-6 rounded-2xl bg-hotel-gold/5 border border-hotel-gold/10">
                                    <div class="w-2.5 h-2.5 rounded-full bg-accent-emerald animate-pulse"></div>
                                    <span
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-[0.3em] italic">Hệ
                                        thống trực tuyến</span>
                                </div>
                            </div>

                            <div
                                class="card-elegant rounded-3xl p-8 border-l-4 border-l-accent-ruby flex items-center justify-between">
                                <div>
                                    <p
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-[0.2em] mb-2 opacity-60">
                                        Thông báo tồn kho</p>
                                    <p class="text-2xl font-serif font-bold text-hotel-text tracking-tight italic">Mức
                                        độ <span class="text-accent-ruby">Thấp</span></p>
                                </div>
                                <span
                                    class="material-symbols-outlined text-accent-ruby text-4xl animate-bounce">warning</span>
                            </div>
                        </div>

                        <!-- Inventory Registry -->
                        <div
                            class="card-elegant rounded-[2.5rem] overflow-hidden shadow-xl border border-hotel-gold/10">
                            <div class="overflow-x-auto">
                                <table class="w-full text-left border-collapse min-w-[1100px]">
                                    <thead>
                                        <tr class="table-header">
                                            <th
                                                class="px-10 py-8 text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                                STT / Mã Vật Tư</th>
                                            <th
                                                class="px-10 py-8 text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                                Tên Vật Tư & Đơn Vị</th>
                                            <th
                                                class="px-10 py-8 text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                                Phân Loại</th>
                                            <th
                                                class="px-10 py-8 text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                                Tồn Kho Hiện Tại</th>
                                            <th
                                                class="px-10 py-8 text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                                Đơn Giá (Vốn/Bán)</th>
                                            <th
                                                class="px-10 py-8 text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em] text-center">
                                                Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-hotel-gold/5">
                                        <c:forEach var="p" items="${listProducts}">
                                            <tr
                                                class="group hover:bg-hotel-gold/5 transition-all duration-300 ${p.isActive ? '' : 'opacity-40 grayscale'}">
                                                <td class="px-10 py-10">
                                                    <span
                                                        class="font-serif font-bold text-hotel-muted/40 italic text-lg tracking-widest group-hover:text-hotel-gold transition-colors">
                                                        #${p.itemID}</span>
                                                </td>
                                                <td class="px-10 py-10">
                                                    <p
                                                        class="font-serif font-bold text-hotel-text text-xl group-hover:text-hotel-gold transition-colors tracking-tight uppercase italic">
                                                        ${p.itemName}</p>
                                                    <div
                                                        class="inline-flex items-center gap-2 mt-2 px-3 py-1 bg-hotel-gold/5 border border-hotel-gold/10 rounded-md">
                                                        <span
                                                            class="text-sm text-hotel-muted font-bold uppercase tracking-widest">Đơn
                                                            vị: ${p.unit}</span>
                                                    </div>
                                                </td>
                                                <td class="px-10 py-10">
                                                    <c:if test="${p.isTradeGood}">
                                                        <span
                                                            class="bg-accent-emerald/5 text-accent-emerald border border-accent-emerald/20 text-sm font-bold px-5 py-1.5 rounded-full uppercase tracking-[0.2em]">Thương
                                                            mại</span>
                                                    </c:if>
                                                    <c:if test="${!p.isTradeGood}">
                                                        <span
                                                            class="bg-hotel-gold/5 text-hotel-gold border border-hotel-gold/20 text-sm font-bold px-5 py-1.5 rounded-full uppercase tracking-[0.2em]">Nội
                                                            bộ</span>
                                                    </c:if>
                                                </td>
                                                <td class="px-10 py-10">
                                                    <div class="flex flex-col gap-2">
                                                        <span
                                                            class="text-3xl font-serif font-bold tracking-tighter ${p.quantity <= 10 ? 'text-accent-ruby' : 'text-hotel-text'}">
                                                            ${p.quantity} <span
                                                                class="text-xs font-sans text-hotel-muted font-normal ml-0.5">${p.unit}</span>
                                                        </span>
                                                        <c:if test="${p.quantity <= 10}">
                                                            <div class="flex items-center gap-2">
                                                                <span
                                                                    class="w-2 h-2 rounded-full bg-accent-ruby animate-ping"></span>
                                                                <span
                                                                    class="text-sm font-bold text-accent-ruby uppercase tracking-widest">Sắp
                                                                    hết hàng</span>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td class="px-10 py-10">
                                                    <div class="space-y-1">
                                                        <p
                                                            class="text-hotel-muted text-base font-bold tracking-tight italic">
                                                            <span class="opacity-40 uppercase mr-1">Vốn:</span>
                                                            <fmt:formatNumber value="${p.costPrice}" pattern="#,###" />
                                                            <span class="text-sm">VND</span>
                                                        </p>
                                                        <p
                                                            class="text-hotel-gold text-lg font-serif font-bold tracking-tight italic">
                                                            <span
                                                                class="opacity-40 uppercase mr-1 text-base font-sans">Bán:</span>
                                                            <fmt:formatNumber value="${p.sellingPrice}"
                                                                pattern="#,###" /> <span class="text-sm">VND</span>
                                                        </p>
                                                    </div>
                                                </td>
                                                <td class="px-10 py-10">
                                                    <div class="flex items-center justify-center gap-4">
                                                        <c:if test="${p.isActive}">
                                                            <a href="${pageContext.request.contextPath}/products?action=edit&id=${p.itemID}"
                                                                class="w-12 h-16 rounded-xl bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all flex items-center justify-center shadow-sm group active:scale-90"
                                                                title="Chỉnh sửa">
                                                                <span
                                                                    class="material-symbols-outlined text-xl">edit_square</span>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/products?action=import&id=${p.itemID}"
                                                                class="w-12 h-16 rounded-xl bg-accent-emerald/5 border border-accent-emerald/10 text-accent-emerald hover:bg-accent-emerald hover:text-white transition-all flex items-center justify-center shadow-sm active:scale-90"
                                                                title="Nhập hàng">
                                                                <span
                                                                    class="material-symbols-outlined text-xl">add_shopping_cart</span>
                                                            </a>
                                                            <form action="products" method="POST" class="inline">
                                                                <input type="hidden" name="action" value="softDelete">
                                                                <input type="hidden" name="id" value="${p.itemID}">
                                                                <button type="submit"
                                                                    onclick="return confirm('Bạn có chắc chắn muốn ẩn vật tư này?')"
                                                                    class="w-12 h-16 rounded-xl bg-hotel-muted/5 border border-hotel-muted/10 text-hotel-muted hover:bg-hotel-muted hover:text-white transition-all flex items-center justify-center shadow-sm active:scale-90"
                                                                    title="Ẩn vật tư">
                                                                    <span
                                                                        class="material-symbols-outlined text-xl">visibility_off</span>
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${!p.isActive}">
                                                            <form action="products" method="POST" class="inline">
                                                                <input type="hidden" name="action" value="restore">
                                                                <input type="hidden" name="id" value="${p.itemID}">
                                                                <button type="submit"
                                                                    class="w-12 h-16 rounded-xl bg-hotel-gold/20 text-hotel-gold border border-hotel-gold/30 hover:bg-hotel-gold hover:text-white transition-all flex items-center justify-center shadow-sm active:scale-90"
                                                                    title="Khôi phục">
                                                                    <span
                                                                        class="material-symbols-outlined text-xl">visibility</span>
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <form action="products" method="POST" class="inline">
                                                            <input type="hidden" name="action" value="hardDelete">
                                                            <input type="hidden" name="id" value="${p.itemID}">
                                                            <button type="submit"
                                                                onclick="return confirm('CẢNH BÁO: Xóa vĩnh viễn vật tư này khỏi hệ thống?')"
                                                                class="w-12 h-16 rounded-xl bg-accent-ruby/5 border border-accent-ruby/10 text-accent-ruby hover:bg-accent-ruby hover:text-white transition-all flex items-center justify-center shadow-sm active:scale-90"
                                                                title="Xóa vĩnh viễn">
                                                                <span
                                                                    class="material-symbols-outlined text-xl">delete_forever</span>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="text-center opacity-40 py-8">
                            <p class="font-serif italic text-hotel-muted text-base tracking-[0.5em] uppercase">
                                SmartHotel Luxury Management System • Inventory v2.0</p>
                        </div>
                    </div>
                </div>

                <jsp:include page="/common/neural_shell_bottom.jspf" />
            </body>

            </html>