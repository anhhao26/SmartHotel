<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Thông Tin Vật Tư - SmartHotel</title>

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

                .input-elegant[readonly] {
                    background: rgba(112, 104, 95, 0.03);
                    border-color: rgba(112, 104, 95, 0.1);
                    color: rgba(44, 39, 34, 0.4);
                    cursor: not-allowed;
                }

                .radio-elegant:checked+label {
                    background: rgba(184, 154, 108, 0.08);
                    border-color: #B89A6C;
                    color: #B89A6C;
                }

                .radio-elegant:checked+label .material-symbols-outlined {
                    color: #B89A6C;
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

            <!-- Product Form Content -->
            <div class="flex-1 h-screen overflow-y-auto pb-32">
                <div class="max-w-4xl mx-auto px-8 py-16 animate-[fadeIn_0.6s_ease-out]">

                    <!-- Header Section -->
                    <div class="text-center mb-16 space-y-4">
                        <div
                            class="inline-flex items-center gap-2 px-4 py-1 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-[10px] font-bold tracking-[0.3em] uppercase">
                            Giao Thức Nhập Liệu Vật Tư
                        </div>
                        <h2
                            class="text-6xl font-serif font-bold text-hotel-text tracking-tight uppercase leading-tight italic">
                            <c:choose>
                                <c:when test="${product != null}">Cập Nhật <span class="text-hotel-gold">Vật Tư.</span>
                                </c:when>
                                <c:otherwise>Khai Báo <span class="text-hotel-gold">Vật Tư.</span></c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="text-hotel-muted text-sm font-medium uppercase tracking-[0.2em] opacity-60">
                            Cập nhật chi tiết các thuộc tính vật lý và giá trị thương mại
                        </p>
                    </div>

                    <div class="card-elegant rounded-[3rem] p-12 lg:p-16 relative overflow-hidden shadow-2xl">
                        <div
                            class="absolute top-0 right-0 w-64 h-64 bg-hotel-gold/5 blur-[100px] rounded-full pointer-events-none">
                        </div>

                        <form action="products" method="post" class="space-y-12 relative z-10">
                            <c:choose>
                                <c:when test="${product != null}">
                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="id" value="${product.itemID}" />
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="action" value="insert" />
                                </c:otherwise>
                            </c:choose>

                            <div class="space-y-10">
                                <!-- Name & Classification -->
                                <div class="grid grid-cols-1 gap-10">
                                    <div class="space-y-1">
                                        <div class="flex items-center justify-between px-2">
                                            <label class="label-premium">Tên vật tư kỹ thuật (Entry Name)</label>
                                            <span class="material-symbols-outlined text-hotel-gold/30 text-sm">signature</span>
                                        </div>
                                        <input type="text" name="name" value="${product.itemName}" required
                                            class="w-full h-24 input-elegant rounded-3xl px-10 font-serif font-bold text-hotel-text text-3xl tracking-tight uppercase placeholder-hotel-muted/20 italic border-hotel-gold/20"
                                            placeholder="NHẬP TÊN VẬT TƯ..." />
                                    </div>

                                    <div class="space-y-2">
                                        <label class="label-premium px-2">Phân loại nghiệp vụ (*)</label>
                                        <div class="grid grid-cols-2 gap-6">
                                            <div class="relative">
                                                <input type="radio" id="trade1" name="isTradeGood" value="1"
                                                    class="hidden radio-elegant" ${product==null || product.isTradeGood
                                                    ? 'checked' : '' } onclick="toggleSellingPrice(true)">
                                                <label for="trade1"
                                                    class="flex flex-col items-center justify-center h-28 rounded-3xl border border-hotel-gold/10 bg-hotel-bone cursor-pointer hover:bg-hotel-gold/5 transition-all group/radio">
                                                    <span
                                                        class="material-symbols-outlined mb-2 text-hotel-gold/30 group-hover:text-hotel-gold transition-colors">trending_up</span>
                                                    <span class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.2em] group-hover:text-hotel-gold transition-colors italic">Sản Phẩm Thương Mại</span>
                                                </label>
                                            </div>
                                            <div class="relative">
                                                <input type="radio" id="trade2" name="isTradeGood" value="0"
                                                    class="hidden radio-elegant" ${product !=null &&
                                                    !product.isTradeGood ? 'checked' : '' }
                                                    onclick="toggleSellingPrice(false)">
                                                <label for="trade2"
                                                    class="flex flex-col items-center justify-center h-28 rounded-3xl border border-hotel-gold/10 bg-hotel-bone cursor-pointer hover:bg-hotel-gold/5 transition-all group/radio">
                                                    <span
                                                        class="material-symbols-outlined mb-2 text-hotel-gold/30 group-hover:text-hotel-chocolate transition-colors">inventory</span>
                                                    <span class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.2em] group-hover:text-hotel-chocolate transition-colors italic">Vật Tư Nội Bộ</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Unit & Quantity -->
                                <div class="grid grid-cols-2 gap-10">
                                    <div class="space-y-4">
                                        <label
                                            class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Đơn
                                            vị tính (Unit)</label>
                                        <input type="text" name="unit" value="${product.unit}" required
                                            class="w-full h-20 input-elegant rounded-2xl px-8 font-bold text-hotel-text text-[11px] uppercase tracking-widest italic"
                                            placeholder="Lon/Gói/Cái..." />
                                    </div>
                                    <div class="space-y-4">
                                        <label
                                            class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Số
                                            lượng tồn kho (Stock)</label>
                                        <div class="relative">
                                            <input type="number" name="quantity" value="${product.quantity}" ${product
                                                !=null ? 'readonly' : 'required' }
                                                class="w-full h-20 input-elegant rounded-2xl px-8 font-serif font-bold text-hotel-text text-2xl" />
                                            <c:if test="${product != null}">
                                                <p
                                                    class="absolute -bottom-6 left-2 text-[8px] font-bold text-accent-ruby uppercase tracking-[0.2em] italic opacity-60">
                                                    Chế độ xem: Vui lòng nhập hàng để thay đổi số lượng.</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <!-- Pricing -->
                                <div class="grid grid-cols-2 gap-10 pt-2">
                                    <div class="space-y-4">
                                        <label
                                            class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Đơn
                                            giá vốn (Cost)</label>
                                        <div class="relative flex items-center">
                                            <input type="number" name="costPrice" value="${product.costPrice}" ${product
                                                !=null ? 'readonly' : 'required' }
                                                class="w-full h-20 input-elegant rounded-2xl px-8 font-serif font-bold text-hotel-text text-2xl" />
                                            <span
                                                class="absolute right-8 text-[12px] font-bold text-hotel-muted/40 uppercase">VNĐ</span>
                                        </div>
                                    </div>
                                    <div class="space-y-4">
                                        <label
                                            class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Đơn
                                            giá bán (Selling Matrix)</label>
                                        <div class="relative flex items-center">
                                            <input type="number" id="sellingPriceInput" name="sellingPrice"
                                                value="${product.sellingPrice}" required
                                                class="w-full h-20 input-elegant rounded-2xl px-8 font-serif font-bold text-hotel-gold text-3xl border-hotel-gold/20" />
                                            <span
                                                class="absolute right-8 text-[12px] font-bold text-hotel-gold/40 uppercase">VNĐ</span>
                                            <p id="priceNote"
                                                class="absolute -bottom-6 left-2 text-[8px] font-bold text-hotel-muted uppercase tracking-[0.2em] italic opacity-60">
                                                Đơn giá niêm yết khi bán dịch vụ/sản phẩm.</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Supplier -->
                                <div class="space-y-4 pt-4">
                                    <label
                                        class="text-[10px] font-bold text-hotel-muted uppercase tracking-[0.3em] px-2">Đối
                                        tác cung cấp (Supplier Asset)</label>
                                    <div class="flex gap-4">
                                        <div class="relative flex-1 group/select">
                                            <select name="supplierID"
                                                class="w-full h-20 input-elegant rounded-2xl px-8 font-bold text-hotel-text text-[11px] uppercase tracking-widest appearance-none cursor-pointer">
                                                <c:forEach var="s" items="${listSuppliers}">
                                                    <option value="${s.supplierID}"
                                                        ${product.supplier.supplierID==s.supplierID ? 'selected' : '' }>
                                                        ${s.supplierName} (Mã đối tác: ${s.supplierID})
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <span
                                                class="material-symbols-outlined absolute right-8 top-1/2 -translate-y-1/2 text-hotel-gold/40 pointer-events-none group-hover/select:text-hotel-gold transition-colors">expand_more</span>
                                        </div>
                                        <a href="products?action=newSupplier"
                                            class="h-20 w-20 rounded-2xl bg-hotel-gold/5 border border-hotel-gold/10 flex items-center justify-center text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all shadow-sm active:scale-95">
                                            <span class="material-symbols-outlined text-3xl">add</span>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 pt-10">
                                <button type="submit"
                                    class="h-20 btn-gold font-bold text-xs tracking-[0.4em] uppercase rounded-3xl flex items-center justify-center gap-3 shadow-lg group">
                                    <span
                                        class="material-symbols-outlined group-hover:rotate-12 transition-transform">save</span>
                                    Lưu Thông Tin
                                </button>
                                <a href="products"
                                    class="h-20 bg-hotel-muted/5 border border-hotel-muted/10 flex items-center justify-center font-bold text-xs tracking-[0.4em] uppercase rounded-3xl hover:bg-hotel-muted hover:text-white transition-all text-hotel-muted">
                                    Hủy Bỏ
                                </a>
                            </div>
                        </form>
                    </div>

                    <div class="text-center opacity-40 py-12">
                        <p class="font-serif italic text-hotel-muted text-[11px] tracking-[0.5em] uppercase">SmartHotel
                            Luxury Management System • Asset Entry v2.0</p>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/neural_shell_bottom.jspf" />

            <script>
                function toggleSellingPrice(isTrade) {
                    var input = document.getElementById("sellingPriceInput");
                    var note = document.getElementById("priceNote");

                    if (isTrade) {
                        input.readOnly = false;
                        input.style.borderColor = "rgba(184, 154, 108, 0.4)";
                        input.style.color = "#B89A6C";
                        input.setAttribute("required", "true");
                        note.innerText = "Đơn giá niêm yết khi bán dịch vụ/sản phẩm.";
                        note.style.color = "rgba(112, 104, 95, 0.6)";
                    } else {
                        input.value = 0;
                        input.readOnly = true;
                        input.style.borderColor = "rgba(112, 104, 95, 0.1)";
                        input.style.color = "rgba(112, 104, 95, 0.4)";
                        input.removeAttribute("required");
                        note.innerText = "Vật tư nội bộ không có đơn giá bán (Mặc định = 0).";
                        note.style.color = "rgba(139, 0, 0, 0.6)";
                    }
                }

                window.onload = function () {
                    var tradeRadio = document.getElementById("trade1");
                    if (tradeRadio) {
                        toggleSellingPrice(tradeRadio.checked);
                    }
                };
            </script>
        </body>

        </html>