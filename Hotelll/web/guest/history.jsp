<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.smarthotel.dao.BookingDAO" %>
<%@ page import="com.smarthotel.model.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    Integer cidObj = (Integer) session.getAttribute("CUST_ID");
    if (cidObj == null) { 
        response.sendRedirect(request.getContextPath()+"/login.jsp"); 
        return; 
    }
    int cid = cidObj;
    BookingDAO dao = new BookingDAO();
    // Giờ hàm này đã có trong BookingDAO, sẽ không còn lỗi "undefined" nữa
    List<Booking> hist = dao.findByCustomerId(cid); 
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Lịch sử Đặt Phòng</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#135bec",
                        "background-light": "#f6f6f8", "background-dark": "#101622",
                        "gold-accent": "#D4AF37", "emerald-accent": "#10B981", "rose-accent": "#F43F5E",
                        "surface-dark": "#1A2332", "surface-darker": "#151C28",
                    },
                    fontFamily: { display: ["Manrope", "sans-serif"], },
                },
            },
        }
    </script>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 antialiased min-h-screen flex flex-col">
    
    <header class="flex items-center justify-between border-b border-slate-200 dark:border-slate-800 px-6 py-4 bg-white dark:bg-surface-darker sticky top-0 z-50 shadow-sm">
        <div class="flex items-center gap-3">
            <div class="size-8 text-primary flex items-center justify-center bg-primary/10 rounded-lg"><span class="material-symbols-outlined text-[24px]">hotel_class</span></div>
            <h2 class="text-slate-900 dark:text-white text-xl font-bold leading-tight">SmartHotel</h2>
        </div>
        <div class="flex items-center gap-4">
            <a href="<%=request.getContextPath()%>/guest/profile.jsp" class="flex items-center gap-2 px-4 py-2 bg-slate-100 dark:bg-surface-dark text-slate-900 dark:text-slate-200 rounded-lg hover:bg-slate-200 transition-colors text-sm font-bold">
                <span class="material-symbols-outlined text-[20px]">arrow_back</span> Về Hồ Sơ
            </a>
        </div>
    </header>

    <main class="flex h-full grow flex-col px-4 md:px-10 lg:px-20 pb-20 pt-8">
        <div class="flex flex-col max-w-[1200px] w-full mx-auto flex-1 gap-8">
            
            <div class="flex flex-wrap justify-between items-end gap-4">
                <div class="flex flex-col gap-2">
                    <h1 class="text-slate-900 dark:text-white text-3xl md:text-4xl font-black leading-tight">Lịch sử giao dịch</h1>
                    <p class="text-slate-500 dark:text-slate-400 text-base font-normal">Xem lại các kỳ nghỉ và chi tiết thanh toán của bạn.</p>
                </div>
                <a href="<%=request.getContextPath()%>/rooms" class="inline-flex items-center justify-center rounded-lg bg-primary px-5 py-2.5 text-sm font-bold text-white shadow-sm hover:bg-blue-600 transition-colors">
                    <span class="material-symbols-outlined mr-2 text-[18px]">add_circle</span> Đặt Phòng Mới
                </a>
            </div>

            <div class="rounded-xl bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-800 overflow-hidden shadow-sm flex-1 flex flex-col">
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-slate-50 dark:bg-surface-darker border-b border-slate-200 dark:border-slate-800">
                                <th class="px-6 py-4 text-xs font-bold uppercase text-slate-500 dark:text-slate-400 tracking-wider">Mã Booking</th>
                                <th class="px-6 py-4 text-xs font-bold uppercase text-slate-500 dark:text-slate-400 tracking-wider">Phòng</th>
                                <th class="px-6 py-4 text-xs font-bold uppercase text-slate-500 dark:text-slate-400 tracking-wider">Check-in / Out</th>
                                <th class="px-6 py-4 text-xs font-bold uppercase text-slate-500 dark:text-slate-400 tracking-wider">Trạng Thái</th>
                                <th class="px-6 py-4 text-xs font-bold uppercase text-slate-500 dark:text-slate-400 tracking-wider text-right">Tổng Tiền</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                            <% if(hist != null && !hist.isEmpty()) { 
                                for (Booking h : hist) { 
                                    String status = h.getStatus() != null ? h.getStatus() : "Pending";
                                    boolean isDone = status.equalsIgnoreCase("Completed") || status.equalsIgnoreCase("Đã xong") || status.equalsIgnoreCase("Checked-out");
                                    
                                    String checkIn = h.getCheckInDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(h.getCheckInDate()) : "-";
                                    String checkOut = h.getCheckOutDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(h.getCheckOutDate()) : "-";
                                    String roomNum = h.getRoom() != null ? h.getRoom().getRoomNumber() : "-";
                                    String total = h.getTotalAmount() != null ? String.format("%,.0f", h.getTotalAmount()) + " đ" : "-";
                            %>
                            <tr class="group hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                                <td class="px-6 py-4 text-sm font-bold text-slate-900 dark:text-white whitespace-nowrap">#BK-<%= h.getBookingID() %></td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="p-2 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-500 dark:text-slate-400"><span class="material-symbols-outlined text-[18px]">bed</span></div>
                                        <p class="text-sm font-semibold text-slate-900 dark:text-white">P.<%= roomNum %></p>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-sm text-slate-600 dark:text-slate-300">
                                    <%= checkIn %> <span class="text-xs text-slate-400 mx-1">đến</span> <%= checkOut %>
                                </td>
                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold border <%= isDone ? "bg-emerald-accent/10 text-emerald-accent border-emerald-accent/20" : "bg-gold-accent/10 text-gold-accent border-gold-accent/20" %>">
                                        <%= status %>
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-primary/10 text-primary text-sm font-bold border border-primary/20">
                                        <%= total %>
                                    </span>
                                </td>
                            </tr>
                            <%  } 
                            } else { %>
                            <tr><td colspan="5" class="px-6 py-16 text-center text-slate-500 text-lg font-medium">Bạn chưa có giao dịch nào trong hệ thống.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</body>
</html>