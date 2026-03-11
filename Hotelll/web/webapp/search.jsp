<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Xác nhận Đặt Phòng - SmartHotel</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = { theme: { extend: { colors: { primary: "#1069f9", "background-light": "#f6f8f7" }, fontFamily: { display: ["Plus Jakarta Sans", "sans-serif"] }, }, }, }
    </script>
</head>
<body class="bg-background-light font-display text-slate-900 min-h-screen flex flex-col antialiased">
    
    <header class="w-full bg-white border-b border-slate-200 px-6 py-4 shadow-sm">
        <div class="max-w-[1200px] mx-auto flex items-center justify-between">
            <div class="flex items-center gap-2 text-slate-900">
                <span class="material-symbols-outlined text-4xl text-primary">hotel_class</span>
                <h2 class="text-xl font-bold tracking-tight">SmartHotel</h2>
            </div>
            <a href="${pageContext.request.contextPath}/rooms" class="font-bold text-sm text-slate-500 hover:text-primary flex items-center gap-1">
                <span class="material-symbols-outlined text-[18px]">arrow_back</span> Chọn phòng khác
            </a>
        </div>
    </header>

    <main class="flex-grow flex items-center justify-center py-12 px-4">
        <div class="max-w-xl w-full bg-white rounded-2xl shadow-xl border border-slate-200 overflow-hidden">
            
            <div class="bg-primary/10 p-6 sm:p-8 border-b border-primary/20 text-center">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-white text-primary mb-4 shadow-md">
                    <span class="material-symbols-outlined text-3xl">calendar_month</span>
                </div>
                <h2 class="text-3xl font-black text-slate-900 tracking-tight">Thiết lập Đặt Phòng</h2>
                <p class="text-slate-600 font-medium mt-2">Vui lòng chọn ngày lưu trú và áp dụng mã giảm giá (nếu có).</p>
            </div>

            <div class="p-6 sm:p-8">
                <% String error = (String) request.getAttribute("error"); if (error != null) { %>
                    <div class="mb-6 bg-red-50 text-red-600 p-4 rounded-xl font-bold border border-red-100 flex items-center gap-2">
                        <span class="material-symbols-outlined">error</span> <%= error %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/booking" method="post" onsubmit="this.querySelector('button[type=submit]').innerHTML='Đang xử lý hóa đơn...'; this.querySelector('button[type=submit]').disabled=true;" class="space-y-6">
                    
                    <div>
                        <label class="block text-sm font-bold text-slate-700 mb-2">Mã Phòng Đã Chọn</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-primary">meeting_room</span>
                            <input type="text" class="w-full pl-12 pr-4 py-3 bg-blue-50 border-blue-200 rounded-xl font-black text-primary text-lg" name="roomId" value="${param.roomId}" readonly required>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Ngày Nhận Phòng (Check-in)</label>
                            <input type="date" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:border-primary focus:ring-primary font-semibold text-slate-700" name="checkIn" required>
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Ngày Trả Phòng (Check-out)</label>
                            <input type="date" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:border-primary focus:ring-primary font-semibold text-slate-700" name="checkOut" required>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-bold text-emerald-600 mb-2 flex items-center gap-1"><span class="material-symbols-outlined text-[18px]">local_offer</span> Mã Giảm Giá (Voucher)</label>
                        <input type="text" class="w-full px-4 py-3 bg-emerald-50 border border-emerald-200 rounded-xl focus:border-emerald-500 focus:ring-emerald-500 font-bold text-emerald-700 uppercase placeholder:text-emerald-300 placeholder:normal-case placeholder:font-medium" name="voucherCode" placeholder="Nhập mã voucher tại đây (nếu có)...">
                    </div>

                    <button type="submit" class="w-full py-4 bg-primary hover:bg-blue-700 text-white font-black text-lg rounded-xl shadow-lg shadow-primary/30 transition-all active:scale-[0.98] mt-4 flex items-center justify-center gap-2">
                        XÁC NHẬN ĐẶT PHÒNG <span class="material-symbols-outlined">arrow_forward</span>
                    </button>
                </form>
            </div>
        </div>
    </main>
</body>
</html>