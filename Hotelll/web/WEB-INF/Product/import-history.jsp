<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Báo Cáo Nhập Kho | SmartHotel Logistics</title>
    
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
            transition: all 0.5s ease;
        }
        .rank-gold { @apply bg-gradient-to-br from-hotel-gold to-hotel-chocolate text-white shadow-lg shadow-hotel-gold/30; }
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

    <!-- Import History Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-6xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">
            
            <!-- Header Section -->
            <div class="flex justify-between items-end py-12">
                <div class="space-y-4">
                    <div class="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-sm font-bold tracking-[0.3em] uppercase">
                        <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                        Phân tích luồng cung ứng
                    </div>
                    <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                        Lịch Sử <span class="text-hotel-gold italic">Nhập Kho.</span>
                    </h2>
                </div>
                
                <div class="flex items-center gap-6 bg-white p-4 rounded-2xl border border-hotel-gold/10">
                    <form action="products" method="GET" class="flex items-center gap-4 m-0">
                        <input type="hidden" name="action" value="history">
                        <label class="text-sm font-bold text-hotel-muted uppercase tracking-widest">Thời điểm:</label>
                        <input type="month" name="monthPicker" value="${selectedMonth}" onchange="this.form.submit()" class="bg-hotel-cream border border-hotel-gold/10 rounded-xl px-4 py-2 text-sm font-bold text-hotel-text outline-none focus:border-hotel-gold transition-all">
                    </form>
                    <a href="products" class="w-12 h-16 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all" title="Về kho hàng">
                        <span class="material-symbols-outlined">arrow_back</span>
                    </a>
                </div>
            </div>

            <!-- Top Ranking Cards -->
            <c:if test="${not empty importStats}">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
                    <c:forEach var="stat" items="${importStats}" varStatus="loop" begin="0" end="2">
                        <div class="card-elegant p-8 rounded-[2.5rem] relative overflow-hidden group hover:-translate-y-2">
                            <div class="absolute top-0 right-0 p-6 opacity-5 group-hover:opacity-10 transition-opacity">
                                <span class="material-symbols-outlined text-8xl">trending_up</span>
                            </div>
                            <div class="flex items-center gap-4 mb-6">
                                <div class="w-10 h-10 rounded-full flex items-center justify-center font-serif font-bold ${loop.index == 0 ? 'bg-hotel-gold text-white' : 'bg-hotel-gold/10 text-hotel-gold'}">
                                    ${loop.index + 1}
                                </div>
                                <p class="text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Hạng ${loop.index + 1}</p>
                            </div>
                            <h4 class="text-xl font-serif font-bold text-hotel-text mb-2 line-clamp-1">${stat[0].itemName}</h4>
                            <p class="text-sm text-hotel-muted font-bold tracking-widest uppercase mb-6 opacity-60">${stat[0].supplier.supplierName}</p>
                            <div class="flex items-baseline gap-2">
                                <span class="text-3xl font-serif font-bold text-hotel-text">${stat[1]}</span>
                                <span class="text-sm font-bold text-hotel-gold uppercase">${stat[0].unit}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- Full Report Table -->
            <div class="card-elegant rounded-[3rem] overflow-hidden">
                <div class="p-8 border-b border-hotel-gold/5 flex justify-between items-center bg-hotel-bone/30">
                    <h5 class="text-base font-bold text-hotel-text uppercase tracking-[0.3em]">Chi tiết biến động tồn kho</h5>
                    <span class="px-3 py-1 bg-hotel-gold/10 text-hotel-gold text-xs font-bold rounded-full uppercase tracking-tighter">Tháng ${selectedMonth}</span>
                </div>
                
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="bg-hotel-bone/50 border-b border-hotel-gold/10">
                                <th class="px-10 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Thứ hạng</th>
                                <th class="px-10 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Sản phẩm & NCC</th>
                                <th class="px-10 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em] text-right">Khối lượng nhập</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-hotel-gold/5">
                            <c:forEach var="stat" items="${importStats}" varStatus="loop">
                                <tr class="hover:bg-hotel-gold/5 transition-colors">
                                    <td class="px-10 py-8">
                                        <div class="w-10 h-10 rounded-xl bg-hotel-cream border border-hotel-gold/10 flex items-center justify-center font-serif font-bold italic text-hotel-gold">
                                            #${loop.index + 1}
                                        </div>
                                    </td>
                                    <td class="px-10 py-8">
                                        <div>
                                            <p class="text-base font-bold text-hotel-text uppercase tracking-widest mb-1">${stat[0].itemName}</p>
                                            <p class="text-sm text-hotel-muted font-bold opacity-60 tracking-wider">${stat[0].supplier.supplierName}</p>
                                        </div>
                                    </td>
                                    <td class="px-10 py-8 text-right">
                                        <div class="inline-flex items-center gap-3 bg-emerald-50 px-5 py-2.5 rounded-xl border border-emerald-100">
                                            <span class="material-symbols-outlined text-emerald-600 text-sm">add_shopping_cart</span>
                                            <span class="text-lg font-serif font-bold text-emerald-700">${stat[1]}</span>
                                            <span class="text-sm font-bold text-emerald-600/60 uppercase uppercase">${stat[0].unit}</span>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty importStats}">
                    <div class="py-32 text-center">
                        <span class="material-symbols-outlined text-7xl text-hotel-gold/20 block mb-6">query_stats</span>
                        <h3 class="text-xl font-serif font-bold text-hotel-text uppercase tracking-[0.2em] opacity-30">Không có dữ liệu nhập hàng</h3>
                        <p class="text-sm text-hotel-muted font-bold tracking-widest uppercase mt-2">Vui lòng chọn mốc thời gian khác</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>