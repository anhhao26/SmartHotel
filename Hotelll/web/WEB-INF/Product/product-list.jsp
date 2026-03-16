<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>SmartHotel Logistics - Quản Lý Kho Cao Cấp</title>
    
    <!-- Premium Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

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
        .dimmed-row { opacity: 0.6; filter: grayscale(1); }
        .table-row-hover:hover { background-color: rgba(184, 154, 108, 0.02); }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

    <jsp:include page="/common/neural_shell_top.jspf">
        <jsp:param name="active" value="inventory" />
    </jsp:include>

    <!-- Logistics Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-7xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">
            
            <!-- Header Section -->
            <div class="flex justify-between items-end py-12">
                <div class="space-y-4">
                    <div class="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-[9px] font-bold tracking-[0.3em] uppercase">
                        <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                        Hệ thống Logistics & Chuỗi cung ứng
                    </div>
                    <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                        Kho Vật Tư <span class="text-hotel-gold italic">& Hàng Hóa.</span>
                    </h2>
                </div>
                
                <div class="flex items-center gap-4">
                    <a href="products?action=history" class="inline-flex items-center gap-3 px-6 py-4 rounded-xl bg-white border border-hotel-gold/20 text-hotel-muted text-[10px] font-bold tracking-widest uppercase hover:bg-hotel-gold hover:text-white transition-all shadow-sm">
                        <span class="material-symbols-outlined text-lg">history</span> Báo Cáo
                    </a>
                    <a href="products?action=listSuppliers" class="inline-flex items-center gap-3 px-6 py-4 rounded-xl bg-white border border-hotel-gold/20 text-hotel-muted text-[10px] font-bold tracking-widest uppercase hover:bg-hotel-gold hover:text-white transition-all shadow-sm">
                        <span class="material-symbols-outlined text-lg">local_shipping</span> Nhà Cung Cấp
                    </a>
                    <a href="products?action=new" class="inline-flex items-center gap-3 px-8 py-4 rounded-xl bg-hotel-gold text-white text-[10px] font-bold tracking-widest uppercase hover:bg-hotel-text transition-all shadow-lg shadow-hotel-gold/20">
                        <span class="material-symbols-outlined text-lg">add_circle</span> Nhập Hàng Mới
                    </a>
                </div>
            </div>

            <!-- Dashboard Stats Summary (Mini) -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
                <div class="card-elegant p-8 rounded-[2rem] flex items-center gap-6">
                    <div class="w-16 h-16 rounded-2xl bg-hotel-gold/5 flex items-center justify-center text-hotel-gold border border-hotel-gold/10">
                        <span class="material-symbols-outlined text-3xl">inventory_2</span>
                    </div>
                    <div>
                        <p class="text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em] mb-1">Tổng Danh Mục</p>
                        <h4 class="text-2xl font-serif font-bold text-hotel-text">${listProducts.size()} <span class="text-xs uppercase font-sans text-hotel-muted opacity-60">Sản phẩm</span></h4>
                    </div>
                </div>
                <!-- Add more stats if needed -->
            </div>

            <!-- Toolbar & Filter -->
            <div class="mb-10 flex justify-between items-center bg-white/50 backdrop-blur-md p-6 rounded-3xl border border-hotel-gold/5 shadow-sm">
                <div class="relative w-96 group">
                    <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-hotel-gold/40 group-focus-within:text-hotel-gold transition-colors">search</span>
                    <input type="text" id="quickSearch" placeholder="Tìm kiếm vật tư nhanh..." class="w-full bg-white border border-hotel-gold/10 rounded-2xl pl-12 pr-6 py-3 text-[11px] font-bold uppercase tracking-widest focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold transition-all outline-none">
                </div>
                
                <form action="products" method="get" id="filterForm" class="flex items-center gap-4">
                    <input type="hidden" name="action" value="list">
                    <label class="relative inline-flex items-center cursor-pointer">
                        <input type="checkbox" name="showHidden" value="true" class="sr-only peer" ${isShowHidden ? 'checked' : ''} onchange="this.form.submit()">
                        <div class="w-11 h-6 bg-hotel-gold/10 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-hotel-gold"></div>
                        <span class="ms-3 text-[10px] font-bold text-hotel-muted uppercase tracking-widest">Hiển thị hàng đã ẩn</span>
                    </label>
                </form>
            </div>

            <!-- Inventory Table -->
            <div class="card-elegant rounded-[2.5rem] overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="bg-hotel-bone/50 border-b border-hotel-gold/10">
                                <th class="px-8 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Thông tin Sản phẩm</th>
                                <th class="px-8 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Loại & Đơn vị</th>
                                <th class="px-8 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Tồn Kho</th>
                                <th class="px-8 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Giá (Cost / Sell)</th>
                                <th class="px-8 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em] text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-hotel-gold/5">
                            <c:forEach var="p" items="${listProducts}">
                                <tr class="table-row-hover transition-colors ${p.isActive ? '' : 'dimmed-row'}">
                                    <td class="px-8 py-6">
                                        <div class="flex items-center gap-5">
                                            <div class="w-12 h-12 rounded-xl bg-hotel-cream flex items-center justify-center text-hotel-gold border border-hotel-gold/10 font-serif font-bold italic">
                                                #${p.itemID}
                                            </div>
                                            <div>
                                                <p class="text-[12px] font-bold text-hotel-text uppercase tracking-widest mb-1">${p.itemName}</p>
                                                <div class="flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-[14px] text-hotel-gold opacity-60">store</span>
                                                    <p class="text-[9px] text-hotel-muted font-bold tracking-wider">${p.supplier.supplierName}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-8 py-6">
                                        <div class="space-y-2">
                                            <c:choose>
                                                <c:when test="${p.isTradeGood}">
                                                    <span class="inline-flex px-3 py-1 rounded-full bg-emerald-50 text-emerald-600 text-[8px] font-bold uppercase tracking-wider border border-emerald-100">Kinh Doanh</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex px-3 py-1 rounded-full bg-orange-50 text-orange-600 text-[8px] font-bold uppercase tracking-wider border border-orange-100">Tiêu Hao Nội Bộ</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <p class="text-[11px] font-semibold text-hotel-muted">ĐVT: ${p.unit}</p>
                                        </div>
                                    </td>
                                    <td class="px-8 py-6">
                                        <div class="flex items-center gap-3">
                                            <span class="text-lg font-serif font-bold text-hotel-text">${p.quantity}</span>
                                            <c:if test="${p.quantity <= 10}">
                                                <div class="w-8 h-8 rounded-lg bg-red-50 text-red-500 flex items-center justify-center animate-pulse" title="Sắp hết hàng!">
                                                    <span class="material-symbols-outlined text-lg">warning</span>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="w-24 h-1.5 bg-hotel-gold/10 rounded-full mt-2 overflow-hidden">
                                            <div class="h-full bg-hotel-gold rounded-full" style="width: ${p.quantity > 100 ? 100 : p.quantity}%"></div>
                                        </div>
                                    </td>
                                    <td class="px-8 py-6">
                                        <p class="text-[10px] font-bold text-hotel-muted line-through opacity-40"><fmt:formatNumber value="${p.costPrice}" pattern="#,##0"/>đ</p>
                                        <p class="text-[13px] font-bold text-hotel-gold tracking-tighter"><fmt:formatNumber value="${p.sellingPrice}" pattern="#,##0"/>đ</p>
                                    </td>
                                    <td class="px-8 py-6">
                                        <div class="flex items-center justify-center gap-2">
                                            <c:if test="${p.isActive}">
                                                <a href="products?action=edit&id=${p.itemID}" class="w-10 h-10 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-muted hover:text-hotel-gold hover:border-hotel-gold hover:shadow-lg transition-all" title="Sửa">
                                                    <span class="material-symbols-outlined text-lg">edit_note</span>
                                                </a>
                                                <a href="products?action=import&id=${p.itemID}" class="w-10 h-10 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-muted hover:text-green-600 hover:border-green-600 hover:shadow-lg transition-all" title="Nhập hàng">
                                                    <span class="material-symbols-outlined text-lg">add_box</span>
                                                </a>
                                                <form action="products" method="POST" class="m-0">
                                                    <input type="hidden" name="action" value="softDelete">
                                                    <input type="hidden" name="id" value="${p.itemID}">
                                                    <button type="submit" onclick="return confirm('Ngừng kinh doanh sản phẩm này?')" class="w-10 h-10 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-muted hover:text-orange-500 hover:border-orange-500 hover:shadow-lg transition-all" title="Tạm ẩn">
                                                        <span class="material-symbols-outlined text-lg">visibility_off</span>
                                                    </button>
                                                </form>
                                            </c:if>

                                            <c:if test="${!p.isActive}">
                                                <form action="products" method="POST" class="m-0">
                                                    <input type="hidden" name="action" value="restore">
                                                    <input type="hidden" name="id" value="${p.itemID}">
                                                    <button type="submit" class="w-10 h-10 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-muted hover:text-emerald-500 hover:border-emerald-500 hover:shadow-lg transition-all" title="Khôi phục">
                                                        <span class="material-symbols-outlined text-lg">settings_backup_restore</span>
                                                    </button>
                                                </form>
                                            </c:if>

                                            <form action="products" method="POST" class="m-0">
                                                <input type="hidden" name="action" value="hardDelete">
                                                <input type="hidden" name="id" value="${p.itemID}">
                                                <button type="submit" onclick="return confirm('XÓA VĨNH VIỄN sản phẩm này? Thao tác không thể hoàn tác!')" class="w-10 h-10 rounded-xl bg-red-50 border border-red-100 flex items-center justify-center text-red-400 hover:bg-red-500 hover:text-white hover:border-red-500 hover:shadow-lg transition-all" title="Xóa">
                                                    <span class="material-symbols-outlined text-lg">delete_forever</span>
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
            
            <c:if test="${empty listProducts}">
                <div class="py-32 text-center animate-pulse">
                    <span class="material-symbols-outlined text-7xl text-hotel-gold/20 block mb-6">inventory_2</span>
                    <h3 class="text-xl font-serif font-bold text-hotel-text uppercase tracking-[0.2em] opacity-30">Kho hàng đang trống</h3>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        // Simple client-side quick search
        document.getElementById('quickSearch').addEventListener('input', function(e) {
            const term = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const text = row.querySelector('.text-[12px]').innerText.toLowerCase();
                row.style.display = text.includes(term) ? '' : 'none';
            });
        });
    </script>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>