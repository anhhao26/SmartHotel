<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%
    // Xác định role của người dùng: staff/admin được dùng đầy đủ chức năng quản lý phòng
    Object accObj = session.getAttribute("acc");
    boolean isStaffOrAdmin = false;
    if (accObj instanceof model.Account) {
        String role = ((model.Account) accObj).getRole();
        if (role != null) {
            role = role.trim().toUpperCase();
            isStaffOrAdmin = role.equals("ADMIN") || role.equals("MANAGER") || role.equals("SUPERADMIN")
                          || role.equals("RECEPTIONIST") || role.equals("STAFF");
        }
    }
    request.setAttribute("isAdminUser", isStaffOrAdmin);
%>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <title>SmartHotel Room Board - Luxury Management</title>

                    <!-- Premium Fonts -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&display=swap"
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
                                        }
                                    },
                                    fontFamily: {
                                        serif: ["Cormorant Garamond", "serif"],
                                        sans: ["Inter", "sans-serif"],
                                    }
                                },
                            },
                        }
                    </script>
                    <style>
                        .room-unit {
                            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                            background: #FFFFFF;
                            border: 1px solid rgba(184, 154, 108, 0.1);
                        }

                        .room-unit:hover {
                            transform: translateY(-8px);
                            border-color: #B89A6C;
                            box-shadow: 0 20px 40px -10px rgba(184, 154, 108, 0.15);
                        }

                        .status-dot {
                            width: 8px;
                            height: 8px;
                            border-radius: 50%;
                        }

                        .status-Available {
                            background: #10b981;
                            box-shadow: 0 0 10px rgba(16, 185, 129, 0.4);
                        }

                        .status-Occupied {
                            background: #ef4444;
                            box-shadow: 0 0 10px rgba(239, 68, 68, 0.4);
                        }

                        .status-Cleaning {
                            background: #f59e0b;
                            box-shadow: 0 0 10px rgba(245, 158, 11, 0.4);
                        }

                        .no-scrollbar::-webkit-scrollbar {
                            display: none;
                        }

                        .no-scrollbar {
                            -ms-overflow-style: none;
                            scrollbar-width: none;
                        }

                        .label-premium {
                            font-family: 'Inter', sans-serif;
                            font-size: 10px;
                            font-weight: 700;
                            text-transform: uppercase;
                            letter-spacing: 0.25em;
                            color: #70685F;
                            margin-bottom: 0.5rem;
                            display: block;
                            opacity: 0.8;
                        }
                    </style>
                </head>

                <body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-auto">

                    <c:set var="active" value="rooms" scope="request" />
                    <%@ include file="/common/neural_shell_top.jspf" %>

                        <!-- Room Board Content -->
                        <div class="space-y-10 animate-[fadeIn_0.5s_ease-out] w-full">

                            <!-- Header Section -->
                            <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                                <div>
                                    <div
                                        class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold tracking-widest uppercase mb-4">
                                        Hotel Inventory Management
                                    </div>
                                    <h2 class="text-6xl font-serif text-hotel-text tracking-tight">Quản Lý <br /><span
                                            class="text-hotel-gold italic">Phòng Nghỉ.</span></h2>
                                    <p class="text-hotel-muted text-lg font-serif italic mt-4">Điều phối trạng thái và
                                        cấu hình phòng thời gian thực.</p>
                                </div>
                                <c:if test="${isAdminUser}">
                                <div class="flex gap-4">
                                    <button onclick="openTailwindModal('addRoomModal')"
                                        class="px-8 py-4 rounded-sm bg-hotel-gold text-white font-bold text-sm tracking-widest uppercase hover:bg-hotel-text transition-all flex items-center gap-2">
                                        <span class="material-symbols-outlined text-sm">add_circle</span> THÊM PHÒNG MỚI
                                    </button>
                                    <button onclick="openTailwindModal('updatePriceModal')"
                                        class="px-8 py-4 rounded-sm bg-hotel-bone border border-hotel-gold/20 text-hotel-text font-bold text-sm tracking-widest uppercase hover:bg-hotel-gold/5 transition-all">ĐIỀU
                                        CHỈNH GIÁ CHUNG</button>
                                </div>
                                </c:if>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div
                                    class="p-6 rounded-sm bg-red-500/5 border border-red-500/20 text-red-600 font-bold text-sm uppercase tracking-widest italic">
                                    ${errorMessage}</div>
                            </c:if>
                            <c:if test="${not empty successMessage}">
                                <div
                                    class="p-6 rounded-sm bg-emerald-500/5 border border-emerald-500/20 text-emerald-600 font-bold text-sm uppercase tracking-widest italic">
                                    ${successMessage}</div>
                            </c:if>

                            <!-- Room Grid -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-8 pb-32">
                                <c:forEach items="${roomList}" var="room">
                                    <div class="room-unit rounded-sm p-8 flex flex-col h-full cursor-pointer relative overflow-hidden group active:scale-[0.98]"
                                        onclick="openManageModal('${room.roomNumber}', '${room.roomType.roomTypeId}', '${room.price}', '${room.primaryImageUrl}', this)">

                                        <div class="flex items-start justify-between mb-10 relative">
                                            <div>
                                                <h3
                                                    class="text-4xl font-serif font-bold text-hotel-text group-hover:text-hotel-gold transition-colors tracking-tight">
                                                    ${room.roomNumber}</h3>
                                                <p
                                                    class="text-sm font-bold text-hotel-muted uppercase tracking-widest mt-2">
                                                    ${room.roomType.typeName}</p>
                                            </div>
                                            <div class="flex flex-col items-end gap-3">
                                                <span class="status-dot status-${room.status}"></span>
                                                <span
                                                    class="text-xs font-bold text-hotel-muted/50 uppercase tracking-widest">${room.status
                                                    == 'Available' ? 'Còn Trống' : (room.status == 'Occupied' ? 'Đã
                                                    Nhận' : 'Dọn Phòng')}</span>
                                            </div>
                                        </div>

                                        <div class="flex-1 space-y-6 relative">
                                            <div
                                                class="flex justify-between items-center text-sm font-bold text-hotel-text uppercase tracking-widest bg-hotel-gold/5 p-2 rounded-sm border border-hotel-gold/10">
                                                <span class="flex items-center gap-1.5"><span
                                                        class="material-symbols-outlined text-[16px] text-hotel-gold">apartment</span>
                                                    Tầng ${room.floor}</span>
                                                <span class="flex items-center gap-1.5"><span
                                                        class="material-symbols-outlined text-[16px] text-hotel-gold">group</span>
                                                    ${room.roomType.maxCapacity} KHÁCH</span>
                                            </div>
                                            <div class="w-full h-[1px] bg-hotel-gold/10 rounded-full overflow-hidden">
                                                <div class="h-full bg-hotel-gold w-3/4 opacity-40"></div>
                                            </div>
                                        </div>

                                        <div class="mt-10 flex items-end justify-between relative">
                                            <div>
                                                <p
                                                    class="text-xs font-bold text-hotel-muted uppercase tracking-widest mb-1">
                                                    Giá chuẩn</p>
                                                <p class="text-xl font-bold text-hotel-text tracking-tight">
                                                    <fmt:formatNumber value="${room.price}" pattern="#,###" /> <span
                                                        class="text-sm text-hotel-muted ml-0.5 font-serif">đ</span>
                                                </p>
                                            </div>
                                            <button
                                                onclick="event.stopPropagation(); openStatusModal('${room.roomNumber}', '${room.status}')"
                                                class="w-12 h-16 rounded-sm bg-hotel-gold/5 border border-hotel-gold/10 flex items-center justify-center text-hotel-gold/40 hover:text-hotel-gold hover:border-hotel-gold hover:bg-hotel-gold/10 transition-all">
                                                <span
                                                    class="material-symbols-outlined text-xl">settings_input_component</span>
                                            </button>
                                        </div>

                                        <div class="room-images-data hidden">
                                            <c:forEach items="${room.images}" var="img">
                                                <span data-id="${img.imageId}" data-url="${img.imageUrl}"></span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Status Modal -->
                        <div id="statusModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-6"
                            x-cloak>
                            <div class="absolute inset-0 bg-hotel-text/60 backdrop-blur-md"
                                onclick="closeTailwindModal('statusModal')"></div>
                            <div
                                class="relative w-full max-w-lg bg-hotel-bone rounded-sm p-12 border border-hotel-gold/10 shadow-2xl">
                                <form action="${pageContext.request.contextPath}/RoomServlet" method="POST"
                                    class="space-y-10">
                                    <input type="hidden" name="action" value="changeStatus">
                                    <input type="hidden" name="roomId" id="modalRoomId">

                                    <div class="flex items-center gap-6">
                                        <div
                                            class="w-16 h-16 rounded-sm bg-hotel-gold/5 flex items-center justify-center text-hotel-gold border border-hotel-gold/20">
                                            <span
                                                class="material-symbols-outlined text-4xl">notification_important</span>
                                        </div>
                                        <div>
                                            <h3
                                                class="text-3xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                                                Trạng Thái</h3>
                                            <p
                                                class="text-sm text-hotel-gold font-bold tracking-widest uppercase opacity-60">
                                                Phòng <span id="displayRoomId"></span></p>
                                        </div>
                                    </div>

                                    <div class="space-y-8">
                                        <div class="space-y-1">
                                            <label class="label-premium">Trạng thái hiện tạ (Current Status)</label>
                                            <input type="text" id="modalCurrentStatus" readonly
                                                class="w-full bg-hotel-gold/5 border border-hotel-gold/10 rounded-xl px-8 py-5 font-bold text-hotel-muted/60 cursor-not-allowed text-base uppercase tracking-widest">
                                        </div>
                                        <div class="space-y-1">
                                            <label class="label-premium">Điều chuyển quy trình (*)</label>
                                            <div class="relative">
                                                <select name="newStatus" id="modalNewStatus"
                                                    class="w-full bg-white border border-hotel-gold/10 rounded-xl px-8 py-5 font-bold text-hotel-text focus:border-hotel-gold focus:ring-0 text-base uppercase tracking-widest appearance-none cursor-pointer">
                                                    <option value="Available">Hợp lệ (Available)</option>
                                                    <option value="Occupied">Đang ở (Occupied)</option>
                                                    <option value="Cleaning">Dọn dẹp (Cleaning)</option>
                                                    <option value="Maintenance">Bảo trì (Maintenance)</option>
                                                </select>
                                                <span class="material-symbols-outlined absolute right-6 top-1/2 -translate-y-1/2 text-hotel-gold/40 pointer-events-none">swap_vert</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flex gap-4 pt-4">
                                        <button type="button" onclick="closeTailwindModal('statusModal')"
                                            class="flex-1 py-5 rounded-sm text-hotel-muted font-bold text-sm tracking-widest uppercase hover:bg-hotel-gold/5 transition-all">Hủy
                                            bỏ</button>
                                        <button type="submit"
                                            class="flex-[2] py-5 rounded-sm bg-hotel-gold text-white font-bold text-sm tracking-widest uppercase hover:bg-hotel-text transition-all">Xác
                                            nhận đơn</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <%-- Các modal chỉ dành cho ADMIN --%>
                        <c:if test="${isAdminUser}">
                        <!-- Add Room Modal -->
                        <div id="addRoomModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-6" x-cloak>
                            <div class="absolute inset-0 bg-hotel-text/60 backdrop-blur-md" onclick="closeTailwindModal('addRoomModal')"></div>
                            <div class="relative w-full max-w-lg bg-hotel-bone rounded-sm p-12 border border-hotel-gold/10 shadow-2xl">
                                <form action="${pageContext.request.contextPath}/RoomServlet" method="POST" class="space-y-8">
                                    <input type="hidden" name="action" value="addRoom">
                                    <h3 class="text-3xl font-serif font-bold text-hotel-text tracking-tight uppercase">Thêm Phòng Mới</h3>
                                    
                                    <div class="space-y-6">
                                        <div class="grid grid-cols-2 gap-6">
                                            <div class="space-y-1">
                                                <label class="label-premium">Số Phòng (NodeID)</label>
                                                <input type="text" name="roomId" required class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-4 font-bold text-hotel-text text-[13px] tracking-widest">
                                            </div>
                                            <div class="space-y-1">
                                                <label class="label-premium">Tầng (Floor)</label>
                                                <input type="number" name="floor" required class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-4 font-bold text-hotel-text text-[13px]">
                                            </div>
                                        </div>
                                        <div class="space-y-1">
                                            <label class="label-premium">Hạng Phòng (Category)</label>
                                            <div class="relative">
                                                <select name="typeId" class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-4 font-bold text-hotel-text text-base uppercase tracking-widest appearance-none cursor-pointer">
                                                    <c:forEach items="${typeList}" var="type">
                                                        <option value="${type.roomTypeId}">${type.typeName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-hotel-gold/40 pointer-events-none">expand_more</span>
                                            </div>
                                        </div>
                                        <div class="space-y-1">
                                            <label class="label-premium">Giá Niêm Yết (Standard Rate)</label>
                                            <input type="number" name="price" required class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-4 font-serif font-bold text-hotel-text text-xl">
                                        </div>
                                    </div>

                                    <div class="flex gap-4 pt-4">
                                        <button type="button" onclick="closeTailwindModal('addRoomModal')" class="flex-1 py-4 text-hotel-muted font-bold text-sm tracking-widest uppercase hover:bg-hotel-gold/5 transition-all">Hủy</button>
                                        <button type="submit" class="flex-1 py-4 bg-hotel-gold text-white font-bold text-sm tracking-widest uppercase hover:bg-hotel-text transition-all">Tạo Phòng</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Update Price Modal -->
                        <div id="updatePriceModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-6" x-cloak>
                            <div class="absolute inset-0 bg-hotel-text/60 backdrop-blur-md" onclick="closeTailwindModal('updatePriceModal')"></div>
                            <div class="relative w-full max-w-lg bg-hotel-bone rounded-sm p-12 border border-hotel-gold/10 shadow-2xl">
                                <form action="${pageContext.request.contextPath}/RoomServlet" method="POST" class="space-y-8">
                                    <input type="hidden" name="action" value="updatePrice">
                                    <h3 class="text-3xl font-serif font-bold text-hotel-text tracking-tight uppercase">Điều Chỉnh Giá</h3>
                                    
                                    <div class="space-y-6">
                                        <div class="space-y-1">
                                            <label class="label-premium">Số Phòng Cần Cập Nhật</label>
                                            <input type="text" name="roomId" required placeholder="VD: 101" class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-4 font-bold text-hotel-text text-[13px] tracking-widest">
                                        </div>
                                        <div class="space-y-1">
                                            <label class="label-premium">Giá Mới (New Rate)</label>
                                            <input type="number" name="newPrice" required class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-4 font-serif font-bold text-hotel-text text-2xl">
                                        </div>
                                    </div>

                                    <div class="flex gap-4 pt-4">
                                        <button type="button" onclick="closeTailwindModal('updatePriceModal')" class="flex-1 py-4 text-hotel-muted font-bold text-sm tracking-widest uppercase hover:bg-hotel-gold/5 transition-all">Hủy</button>
                                        <button type="submit" class="flex-1 py-4 bg-hotel-gold text-white font-bold text-sm tracking-widest uppercase hover:bg-hotel-text transition-all">Cập Nhật</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        </c:if>

                        <!-- Management Modal -->
                        <div id="manageModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-6"
                            x-cloak>
                            <div class="absolute inset-0 bg-hotel-text/95 backdrop-blur-3xl"
                                onclick="closeTailwindModal('manageModal')"></div>
                            <div
                                class="relative w-full max-w-[1400px] h-[85vh] bg-hotel-bone rounded-sm flex flex-col md:flex-row overflow-hidden border border-hotel-gold/20 shadow-2xl">
                                <button onclick="closeTailwindModal('manageModal')"
                                    class="absolute top-10 right-10 z-[110] w-14 h-16 rounded-full bg-hotel-gold/10 text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all flex items-center justify-center border border-hotel-gold/20 group">
                                    <span
                                        class="material-symbols-outlined group-hover:rotate-90 transition-transform">close</span>
                                </button>

                                <!-- Attributes Panel -->
                                <div
                                    class="w-full md:w-[400px] p-16 border-r border-hotel-gold/10 flex flex-col bg-hotel-cream">
                                    <div class="mb-14">
                                        <h3
                                            class="text-5xl font-serif font-bold text-hotel-text tracking-tighter leading-tight uppercase">
                                            Phòng<br /><span id="displayManageRoomId" class="text-hotel-gold italic"></span>
                                        </h3>
                                        <p class="text-sm text-hotel-gold font-bold tracking-[0.4em] uppercase mt-4">
                                            Cấu hình Node</p>
                                    </div>

                                    <c:choose>
                                        <c:when test="${isAdminUser}">
                                            <%-- ADMIN: được phép chỉnh sửa loại phòng, giá và xóa phòng --%>
                                            <form action="${pageContext.request.contextPath}/RoomServlet" method="POST"
                                                class="space-y-10 flex-1">
                                                <input type="hidden" name="action" value="updateRoomInfo">
                                                <input type="hidden" name="roomId" id="manageRoomId">

                                                <div class="space-y-1">
                                                    <label class="label-premium">Phân loại hạng phòng</label>
                                                    <div class="relative">
                                                        <select name="typeId" id="manageTypeId"
                                                            class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-5 font-bold text-hotel-text text-base uppercase tracking-widest appearance-none cursor-pointer">
                                                            <c:forEach items="${typeList}" var="type">
                                                                <option value="${type.roomTypeId}">${type.typeName}</option>
                                                            </c:forEach>
                                                        </select>
                                                        <span class="material-symbols-outlined absolute right-6 top-1/2 -translate-y-1/2 text-hotel-gold/40 pointer-events-none">expand_more</span>
                                                    </div>
                                                </div>

                                                <div class="space-y-1">
                                                    <label class="label-premium">Giá Niêm Yết (VNĐ)</label>
                                                    <input type="number" name="price" id="managePrice"
                                                        class="w-full bg-white border border-hotel-gold/10 rounded-xl px-6 py-5 font-serif font-bold text-hotel-text text-3xl tracking-tight border-hotel-gold/20">
                                                </div>

                                                <button type="submit"
                                                    class="w-full py-6 rounded-sm bg-hotel-gold text-white font-bold text-sm tracking-[0.4em] uppercase hover:bg-hotel-text transition-all active:scale-95 shadow-xl">Áp dụng Thay đổi</button>
                                            </form>

                                            <div class="mt-14 pt-10 border-t border-hotel-gold/10">
                                                <form action="${pageContext.request.contextPath}/RoomServlet" method="POST"
                                                    onsubmit="return confirm('CẢNH BÁO: Xóa vĩnh viễn dữ liệu phòng này?');">
                                                    <input type="hidden" name="action" value="deleteRoom">
                                                    <input type="hidden" name="roomId" id="deleteRoomId">
                                                    <button type="submit"
                                                        class="w-full py-4 rounded-sm text-red-500 hover:text-white hover:bg-red-500 font-bold text-sm tracking-[0.2em] uppercase border border-red-500/20 transition-all flex items-center justify-center gap-3">
                                                        <span class="material-symbols-outlined text-sm">delete</span> Xóa Phòng
                                                    </button>
                                                </form>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- STAFF/RECEPTIONIST: chỉ xem thông tin phòng, không chỉnh sửa --%>
                                            <input type="hidden" id="manageRoomId">
                                            <input type="hidden" id="manageTypeId">
                                            <input type="hidden" id="managePrice">
                                            <input type="hidden" id="deleteRoomId">
                                            <div class="flex-1 flex flex-col items-center justify-center gap-4 text-center opacity-50">
                                                <span class="material-symbols-outlined text-4xl text-hotel-gold">lock</span>
                                                <p class="text-sm font-bold text-hotel-muted uppercase tracking-widest">Chỉ quản trị viên<br/>mới có thể chỉnh sửa</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Media/Gallery Panel -->
                                <div class="flex-1 p-20 flex flex-col bg-black/40 relative overflow-hidden">
                                    <div class="absolute inset-0 bg-primary/[0.02] pointer-events-none"></div>
                                    <div class="flex items-center justify-between mb-16 relative">
                                        <div>
                                            <h4 class="text-xs font-black text-white/30 uppercase tracking-[0.4em]">
                                                Asset
                                                Repository</h4>
                                            <p class="text-sm text-white/10 font-bold uppercase tracking-widest">
                                                Visual
                                                data stream for this node</p>
                                        </div>
                                        <button onclick="triggerUpload()"
                                            class="flex items-center gap-3 px-8 py-4 rounded-2xl bg-primary text-background-dark font-black text-sm tracking-[0.3em] uppercase hover:shadow-[0_0_25px_rgba(34,211,238,0.4)] transition-all">
                                            <span class="material-symbols-outlined text-sm">cloud_upload</span> Inject
                                            Media
                                        </button>
                                    </div>

                                    <div id="manageImageGallery"
                                        class="flex-1 grid grid-cols-2 lg:grid-cols-3 2xl:grid-cols-4 gap-10 overflow-y-auto no-scrollbar pr-4 pb-10">
                                        <!-- Dynamic Gallery Content -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Assets Utility -->
                        <form id="setPrimaryForm" action="${pageContext.request.contextPath}/RoomServlet" method="POST"
                            class="hidden">
                            <input type="hidden" name="action" value="setPrimaryImage">
                            <input type="hidden" name="roomId" id="primaryRoomId">
                            <input type="hidden" name="imageUrl" id="primaryImageUrl">
                        </form>
                        <form id="deleteImageForm" action="${pageContext.request.contextPath}/RoomServlet" method="POST"
                            class="hidden">
                            <input type="hidden" name="action" value="deleteImage">
                            <input type="hidden" name="imageId" id="deleteImageId">
                        </form>
                        <form id="uploadImageForm" action="${pageContext.request.contextPath}/RoomServlet" method="POST"
                            enctype="multipart/form-data" class="hidden">
                            <input type="hidden" name="action" value="uploadRoomImage">
                            <input type="hidden" name="roomId" id="uploadRoomId">
                            <input type="file" name="file" id="hiddenFileInput" accept="image/*"
                                onchange="submitImageUpload()">
                        </form>

                        <%@ include file="/common/neural_shell_bottom.jspf" %>

                            <script>
                                function openTailwindModal(id) { document.getElementById(id).classList.remove('hidden'); }
                                function closeTailwindModal(id) { document.getElementById(id).classList.add('hidden'); }

                                function openStatusModal(roomId, current) {
                                    document.getElementById('modalRoomId').value = roomId;
                                    document.getElementById('displayRoomId').innerText = roomId;
                                    document.getElementById('modalCurrentStatus').value = current;
                                    openTailwindModal('statusModal');
                                }

                                function openManageModal(roomId, typeId, price, primaryImg, element) {
                                    document.getElementById('manageRoomId').value = roomId;
                                    document.getElementById('displayManageRoomId').innerText = roomId;
                                    document.getElementById('manageTypeId').value = typeId;
                                    document.getElementById('managePrice').value = price;
                                    document.getElementById('deleteRoomId').value = roomId;
                                    document.getElementById('uploadRoomId').value = roomId;

                                    const gallery = document.getElementById('manageImageGallery');
                                    gallery.innerHTML = '';
                                    const images = element.querySelectorAll('.room-images-data span');

                                    if (images.length === 0) {
                                        gallery.innerHTML = '<div class="col-span-full py-40 flex flex-col items-center justify-center border-2 border-dashed border-white/5 rounded-[4rem] text-white/5 uppercase tracking-[0.5em] italic text-sm">Dữ liệu Asset rỗng</div>';
                                    } else {
                                        images.forEach(img => {
                                            const id = img.getAttribute('data-id');
                                            const rawUrl = img.getAttribute('data-url');
                                            const isPrimary = (primaryImg && rawUrl && primaryImg.replace(/^\//, '') === rawUrl.replace(/^\//, ''));
                                            const url = rawUrl.startsWith('http') ? rawUrl : '${pageContext.request.contextPath}/' + rawUrl;

                                            const card = document.createElement('div');
                                            card.className = 'relative group rounded-sm overflow-hidden aspect-[4/3] border ' + (isPrimary ? 'border-hotel-gold shadow-lg' : 'border-hotel-gold/10') + ' bg-white';

                                            let innerHtml = '<img src="' + url + '" class="w-full h-full object-cover group-hover:scale-105 transition-all duration-1000">';
                                            if (isPrimary) {
                                                innerHtml += '<span class="absolute top-4 left-4 bg-hotel-gold text-white font-bold tracking-widest uppercase text-[7px] px-3 py-1.5 rounded-sm">Ảnh Đại Diện</span>';
                                            }
                                            innerHtml += '<div class="absolute inset-0 bg-hotel-text/60 opacity-0 group-hover:opacity-100 transition-all duration-400 flex items-center justify-center gap-6 backdrop-blur-[2px]">';
                                            if (!isPrimary) {
                                                innerHtml += '<button onclick="setPrimaryImage(\'' + roomId + '\', \'' + rawUrl + '\')" class="w-12 h-16 rounded-full bg-hotel-gold text-white hover:scale-110 transition-all flex items-center justify-center shadow-lg"><span class="material-symbols-outlined text-lg">star</span></button>';
                                            }
                                            innerHtml += '<button onclick="deleteImage(\'' + id + '\')" class="w-12 h-16 rounded-full bg-white text-hotel-text hover:bg-red-500 hover:text-white hover:scale-110 transition-all flex items-center justify-center shadow-lg"><span class="material-symbols-outlined text-lg">delete</span></button>';
                                            innerHtml += '</div>';

                                            card.innerHTML = innerHtml;
                                            gallery.appendChild(card);
                                        });
                                    }
                                    openTailwindModal('manageModal');
                                }

                                function setPrimaryImage(rid, url) { document.getElementById('primaryRoomId').value = rid; document.getElementById('primaryImageUrl').value = url; document.getElementById('setPrimaryForm').submit(); }
                                function deleteImage(id) { if (confirm('Xác nhận xóa bỏ phương tiện này khỏi Node?')) { document.getElementById('deleteImageId').value = id; document.getElementById('deleteImageForm').submit(); } }
                                function triggerUpload() { document.getElementById('hiddenFileInput').click(); }
                                function submitImageUpload() { if (document.getElementById('hiddenFileInput').files.length > 0) document.getElementById('uploadImageForm').submit(); }
                            </script>
                </body>

                </html>