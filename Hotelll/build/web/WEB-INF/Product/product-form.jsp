<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Sản Phẩm | SmartHotel Logistics</title>
    
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
        }
        .input-elegant {
            @apply w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-base font-bold uppercase tracking-widest transition-all outline-none focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold focus:bg-white;
        }
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

    <!-- Logistics Form Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-4xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">
            
            <!-- Header Section -->
            <div class="py-12 text-center">
                <div class="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-sm font-bold tracking-[0.3em] uppercase mb-6">
                    <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                    Cấu hình vật tư danh mục
                </div>
                <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                    <c:choose>
                        <c:when test="${product != null}">Cập Nhật <span class="text-hotel-gold italic">Sản Phẩm.</span></c:when>
                        <c:otherwise>Thêm Mới <span class="text-hotel-gold italic">Vật Tư.</span></c:otherwise>
                    </c:choose>
                </h2>
            </div>

            <div class="card-elegant rounded-[3rem] p-12 relative overflow-hidden">
                <div class="absolute top-0 right-0 w-64 h-64 bg-hotel-gold/[0.02] blur-3xl rounded-full -mr-32 -mt-32"></div>
                
                <form action="products" method="POST" class="space-y-10 relative z-10">
                    <c:choose>
                        <c:when test="${product != null}">
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="id" value="${product.itemID}" />
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="action" value="insert" />
                        </c:otherwise>
                    </c:choose>

                    <!-- Row 1: Item Name -->
                    <div class="space-y-4">
                        <label class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">inventory_2</span> Tên vật tư / hàng hóa (*)
                        </label>
                        <input type="text" name="name" value="${product.itemName}" placeholder="Nhập tên sản phẩm..." class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-base font-bold uppercase tracking-widest transition-all outline-none focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold focus:bg-white" required />
                    </div>

                    <!-- Row 2: Classification -->
                    <div class="space-y-4">
                        <label class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">category</span> Phân loại mặt hàng
                        </label>
                        <div class="grid grid-cols-2 gap-6">
                            <label class="relative flex items-center gap-4 p-6 rounded-2xl border border-hotel-gold/10 bg-hotel-cream/30 cursor-pointer hover:bg-white hover:border-hotel-gold/30 transition-all group">
                                <input type="radio" name="isTradeGood" value="1" id="trade1" class="peer sr-only" ${product==null || product.isTradeGood ? 'checked' : ''} onclick="toggleSellingPrice(true)">
                                <div class="w-6 h-6 rounded-full border-2 border-hotel-gold/20 flex items-center justify-center peer-checked:border-hotel-gold peer-checked:bg-hotel-gold transition-all">
                                    <div class="w-2 h-2 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                </div>
                                <div>
                                    <p class="text-base font-bold text-hotel-text uppercase tracking-widest">Hàng Kinh Doanh</p>
                                    <p class="text-sm text-hotel-muted font-bold opacity-60">Dùng để bán cho khách hàng</p>
                                </div>
                            </label>

                            <label class="relative flex items-center gap-4 p-6 rounded-2xl border border-hotel-gold/10 bg-hotel-cream/30 cursor-pointer hover:bg-white hover:border-hotel-gold/30 transition-all group">
                                <input type="radio" name="isTradeGood" value="0" id="trade2" class="peer sr-only" ${product !=null && !product.isTradeGood ? 'checked' : ''} onclick="toggleSellingPrice(false)">
                                <div class="w-6 h-6 rounded-full border-2 border-hotel-gold/20 flex items-center justify-center peer-checked:border-hotel-gold peer-checked:bg-hotel-gold transition-all">
                                    <div class="w-2 h-2 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                </div>
                                <div>
                                    <p class="text-base font-bold text-hotel-text uppercase tracking-widest">Tiêu Hao Nội Bộ</p>
                                    <p class="text-sm text-hotel-muted font-bold opacity-60">Sử dụng trong khách sạn</p>
                                </div>
                            </label>
                        </div>
                    </div>

                    <!-- Row 3: Unit & Quantity -->
                    <div class="grid grid-cols-2 gap-8">
                        <div class="space-y-4">
                            <label class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">straighten</span> Đơn vị tính
                            </label>
                            <input type="text" name="unit" value="${product.unit}" placeholder="Chai, Lon, Kg..." class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-base font-bold uppercase tracking-widest transition-all outline-none focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold focus:bg-white" required />
                        </div>
                        <div class="space-y-4">
                            <label class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">dynamic_feed</span> Số lượng tồn
                            </label>
                            <input type="number" name="quantity" value="${product.quantity != null ? product.quantity : '0'}" ${product!=null ? 'readonly' : 'required'} class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-base font-bold uppercase tracking-widest transition-all outline-none focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold focus:bg-white ${product!=null ? 'opacity-50 cursor-not-allowed' : ''}" />
                            <c:if test="${product != null}">
                                <p class="text-sm text-orange-500 font-bold uppercase italic"><span class="material-symbols-outlined text-sm align-middle mr-1">info</span> Vui lòng tạo "Phiếu Nhập" để đổi số lượng</p>
                            </c:if>
                        </div>
                    </div>

                    <!-- Row 4: Prices -->
                    <div class="grid grid-cols-2 gap-8">
                        <div class="space-y-4">
                            <label class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">payments</span> Giá Nhập (Cost)
                            </label>
                            <div class="relative">
                                <input type="number" name="costPrice" value="${product.costPrice != null ? product.costPrice : '0'}" ${product!=null ? 'readonly' : 'required'} class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl pl-6 pr-16 py-4 text-base font-bold uppercase tracking-widest transition-all outline-none focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold focus:bg-white ${product!=null ? 'opacity-50 cursor-not-allowed' : ''}" />
                                <span class="absolute right-6 top-1/2 -translate-y-1/2 text-sm font-bold text-hotel-gold italic opacity-60 uppercase">VND</span>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <label class="text-sm font-bold text-emerald-600 uppercase tracking-[0.2em] flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm font-bold">sell</span> Giá Bán Ra (Selling)
                            </label>
                            <div class="relative">
                                <input type="number" id="sellingPriceInput" name="sellingPrice" value="${product.sellingPrice != null ? product.sellingPrice : '0'}" class="w-full bg-white border-2 border-emerald-600/20 rounded-2xl pl-6 pr-16 py-4 text-[13px] font-bold text-emerald-700 tracking-tighter transition-all outline-none focus:ring-4 focus:ring-emerald-600/10 focus:border-emerald-600" required />
                                <span class="absolute right-6 top-1/2 -translate-y-1/2 text-sm font-bold text-emerald-600 italic uppercase">VND</span>
                            </div>
                            <p id="priceNote" class="text-sm text-emerald-600/60 font-bold italic tracking-wide">Giá niêm yết xuất hóa đơn</p>
                        </div>
                    </div>

                    <!-- Row 5: Supplier -->
                    <div class="space-y-4">
                        <label class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">store</span> Nhà cung cấp đối tác
                        </label>
                        <div class="flex gap-4">
                            <select name="supplierID" class="flex-1 bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-base font-bold uppercase tracking-widest transition-all outline-none focus:ring-2 focus:ring-hotel-gold/20 focus:border-hotel-gold focus:bg-white appearance-none cursor-pointer">
                                <c:forEach var="s" items="${listSuppliers}">
                                    <option value="${s.supplierID}" ${product.supplier.supplierID==s.supplierID ? 'selected' : ''}>${s.supplierName}</option>
                                </c:forEach>
                            </select>
                            <a href="products?action=newSupplier" class="px-6 py-4 rounded-2xl bg-hotel-gold/10 border border-hotel-gold/20 text-hotel-gold text-sm font-bold tracking-widest uppercase hover:bg-hotel-gold hover:text-white transition-all flex items-center gap-2">
                                <span class="material-symbols-outlined text-lg">add</span>
                            </a>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="flex gap-6 pt-10">
                        <a href="products" class="flex-1 py-5 rounded-2xl border border-hotel-gold/20 text-hotel-muted text-base font-bold uppercase tracking-[0.3em] text-center hover:bg-hotel-bone transition-all">
                            Quay Lại
                        </a>
                        <button type="submit" class="flex-[2] py-5 rounded-2xl bg-hotel-gold text-white text-base font-bold uppercase tracking-[0.3em] shadow-xl shadow-hotel-gold/30 hover:bg-hotel-text transition-all active:scale-95">
                            Lưu Thông Tin <span class="material-symbols-outlined align-middle ml-2 text-sm">verified</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleSellingPrice(isTrade) {
            const input = document.getElementById("sellingPriceInput");
            const note = document.getElementById("priceNote");

            if (isTrade) {
                input.readOnly = false;
                input.classList.remove("opacity-40", "bg-hotel-cream/50", "border-hotel-gold/10", "text-hotel-muted");
                input.classList.add("bg-white", "border-emerald-600/20", "text-emerald-700");
                note.innerHTML = "Giá niêm yết xuất hóa đơn cho khách";
                note.classList.replace("text-red-500", "text-emerald-600/60");
            } else {
                input.value = 0;
                input.readOnly = true;
                input.classList.add("opacity-40", "bg-hotel-cream/50", "border-hotel-gold/10", "text-hotel-muted");
                input.classList.remove("bg-white", "border-emerald-600/20", "text-emerald-700");
                note.innerHTML = "Hàng nội bộ - không có giá bán";
                note.classList.replace("text-emerald-600/60", "text-red-500");
            }
        }
        window.onload = function () {
            const isTrade = document.getElementById("trade1").checked;
            toggleSellingPrice(isTrade);
        };
    </script>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>