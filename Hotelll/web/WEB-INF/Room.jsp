<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel Interactive Room Board</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              "primary": "#1069f9", "background-light": "#f5f7f8", "background-dark": "#0f1723",
              "status-available": "#10b981", "status-occupied": "#ef4444", "status-cleaning": "#f59e0b", "status-maintenance": "#6b7280",
            },
            fontFamily: { "display": ["Manrope"] }
          },
        },
      }
    </script>
    <style>
        .room-card:hover .action-overlay { opacity: 1; }
        .room-card:hover { transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-background-light font-display antialiased min-h-screen flex flex-col">
    
    <header class="sticky top-0 z-40 w-full border-b border-slate-200 bg-white/80 px-6 py-3 backdrop-blur-md">
        <div class="mx-auto flex max-w-[1440px] items-center justify-between">
            <div class="flex items-center gap-3 text-slate-900">
                <div class="flex size-8 items-center justify-center rounded-lg bg-primary text-white shadow-lg shadow-primary/30">
                    <span class="material-symbols-outlined text-[20px]">domain</span>
                </div>
                <h2 class="text-xl font-bold leading-tight tracking-tight">SmartHotel Room Board</h2>
            </div>
            <nav class="flex items-center gap-6">
                <a class="text-slate-500 hover:text-primary transition-colors text-sm font-semibold" href="<%=request.getContextPath()%>/admin">⬅ Quay Lại Dashboard</a>
            </nav>
        </div>
    </header>

    <main class="flex-1 px-6 py-8">
        <div class="mx-auto max-w-[1440px]">
            <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
                <div>
                    <h1 class="text-4xl font-extrabold text-slate-900 tracking-tight">Room Board</h1>
                    <p class="mt-2 text-slate-500">Giám sát trạng thái phòng trực tiếp theo thời gian thực.</p>
                </div>
                <div class="flex gap-2">
                    <button onclick="openTailwindModal('addRoomModal')" class="inline-flex h-10 items-center justify-center gap-2 rounded-lg bg-primary px-6 text-sm font-bold text-white shadow-lg transition-transform active:scale-95 hover:bg-primary/90">
                        <span class="material-symbols-outlined text-[20px]">add</span> <span>Thêm Phòng</span>
                    </button>
                    <button onclick="openTailwindModal('updatePriceModal')" class="inline-flex h-10 items-center justify-center gap-2 rounded-lg bg-amber-500 px-6 text-sm font-bold text-white shadow-lg transition-transform active:scale-95 hover:bg-amber-600">
                        <span class="material-symbols-outlined text-[20px]">payments</span> <span>Chỉnh Giá</span>
                    </button>
                </div>
            </div>

            <c:if test="${param.success == 'true'}">
                <div class="mb-6 p-5 rounded-2xl bg-emerald-50 border border-emerald-200 flex items-center gap-4 shadow-sm animate-pulse">
                    <div class="flex-shrink-0 w-12 h-12 rounded-full bg-emerald-500 flex items-center justify-center text-white">
                        <span class="material-symbols-outlined text-3xl">check_circle</span>
                    </div>
                    <div>
                        <h4 class="text-emerald-700 font-extrabold text-lg">Đặt phòng và Thanh toán thành công!</h4>
                        <p class="text-emerald-600/80 text-sm font-semibold mt-0.5">Cảm ơn bạn đã lựa chọn SmartHotel. Hóa đơn chi tiết đã được gửi đến email của bạn.</p>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}"><div class="mb-4 p-4 rounded-lg bg-red-100 text-red-700 font-bold border border-red-200">${errorMessage}</div></c:if>
            <c:if test="${not empty successMessage}"><div class="mb-4 p-4 rounded-lg bg-green-100 text-green-700 font-bold border border-green-200">${successMessage}</div></c:if>

            <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4 xl:grid-cols-5">
                <c:forEach items="${roomList}" var="room">
                    
                    <c:set var="statusColor" value="" />
                    <c:set var="statusIcon" value="" />
                    <c:set var="bgHeader" value="" />
                    
                    <c:choose>
                        <c:when test="${room.status == 'Available'}">
                            <c:set var="statusColor" value="emerald" /> <c:set var="statusIcon" value="check_circle" /> <c:set var="bgHeader" value="bg-emerald-500 text-white" />
                        </c:when>
                        <c:when test="${room.status == 'Occupied'}">
                            <c:set var="statusColor" value="red" /> <c:set var="statusIcon" value="lock" /> <c:set var="bgHeader" value="bg-red-500 text-white" />
                        </c:when>
                        <c:when test="${room.status == 'Cleaning'}">
                            <c:set var="statusColor" value="amber" /> <c:set var="statusIcon" value="cleaning_services" /> <c:set var="bgHeader" value="bg-amber-500 text-white" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="statusColor" value="slate" /> <c:set var="statusIcon" value="build" /> <c:set var="bgHeader" value="bg-slate-500 text-white" />
                        </c:otherwise>
                    </c:choose>

                    <div class="room-card group relative flex flex-col overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm transition-all duration-300">
                        
                        <c:set var="bgImage" value="${room.primaryImageUrl}" />
                        <c:if test="${empty bgImage}"><c:set var="bgImage" value="https://via.placeholder.com/400x300?text=No+Photo" /></c:if>
                        <c:if test="${not fn:startsWith(bgImage, 'http')}">
                            <c:set var="bgImage" value="${pageContext.request.contextPath}/${bgImage}" />
                        </c:if>
                        
                        <div class="h-32 w-full bg-cover bg-center relative" style="background-image: url('${bgImage}');">
                            <div class="absolute inset-0 bg-gradient-to-b from-slate-900/60 to-transparent"></div>
                            <div class="absolute top-2 left-2 flex items-center gap-1 px-2 py-1 rounded shadow-md text-[10px] font-bold uppercase tracking-wider ${bgHeader}">
                                <span class="material-symbols-outlined text-[14px]">${statusIcon}</span> ${room.status}
                            </div>
                        </div>

                        <div class="p-4 flex-1 flex flex-col relative z-10">
                            <div class="flex items-start justify-between mb-1">
                                <h3 class="text-3xl font-black text-slate-900">${room.roomNumber}</h3>
                                <span class="rounded bg-slate-100 px-2 py-1 text-xs font-bold text-slate-600 border border-slate-200">${room.roomType.typeName}</span>
                            </div>
                            <div class="mt-auto space-y-1 pt-2 border-t border-slate-100 flex justify-between items-end">
                                <p class="text-xs font-medium text-slate-500">Tầng ${room.floor}</p>
                                <p class="text-lg font-bold text-primary"><fmt:formatNumber value="${room.price}" pattern="#,###"/> đ<span class="text-[10px] font-normal text-slate-400">/đêm</span></p>
                            </div>
                        </div>
                        
                        <div class="action-overlay absolute inset-0 flex flex-col items-center justify-center gap-3 bg-slate-900/70 opacity-0 transition-opacity duration-200 backdrop-blur-[2px] z-20">
                            <button type="button" onclick="openStatusModal('${room.roomNumber}', '${room.status}')" class="flex w-3/4 items-center justify-center gap-2 rounded-lg bg-white px-4 py-2 text-sm font-bold text-slate-900 shadow-xl transition-transform hover:scale-105">
                                <span class="material-symbols-outlined text-[18px]">edit</span> Đổi Trạng Thái
                            </button>
                            
                            <button type="button" onclick="openManageModal('${room.roomNumber}', '${room.roomType.roomTypeId}', '<fmt:formatNumber value="${room.price}" pattern="0" groupingUsed="false"/>', '${room.primaryImageUrl}', this)" class="flex w-3/4 items-center justify-center gap-2 rounded-lg bg-primary px-4 py-2 text-sm font-bold text-white shadow-xl transition-transform hover:scale-105">
                                <span class="material-symbols-outlined text-[18px]">settings</span> Quản Lý Phòng
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
    </main>

    <div id="statusModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm">
        <div class="bg-white rounded-xl shadow-2xl w-full max-w-md overflow-hidden transform transition-all">
            <form action="<%=request.getContextPath()%>/RoomServlet" method="POST">
                <input type="hidden" name="action" value="changeStatus">
                <input type="hidden" name="roomId" id="modalRoomId">
                <div class="px-6 py-4 border-b border-slate-200 bg-primary text-white flex justify-between items-center">
                    <h3 class="font-bold text-lg">Cập nhật Trạng thái <span id="displayRoomId"></span></h3>
                </div>
                <div class="p-6 space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Trạng thái hiện tại</label>
                        <input type="text" class="w-full rounded-lg border-slate-300 bg-slate-100 text-slate-500 font-bold" id="modalCurrentStatus" readonly>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Chuyển sang</label>
                        <select class="w-full rounded-lg border-primary focus:ring-primary focus:border-primary text-slate-900 font-bold" name="newStatus" id="modalNewStatus" required>
                            <option value="Available">Trống (Available)</option>
                            <option value="Occupied">Đang ở (Occupied)</option>
                            <option value="Cleaning">Đang dọn (Cleaning)</option>
                            <option value="Maintenance">Bảo trì (Maintenance)</option>
                        </select>
                    </div>
                </div>
                <div class="px-6 py-4 bg-slate-50 border-t border-slate-200 flex justify-end gap-3">
                    <button type="button" onclick="closeTailwindModal('statusModal')" class="px-4 py-2 text-slate-600 hover:bg-slate-200 rounded-lg font-medium">Hủy</button>
                    <button type="submit" class="px-4 py-2 bg-primary text-white font-bold rounded-lg hover:bg-blue-600">Lưu Thay Đổi</button>
                </div>
            </form>
        </div>
    </div>

    <div id="addRoomModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm">
        <div class="bg-white rounded-xl shadow-2xl w-full max-w-md overflow-hidden">
            <form action="<%=request.getContextPath()%>/RoomServlet" method="POST">
                <input type="hidden" name="action" value="addRoom">
                <div class="px-6 py-4 border-b border-slate-200 bg-emerald-500 text-white"><h3 class="font-bold text-lg">Tạo Phòng Mới</h3></div>
                <div class="p-6 space-y-4">
                    <div><label class="block text-sm font-medium text-slate-700 mb-1">Số Phòng</label><input type="text" name="roomId" required class="w-full rounded-lg border-slate-300"></div>
                    <div><label class="block text-sm font-medium text-slate-700 mb-1">Tầng</label><input type="number" name="floor" required class="w-full rounded-lg border-slate-300"></div>
                    <div><label class="block text-sm font-medium text-slate-700 mb-1">Loại Phòng</label>
                        <select name="typeId" class="w-full rounded-lg border-slate-300" required>
                            <c:forEach items="${typeList}" var="type"><option value="${type.roomTypeId}">${type.typeName}</option></c:forEach>
                        </select>
                    </div>
                    <div><label class="block text-sm font-medium text-slate-700 mb-1">Giá Phòng (VNĐ)</label><input type="number" name="price" step="1000" required class="w-full rounded-lg border-slate-300 text-emerald-600 font-bold"></div>
                </div>
                <div class="px-6 py-4 bg-slate-50 border-t border-slate-200 flex justify-end gap-3">
                    <button type="button" onclick="closeTailwindModal('addRoomModal')" class="px-4 py-2 text-slate-600 hover:bg-slate-200 rounded-lg">Hủy</button>
                    <button type="submit" class="px-4 py-2 bg-emerald-500 text-white font-bold rounded-lg hover:bg-emerald-600">Thêm</button>
                </div>
            </form>
        </div>
    </div>

    <div id="updatePriceModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm">
        <div class="bg-white rounded-xl shadow-2xl w-full max-w-md overflow-hidden">
            <form action="<%=request.getContextPath()%>/RoomServlet" method="POST">
                <input type="hidden" name="action" value="updatePrice">
                <div class="px-6 py-4 border-b border-slate-200 bg-amber-500 text-white"><h3 class="font-bold text-lg">Cập Nhật Giá</h3></div>
                <div class="p-6 space-y-4">
                    <div><label class="block text-sm font-medium text-slate-700 mb-1">Chọn phòng cần chỉnh</label>
                        <select name="roomId" class="w-full rounded-lg border-slate-300" required>
                            <c:forEach items="${roomList}" var="r"><option value="${r.roomNumber}">Phòng ${r.roomNumber} - ${r.roomType.typeName} (Cũ: <fmt:formatNumber value="${r.price}" pattern="#,###"/> đ)</option></c:forEach>
                        </select>
                    </div>
                    <div><label class="block text-sm font-medium text-slate-700 mb-1">Mức giá mới (VNĐ)</label><input type="number" name="newPrice" step="1000" required class="w-full rounded-lg border-amber-500 text-amber-600 font-bold"></div>
                </div>
                <div class="px-6 py-4 bg-slate-50 border-t border-slate-200 flex justify-end gap-3">
                    <button type="button" onclick="closeTailwindModal('updatePriceModal')" class="px-4 py-2 text-slate-600 hover:bg-slate-200 rounded-lg">Hủy</button>
                    <button type="submit" class="px-4 py-2 bg-amber-500 text-white font-bold rounded-lg hover:bg-amber-600">Lưu giá</button>
                </div>
            </form>
        </div>
    </div>

    <div id="manageModal" class="hidden fixed inset-0 z-[60] flex items-center justify-center bg-slate-900/60 backdrop-blur-sm p-4">
        <div class="bg-white rounded-xl shadow-2xl w-full max-w-4xl max-h-[90vh] flex flex-col md:flex-row overflow-hidden relative">
            <button type="button" onclick="closeTailwindModal('manageModal')" class="absolute top-4 right-4 text-slate-400 hover:text-slate-900 z-50"><span class="material-symbols-outlined">close</span></button>
            
            <div class="w-full md:w-1/3 bg-slate-50 p-6 border-b md:border-b-0 md:border-r border-slate-200 overflow-y-auto no-scrollbar">
                <h3 class="font-bold text-xl mb-4 text-slate-900">Phòng <span id="displayManageRoomId" class="text-primary"></span></h3>
                <form action="<%=request.getContextPath()%>/RoomServlet" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="updateRoomInfo">
                    <input type="hidden" name="roomId" id="manageRoomId">
                    <div>
                        <label class="block text-sm font-bold text-slate-500 mb-1">Hạng phòng</label>
                        <select name="typeId" id="manageTypeId" class="w-full rounded-lg border-slate-300">
                            <c:forEach items="${typeList}" var="type"><option value="${type.roomTypeId}">${type.typeName}</option></c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-slate-500 mb-1">Giá tùy chỉnh (VNĐ)</label>
                        <input type="number" name="price" id="managePrice" class="w-full rounded-lg border-slate-300 text-primary font-bold">
                    </div>
                    <button type="submit" class="w-full py-2 bg-primary text-white font-bold rounded-lg hover:bg-blue-600 transition-colors">Lưu Thông Tin</button>
                </form>

                <hr class="my-6 border-slate-200">
                
                <form action="<%=request.getContextPath()%>/RoomServlet" method="POST" onsubmit="return confirm('Bạn chắc chắn muốn xóa vĩnh viễn phòng này?');">
                    <input type="hidden" name="action" value="deleteRoom">
                    <input type="hidden" name="roomId" id="deleteRoomId">
                    <button type="submit" class="w-full py-2 bg-red-50 text-red-600 border border-red-200 font-bold rounded-lg hover:bg-red-100 flex items-center justify-center gap-2">
                        <span class="material-symbols-outlined text-[18px]">delete</span> Xóa Phòng Này
                    </button>
                </form>
            </div>

            <div class="w-full md:w-2/3 p-6 flex flex-col bg-white overflow-y-auto no-scrollbar">
                <div class="flex justify-between items-center mb-4">
                    <h4 class="font-bold text-slate-800 text-lg">Thư viện ảnh</h4>
                    <button type="button" onclick="triggerUpload()" class="bg-slate-800 text-white px-4 py-2 rounded-lg text-sm font-bold hover:bg-slate-900 flex items-center gap-2 shadow-md">
                        <span class="material-symbols-outlined text-[16px]">upload</span> Thêm Ảnh Mới
                    </button>
                </div>
                
                <div id="manageImageGallery" class="grid grid-cols-2 lg:grid-cols-3 gap-4">
                    </div>
            </div>
        </div>
    </div>

    <form id="setPrimaryForm" action="<%=request.getContextPath()%>/RoomServlet" method="POST" class="hidden">
        <input type="hidden" name="action" value="setPrimaryImage">
        <input type="hidden" name="roomId" id="primaryRoomId">
        <input type="hidden" name="imageUrl" id="primaryImageUrl">
    </form>

    <form id="deleteImageForm" action="<%=request.getContextPath()%>/RoomServlet" method="POST" class="hidden">
        <input type="hidden" name="action" value="deleteImage">
        <input type="hidden" name="imageId" id="deleteImageId">
    </form>

    <form id="uploadImageForm" action="<%=request.getContextPath()%>/RoomServlet" method="POST" enctype="multipart/form-data" class="hidden">
        <input type="hidden" name="action" value="uploadRoomImage">
        <input type="hidden" name="roomId" id="uploadRoomId">
        <input type="file" name="file" id="hiddenFileInput" accept="image/*" onchange="submitImageUpload()">
    </form>

    <script>
        // Mở / Đóng Modal dùng chung
        function openTailwindModal(modalId) { 
            document.getElementById(modalId).classList.remove('hidden'); 
        }
        function closeTailwindModal(modalId) { 
            document.getElementById(modalId).classList.add('hidden'); 
        }
        
        // 1. Mở Modal Đổi Trạng Thái
        function openStatusModal(roomId, currentStatus) {
            document.getElementById('modalRoomId').value = roomId;
            document.getElementById('displayRoomId').innerText = roomId;
            document.getElementById('modalCurrentStatus').value = currentStatus;
            document.getElementById('modalNewStatus').value = currentStatus;
            openTailwindModal('statusModal');
        }

        // 2. Mở Modal Siêu Quản Lý Phòng & Hình Ảnh
        function openManageModal(roomId, typeId, price, primaryImg, element) {
            document.getElementById('manageRoomId').value = roomId;
            document.getElementById('displayManageRoomId').innerText = roomId;
            document.getElementById('manageTypeId').value = typeId;
            document.getElementById('managePrice').value = price;
            
            document.getElementById('deleteRoomId').value = roomId;
            document.getElementById('uploadRoomId').value = roomId;

            const gallery = document.getElementById('manageImageGallery');
            gallery.innerHTML = ''; 
            
            const imageNodes = element.closest('.room-card').querySelectorAll('.room-images-data span');
            
            if (imageNodes.length === 0) {
                gallery.innerHTML = '<div class="col-span-full py-10 flex flex-col items-center justify-center border-2 border-dashed border-slate-300 rounded-xl"><span class="material-symbols-outlined text-4xl text-slate-300 mb-2">image_not_supported</span><span class="text-slate-400 font-medium text-sm">Phòng này chưa có ảnh</span></div>';
            } else {
                imageNodes.forEach(span => {
                    const id = span.getAttribute('data-id');
                    const rawUrl = span.getAttribute('data-url');
                    
                    let isPrimary = false;
                    if (primaryImg && rawUrl) {
                        const cleanPrimary = primaryImg.replace(/^\//, '');
                        const cleanRaw = rawUrl.replace(/^\//, '');
                        isPrimary = (cleanRaw === cleanPrimary);
                    }
                    
                    const url = rawUrl.startsWith('http') ? rawUrl : '<%=request.getContextPath()%>/' + rawUrl;
                    
                    const wrapper = document.createElement('div');
                    wrapper.className = 'relative group rounded-xl overflow-hidden border-2 aspect-video bg-slate-100 ' + (isPrimary ? 'border-amber-400 shadow-[0_0_10px_rgba(251,191,36,0.5)]' : 'border-slate-200');
                    
                    let html = '<img src="' + url + '" class="w-full h-full object-cover">';
                    
                    if (isPrimary) {
                        html += '<div class="absolute top-1.5 left-1.5 bg-amber-400 text-white text-[9px] font-black px-1.5 py-0.5 rounded uppercase flex items-center gap-0.5 shadow"><span class="material-symbols-outlined text-[10px]">star</span>BÌA</div>';
                    }
                    
                    html += '<div class="absolute inset-0 bg-slate-900/60 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2 backdrop-blur-sm">';
                    if (!isPrimary) {
                        html += '<button onclick="event.stopPropagation(); setPrimaryImage(\'' + roomId + '\', \'' + rawUrl + '\')" class="size-9 rounded-full bg-amber-500 text-white hover:scale-110 hover:bg-amber-400 transition-transform shadow flex items-center justify-center" title="Làm ảnh bìa"><span class="material-symbols-outlined text-[18px]">star</span></button>';
                    }
                    html += '<button onclick="event.stopPropagation(); deleteImage(\'' + id + '\')" class="size-9 rounded-full bg-red-500 text-white hover:scale-110 hover:bg-red-400 transition-transform shadow flex items-center justify-center" title="Xóa ảnh"><span class="material-symbols-outlined text-[18px]">delete</span></button>';
                    html += '</div>';
                    
                    wrapper.innerHTML = html;
                    gallery.appendChild(wrapper);
                });
            }
            openTailwindModal('manageModal');
        }

        function setPrimaryImage(roomId, url) {
            document.getElementById('primaryRoomId').value = roomId;
            document.getElementById('primaryImageUrl').value = url;
            document.getElementById('setPrimaryForm').submit();
        }

        function deleteImage(id) {
            if(confirm('Xóa ảnh này vĩnh viễn?')) {
                document.getElementById('deleteImageId').value = id;
                document.getElementById('deleteImageForm').submit();
            }
        }
        
        function triggerUpload() {
            document.getElementById('hiddenFileInput').click();
        }
        
        function submitImageUpload() {
            if(document.getElementById('hiddenFileInput').files.length > 0) {
                if(confirm("Tải ảnh này lên?")) {
                    document.getElementById('uploadImageForm').submit();
                }
            }
        }
    </script>
</body>
</html>