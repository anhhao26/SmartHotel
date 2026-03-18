<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Giao Dịch Nhập Kho | SmartHotel Logistics</title>
    
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

    <!-- Logistics Import Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-2xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">
            
            <!-- Header Section -->
            <div class="py-12 text-center">
                <div class="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-[9px] font-bold tracking-[0.3em] uppercase mb-6">
                    <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                    Giao dịch bổ sung tồn kho
                </div>
                <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                    Nhập <span class="text-hotel-gold italic">Hàng Hóa.</span>
                </h2>
            </div>

            <div class="card-elegant rounded-[3rem] p-12 relative overflow-hidden">
                <div class="absolute top-0 right-0 w-48 h-48 bg-hotel-gold/[0.02] blur-3xl rounded-full -mr-24 -mt-24"></div>
                
                <div class="text-center mb-10">
                    <div class="inline-flex items-center gap-4 px-6 py-3 rounded-2xl bg-hotel-gold/5 border border-hotel-gold/10">
                        <span class="material-symbols-outlined text-hotel-gold">inventory</span>
                        <span class="text-[13px] font-bold text-hotel-text uppercase tracking-widest">${product.itemName}</span>
                    </div>
                </div>

                <form action="products" method="POST" id="importForm" class="space-y-8 relative z-10">
                    <input type="hidden" name="action" value="saveImport">
                    <input type="hidden" name="id" value="${product.itemID}">

                    <div class="space-y-4">
                        <label class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">database</span> Tồn kho hiện tại
                        </label>
                        <div class="flex items-center gap-4 bg-hotel-cream/50 border border-hotel-gold/5 p-5 rounded-2xl opacity-60">
                            <span class="text-2xl font-serif font-bold text-hotel-text">${product.quantity}</span>
                            <span class="text-[10px] font-bold text-hotel-muted uppercase tracking-widest">${product.unit}</span>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <label class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">add_box</span> Số lượng nhập thêm (*)
                        </label>
                        <div class="relative">
                            <input type="number" name="quantityToAdd" min="1" placeholder="0" class="w-full bg-hotel-cream border border-hotel-gold/10 rounded-2xl pl-6 pr-20 py-5 text-[14px] font-bold text-hotel-text tracking-widest outline-none focus:ring-4 focus:ring-hotel-gold/10 focus:border-hotel-gold transition-all" required />
                            <span class="absolute right-6 top-1/2 -translate-y-1/2 text-[10px] font-bold text-hotel-gold/40 uppercase">${product.unit}</span>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <label class="text-[10px] font-bold text-emerald-600 uppercase tracking-[0.2em] flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">payments</span> Đơn giá nhập mới (*)
                        </label>
                        <div class="relative">
                            <input type="number" name="newCostPrice" value="${product.costPrice}" class="w-full bg-white border-2 border-emerald-600/10 rounded-2xl pl-6 pr-20 py-5 text-[14px] font-bold text-emerald-700 tracking-widest outline-none focus:ring-4 focus:ring-emerald-600/10 focus:border-emerald-600 transition-all" required />
                            <span class="absolute right-6 top-1/2 -translate-y-1/2 text-[10px] font-bold text-emerald-600/40 uppercase">VND</span>
                        </div>
                        <p class="text-[9px] text-emerald-600/60 font-bold italic tracking-wide"><span class="material-symbols-outlined text-[10px] align-middle mr-1">check_circle</span> Hệ thống sẽ tự động cập nhật giá vốn trung bình</p>
                    </div>

                    <div class="flex gap-6 pt-10">
                        <a href="products" class="flex-1 py-5 rounded-2xl border border-hotel-gold/20 text-hotel-muted text-[11px] font-bold uppercase tracking-[0.3em] text-center hover:bg-hotel-bone transition-all">
                            Hủy Bỏ
                        </a>
                        <button type="submit" id="submitBtn" class="flex-[2] py-5 rounded-2xl bg-hotel-gold text-white text-[11px] font-bold uppercase tracking-[0.3em] shadow-xl shadow-hotel-gold/30 hover:bg-hotel-text transition-all active:scale-95 flex items-center justify-center gap-2">
                            Xác Nhận Nhập Kho <span class="material-symbols-outlined text-sm">verified</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('importForm').addEventListener('submit', function () {
            var btn = document.getElementById('submitBtn');
            btn.innerHTML = '<span class="material-symbols-outlined animate-spin text-sm">progress_activity</span> Đang xử lý...';
            btn.classList.add('opacity-50', 'pointer-events-none');
        });
    </script>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>