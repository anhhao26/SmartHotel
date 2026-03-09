<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.smarthotel.dao.BookingDAO" %>
<%@ page import="com.smarthotel.dao.InventoryDAO" %>
<%@ page import="com.smarthotel.dao.BookingDAO.BookingShort" %>
<%@ page import="com.smarthotel.model.Inventory" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel Reception Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { "primary": "#1069f9", "secondary": "#ef4444", "background-light": "#f5f7f8", "surface-light": "#ffffff", "border-light": "#e2e8f0", },
                    fontFamily: { "display": ["Manrope", "sans-serif"] },
                },
            },
        }
    </script>
    <style>
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-background-light min-h-screen flex flex-col font-display text-slate-900 transition-colors duration-200">
<%
  BookingDAO bdao = new BookingDAO();
  List<BookingShort> pending = bdao.findPendingBookings();
  List<BookingShort> checked = bdao.findCheckedInBookings();
  InventoryDAO invDao = new InventoryDAO();
  List<Inventory> invList = invDao.findAll();
%>

    <header class="sticky top-0 z-50 bg-surface-light border-b border-border-light px-6 py-4 shadow-sm">
        <div class="mx-auto max-w-[1440px] flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-primary/10 text-primary"><span class="material-symbols-outlined text-2xl">apartment</span></div>
                <div><h1 class="text-xl font-bold tracking-tight text-slate-900">SmartHotel</h1><p class="text-xs font-medium text-slate-500">Reception Console v2.4</p></div>
            </div>
            <div class="flex items-center gap-6">
                <a href="<%=request.getContextPath()%>/admin" class="flex items-center text-slate-600 hover:text-primary font-bold text-sm bg-slate-100 px-4 py-2 rounded-lg transition-colors"><span class="material-symbols-outlined text-lg mr-1">dashboard</span> Bảng Điều Khiển</a>
            </div>
        </div>
    </header>

    <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 md:p-6 lg:p-8">
        <div class="mb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
            <div>
                <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Nghiệp Vụ Hàng Ngày</h2>
                <p class="text-slate-500 mt-1">Quản lý khách đến (Check-in) và khách đi (Check-out).</p>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 h-full">
            <section class="flex flex-col rounded-2xl bg-surface-light shadow-sm border border-slate-200 overflow-hidden h-fit">
                <div class="bg-primary/5 border-b border-primary/10 p-6 flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <div class="p-2 bg-primary text-white rounded-lg shadow-sm shadow-primary/30"><span class="material-symbols-outlined">login</span></div>
                        <div><h3 class="text-lg font-bold text-slate-900">Check-in</h3><p class="text-xs text-primary font-medium uppercase tracking-wider">Khách đợi nhận phòng</p></div>
                    </div>
                </div>
                <div class="p-6 space-y-6">
                    <div class="space-y-2">
                        <label class="block text-sm font-semibold text-slate-700">Chọn Booking Đã Đặt</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <select id="pendingSel" onchange="fillCheckin()" class="w-full pl-11 pr-4 py-3.5 bg-slate-50 border border-slate-200 rounded-xl text-slate-900 focus:ring-2 focus:ring-primary/20 focus:border-primary font-bold cursor-pointer">
                                <option disabled selected value="">-- Chọn khách hàng --</option>
                                <% for (BookingShort b : pending) { String v = b.bookingID + "|" + b.roomID + "|" + b.customerName; %>
                                    <option value="<%=v%>">Mã #<%=b.bookingID%> - Khách: <%=b.customerName%></option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <input type="hidden" name="action" value="checkin">
                        <input type="hidden" name="bid" id="bid_checkin_input">
                        <input type="hidden" name="rid" id="rid_checkin_input">
                        
                        <div class="bg-slate-50 rounded-xl p-5 border border-slate-100 space-y-5 mb-6">
                            <div class="grid grid-cols-2 gap-6">
                                <div class="space-y-1"><span class="text-xs font-medium text-slate-400 uppercase tracking-wide">Mã Booking</span><p id="bid_checkin_display" class="text-base font-bold text-slate-900 font-mono">--</p></div>
                                <div class="space-y-1"><span class="text-xs font-medium text-slate-400 uppercase tracking-wide">Tên Khách Hàng</span><p id="name_checkin_display" class="text-base font-bold text-primary">--</p></div>
                            </div>
                            <div class="h-px bg-slate-200"></div>
                            <div class="grid grid-cols-2 gap-6">
                                <div class="space-y-1"><span class="text-xs font-medium text-slate-400 uppercase tracking-wide">Phòng Sắp Nhận</span><p id="rid_checkin_display" class="text-base font-bold text-slate-900">--</p></div>
                            </div>
                        </div>

                        <button type="submit" id="btn_checkin" class="w-full py-4 bg-primary hover:bg-blue-600 text-white font-bold rounded-xl shadow-lg shadow-primary/25 transition-all flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                            <span class="material-symbols-outlined">key</span> Xác nhận Nhận Phòng
                        </button>
                    </form>
                </div>
            </section>

            <section class="flex flex-col rounded-2xl bg-surface-light shadow-sm border border-slate-200 overflow-hidden h-fit">
                <div class="bg-secondary/5 border-b border-secondary/10 p-6 flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <div class="p-2 bg-secondary text-white rounded-lg shadow-sm shadow-secondary/30"><span class="material-symbols-outlined">logout</span></div>
                        <div><h3 class="text-lg font-bold text-slate-900">Check-out</h3><p class="text-xs text-secondary font-medium uppercase tracking-wider">Thanh toán & Trả phòng</p></div>
                    </div>
                </div>
                <div class="p-6 space-y-6">
                    <div class="space-y-2">
                        <label class="block text-sm font-semibold text-slate-700">Chọn phòng đang sử dụng</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">meeting_room</span>
                            <select id="checkedSel" onchange="fillCheckout()" class="w-full pl-11 pr-4 py-3.5 bg-slate-50 border border-slate-200 rounded-xl text-slate-900 focus:ring-2 focus:ring-secondary/20 focus:border-secondary font-bold cursor-pointer">
                                <option disabled selected value="">-- Chọn phòng thanh toán --</option>
                                <% for (BookingShort b : checked) { String v = b.bookingID + "|" + b.roomID + "|" + b.customerID + "|" + b.customerName; %>
                                    <option value="<%=v%>">Phòng <%=b.roomID%> - <%=b.customerName%></option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/checkout" method="post" class="space-y-5">
                        <input type="hidden" name="action" value="checkout">
                        <input type="hidden" name="bid" id="bid_checkout_input">
                        <input type="hidden" name="rid" id="rid_checkout_input">
                        <input type="hidden" name="cid" id="cid_checkout_input">

                        <div class="bg-slate-50 rounded-xl p-4 border border-slate-100 flex flex-wrap gap-4 items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="h-10 w-10 rounded-full bg-slate-200 flex items-center justify-center text-slate-500 font-bold"><span class="material-symbols-outlined">person</span></div>
                                <div><p id="name_checkout_display" class="text-sm font-bold text-slate-900">--</p><p id="room_checkout_display" class="text-xs text-slate-500">Phòng: --</p></div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-1">Giá phòng thanh toán (VNĐ)</label>
                            <input type="number" name="price" value="1000000" required class="w-full py-3 px-4 text-2xl font-black text-secondary bg-red-50 border-red-200 rounded-xl focus:ring-secondary focus:border-secondary transition-all">
                        </div>

                        <div class="space-y-3">
                            <div class="flex items-center justify-between">
                                <h4 class="text-sm font-bold text-slate-800 flex items-center gap-2"><span class="material-symbols-outlined text-secondary text-[18px]">wine_bar</span> Minibar / Dịch vụ</h4>
                            </div>
                            <div class="border border-slate-200 rounded-xl overflow-hidden bg-white">
                                <div class="max-h-[220px] overflow-y-auto no-scrollbar">
                                    <table class="w-full text-left text-sm">
                                        <thead class="bg-slate-50 sticky top-0 z-10 border-b border-slate-200">
                                            <tr><th class="px-4 py-3 font-medium text-slate-500">Chọn</th><th class="px-4 py-3 font-medium text-slate-500">Sản phẩm</th><th class="px-4 py-3 font-medium text-slate-500 text-center">Đơn giá</th><th class="px-4 py-3 font-medium text-slate-500 text-right">SL dùng</th></tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <% for (Inventory it : invList) { %>
                                            <tr class="hover:bg-slate-50 transition-colors">
                                                <td class="px-4 py-3"><input type="checkbox" name="itemId" value="<%= it.getItemID() %>" class="w-5 h-5 rounded border-slate-300 text-secondary focus:ring-secondary cursor-pointer"></td>
                                                <td class="px-4 py-3 text-slate-700 font-bold"><%= it.getItemName() %></td>
                                                <td class="px-4 py-3 text-slate-500 text-center font-medium"><%= String.format("%,.0f", it.getSellingPrice()) %>đ</td>
                                                <td class="px-4 py-3 text-right"><input type="number" name="qty_<%=it.getItemID()%>" value="1" min="1" class="w-16 rounded border-slate-200 p-1 text-center font-bold"></td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <button type="submit" id="btn_checkout" class="w-full py-4 bg-secondary hover:bg-red-600 text-white font-bold rounded-xl shadow-lg shadow-secondary/25 transition-all flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                            <span class="material-symbols-outlined">receipt_long</span> XUẤT HÓA ĐƠN & TRẢ PHÒNG
                        </button>
                    </form>
                </div>
            </section>
        </div>
    </main>

    <script>
        function fillCheckin(){
            var v = document.getElementById('pendingSel').value;
            var btn = document.getElementById('btn_checkin');
            if(!v) { 
                document.getElementById('bid_checkin_display').innerText = "--"; 
                document.getElementById('rid_checkin_display').innerText = "--"; 
                document.getElementById('name_checkin_display').innerText = "--";
                btn.disabled = true; return; 
            }
            var p = v.split('|');
            document.getElementById('bid_checkin_input').value = p[0];
            document.getElementById('rid_checkin_input').value = p[1];
            
            document.getElementById('bid_checkin_display').innerText = "BK-" + p[0];
            document.getElementById('rid_checkin_display').innerText = "Phòng " + p[1];
            document.getElementById('name_checkin_display').innerText = p[2];
            btn.disabled = false;
        }

        function fillCheckout(){
            var v = document.getElementById('checkedSel').value;
            var btn = document.getElementById('btn_checkout');
            if(!v) { 
                document.getElementById('name_checkout_display').innerText = "--";
                document.getElementById('room_checkout_display').innerText = "Phòng: --";
                btn.disabled = true; return; 
            }
            var p = v.split('|');
            document.getElementById('bid_checkout_input').value = p[0];
            document.getElementById('rid_checkout_input').value = p[1];
            document.getElementById('cid_checkout_input').value = p[2];
            
            document.getElementById('room_checkout_display').innerText = "Phòng: " + p[1];
            document.getElementById('name_checkout_display').innerText = p[3];
            btn.disabled = false;
        }
    </script>
</body>
</html>