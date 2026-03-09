<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Thanh Toán VNPay</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { "primary": "#11d493", "background-light": "#f6f8f7", "text-main": "#10221c" },
                    fontFamily: { "display": ["Plus Jakarta Sans", "sans-serif"] },
                },
            },
        }
    </script>
</head>
<body class="bg-background-light font-display text-slate-900 min-h-screen flex flex-col">
    
    <header class="w-full bg-white border-b border-slate-200 px-6 py-4 shadow-sm">
        <div class="max-w-[1200px] mx-auto flex items-center justify-between">
            <div class="flex items-center gap-3 text-slate-900">
                <div class="size-10 text-primary flex items-center justify-center bg-primary/10 rounded-xl"><span class="material-symbols-outlined text-2xl">hotel_class</span></div>
                <h2 class="text-2xl font-bold tracking-tight">SmartHotel</h2>
            </div>
            <a href="${pageContext.request.contextPath}/rooms" class="flex cursor-pointer items-center justify-center rounded-lg h-10 px-5 bg-white border border-slate-200 hover:bg-slate-50 transition-colors text-slate-600 text-sm font-bold text-decoration-none">Hủy Giao Dịch</a>
        </div>
    </header>

    <main class="flex-grow flex items-center justify-center py-12 px-4">
        <div class="max-w-4xl w-full grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <div class="lg:col-span-5 flex flex-col justify-center space-y-6 lg:sticky lg:top-8">
                <div>
                    <span class="inline-flex items-center rounded-full bg-emerald-100 px-3 py-1 text-xs font-bold text-emerald-800 mb-4 border border-emerald-200">
                        <span class="material-symbols-outlined text-[16px] mr-1">lock</span> Cổng Thanh Toán An Toàn
                    </span>
                    <h1 class="text-3xl md:text-4xl font-black tracking-tight text-slate-900 mb-3">Hoàn tất đặt phòng</h1>
                    <p class="text-slate-500 text-lg leading-relaxed font-medium">Vui lòng sử dụng cổng thanh toán VNPay để hoàn tất giao dịch một cách nhanh chóng và bảo mật.</p>
                </div>
                <div class="grid grid-cols-2 gap-4 mt-4">
                    <div class="flex flex-col gap-2 p-4 bg-white rounded-xl border border-slate-200 shadow-sm">
                        <span class="material-symbols-outlined text-primary text-3xl">verified_user</span>
                        <span class="text-sm font-bold text-slate-900">Bảo mật cấp cao</span>
                    </div>
                    <div class="flex flex-col gap-2 p-4 bg-white rounded-xl border border-slate-200 shadow-sm">
                        <span class="material-symbols-outlined text-primary text-3xl">bolt</span>
                        <span class="text-sm font-bold text-slate-900">Xác nhận tức thì</span>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-7">
                <div class="bg-white rounded-2xl shadow-xl shadow-slate-200/50 overflow-hidden border-t-4 border-primary relative">
                    <div class="absolute top-0 left-0 w-full h-32 bg-gradient-to-b from-emerald-50 to-transparent pointer-events-none"></div>
                    <div class="p-6 md:p-8 relative">
                        
                        <div class="flex justify-between items-start mb-8 border-b border-slate-100 pb-4">
                            <div>
                                <h3 class="text-lg font-bold text-slate-900">Thông Tin Giao Dịch</h3>
                                <p class="text-sm text-slate-500 mt-1 font-medium">Mã Booking: <span class="font-bold text-primary">#BK-${booking.bookingID}</span></p>
                            </div>
                            <div class="text-right">
                                <p class="text-sm font-bold text-slate-500 uppercase tracking-wider mb-1">Cần Thanh Toán</p>
                                <h2 class="text-3xl font-black text-rose-500 tracking-tight">
                                    <fmt:formatNumber value="${booking.totalAmount}" pattern="#,###"/> đ
                                </h2>
                            </div>
                        </div>

                        <div class="bg-slate-50 rounded-xl p-5 mb-8 border border-slate-100">
                            <div class="grid grid-cols-2 gap-y-4 gap-x-8">
                                <div><p class="text-xs text-slate-400 uppercase font-bold mb-1">Khách Hàng</p><p class="text-sm font-black text-slate-900">${booking.customer.fullName}</p></div>
                                <div><p class="text-xs text-slate-400 uppercase font-bold mb-1">Phòng</p><p class="text-sm font-bold text-slate-900">Phòng ${booking.room.roomNumber}</p></div>
                                <div class="col-span-2"><p class="text-xs text-slate-400 uppercase font-bold mb-1">Thời gian lưu trú</p><p class="text-sm font-bold text-slate-900"><fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/></p></div>
                            </div>
                        </div>

                        <form action="${pageContext.request.contextPath}/create_payment" method="GET" onsubmit="this.querySelector('button').innerHTML='Đang chuyển hướng...'; this.querySelector('button').disabled=true;">
                            <input type="hidden" name="bookingId" value="${booking.bookingID}">
                            <input type="hidden" name="amount" value="${booking.totalAmount}">
                            
                            <button type="submit" class="w-full py-4 px-6 bg-gradient-to-r from-blue-600 to-blue-800 hover:from-blue-700 hover:to-blue-900 text-white font-black text-lg rounded-xl shadow-lg transform transition-all active:scale-[0.98] flex items-center justify-center gap-2 mb-4">
                                <span class="material-symbols-outlined">account_balance</span> 
                                THANH TOÁN QUA VNPAY
                            </button>
                        </form>

                        <p class="text-center text-xs text-slate-400 font-medium">Bạn sẽ được chuyển hướng đến cổng thanh toán VNPay để thực hiện giao dịch.</p>
                    </div>
                    
                    <div class="bg-slate-50 px-8 py-4 border-t border-slate-100 flex items-center justify-between text-xs font-bold text-slate-400">
                        <div class="flex items-center gap-1"><span class="material-symbols-outlined text-base">lock</span> SSL Encrypted</div>
                        <div>Powered by VNPay</div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>