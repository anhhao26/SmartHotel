<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Quản Lý Đặt Phòng | SmartHotel</title>

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
            transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">
    <jsp:include page="/common/neural_shell_top.jspf">
        <jsp:param name="active" value="bookings" />
    </jsp:include>
    
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-7xl mx-auto px-12 py-12 animate-[fadeIn_0.8s_ease-out]">
            <!-- Header section -->
            <div class="flex justify-between items-end mb-12">
                <div>
                    <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase leading-tight">
                        Toàn Bộ <span class="text-hotel-gold italic">Thông Báo & Đặt Phòng.</span>
                    </h2>
                    <p class="text-hotel-muted text-lg font-medium italic mt-2 tracking-wide opacity-80">Theo dõi dòng thời gian booking và trạng thái thanh toán.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin" class="px-8 py-4 rounded-xl border border-hotel-gold/20 text-hotel-gold text-sm font-bold uppercase tracking-[0.2em] hover:bg-hotel-gold hover:text-white transition-all">
                    Quay lại Dashboard
                </a>
            </div>

            <!-- Bookings Table -->
            <div class="card-elegant rounded-[2.5rem] overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead class="bg-hotel-bone border-b border-hotel-gold/10">
                            <tr>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Mã</th>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">HÀNH ĐỘNG</th>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Trạng Thái</th>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Khách Hàng</th>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Phòng / Loại</th>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Thời Gian</th>
                                <th class="px-4 py-6 text-sm font-bold text-hotel-gold uppercase tracking-[0.2em]">Tiền</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-hotel-gold/5 italic">
                            <c:forEach var="b" items="${bookings}">
                                <c:set var="valStatus" value="${not empty b.status ? b.status : 'PENDING'}" />
                                <c:set var="statusUpper" value="${fn:toUpperCase(valStatus)}" />
                                <tr class="hover:bg-hotel-cream/40 transition-colors">
                                    <td class="px-4 py-6">
                                        <span class="text-base font-bold text-hotel-text tracking-widest">#${b.bookingID}</span>
                                    </td>
                                    
                                    <!-- HÀNH ĐỘNG COLUMN (Moved to 2nd position) -->
                                    <td class="px-4 py-6">
                                        <div class="flex items-center gap-2">
                                            <!-- 1. Edit/Detail (Amber) -->

                                            <!-- 2. Status Action -->
                                            <c:choose>
                                                <c:when test="${statusUpper == 'PENDING'}">
                                                    <button onclick="submitBookingAction(${b.bookingID}, 'confirm')" 
                                                            class="w-11 h-11 rounded-xl bg-emerald-50 border border-emerald-100 flex items-center justify-center text-emerald-600 hover:bg-emerald-600 hover:text-white transition-all shadow-sm" 
                                                            title="Xác nhận">
                                                        <span class="material-symbols-outlined text-xl">shopping_cart_checkout</span>
                                                    </button>
                                                </c:when>
                                                <c:when test="${statusUpper == 'CONFIRMED' || statusUpper == 'SUCCESS'}">
                                                    <button onclick="submitBookingAction(${b.bookingID}, 'checkin')" 
                                                            class="w-11 h-11 rounded-xl bg-hotel-gold/10 border border-hotel-gold/20 flex items-center justify-center text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all shadow-sm" 
                                                            title="Check-in">
                                                        <span class="material-symbols-outlined text-xl">login</span>
                                                    </button>
                                                </c:when>
                                                <c:when test="${statusUpper == 'CHECKED-IN'}">
                                                    <button onclick="submitBookingAction(${b.bookingID}, 'checkout')" 
                                                            class="w-11 h-11 rounded-xl bg-hotel-text/10 border border-hotel-text/20 flex items-center justify-center text-hotel-text hover:bg-hotel-text hover:text-white transition-all shadow-sm" 
                                                            title="Check-out">
                                                        <span class="material-symbols-outlined text-xl">logout</span>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-11 h-11 rounded-xl bg-slate-50 border border-slate-100 flex items-center justify-center text-slate-300">
                                                        <span class="material-symbols-outlined text-xl">info</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- 2. Edit (Gold) -->
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/admin/bookings?action=edit&id=${b.bookingID}'" 
                                                    class="w-11 h-11 rounded-xl bg-hotel-gold/10 border border-hotel-gold/20 flex items-center justify-center text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all shadow-sm" 
                                                    title="Sửa">
                                                <span class="material-symbols-outlined text-xl">edit</span>
                                            </button>

                                            <!-- 3. View (Gray) -->
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/invoice?bookingId=${b.bookingID}'" 
                                                    class="w-11 h-11 rounded-xl bg-slate-50 border border-slate-100 flex items-center justify-center text-slate-500 hover:bg-slate-500 hover:text-white transition-all shadow-sm" 
                                                    title="Xem">
                                                <span class="material-symbols-outlined text-xl">visibility</span>
                                            </button>

                                            <!-- 4. Cancel (Red) -->
                                            <c:choose>
                                                <c:when test="${statusUpper != 'CANCELLED' && statusUpper != 'CANCEL' && statusUpper != 'COMPLETED'}">
                                                    <button onclick="submitBookingAction(${b.bookingID}, 'cancel')" 
                                                            class="w-11 h-11 rounded-xl bg-rose-50 border border-rose-100 flex items-center justify-center text-rose-600 hover:bg-rose-600 hover:text-white transition-all shadow-sm" 
                                                            title="Huỷ">
                                                        <span class="material-symbols-outlined text-xl">delete</span>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-11 h-11 rounded-xl bg-slate-50 border border-slate-100 flex items-center justify-center text-slate-300">
                                                        <span class="material-symbols-outlined text-xl">delete_forever</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>

                                    <td class="px-4 py-6">
                                        <c:choose>
                                            <c:when test="${statusUpper == 'CONFIRMED' || statusUpper == 'SUCCESS'}">
                                                <span class="px-3 py-1 rounded-full bg-emerald-50 text-emerald-600 text-sm font-bold uppercase tracking-widest border border-emerald-100">Confirmed</span>
                                            </c:when>
                                            <c:when test="${statusUpper == 'PENDING'}">
                                                <span class="px-3 py-1 rounded-full bg-orange-50 text-orange-500 text-sm font-bold uppercase tracking-widest border border-orange-100">Pending</span>
                                            </c:when>
                                            <c:when test="${statusUpper == 'CHECKED-IN'}">
                                                <span class="px-3 py-1 rounded-full bg-blue-50 text-blue-500 text-sm font-bold uppercase tracking-widest border border-blue-100">In House</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 rounded-full bg-hotel-gold/10 text-hotel-gold text-sm font-bold uppercase tracking-widest">${b.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="px-4 py-6">
                                        <p class="text-base font-bold text-hotel-text uppercase tracking-wider">${b.customer.fullName}</p>
                                        <p class="text-sm text-hotel-muted">${b.customer.email}</p>
                                    </td>

                                    <td class="px-4 py-6">
                                        <p class="text-base font-bold text-hotel-text">P.${b.room.roomNumber}</p>
                                        <p class="text-sm text-hotel-gold font-bold uppercase tracking-widest">${fn:substring(b.room.roomType.typeName, 0, 15)}</p>
                                    </td>

                                    <td class="px-4 py-6">
                                        <div class="text-sm font-bold text-hotel-muted">
                                            <fmt:formatDate value="${b.checkInDate}" pattern="dd/MM"/> - <fmt:formatDate value="${b.checkOutDate}" pattern="dd/MM"/>
                                        </div>
                                    </td>

                                    <td class="px-4 py-6">
                                        <p class="text-base font-bold text-hotel-text">
                                            <fmt:formatNumber value="${b.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty bookings}">
                                <tr>
                                    <td colspan="7" class="px-10 py-24 text-center">
                                        <span class="material-symbols-outlined text-6xl text-hotel-gold/20 mb-4 block">receipt_long</span>
                                        <p class="text-hotel-muted text-sm font-bold uppercase tracking-[0.4em]">Không tìm thấy dữ liệu đặt phòng</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
    
    <!-- Hidden form for actions -->
    <form id="actionForm" method="POST" action="${pageContext.request.contextPath}/admin/bookings" class="hidden">
        <input type="hidden" name="bookingId" id="actionBookingId">
        <input type="hidden" name="action" id="actionType">
    </form>

    <script>
        function submitBookingAction(id, type) {
            const confirmMsg = {
                'confirm': 'Xác nhận thanh toán cho đơn đặt phòng này?',
                'cancel': 'Bạn có chắc chắn muốn huỷ đơn đặt phòng này?',
                'checkin': 'Tiến hành Check-in cho khách?',
                'checkout': 'Tiến hành Check-out và trả phòng?'
            };
            
            if (confirm(confirmMsg[type] || 'Xác nhận thực hiện thao tác này?')) {
                document.getElementById('actionBookingId').value = id;
                document.getElementById('actionType').value = type;
                document.getElementById('actionForm').submit();
            }
        }

        // Handle URL messages
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const msg = urlParams.get('msg');
            const err = urlParams.get('err');
            
            const messages = {
                'CheckinSuccess': 'Nhận phòng (Check-in) thành công!',
                'CheckoutSuccess': 'Trả phòng (Check-out) thành công!',
                'ConfirmSuccess': 'Xác nhận đặt phòng thành công!',
                'CancelSuccess': 'Huỷ đặt phòng thành công!',
                'UpdateSuccess': 'Cập nhật thông tin thành công!',
                'ActionSuccess': 'Thao tác thành công!'
            };
            
            const errors = {
                'CheckinFailed': 'Lỗi khi thực hiện Check-in.',
                'CheckoutFailed': 'Lỗi khi thực hiện Check-out.',
                'ConfirmFailed': 'Lỗi khi xác nhận đặt phòng.',
                'CancelFailed': 'Lỗi khi huỷ đặt phòng.',
                'UpdateFailed': 'Lỗi khi cập nhật thông tin.',
                'ActionFailed': 'Thao tác thất bại!'
            };

            if (msg && window.showToast) {
                showToast(messages[msg] || 'Thao tác thành công', 'success');
            } else if (err && window.showToast) {
                showToast(errors[err] || 'Thao tác thất bại', 'error');
            }
        };
    </script>
</body>
</html>
