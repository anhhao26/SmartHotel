<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ page import="dao.BookingDAO" %>
<%@ page import="dao.InventoryDAO" %>
<%@ page import="dao.BookingDAO.BookingShort" %>
<%@ page import="model.Inventory" %>
                        <%@ page import="java.util.List" %>
                            <!DOCTYPE html>
                            <html lang="vi">

                            <head>
                                <meta charset="utf-8" />
                                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                                <title>SmartHotel Reception - Hệ Thống Quản Trị Trung Tâm</title>

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
                                    .no-scrollbar::-webkit-scrollbar {
                                        display: none;
                                    }

                                    .no-scrollbar {
                                        -ms-overflow-style: none;
                                        scrollbar-width: none;
                                    }

                                    .card-elegant {
                                        background: #FFFFFF;
                                        border: 1px solid rgba(184, 154, 108, 0.1);
                                        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.02);
                                    }

                                    .input-elegant {
                                        background: #FDFCFB;
                                        border: 1px solid rgba(184, 154, 108, 0.15);
                                        color: #2C2722;
                                        transition: all 0.3s;
                                    }

                                    .input-elegant:focus {
                                        border-color: #B89A6C;
                                        background: #FFFFFF;
                                        box-shadow: 0 0 0 4px rgba(184, 154, 108, 0.05);
                                        outline: none;
                                    }

                                    .btn-gold {
                                        background-color: #B89A6C;
                                        color: white;
                                        transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
                                    }

                                    .btn-gold:hover {
                                        background-color: #2C2722;
                                        transform: translateY(-2px);
                                        box-shadow: 0 10px 30px rgba(184, 154, 108, 0.2);
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
                                </style>
                            </head>

                            <body
                                class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">
                                <% BookingDAO bdao=new BookingDAO(); List<BookingShort> pending =
                                    bdao.findPendingBookings();
                                    List<BookingShort> checked = bdao.findCheckedInBookings();
                                        InventoryDAO invDao = new InventoryDAO();
                                        List<Inventory> invList = invDao.findAll();
                                            %>

                                            <jsp:include page="/common/neural_shell_top.jspf">
                                                <jsp:param name="active" value="reception" />
                                            </jsp:include>

                                            <!-- Checkout Console Content -->
                                            <div class="flex-1 h-screen overflow-y-auto pb-32">
                                                <div class="max-w-7xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">

                                                    <!-- Header Section -->
                                                    <div
                                                        class="flex flex-col md:flex-row md:items-end justify-between gap-6 py-12">
                                                        <div>
                                                            <div
                                                                class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-[9px] font-bold tracking-[0.3em] uppercase mb-4">
                                                                Quản Trị Lưu Trú Cao Cấp
                                                            </div>
                                                            <h2
                                                                class="text-6xl font-serif font-bold text-hotel-text tracking-tight leading-tight uppercase">
                                                                Nghiệp Vụ<br /><span class="text-hotel-gold italic">Lễ
                                                                    Tân.</span>
                                                            </h2>
                                                            <p
                                                                class="text-hotel-muted text-lg font-medium mt-4 italic uppercase tracking-widest opacity-60">
                                                                Quy trình Nhận khách & Kết toán hóa đơn tiêu chuẩn 5
                                                                sao.</p>
                                                        </div>
                                                    </div>

                                                    <div class="grid grid-cols-1 xl:grid-cols-2 gap-12">

                                                        <!-- Nhận Phòng Section -->
                                                        <section
                                                            class="card-elegant rounded-[3rem] overflow-hidden flex flex-col group">
                                                            <div
                                                                class="bg-hotel-bone border-b border-hotel-gold/10 p-10 flex items-center justify-between">
                                                                <div class="flex items-center gap-5">
                                                                    <div
                                                                        class="w-14 h-14 rounded-2xl bg-hotel-gold/10 text-hotel-gold flex items-center justify-center border border-hotel-gold/20 shadow-sm group-hover:rotate-6 transition-transform">
                                                                        <span
                                                                            class="material-symbols-outlined text-2xl">door_front</span>
                                                                    </div>
                                                                    <div>
                                                                        <h3
                                                                            class="text-2xl font-serif font-bold text-hotel-text uppercase tracking-tight">
                                                                            Quy Trình Nhận Phòng</h3>
                                                                        <p
                                                                            class="text-[9px] text-hotel-gold font-bold uppercase tracking-[0.3em] opacity-60">
                                                                            Danh sách chờ nhận phòng</p>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="p-10 space-y-10">
                                                            <div class="space-y-1">
                                                                <label class="label-premium ml-1">Khai thác danh sách đặt trước (*)</label>
                                                                <div class="relative">
                                                                    <select id="pendingSel" onchange="fillCheckin()"
                                                                        class="w-full h-18 px-8 rounded-xl input-elegant font-bold text-[11px] uppercase tracking-widest appearance-none cursor-pointer border-hotel-gold/10">
                                                                        <option disabled selected value="">-- LỰA CHỌN MÃ ĐẶT PHÒNG --</option>
                                                                            <% for (BookingShort b : pending) { String
                                                                                v=b.bookingID + "|" + b.roomID + "|" +
                                                                                b.customerName; %>
                                                                                <option value="<%=v%>">MÃ: BK#
                                                                                    <%=b.bookingID%> -
                                                                                        PHÒNG: <%=b.roomID%> [
                                                                                            <%=b.customerName%>]
                                                                                </option>
                                                                                <% } %>
                                                                        </select>
                                                                        <span
                                                                            class="material-symbols-outlined absolute right-5 top-1/2 -translate-y-1/2 text-hotel-gold pointer-events-none">expand_more</span>
                                                                    </div>
                                                                </div>

                                                                <form
                                                                    action="${pageContext.request.contextPath}/checkout"
                                                                    method="post" id="checkinForm" class="space-y-10">
                                                                    <input type="hidden" name="action" value="checkin"
                                                                        id="action_checkin_input">
                                                                    <input type="hidden" name="bid"
                                                                        id="bid_checkin_input">
                                                                    <input type="hidden" name="rid"
                                                                        id="rid_checkin_input">

                                                                    <div
                                                                        class="bg-hotel-bone rounded-[2rem] p-10 border border-hotel-gold/5 space-y-8 relative overflow-hidden">
                                                                        <div class="grid grid-cols-2 gap-10 relative">
                                                                            <div class="space-y-1">
                                                                                <span
                                                                                    class="text-[8px] font-bold text-hotel-muted uppercase tracking-[0.3em]">Mã
                                                                                    Đặt Phòng</span>
                                                                                <p id="bid_checkin_display"
                                                                                    class="text-2xl font-serif font-bold text-hotel-text tracking-widest italic">
                                                                                    --</p>
                                                                            </div>
                                                                            <div class="space-y-1">
                                                                                <span
                                                                                    class="text-[8px] font-bold text-hotel-muted uppercase tracking-[0.3em]">Số
                                                                                    Phòng</span>
                                                                                <p id="rid_checkin_display"
                                                                                    class="text-2xl font-serif font-bold text-hotel-gold tracking-widest">
                                                                                    --</p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="h-px bg-hotel-gold/10"></div>
                                                                        <div class="space-y-1 relative">
                                                                            <span
                                                                                class="text-[8px] font-bold text-hotel-muted uppercase tracking-[0.3em]">Họ
                                                                                Tên Khách Hàng</span>
                                                                            <p id="name_checkin_display"
                                                                                class="text-xl font-serif font-bold text-hotel-text uppercase italic tracking-tight italic">
                                                                                --</p>
                                                                        </div>
                                                                    </div>

                                                                    <div
                                                                        class="grid grid-cols-1 sm:grid-cols-2 gap-5 pt-4">
                                                                        <button type="button" id="btn_confirm"
                                                                            onclick="submitCheckinForm('confirm')"
                                                                            class="h-18 bg-white border border-accent-emerald/30 text-accent-emerald font-bold text-[10px] tracking-[0.2em] uppercase rounded-xl hover:bg-accent-emerald hover:text-white transition-all disabled:opacity-20 flex items-center justify-center gap-3 active:scale-95 shadow-sm"
                                                                            disabled>
                                                                            <span
                                                                                class="material-symbols-outlined text-lg">fact_check</span>
                                                                            XÁC NHẬN THÔNG TIN
                                                                        </button>
                                                                        <button type="button" id="btn_checkin"
                                                                            onclick="submitCheckinForm('checkin')"
                                                                            class="h-18 btn-gold font-bold text-[10px] tracking-[0.2em] uppercase rounded-xl disabled:opacity-20 flex items-center justify-center gap-3 active:scale-95 shadow-lg shadow-hotel-gold/10"
                                                                            disabled>
                                                                            <span
                                                                                class="material-symbols-outlined text-lg">vpn_key</span>
                                                                            HOÀN TẤT & GIAO KHÓA
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </section>

                                                        <!-- Trả Phòng Section -->
                                                        <section
                                                            class="card-elegant rounded-[3rem] overflow-hidden flex flex-col group">
                                                            <div
                                                                class="bg-hotel-bone border-b border-hotel-gold/10 p-10 flex items-center justify-between">
                                                                <div class="flex items-center gap-5">
                                                                    <div
                                                                        class="w-14 h-14 rounded-2xl bg-hotel-text/10 text-hotel-text flex items-center justify-center border border-hotel-gold/20 shadow-sm group-hover:rotate-6 transition-transform">
                                                                        <span
                                                                            class="material-symbols-outlined text-2xl">logout</span>
                                                                    </div>
                                                                    <div>
                                                                        <h3
                                                                            class="text-2xl font-serif font-bold text-hotel-text uppercase tracking-tight">
                                                                            Quy Trình Trả Phòng</h3>
                                                                        <p
                                                                            class="text-[9px] text-hotel-muted font-bold uppercase tracking-[0.3em] opacity-60">
                                                                            Kết toán & Chụp hóa đơn</p>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="p-10 space-y-10">
                                                            <div class="space-y-1">
                                                                <label class="label-premium ml-1">Truy vấn phòng đang lưu trú (*)</label>
                                                                <div class="relative">
                                                                    <select id="checkedSel"
                                                                        onchange="fillCheckout()"
                                                                        class="w-full h-18 px-8 rounded-xl input-elegant font-bold text-[11px] uppercase tracking-widest appearance-none cursor-pointer border-hotel-gold/10">
                                                                        <option disabled selected value="">-- CHỌN SỐ PHÒNG --</option>
                                                                            <% for (BookingShort b : checked) { String
                                                                                v=b.bookingID + "|" + b.roomID + "|" +
                                                                                b.customerID + "|" + b.customerName; %>
                                                                                <option value="<%=v%>">PHÒNG:
                                                                                    <%=b.roomID%>
                                                                                        [<%=b.customerName%>]</option>
                                                                                <% } %>
                                                                        </select>
                                                                        <span
                                                                            class="material-symbols-outlined absolute right-5 top-1/2 -translate-y-1/2 text-hotel-gold pointer-events-none">expand_more</span>
                                                                    </div>
                                                                </div>

                                                                <form
                                                                    action="${pageContext.request.contextPath}/checkout"
                                                                    method="post" class="space-y-8">
                                                                    <input type="hidden" name="action" value="checkout">
                                                                    <input type="hidden" name="bid"
                                                                        id="bid_checkout_input">
                                                                    <input type="hidden" name="rid"
                                                                        id="rid_checkout_input">
                                                                    <input type="hidden" name="cid"
                                                                        id="cid_checkout_input">

                                                                    <div
                                                                        class="bg-hotel-bone rounded-2xl p-6 border border-hotel-gold/5 flex items-center justify-between group/user relative overflow-hidden shadow-sm">
                                                                        <div class="flex items-center gap-5 relative">
                                                                            <div
                                                                                class="w-12 h-12 rounded-full bg-hotel-gold/10 flex items-center justify-center text-hotel-gold border border-hotel-gold/20">
                                                                                <span
                                                                                    class="material-symbols-outlined text-2xl">person</span>
                                                                            </div>
                                                                            <div>
                                                                                <p id="name_checkout_display"
                                                                                    class="text-lg font-serif font-bold text-hotel-text tracking-tight uppercase italic">
                                                                                    --</p>
                                                                                <p id="room_checkout_display"
                                                                                    class="text-[9px] text-hotel-gold font-bold uppercase tracking-[0.1em] mt-0.5">
                                                                                    Phòng: --</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="space-y-1">
                                                                        <label class="label-premium ml-1">Kết toán giá phòng (Standard Rate)</label>
                                                                        <input type="number" name="price"
                                                                            value="1000000" required
                                                                            class="w-full h-18 px-8 text-4xl font-serif font-bold text-hotel-text input-elegant rounded-xl tracking-tighter border-hotel-gold/10">
                                                                    </div>

                                                                    <div class="space-y-4">
                                                                        <div class="flex items-center justify-between">
                                                                            <h4
                                                                                class="text-[10px] font-bold text-hotel-gold uppercase tracking-[0.4em] flex items-center gap-2">
                                                                                <span
                                                                                    class="material-symbols-outlined text-hotel-gold text-lg">local_bar</span>
                                                                                Dịch Vụ Tiện Ích
                                                                            </h4>
                                                                        </div>
                                                                        <div
                                                                            class="border border-hotel-gold/10 rounded-xl overflow-hidden bg-white shadow-sm">
                                                                            <div
                                                                                class="max-h-[250px] overflow-y-auto no-scrollbar">
                                                                                <table class="w-full text-left">
                                                                                    <thead
                                                                                        class="bg-hotel-bone border-b border-hotel-gold/10 sticky top-0 z-10">
                                                                                        <tr
                                                                                            class="text-[8px] font-bold text-hotel-muted uppercase tracking-[0.4em]">
                                                                                            <th class="px-6 py-4">Chọn
                                                                                            </th>
                                                                                            <th class="px-6 py-4">Tên
                                                                                                Sản Phẩm
                                                                                            </th>
                                                                                            <th
                                                                                                class="px-6 py-4 text-center">
                                                                                                Đơn Giá</th>
                                                                                            <th
                                                                                                class="px-6 py-4 text-right">
                                                                                                Số Lượng</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody
                                                                                        class="divide-y divide-hotel-gold/5">
                                                                                        <% for (Inventory it : invList)
                                                                                            { %>
                                                                                            <tr
                                                                                                class="hover:bg-hotel-gold/[0.02] transition-colors group/row">
                                                                                                <td class="px-6 py-4">
                                                                                                    <input
                                                                                                        type="checkbox"
                                                                                                        name="itemId"
                                                                                                        value="<%= it.getItemID() %>"
                                                                                                        class="w-5 h-5 rounded border-hotel-gold/20 text-hotel-gold focus:ring-hotel-gold/40 cursor-pointer">
                                                                                                </td>
                                                                                                <td
                                                                                                    class="px-6 py-4 text-[11px] font-bold text-hotel-text group-hover/row:text-hotel-gold transition-colors uppercase tracking-widest">
                                                                                                    <%= it.getItemName()
                                                                                                        %>
                                                                                                </td>
                                                                                                <td
                                                                                                    class="px-6 py-4 text-[10px] text-hotel-muted text-center font-bold">
                                                                                                    <%= String.format("%,.0f",
                                                                                                        it.getSellingPrice())
                                                                                                        %>đ
                                                                                                </td>
                                                                                                <td
                                                                                                    class="px-6 py-4 text-right">
                                                                                                    <input type="number"
                                                                                                        name="qty_<%=it.getItemID()%>"
                                                                                                        value="1"
                                                                                                        min="1"
                                                                                                        class="w-14 h-8 bg-hotel-bone border border-hotel-gold/10 rounded-lg text-center font-bold text-[10px] text-hotel-text focus:border-hotel-gold outline-none">
                                                                                                </td>
                                                                                            </tr>
                                                                                            <% } %>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <button type="submit" id="btn_checkout"
                                                                        class="w-full h-20 btn-gold font-bold text-[10px] tracking-[0.3em] uppercase rounded-xl shadow-lg shadow-hotel-gold/10 hover:bg-hotel-text transition-all disabled:opacity-20 flex items-center justify-center gap-4 active:scale-95"
                                                                        disabled>
                                                                        <span
                                                                            class="material-symbols-outlined text-2xl">payments</span>
                                                                        XUẤT HÓA ĐƠN & TRẢ PHÒNG
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </section>
                                                    </div>
                                                </div>
                                            </div>

                                            <script>
                                                function fillCheckin() {
                                                    var v = document.getElementById('pendingSel').value;
                                                    var btn = document.getElementById('btn_checkin');
                                                    if (!v) {
                                                        document.getElementById('bid_checkin_display').innerText = "--";
                                                        document.getElementById('rid_checkin_display').innerText = "--";
                                                        document.getElementById('name_checkin_display').innerText = "--";
                                                        btn.disabled = true;
                                                        if (document.getElementById('btn_confirm')) document.getElementById('btn_confirm').disabled = true;
                                                        return;
                                                    }
                                                    var p = v.split('|');
                                                    document.getElementById('bid_checkin_input').value = p[0];
                                                    document.getElementById('rid_checkin_input').value = p[1];
                                                    document.getElementById('bid_checkin_display').innerText = "BK#" + p[0];
                                                    document.getElementById('rid_checkin_display').innerText = "PHÒNG " + p[1];
                                                    document.getElementById('name_checkin_display').innerText = p[2];
                                                    btn.disabled = false;
                                                    if (document.getElementById('btn_confirm')) document.getElementById('btn_confirm').disabled = false;
                                                }

                                                function submitCheckinForm(act) {
                                                    document.getElementById('action_checkin_input').value = act;
                                                    document.getElementById('checkinForm').submit();
                                                }

                                                function fillCheckout() {
                                                    var v = document.getElementById('checkedSel').value;
                                                    var btn = document.getElementById('btn_checkout');
                                                    if (!v) {
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
                                            <jsp:include page="/common/neural_shell_bottom.jspf" />
                            </body>

                            </html>