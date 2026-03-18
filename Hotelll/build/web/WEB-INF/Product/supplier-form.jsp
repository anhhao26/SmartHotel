<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Thông Tin Đối Tác | SmartHotel Logistics</title>
    
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

    <!-- Supplier Form Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-3xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">
            
            <!-- Header Section -->
            <div class="py-12 text-center">
                <div class="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-[9px] font-bold tracking-[0.3em] uppercase mb-6">
                    <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                    Hồ sơ đơn vị cung ứng
                </div>
                <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                    <c:choose>
                        <c:when test="${supplier != null}">Hiệu Chỉnh <span class="text-hotel-gold italic">Đối Tác.</span></c:when>
                        <c:otherwise>Thêm <span class="text-hotel-gold italic">Nhà Cung Cấp.</span></c:otherwise>
                    </c:choose>
                </h2>
            </div>

            <div class="card-elegant rounded-[3.5rem] p-16 relative overflow-hidden">
                <div class="absolute top-0 right-0 w-64 h-64 bg-hotel-gold/[0.03] blur-[100px] rounded-full -mr-32 -mt-32"></div>
                
                <form action="products" method="POST" class="space-y-10 relative z-10">
                    <input type="hidden" name="action" value="saveSupplier">
                    
                    <c:if test="${supplier != null}">
                        <input type="hidden" name="id" value="${supplier.supplierID}">
                    </c:if>

                    <div class="space-y-4">
                        <label class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">business_center</span> Tên Nhà Cung Cấp (*)
                        </label>
                        <input type="text" name="name" value="${supplier.supplierName}" placeholder="Vd: Công ty TNHH SmartGoods..." class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-[11px] font-bold uppercase tracking-widest transition-all outline-none focus:ring-4 focus:ring-hotel-gold/10 focus:border-hotel-gold focus:bg-white" required />
                    </div>

                    <div class="grid grid-cols-2 gap-8">
                        <div class="space-y-4">
                            <label class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">call_quality</span> Hotline Liên Hệ
                            </label>
                            <input type="text" name="phone" value="${supplier.contactPhone}" placeholder="Vd: 0987-xxx-xxx" class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-[11px] font-bold uppercase tracking-widest transition-all outline-none focus:ring-4 focus:ring-hotel-gold/10 focus:border-hotel-gold focus:bg-white" />
                        </div>
                        <div class="space-y-4 group">
                            <label class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">badge</span> Trạng thái hợp tác
                            </label>
                            <div class="h-[54px] bg-hotel-gold/5 rounded-2xl border border-hotel-gold/10 px-6 flex items-center">
                                <span class="text-[9px] font-bold text-hotel-gold uppercase tracking-widest">Đang Hoạt Động</span>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <label class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">location_city</span> Địa chỉ trụ sở
                        </label>
                        <input type="text" name="address" value="${supplier.address}" placeholder="Nhập địa chỉ chi tiết..." class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl px-6 py-4 text-[11px] font-bold uppercase tracking-widest transition-all outline-none focus:ring-4 focus:ring-hotel-gold/10 focus:border-hotel-gold focus:bg-white" />
                    </div>

                    <div class="flex gap-6 pt-12">
                        <a href="products?action=listSuppliers" class="flex-1 py-5 rounded-2xl border border-hotel-gold/20 text-hotel-muted text-[11px] font-bold uppercase tracking-[0.3em] text-center hover:bg-hotel-bone transition-all">
                            Quay Lại
                        </a>
                        <button type="submit" class="flex-[2] py-5 rounded-2xl bg-hotel-gold text-white text-[11px] font-bold uppercase tracking-[0.3em] shadow-xl shadow-hotel-gold/30 hover:bg-hotel-text transition-all active:scale-95 flex items-center justify-center gap-2">
                            Lưu Thông Tin <span class="material-symbols-outlined text-sm">save_as</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>