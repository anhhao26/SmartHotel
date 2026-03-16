<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <title>SmartHotel - Bộ Sưu Tập</title>
                    <!-- Premium Fonts -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;700;800;900&display=swap"
                        rel="stylesheet" />
                    <link
                        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                        rel="stylesheet" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <script src="https://unpkg.com/alpinejs" defer></script>
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
                                    fontFamily: { serif: ["Outfit", "serif"], sans: ["Outfit", "sans-serif"] },
                                },
                            },
                        }
                    </script>
                    <style>
                        body {
                            background-color: #FAF9F6;
                            color: #2C2722;
                            overflow-x: hidden;
                        }
                        .card-elegant {
                            background: #FFFFFF;
                            border: 1px solid rgba(184,154,108,0.12);
                            box-shadow: 0 20px 40px -15px rgba(74,66,56,0.07);
                            transition: all 0.5s cubic-bezier(0.23,1,0.32,1);
                        }
                        .card-elegant:hover {
                            border-color: #B89A6C;
                            transform: translateY(-6px);
                            box-shadow: 0 30px 60px -20px rgba(184,154,108,0.15);
                        }

                        .glass-card {
                            background: linear-gradient(135deg, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.01) 100%);
                            backdrop-filter: blur(25px);
                            -webkit-backdrop-filter: blur(25px);
                            border: 1px solid rgba(212, 175, 55, 0.1);
                            box-shadow: 0 40px 100px -20px rgba(0, 0, 0, 0.7);
                        }

                        .tilt-card {
                            transition: transform 0.2s ease-out;
                            transform-style: preserve-3d;
                        }

                        .modal-enter {
                            animation: modalIn 0.5s cubic-bezier(0.16, 1, 0.3, 1);
                        }

                        @keyframes modalIn {
                            from {
                                opacity: 0;
                                transform: scale(0.95) translateY(30px);
                            }

                            to {
                                opacity: 1;
                                transform: scale(1) translateY(0);
                            }
                        }

                        .orb {
                            position: absolute;
                            border-radius: 50%;
                            filter: blur(120px);
                            z-index: -1;
                            opacity: 0.2;
                            pointer-events: none;
                        }

                        .gallery-thumb {
                            border: 2px solid transparent;
                            transition: all 0.3s;
                        }

                        .gallery-thumb.active {
                            border-color: #d4af37;
                            transform: scale(1.05);
                            box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
                        }

                        [x-cloak] {
                            display: none !important;
                        }
                        
                        .modal-hotel {
                            animation: modalFadeIn 0.4s cubic-bezier(0.16, 1, 0.3, 1);
                        }
                        
                        @keyframes modalFadeIn {
                            from { opacity: 0; transform: scale(0.98) translateY(20px); }
                            to { opacity: 1; transform: scale(1) translateY(0); }
                        }
                    </style>
                </head>

                <body class="font-display antialiased min-h-screen flex flex-col relative pb-20" x-data="{ 
    modalOpen: false, 
    activeRoom: {}, 
    activeImg: '', 
    gallery: [],
    getRoomGallery(type) {
        const galleries = {
            'Standard': ['https://images.unsplash.com/photo-1566665797739-1674de7a421a', 'https://images.unsplash.com/photo-1590490360182-c33d57733427', 'https://images.unsplash.com/photo-1584132967334-10e028bd69f7'],
            'Deluxe': ['https://images.unsplash.com/photo-1591088398332-8a7791972843', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b', 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304'],
            'VIP': ['https://images.unsplash.com/photo-1578683010236-d716f9a3f461', 'https://images.unsplash.com/photo-1540518614846-7eded433c457', 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2'],
            'Suite': ['https://images.unsplash.com/photo-1595576508898-0ad5c879a061', 'https://images.unsplash.com/photo-1618773928121-c32242e63f39', 'https://images.unsplash.com/photo-1590490359683-658d3d23f972']
        };
        return galleries[type] || ['https://images.unsplash.com/photo-1590490360182-c33d57733427', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b'];
    }
}">
                    <header class="fixed top-0 w-full z-50 bg-white/90 backdrop-blur-xl border-b border-hotel-gold/10 shadow-sm">
                        <div class="max-w-[1600px] mx-auto px-10 h-24 flex items-center justify-between">
                            <div class="flex items-center gap-12">
                                <a href="${pageContext.request.contextPath}/" class="flex items-center gap-4 group">
                                    <span class="material-symbols-outlined text-hotel-gold text-3xl">local_hotel</span>
                                    <span class="text-hotel-text text-xl font-serif font-bold tracking-[0.2em] uppercase">SmartHotel</span>
                                </a>
                                
                                <form action="${pageContext.request.contextPath}/rooms" method="GET" class="hidden lg:flex items-center bg-hotel-cream border border-hotel-gold/10 rounded-full px-6 py-2.5 w-[350px] group focus-within:border-hotel-gold transition-all">
                                    <span class="material-symbols-outlined text-hotel-muted group-focus-within:text-hotel-gold transition-colors text-xl">search</span>
                                    <input name="search" value="${param.search}" class="bg-transparent border-none focus:ring-0 text-[10px] ml-3 w-full text-hotel-text placeholder-hotel-muted font-bold uppercase tracking-widest" placeholder="TÌM KIẾM PHÒNG..." type="text"/>
                                </form>
                            </div>

                            <nav class="flex items-center gap-10">
                                <c:choose>
                                    <c:when test="${empty sessionScope.acc}">
                                        <a href="${pageContext.request.contextPath}/login.jsp" class="text-hotel-muted hover:text-hotel-gold text-[10px] font-bold tracking-[0.2em] uppercase transition-all">Đăng Nhập</a>
                                        <a href="${pageContext.request.contextPath}/guest/register.jsp" class="bg-hotel-gold text-white px-8 py-3 rounded-sm text-[10px] font-bold tracking-[0.2em] uppercase hover:bg-hotel-text transition-all shadow-lg">Đăng Ký</a>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="relative group" x-data="{ open: false }">
                                            <button @click="open = !open" @click.away="open = false" class="flex items-center gap-4 py-2 px-6 bg-white/50 border border-hotel-gold/10 rounded-full hover:border-hotel-gold/30 transition-all">
                                                <span class="material-symbols-outlined text-hotel-gold text-sm">person</span>
                                                <span class="text-[9px] font-bold uppercase tracking-[0.2em] text-hotel-text">
                                                    ${sessionScope.acc.username}
                                                </span>
                                                <span class="material-symbols-outlined text-hotel-gold text-xs group-hover:rotate-180 transition-transform">expand_more</span>
                                            </button>
                                            
                                            <div x-show="open" 
                                                 x-transition:enter="transition ease-out duration-200"
                                                 x-transition:enter-start="opacity-0 translate-y-1"
                                                 x-transition:enter-end="opacity-100 translate-y-0"
                                                 class="absolute right-0 mt-3 w-56 bg-white rounded-xl shadow-2xl border border-hotel-gold/5 overflow-hidden z-50">
                                                <div class="p-2">
                                                    <a href="${pageContext.request.contextPath}/guest/profile.jsp" class="flex items-center gap-3 px-4 py-3 text-[10px] font-bold text-hotel-muted uppercase tracking-widest hover:bg-hotel-cream hover:text-hotel-gold rounded-lg transition-colors">
                                                        <span class="material-symbols-outlined text-sm">person_outline</span> THÔNG TIN
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/guest/history.jsp" class="flex items-center gap-3 px-4 py-3 text-[10px] font-bold text-hotel-muted uppercase tracking-widest hover:bg-hotel-cream hover:text-hotel-gold rounded-lg transition-colors">
                                                        <span class="material-symbols-outlined text-sm">history</span> LỊCH SỬ ĐẶT
                                                    </a>
                                                    <div class="h-px bg-hotel-gold/5 my-2"></div>
                                                    <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-4 text-[10px] font-bold text-red-400 uppercase tracking-widest hover:bg-red-50 rounded-lg transition-colors">
                                                        <span class="material-symbols-outlined text-sm">logout</span> ĐĂNG XUẤT
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </nav>
                        </div>
                    </header>

                    <!-- Hero Section -->
                    <main class="relative h-[480px] overflow-hidden mt-24">
                        <div class="absolute inset-0">
                            <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2000" 
                                 class="w-full h-full object-cover">
                            <div class="absolute inset-0 bg-black/40 backdrop-blur-[2px]"></div>
                        </div>
                        
                        <div class="relative h-full max-w-7xl mx-auto px-6 flex flex-col justify-center items-center text-center">
                            <div class="w-20 h-[1px] bg-hotel-gold mb-8"></div>
                            <h1 class="text-6xl md:text-7xl font-serif text-white mb-6 tracking-tight leading-tight">
                                Khám Phá <br/>
                                <span class="text-hotel-gold italic">Không Gian Nghỉ Dưỡng.</span>
                            </h1>
                            <p class="text-white/70 text-lg font-serif italic max-w-2xl leading-relaxed">
                                Sự kết hợp hoàn hảo giữa thiết kế đương đại và dịch vụ tận tâm, mang đến trải nghiệm lưu trú đẳng cấp tại trung tâm thành phố.
                            </p>
                            <div class="mt-12 flex flex-col items-center">
                                <span class="text-[10px] text-hotel-gold font-bold uppercase tracking-widest mb-4">Cuộn để tận hưởng</span>
                                <div class="w-0.5 h-10 bg-hotel-gold/30 rounded-full relative overflow-hidden">
                                    <div class="absolute top-0 left-0 w-full bg-hotel-gold h-1/2 animate-bounce"></div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <main class="max-w-[1600px] mx-auto w-full px-10 pt-20">
                        <div class="mb-20 text-center space-y-6">
                            <div
                                class="inline-flex items-center gap-3 px-5 py-2 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-[10px] font-bold uppercase tracking-widest">
                                Không Gian Lưu Trú
                            </div>
                            <h1 class="text-6xl md:text-8xl font-serif text-hotel-text tracking-tight">
                                Bộ Sưu Tập <span class="italic text-hotel-gold">Thượng Lưu.</span>
                            </h1>
                            <p
                                class="text-hotel-muted text-[10px] font-bold tracking-[0.4em] uppercase border-t border-hotel-gold/10 pt-8 inline-block">
                                Tinh hoa nghệ thuật nghỉ dưỡng hiện đại
                            </p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-12 pb-20">
                            <c:forEach items="${rooms}" var="room">
                                <div class="card-elegant rounded-sm overflow-hidden group">
                                    <div class="relative h-80 overflow-hidden">
                                        <c:set var="roomImg" value="${room.primaryImageUrl}" />
                                        <c:if test="${empty roomImg}">
                                            <c:set var="roomImg"
                                                value="https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=1000" />
                                        </c:if>
                                        <c:if test="${not fn:startsWith(roomImg, 'http')}">
                                            <c:set var="roomImg"
                                                value="${pageContext.request.contextPath}/${roomImg}" />
                                        </c:if>

                                        <img src="${roomImg}"
                                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-[1.5s]"
                                            alt="Phòng Nghỉ"
                                            onerror="this.src='https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=1000'">
                                        <div
                                            class="absolute inset-0 bg-black/20 group-hover:bg-black/10 transition-colors">
                                        </div>
                                        <div class="absolute top-6 right-6">
                                            <span
                                                class="px-4 py-1.5 rounded-sm text-[8px] font-bold tracking-widest uppercase backdrop-blur-md border ${room.status == 'Available' ? 'bg-emerald-500/10 text-emerald-600 border-emerald-500/20' : 'bg-red-500/10 text-red-600 border-red-500/20'}">
                                                ${room.status == 'Available' ? 'Còn Trống' : 'Đã Đặt'}
                                            </span>
                                        </div>
                                    </div>

                                    <div class="p-8 space-y-8">
                                        <div class="flex justify-between items-start">
                                            <div>
                                                <h3 class="text-3xl font-serif font-bold text-hotel-text mb-1">
                                                    P.${room.roomNumber}</h3>
                                                <p
                                                    class="text-hotel-gold font-bold text-[9px] uppercase tracking-widest">
                                                    ${room.roomType.typeName}
                                                </p>
                                            </div>
                                            <div class="text-right">
                                                <p class="text-2xl font-serif font-bold text-hotel-text">
                                                    <fmt:formatNumber value="${room.price}" pattern="#,###" /><span
                                                        class="text-[10px] font-serif ml-1">đ</span>
                                                </p>
                                                <p
                                                    class="text-[8px] text-hotel-muted uppercase tracking-widest font-bold">
                                                    mỗi đêm</p>
                                            </div>
                                        </div>

                                        <div
                                            class="flex items-center gap-8 text-hotel-muted text-[9px] font-bold uppercase tracking-widest border-y border-hotel-gold/10 py-6">
                                            <span class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-[18px] text-hotel-gold/60">apartment</span>
                                                TẦNG ${room.floor}
                                            </span>
                                            <span class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-[18px] text-hotel-gold/60">group</span>
                                                ${room.roomType.maxCapacity} KHÁCH
                                            </span>
                                        </div>

                                        <div class="pt-2 flex gap-4">
                                            <button @click="
                                activeRoom = {
                                    num: '${room.roomNumber}',
                                    type: '${room.roomType.typeName}',
                                    price: '${room.price}',
                                    cap: '${room.roomType.maxCapacity}',
                                    desc: '${fn:escapeXml(room.roomType.amenities)}',
                                    status: '${room.status}'
                                };
                                gallery = getRoomGallery(activeRoom.type);
                                activeImg = '${roomImg}';
                                modalOpen = true;
                                document.body.style.overflow = 'hidden';
                            " class="flex-1 py-4 text-hotel-text font-bold text-[9px] tracking-widest uppercase border border-hotel-gold/20 hover:bg-hotel-gold/5 transition-all">Chi
                                                tiết</button>
                                            <a href="${empty sessionScope.acc ? pageContext.request.contextPath.concat('/login.jsp?redirect=booking&roomId=').concat(room.roomNumber) : pageContext.request.contextPath.concat('/webapp/search.jsp?roomId=').concat(room.roomNumber)}"
                                                class="${room.status == 'Available' ? 'bg-hotel-gold text-white' : 'bg-hotel-bone text-hotel-muted/30 cursor-not-allowed'} flex-[1.5] py-4 font-bold text-[9px] tracking-widest uppercase text-center flex items-center justify-center gap-2 transition-all shadow-lg hover:bg-hotel-chocolate">
                                                Đặt Ngay <span
                                                    class="material-symbols-outlined text-sm">calendar_month</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </main>

                    <!-- Room Detail Modal -->
                    <div x-show="modalOpen" class="fixed inset-0 z-[100] flex items-center justify-center p-6 sm:p-12"
                        x-cloak>
                        <div class="absolute inset-0 bg-hotel-text/60 backdrop-blur-md"
                            @click="modalOpen = false; document.body.style.overflow = 'auto'"></div>

                        <div class="relative w-full max-w-7xl bg-hotel-bone rounded-sm overflow-hidden flex flex-col md:flex-row modal-hotel shadow-2xl border border-hotel-gold/10"
                            @click.away="modalOpen = false; document.body.style.overflow = 'auto'">
                            <button @click="modalOpen = false; document.body.style.overflow = 'auto'"
                                class="absolute top-10 right-10 z-[110] w-12 h-12 rounded-full bg-white/50 hover:bg-hotel-gold hover:text-white flex items-center justify-center text-hotel-text border border-hotel-gold/10 transition-all group">
                                <span
                                    class="material-symbols-outlined group-hover:rotate-180 transition-transform">close</span>
                            </button>

                            <!-- Modal Image Gallery Side -->
                            <div class="w-full md:w-1/2 h-[500px] md:h-auto relative overflow-hidden flex flex-col">
                                <div class="flex-grow relative overflow-hidden">
                                    <img :src="activeImg"
                                        class="w-full h-full object-cover transition-all duration-[1.5s]"
                                        alt="Chi tiết phòng">
                                    <div
                                        class="absolute inset-0 bg-gradient-to-t from-hotel-text/30 via-transparent to-transparent">
                                    </div>

                                    <!-- Gallery Navigation Dots -->
                                    <div class="absolute bottom-12 left-1/2 -translate-x-1/2 flex gap-3">
                                        <template x-for="(img, index) in gallery" :key="index">
                                            <button @click="activeImg = img"
                                                :class="activeImg === img ? 'bg-hotel-gold w-10' : 'bg-white/50 w-2.5'"
                                                class="h-1 rounded-full transition-all duration-500"></button>
                                        </template>
                                    </div>
                                </div>

                                <!-- Thumbnails -->
                                <div class="p-6 bg-white flex gap-4 justify-center border-t border-hotel-gold/10">
                                    <template x-for="(img, index) in gallery" :key="index">
                                        <img :src="img" @click="activeImg = img"
                                            :class="activeImg === img ? 'active' : ''"
                                            class="gallery-thumb w-20 h-20 rounded-sm object-cover cursor-pointer hover:opacity-100 opacity-60">
                                    </template>
                                </div>
                            </div>

                            <!-- Modal Content Side -->
                            <div
                                class="w-full md:w-1/2 p-12 md:p-20 flex flex-col justify-center space-y-10 bg-hotel-bone overflow-y-auto">
                                <div class="space-y-4">
                                    <div
                                        class="inline-flex items-center gap-3 px-6 py-2 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-[9px] font-bold uppercase tracking-widest">
                                        Tuyệt Tác Không Gian
                                    </div>
                                    <h2 class="text-6xl md:text-7xl font-serif font-bold text-hotel-text tracking-tight leading-none"
                                        x-text="'PHÒNG ' + activeRoom.num"></h2>
                                    <p class="text-3xl font-serif text-hotel-gold italic" x-text="activeRoom.type"></p>
                                </div>

                                <div class="grid grid-cols-2 gap-10 py-10 border-y border-hotel-gold/10">
                                    <div class="space-y-2">
                                        <p class="text-hotel-muted text-[9px] font-bold uppercase tracking-widest">Giá
                                            Trải Nghiệm</p>
                                        <p class="text-3xl font-serif font-bold text-hotel-text"
                                            x-text="Number(activeRoom.price).toLocaleString() + ' đ'"></p>
                                    </div>
                                    <div class="space-y-2">
                                        <p class="text-hotel-muted text-[9px] font-bold uppercase tracking-widest">Sức
                                            Chứa Tối Đa</p>
                                        <p class="text-3xl font-serif font-bold text-hotel-text"
                                            x-text="activeRoom.cap + ' Khách'"></p>
                                    </div>
                                </div>

                                <div class="space-y-4">
                                    <h4 class="text-[9px] font-bold text-hotel-muted uppercase tracking-widest">Mô Tả
                                        Chi Tiết</h4>
                                    <p class="text-hotel-muted font-sans leading-relaxed text-lg"
                                        x-text="activeRoom.desc || 'Một không gian yên bình, nơi sự sang trọng hòa quyện cùng sự tinh tế, mang đến trải nghiệm nghỉ dưỡng hoàn hảo nhất.'">
                                    </p>
                                </div>

                                <div class="pt-6">
                                    <a :href="${empty sessionScope.acc} ? '${pageContext.request.contextPath}/login.jsp?redirect=booking&roomId=' + activeRoom.num : '${pageContext.request.contextPath}/webapp/search.jsp?roomId=' + activeRoom.num"
                                        :class="activeRoom.status !== 'Available' ? 'opacity-30 pointer-events-none' : ''"
                                        class="w-full py-6 rounded-sm bg-hotel-gold text-white font-bold text-[11px] tracking-widest uppercase text-center flex items-center justify-center gap-4 hover:bg-hotel-text transition-all active:scale-[0.98] shadow-2xl">
                                        <span
                                            x-text="activeRoom.status === 'Available' ? 'Khởi Tạo Đặt Phòng' : 'Hết Phòng'"></span>
                                        <span class="material-symbols-outlined text-lg"
                                            x-show="activeRoom.status === 'Available'">event_available</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <jsp:include page="/common/chat_box.jspf" />
                </body>

                </html>