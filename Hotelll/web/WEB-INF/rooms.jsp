<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Room Discovery</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#1069f9", "background-light": "#f8f9fc", "surface-light": "#ffffff", },
                    fontFamily: { display: ["Plus Jakarta Sans", "sans-serif"] },
                },
            },
        }
    </script>
</head>
<body class="bg-background-light text-slate-900 font-display min-h-screen flex flex-col">
    
    <header class="sticky top-0 z-50 w-full border-b border-slate-200 bg-surface-light/95 backdrop-blur">
        <div class="px-4 md:px-10 py-4 flex items-center justify-between mx-auto max-w-[1400px]">
            <div class="flex items-center gap-4 text-primary">
                <span class="material-symbols-outlined text-3xl">hotel_class</span>
                <h2 class="text-slate-900 text-xl font-bold">SmartHotel</h2>
            </div>
            <a href="${pageContext.request.contextPath}/guest/profile.jsp" class="flex items-center gap-2 text-slate-600 hover:text-primary font-medium bg-slate-100 px-4 py-2 rounded-lg transition-colors">
                <span class="material-symbols-outlined text-[20px]">arrow_back</span> Quay lại Hồ Sơ
            </a>
        </div>
    </header>

    <main class="flex-1 w-full max-w-[1400px] mx-auto px-4 md:px-10 py-8">
        
        <div class="flex flex-col sm:flex-row justify-between items-center mb-8 pb-4 border-b border-slate-200">
            <h3 class="text-3xl font-bold text-slate-900">Danh Sách Phòng Khách Sạn</h3>
        </div>

        <c:if test="${empty rooms}">
            <div class="text-center py-20 bg-white rounded-2xl shadow-sm border border-slate-200">
                <span class="material-symbols-outlined text-6xl text-slate-300 mb-4">search_off</span>
                <h3 class="text-xl font-bold text-slate-700">Không tìm thấy dữ liệu phòng.</h3>
                <p class="text-slate-500 mt-2">Hệ thống hiện tại chưa có phòng nào hoặc tất cả đã được đặt.</p>
            </div>
        </c:if>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 mb-10">
            <c:forEach var="r" items="${rooms}">
                
                <div class="group bg-surface-light rounded-2xl overflow-hidden border border-slate-200 shadow-sm hover:shadow-xl transition-all duration-300 flex flex-col h-full ${r.status != 'Available' ? 'opacity-70 grayscale-[0.3]' : ''}">
                    
                    <c:set var="bgImage" value="${r.primaryImageUrl}" />
                    <c:if test="${empty bgImage}"><c:set var="bgImage" value="https://via.placeholder.com/400x250?text=Chua+Co+Anh" /></c:if>
                    <c:if test="${not fn:startsWith(bgImage, 'http')}">
                        <c:set var="bgImage" value="${pageContext.request.contextPath}/${bgImage}" />
                    </c:if>

                    <div class="w-full h-48 relative bg-slate-100 overflow-hidden">
                        <img src="${bgImage}" alt="Phòng ${r.roomNumber}" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
                        
                        <div class="absolute inset-0 bg-gradient-to-t from-slate-900/60 to-transparent"></div>
                        
                        <div class="absolute top-3 right-3">
                            <c:choose>
                                <c:when test="${r.status == 'Available'}">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/90 backdrop-blur text-white text-xs font-bold shadow-md">
                                        <span class="w-1.5 h-1.5 rounded-full bg-white animate-pulse"></span> Sẵn sàng
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-slate-800/80 backdrop-blur text-slate-200 text-xs font-bold shadow-md">
                                        Không trống
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="p-6 flex flex-col flex-1">
                        <div class="flex justify-between items-start mb-2">
                            <h4 class="text-2xl font-black text-slate-900">Phòng ${r.roomNumber}</h4>
                            <span class="text-sm font-bold text-slate-400">Tầng ${r.floor}</span>
                        </div>
                        
                        <p class="text-slate-500 font-semibold mb-6 flex items-center gap-2">
                            <span class="material-symbols-outlined text-lg text-primary">meeting_room</span> ${r.roomType.typeName}
                        </p>
                        
                        <div class="mt-auto pt-5 border-t border-slate-100 flex items-end justify-between gap-4">
                            <div>
                                <p class="text-xs text-slate-500 font-medium mb-1">Giá mỗi đêm</p>
                                <p class="text-primary text-xl font-black"><fmt:formatNumber value="${r.price}" pattern="#,###"/> đ</p>
                            </div>
                            
                            <c:choose>
                                <c:when test="${r.status == 'Available'}">
                                    <a href="${pageContext.request.contextPath}/webapp/search.jsp?roomId=${r.roomNumber}" class="bg-primary hover:bg-blue-700 text-white py-2.5 px-5 rounded-xl font-bold text-sm shadow-md transition-all active:scale-95 text-center flex items-center gap-1">
                                        ĐẶT NGAY <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button class="bg-slate-100 text-slate-400 py-2.5 px-5 rounded-xl font-bold text-sm cursor-not-allowed border border-slate-200" disabled>
                                        ĐÃ ĐẶT
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
</body>
</html>