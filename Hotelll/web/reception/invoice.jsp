<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.smarthotel.util.JPAUtil" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="com.smarthotel.model.Invoice" %>
<%@ page import="com.smarthotel.model.InvoiceItem" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel Invoice</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = { theme: { extend: { colors: { primary: "#1069f9", "background-light": "#f5f7f8" }, fontFamily: { display: ["Manrope", "sans-serif"], serif: ["Playfair Display", "serif"], } } } }
    </script>
    <style>
        @media print { body { background-color: white; -webkit-print-color-adjust: exact; } .no-print { display: none !important; } .print-border { border: none; box-shadow: none; padding: 0;} }
    </style>
</head>
<body class="bg-background-light min-h-screen font-display antialiased text-slate-900 flex flex-col items-center py-8">
<%
  String sid = request.getParameter("invoiceId");
  Invoice inv = null;
  if (sid != null) {
    try {
      int iid = Integer.parseInt(sid);
      EntityManager em = JPAUtil.getEntityManager();
      try { inv = em.find(Invoice.class, iid); } finally { em.close(); }
    } catch (Exception e) { inv = null; }
  }
%>

<div class="no-print w-full max-w-[210mm] mx-auto mb-4 flex justify-between">
    <a href="<%=request.getContextPath()%>/reception/home.jsp" class="font-bold text-primary hover:underline flex items-center gap-1"><span class="material-symbols-outlined">arrow_back</span> Quay Lại Bảng Điều Khiển</a>
</div>

<div class="w-full max-w-[210mm] bg-white shadow-xl print-border mx-auto p-12 md:p-16 rounded-xl flex flex-col gap-8 h-auto min-h-[297mm]">
    
    <% if (inv == null) { %>
        <div class="text-center text-red-600 font-bold text-xl py-20 flex flex-col items-center gap-4">
            <span class="material-symbols-outlined text-6xl">error</span>
            Không tìm thấy dữ liệu Hóa đơn này trong hệ thống!
        </div>
    <% } else { %>

    <header class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 border-b border-slate-200 pb-8">
        <div class="flex flex-col gap-2">
            <div class="flex items-center gap-3">
                <span class="material-symbols-outlined text-4xl text-primary">apartment</span>
                <h1 class="text-4xl font-serif font-bold text-slate-900 tracking-tight">SmartHotel</h1>
            </div>
            <div class="flex flex-col text-slate-500 text-sm mt-1">
                <p>Số 01 Nguyễn Văn Linh, Đà Nẵng, Việt Nam</p>
                <p>+84 (236) 123-4567 | hello@smarthotel.vn</p>
            </div>
        </div>
        <div class="text-right">
            <div class="inline-flex items-center justify-center px-4 py-1.5 bg-green-100 text-green-700 rounded-full text-sm font-bold uppercase tracking-wider mb-2">PAID / ĐÃ THANH TOÁN</div>
            <p class="text-slate-400 text-xs uppercase tracking-widest font-semibold mt-1">Trạng Thái Hóa Đơn</p>
        </div>
    </header>

    <section class="grid grid-cols-1 md:grid-cols-2 gap-8 md:gap-12">
        <div class="flex flex-col gap-6">
            <div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider mb-1">Khách Hàng (Billed To)</p>
                <h3 class="text-xl font-bold text-slate-900"><%= inv.getCustomer()!=null?inv.getCustomer().getFullName():"Khách Vãng Lai" %></h3>
                <p class="text-slate-500 text-sm mt-1 font-medium">Hạng thẻ: <%= inv.getCustomer()!=null?inv.getCustomer().getMemberType():"Standard" %></p>
            </div>
            <div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider mb-1">Mã Phiếu Đặt (Booking ID)</p>
                <p class="text-slate-900 font-bold font-mono">BK-<%= inv.getBooking()!=null?inv.getBooking().getBookingID():"-" %></p>
            </div>
        </div>
        <div class="flex flex-col gap-6 md:text-right">
            <div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider mb-1">Mã Hóa Đơn (Invoice No.)</p>
                <p class="text-primary font-bold text-xl">INV-<%= inv.getInvoiceID() %></p>
            </div>
            <div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider mb-1">Ngày Xuất (Issue Date)</p>
                <p class="text-slate-900 font-bold"><%= inv.getCreatedDate()!=null? new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(inv.getCreatedDate()) : "-" %></p>
            </div>
        </div>
    </section>

    <section class="mt-4 flex-grow">
        <div class="w-full overflow-hidden rounded-lg border border-slate-200">
            <table class="w-full text-left text-sm">
                <thead>
                    <tr class="bg-slate-50 border-b border-slate-200">
                        <th class="py-4 px-6 font-bold text-slate-900 w-16 text-center">STT</th>
                        <th class="py-4 px-6 font-bold text-slate-900">Chi tiết dịch vụ / Sản phẩm</th>
                        <th class="py-4 px-6 font-bold text-slate-900 text-center w-24">SL</th>
                        <th class="py-4 px-6 font-bold text-slate-900 text-right w-32">Đơn giá</th>
                        <th class="py-4 px-6 font-bold text-slate-900 text-right w-40">Thành tiền</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <%
                      List<InvoiceItem> items = inv.getItems();
                      int idx = 1; double subtotal = 0;
                      for (InvoiceItem it : items) {
                        double line = (it.getUnitPrice()!=null?it.getUnitPrice():0.0) * (it.getQuantity()!=null?it.getQuantity():0);
                        subtotal += line;
                    %>
                    <tr class="hover:bg-slate-50/50 transition-colors">
                        <td class="py-4 px-6 text-center text-slate-500 font-medium"><%= idx++ %></td>
                        <td class="py-4 px-6 font-bold text-slate-900"><%= it.getInventory()!=null?it.getInventory().getItemName():"Tiền phòng & Dịch vụ" %></td>
                        <td class="py-4 px-6 text-center text-slate-700 font-bold"><%= it.getQuantity()!=null?it.getQuantity():0 %></td>
                        <td class="py-4 px-6 text-right text-slate-500 font-medium"><%= String.format("%,.0f", it.getUnitPrice()!=null?it.getUnitPrice():0.0) %></td>
                        <td class="py-4 px-6 text-right text-slate-900 font-black"><%= String.format("%,.0f", line) %> đ</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <section class="flex justify-end pt-4">
        <div class="w-full md:w-1/2 lg:w-2/5 flex flex-col gap-3">
            <div class="flex justify-between items-center text-sm">
                <span class="text-slate-500 font-bold">Tổng phụ (Subtotal)</span>
                <span class="text-slate-900 font-bold"><%= String.format("%,.0f", subtotal) %> đ</span>
            </div>
            <div class="flex justify-between items-center text-sm p-2 bg-green-50 rounded text-green-700 border border-green-100">
                <span class="font-bold flex items-center gap-1"><span class="material-symbols-outlined text-[16px]">local_offer</span> Voucher / Giảm giá</span>
                <span class="font-bold">- <%= String.format("%,.0f", inv.getDiscount()!=null?inv.getDiscount():0.0) %> đ</span>
            </div>
            <div class="h-px bg-slate-200 my-2"></div>
            <div class="flex justify-between items-center">
                <span class="text-slate-900 font-black text-xl">TỔNG THANH TOÁN</span>
                <span class="text-rose-600 font-black text-3xl"><%= String.format("%,.0f", inv.getTotalAmount()!=null?inv.getTotalAmount():subtotal) %> đ</span>
            </div>
        </div>
    </section>

    <footer class="mt-auto pt-16 flex flex-col gap-8">
        <div class="flex flex-col md:flex-row justify-between items-end gap-12">
            <div class="flex flex-col gap-2 max-w-sm">
                <p class="text-slate-900 font-bold text-sm">Ghi chú thanh toán</p>
                <p class="text-slate-500 text-sm font-medium">Toàn bộ chi phí đã được thanh toán đầy đủ bằng tiền mặt / chuyển khoản tại quầy.</p>
            </div>
            <div class="flex flex-col gap-2 w-64">
                <div class="border-b-2 border-dashed border-slate-300 mb-2 h-8"></div>
                <p class="text-center text-xs text-slate-400 uppercase tracking-widest font-bold">Chữ ký Lễ Tân</p>
            </div>
        </div>
        <div class="border-t border-slate-100 pt-8 text-center">
            <p class="text-slate-600 font-bold mb-1">Cảm ơn quý khách đã tin tưởng SmartHotel.</p>
            <div class="flex justify-center gap-6 mt-4 text-xs font-bold text-slate-400">
                <span>Hẹn gặp lại!</span>
                <span>•</span>
                <span>smarthotel.vn</span>
            </div>
        </div>
    </footer>
    <% } %>
</div>

<button class="no-print fixed bottom-8 right-8 bg-primary hover:bg-blue-700 text-white p-4 rounded-full shadow-lg shadow-blue-500/40 transition-all hover:scale-105 z-50 flex items-center justify-center gap-2 group" onclick="window.print()">
    <span class="material-symbols-outlined">print</span>
    <span class="max-w-0 overflow-hidden group-hover:max-w-xs transition-all duration-300 whitespace-nowrap font-bold">In Hóa Đơn</span>
</button>

</body>
</html>