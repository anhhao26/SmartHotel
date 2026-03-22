<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>SmartHotel - Bộ Sưu Tập Phòng</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;1,400;1,600&display=swap" rel="stylesheet" />
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
                            dark: "#1a1612",
                        }
                    },
                    fontFamily: {
                        serif: ["Cormorant Garamond", "serif"],
                        sans: ["Outfit", "sans-serif"]
                    },
                },
            },
        }
    </script>
    <style>
        body {
            background-color: #F8F6F2;
            color: #2C2722;
            overflow-x: hidden;
            font-family: 'Outfit', sans-serif;
        }

        .luxury-bg {
            background-color: #F8F6F2;
            background-image:
                radial-gradient(rgba(184, 154, 108, 0.06) 1.5px, transparent 1.5px);
            background-size: 28px 28px;
        }

        /* ── Card ────────────────────────────────────── */
        .room-card {
            background: linear-gradient(160deg, #ffffff 0%, #fdfcfa 100%);
            border: 1px solid rgba(184, 154, 108, 0.15);
            box-shadow: 0 4px 6px -1px rgba(74,66,56,0.04), 0 20px 40px -15px rgba(74,66,56,0.06);
            transition: transform 0.5s cubic-bezier(0.23,1,0.32,1),
                        box-shadow 0.5s cubic-bezier(0.23,1,0.32,1),
                        border-color 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        .room-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; height: 3px;
            background: linear-gradient(90deg, transparent 10%, #B89A6C 50%, transparent 90%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: 20;
        }
        .room-card:hover {
            border-color: rgba(184, 154, 108, 0.45);
            transform: translateY(-10px);
            box-shadow: 0 30px 60px -15px rgba(184,154,108,0.2), 0 8px 20px -5px rgba(74,66,56,0.07);
        }
        .room-card:hover::before { opacity: 1; }

        /* ── Buttons ─────────────────────────────── */
        .btn-outline-gold {
            border: 1px solid rgba(184,154,108,0.40);
            color: #2C2722;
            transition: all 0.3s ease;
            background: transparent;
        }
        .btn-outline-gold:hover {
            background: rgba(184,154,108,0.10);
            border-color: #B89A6C;
            color: #B89A6C;
        }
        .btn-gold {
            background: linear-gradient(135deg, #c5a87e 0%, #9c8258 100%);
            box-shadow: 0 8px 20px -8px rgba(184,154,108,0.55);
            transition: all 0.35s cubic-bezier(0.23,1,0.32,1);
        }
        .btn-gold:hover {
            box-shadow: 0 14px 28px -8px rgba(184,154,108,0.65);
            transform: translateY(-2px);
        }

        /* ── Modal ───────────────────────────────── */
        .modal-hotel { animation: modalFadeIn 0.45s cubic-bezier(0.16, 1, 0.3, 1); }
        @keyframes modalFadeIn {
            from { opacity: 0; transform: scale(0.97) translateY(24px); }
            to   { opacity: 1; transform: scale(1)    translateY(0); }
        }

        /* ── Gallery ─────────────────────────────── */
        .gallery-thumb {
            border: 2px solid transparent;
            transition: all 0.3s;
        }
        .gallery-thumb.active {
            border-color: #B89A6C;
            transform: scale(1.06);
            box-shadow: 0 0 14px rgba(184,154,108,0.4);
        }

        [x-cloak] { display: none !important; }

        /* ── Badge ───────────────────────────────── */
        .badge-available {
            background: rgba(16,185,129,0.85);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }
    </style>
</head>

<body class="luxury-bg antialiased min-h-screen flex flex-col" x-data="{
    modalOpen: false,
    activeRoom: {},
    activeImg: '',
    gallery: [],
    getRoomGallery(type) {
        const t = (type || '').toLowerCase();
        if (t.includes('suite'))
            return ['https://images.unsplash.com/photo-1595576508898-0ad5c879a061?q=80&w=1000','https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=1000','https://images.unsplash.com/photo-1590490359683-658d3d23f972?q=80&w=1000'];
        if (t.includes('vip') || t.includes('presidential'))
            return ['https://images.unsplash.com/photo-1578683010236-d716f9a3f461?q=80&w=1000','https://images.unsplash.com/photo-1540518614846-7eded433c457?q=80&w=1000','https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?q=80&w=1000'];
        if (t.includes('deluxe') || t.includes('superior'))
            return ['https://images.unsplash.com/photo-1591088398332-8a7791972843?q=80&w=1000','https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=1000','https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=1000'];
        // Standard / mặc định
        return ['https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=1000','https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=1000','https://images.unsplash.com/photo-1584132967334-10e028bd69f7?q=80&w=1000'];
    }
}">

    <!-- ══════════════ HEADER ══════════════ -->
    <header class="fixed top-0 w-full z-50 bg-white/90 backdrop-blur-2xl border-b border-hotel-gold/10 shadow-sm">
        <div class="max-w-[1600px] mx-auto px-8 md:px-12 h-[72px] flex items-center justify-between gap-8">

            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3 shrink-0 group">
                <span class="material-symbols-outlined text-hotel-gold text-3xl group-hover:scale-110 transition-transform">local_hotel</span>
                <span class="text-hotel-text text-lg font-sans font-bold tracking-[0.22em] uppercase">SmartHotel</span>
            </a>

            <!-- Search -->
            <form action="${pageContext.request.contextPath}/rooms" method="GET"
                class="hidden lg:flex items-center bg-hotel-cream border border-hotel-gold/15 rounded-full px-5 py-2 w-[320px] focus-within:border-hotel-gold focus-within:shadow-[0_0_0_3px_rgba(184,154,108,0.10)] transition-all">
                <span class="material-symbols-outlined text-hotel-muted text-[20px]">search</span>
                <input name="search" value="${param.search}"
                    class="bg-transparent border-none outline-none focus:ring-0 text-[13px] ml-3 w-full text-hotel-text placeholder-hotel-muted/70 font-sans font-semibold uppercase tracking-widest"
                    placeholder="Tìm kiếm phòng..." type="text"/>
            </form>

            <!-- Nav -->
            <nav class="flex items-center gap-6">
                <c:choose>
                    <c:when test="${empty sessionScope.acc}">
                        <a href="${pageContext.request.contextPath}/login.jsp"
                            class="text-hotel-muted hover:text-hotel-gold text-[13px] font-bold tracking-[0.2em] uppercase transition-colors">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/guest/register.jsp"
                            class="btn-gold text-white px-7 py-2.5 rounded-full text-[13px] font-bold tracking-[0.18em] uppercase">Đăng Ký</a>
                    </c:when>
                    <c:otherwise>
                        <div x-data="{ open: false }" class="relative">
                            <button @click="open = !open" @click.away="open = false"
                                class="flex items-center gap-3 px-5 py-2 bg-hotel-cream/80 border border-hotel-gold/15 rounded-full hover:border-hotel-gold/40 transition-all">
                                <span class="material-symbols-outlined text-hotel-gold text-[18px]">person</span>
                                <span class="text-[13px] font-bold uppercase tracking-[0.18em] text-hotel-text">${sessionScope.acc.username}</span>
                                <span class="material-symbols-outlined text-hotel-gold text-[14px] transition-transform duration-300" :class="open ? 'rotate-180' : ''">expand_more</span>
                            </button>
                            <div x-show="open"
                                x-transition:enter="transition ease-out duration-200"
                                x-transition:enter-start="opacity-0 translate-y-1 scale-95"
                                x-transition:enter-end="opacity-100 translate-y-0 scale-100"
                                class="absolute right-0 mt-2 w-52 bg-white rounded-2xl shadow-2xl border border-hotel-gold/10 overflow-hidden z-50">
                                <div class="p-1.5">
                                    <a href="${pageContext.request.contextPath}/guest/profile.jsp"
                                        class="flex items-center gap-3 px-4 py-3 text-[12px] font-bold text-hotel-muted uppercase tracking-widest hover:bg-hotel-cream hover:text-hotel-gold rounded-xl transition-colors">
                                        <span class="material-symbols-outlined text-[16px]">person_outline</span> Thông Tin
                                    </a>
                                    <a href="${pageContext.request.contextPath}/guest/history.jsp"
                                        class="flex items-center gap-3 px-4 py-3 text-[12px] font-bold text-hotel-muted uppercase tracking-widest hover:bg-hotel-cream hover:text-hotel-gold rounded-xl transition-colors">
                                        <span class="material-symbols-outlined text-[16px]">history</span> Lịch Sử Đặt
                                    </a>
                                    <div class="h-px bg-hotel-gold/10 my-1"></div>
                                    <a href="${pageContext.request.contextPath}/logout"
                                        class="flex items-center gap-3 px-4 py-3 text-[12px] font-bold text-red-400 uppercase tracking-widest hover:bg-red-50 rounded-xl transition-colors">
                                        <span class="material-symbols-outlined text-[16px]">logout</span> Đăng Xuất
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>

    <!-- ══════════════ HERO ══════════════ -->
    <section class="relative h-[500px] overflow-hidden mt-[72px]">
        <div class="absolute inset-0">
            <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2000"
                 class="w-full h-full object-cover scale-105 transition-transform duration-[20s] hover:scale-100" alt="Hotel Hero">
            <div class="absolute inset-0 bg-gradient-to-b from-black/50 via-black/30 to-black/60"></div>
            <!-- Decorative lines -->
            <div class="absolute inset-x-0 bottom-0 h-px bg-gradient-to-r from-transparent via-hotel-gold/50 to-transparent"></div>
        </div>
        <div class="relative h-full flex flex-col items-center justify-center text-center px-6 gap-6">
            <div class="flex items-center gap-4">
                <div class="w-14 h-px bg-hotel-gold/60"></div>
                <span class="text-hotel-gold text-[11px] font-bold tracking-[0.4em] uppercase">Không Gian Nghỉ Dưỡng</span>
                <div class="w-14 h-px bg-hotel-gold/60"></div>
            </div>
            <h1 class="text-5xl md:text-7xl font-serif text-white leading-tight tracking-tight">
                Khám Phá<br/>
                <em class="text-hotel-gold not-italic font-normal">Không Gian Nghỉ Dưỡng.</em>
            </h1>
            <p class="text-white/65 text-base font-sans max-w-xl leading-relaxed">
                Sự kết hợp hoàn hảo giữa thiết kế đương đại và dịch vụ tận tâm, mang đến trải nghiệm lưu trú đẳng cấp tại trung tâm thành phố.
            </p>
            <div class="flex flex-col items-center gap-2 mt-2">
                <span class="text-[11px] text-hotel-gold/80 font-semibold uppercase tracking-widest">Cuộn để tận hưởng</span>
                <div class="w-0.5 h-10 bg-hotel-gold/30 rounded-full relative overflow-hidden">
                    <div class="absolute top-0 left-0 w-full bg-hotel-gold h-1/2 animate-bounce"></div>
                </div>
            </div>
        </div>
    </section>

    <!-- ══════════════ COLLECTION HEADER ══════════════ -->
    <main class="max-w-[1600px] mx-auto w-full px-6 md:px-12 pt-20 pb-28">
        <div class="mb-16 text-center space-y-5">
            <div class="inline-flex items-center gap-3 px-5 py-2 rounded-full bg-hotel-gold/8 border border-hotel-gold/20 text-hotel-gold text-[11px] font-bold uppercase tracking-[0.35em]">
                Không Gian Lưu Trú
            </div>
            <h2 class="text-5xl md:text-7xl font-serif text-hotel-text tracking-tight">
                Bộ Sưu Tập <em class="text-hotel-gold not-italic">Thượng Lưu.</em>
            </h2>
            <p class="text-hotel-muted text-[11px] font-bold tracking-[0.4em] uppercase border-t border-hotel-gold/10 pt-6 inline-block">
                Tinh hoa nghệ thuật nghỉ dưỡng hiện đại
            </p>
        </div>

        <!-- ══════════════ ROOM GRID ══════════════ -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 xl:gap-10">
            <c:forEach items="${rooms}" var="room">
                <c:set var="roomImg" value="${room.primaryImageUrl}" />
                <c:if test="${empty roomImg}">
                    <%-- Ảnh fallback riêng cho từng hạng phòng --%>
                    <c:choose>
                        <c:when test="${fn:containsIgnoreCase(room.roomType.typeName, 'Suite')}">
                            <c:set var="roomImg" value="https://images.unsplash.com/photo-1595576508898-0ad5c879a061?q=80&w=1000" />
                        </c:when>
                        <c:when test="${fn:containsIgnoreCase(room.roomType.typeName, 'VIP') or fn:containsIgnoreCase(room.roomType.typeName, 'Presidential')}">
                            <c:set var="roomImg" value="https://images.unsplash.com/photo-1578683010236-d716f9a3f461?q=80&w=1000" />
                        </c:when>
                        <c:when test="${fn:containsIgnoreCase(room.roomType.typeName, 'Deluxe') or fn:containsIgnoreCase(room.roomType.typeName, 'Superior')}">
                            <c:set var="roomImg" value="https://images.unsplash.com/photo-1591088398332-8a7791972843?q=80&w=1000" />
                        </c:when>
                        <c:otherwise>
                            <%-- Standard / mặc định --%>
                            <c:set var="roomImg" value="https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=1000" />
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${not fn:startsWith(roomImg, 'http')}">
                    <c:set var="roomImg" value="${pageContext.request.contextPath}/${roomImg}" />
                </c:if>

                <div class="room-card rounded-[28px] overflow-hidden group flex flex-col">

                    <!-- Image -->
                    <div class="relative h-[260px] overflow-hidden shrink-0">
                        <img src="${roomImg}"
                            class="w-full h-full object-cover group-hover:scale-108 transition-transform duration-[1.8s] ease-out"
                            alt="Phòng ${room.roomNumber}"
                            onerror="this.src='https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=1000'">
                        <!-- Overlay gradient -->
                        <div class="absolute inset-0 bg-gradient-to-t from-black/55 via-black/10 to-transparent group-hover:from-black/70 transition-all duration-700"></div>

                        <!-- Badge: Còn Trống top-right -->
                        <div class="absolute top-4 right-4">
                            <span class="badge-available text-white text-[10px] font-bold tracking-widest uppercase px-3 py-1.5 rounded-full shadow-lg">
                                Còn Trống
                            </span>
                        </div>

                        <!-- Hover label bottom -->
                        <div class="absolute inset-x-0 bottom-0 p-5 translate-y-3 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-500">
                            <span class="text-[10px] font-bold tracking-widest uppercase text-white/90 border border-white/30 bg-white/15 backdrop-blur-sm px-3 py-1.5 rounded-full">
                                Khám Phá Thêm →
                            </span>
                        </div>
                    </div>

                    <!-- Card Content -->
                    <div class="p-7 flex flex-col flex-1 gap-5">

                        <!-- Title & Price -->
                        <div class="flex items-start justify-between">
                            <div>
                                <h3 class="text-[28px] font-serif font-semibold text-hotel-text leading-none group-hover:text-hotel-gold transition-colors duration-400">
                                    P.${room.roomNumber}
                                </h3>
                                <p class="text-hotel-muted font-sans font-semibold text-[11px] uppercase tracking-[0.22em] mt-1">
                                    ${room.roomType.typeName}
                                </p>
                            </div>
                            <div class="text-right">
                                <p class="text-[24px] font-serif font-semibold text-hotel-gold leading-none">
                                    <fmt:formatNumber value="${room.price}" pattern="#,###" /><span class="text-[13px] font-sans font-normal text-hotel-muted ml-0.5">đ</span>
                                </p>
                                <p class="text-[10px] text-hotel-muted/70 uppercase tracking-[0.22em] font-bold mt-1">/ đêm</p>
                            </div>
                        </div>

                        <!-- Divider with stats -->
                        <div class="flex items-center gap-5 text-[11px] font-bold uppercase tracking-[0.18em] text-hotel-text/75 border-y border-hotel-gold/12 py-4 mt-auto">
                            <span class="flex items-center gap-1.5">
                                <span class="material-symbols-outlined text-hotel-gold text-[19px]">home_work</span>
                                Tầng ${room.floor}
                            </span>
                            <div class="w-px h-6 bg-hotel-gold/20"></div>
                            <span class="flex items-center gap-1.5">
                                <span class="material-symbols-outlined text-hotel-gold text-[19px]">group</span>
                                ${room.roomType.maxCapacity} Khách
                            </span>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-3">
                            <button
                                @click="
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
                                "
                                class="btn-outline-gold flex-1 py-3.5 rounded-2xl font-sans font-bold text-[11px] tracking-[0.22em] uppercase">
                                Chi Tiết
                            </button>
                            <a href="${empty sessionScope.acc
                                    ? pageContext.request.contextPath.concat('/login.jsp?redirect=booking&roomId=').concat(room.roomNumber)
                                    : pageContext.request.contextPath.concat('/webapp/search.jsp?roomId=').concat(room.roomNumber)}"
                                class="btn-gold flex-[1.6] py-3.5 rounded-2xl text-white font-sans font-bold text-[11px] tracking-[0.22em] uppercase flex items-center justify-center gap-2">
                                Đặt Ngay
                                <span class="material-symbols-outlined text-[16px]">calendar_month</span>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- ══════════════ ROOM DETAIL MODAL ══════════════ -->
    <div x-show="modalOpen" class="fixed inset-0 z-[200] flex items-center justify-center p-4 md:p-10" x-cloak>

        <!-- Backdrop -->
        <div class="absolute inset-0 bg-hotel-dark/80 backdrop-blur-2xl"
            @click="modalOpen = false; document.body.style.overflow = 'auto'"></div>

        <!-- Modal container -->
        <div class="relative w-full max-w-6xl bg-hotel-bone rounded-[32px] overflow-hidden flex flex-col md:flex-row modal-hotel shadow-[0_40px_120px_-20px_rgba(0,0,0,0.7)] border border-hotel-gold/15 max-h-[90vh]"
            @click.away="modalOpen = false; document.body.style.overflow = 'auto'">

            <!-- Close button -->
            <button @click="modalOpen = false; document.body.style.overflow = 'auto'"
                class="absolute top-6 right-6 z-[210] w-10 h-10 rounded-full bg-white/80 hover:bg-hotel-gold hover:text-white flex items-center justify-center text-hotel-text border border-hotel-gold/20 shadow-lg transition-all group">
                <span class="material-symbols-outlined text-[20px] group-hover:rotate-180 transition-transform duration-300">close</span>
            </button>

            <!-- ── Left: Image Gallery ── -->
            <div class="w-full md:w-1/2 flex flex-col overflow-hidden">
                <!-- Main image -->
                <div class="relative flex-1 min-h-[300px] md:min-h-0 overflow-hidden">
                    <img :src="activeImg"
                        class="w-full h-full object-cover transition-all duration-[1.2s]"
                        alt="Chi tiết phòng">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-transparent"></div>

                    <!-- Dot navigation -->
                    <div class="absolute bottom-8 left-1/2 -translate-x-1/2 flex gap-2.5">
                        <template x-for="(img, index) in gallery" :key="index">
                            <button @click="activeImg = img"
                                :class="activeImg === img ? 'bg-hotel-gold w-8' : 'bg-white/50 w-2.5'"
                                class="h-1.5 rounded-full transition-all duration-500 hover:bg-hotel-gold"></button>
                        </template>
                    </div>
                </div>

                <!-- Thumbnails -->
                <div class="p-5 bg-white/80 backdrop-blur-sm flex gap-3 justify-center border-t border-hotel-gold/10">
                    <template x-for="(img, index) in gallery" :key="index">
                        <img :src="img" @click="activeImg = img"
                            :class="activeImg === img ? 'active' : ''"
                            class="gallery-thumb w-[72px] h-[72px] rounded-xl object-cover cursor-pointer opacity-60 hover:opacity-100 transition-opacity">
                    </template>
                </div>
            </div>

            <!-- ── Right: Details ── -->
            <div class="w-full md:w-1/2 p-10 md:p-14 flex flex-col justify-between gap-8 overflow-y-auto">

                <!-- Title block -->
                <div class="space-y-3">
                    <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/8 border border-hotel-gold/20 text-hotel-gold text-[11px] font-bold uppercase tracking-[0.3em]">
                        Tuyệt Tác Không Gian
                    </div>
                    <h2 class="text-5xl md:text-6xl font-serif font-semibold text-hotel-text tracking-tight leading-none"
                        x-text="'PHÒNG ' + activeRoom.num"></h2>
                    <p class="text-2xl font-serif text-hotel-gold italic" x-text="activeRoom.type"></p>
                </div>

                <!-- Stats grid -->
                <div class="grid grid-cols-2 gap-6 py-8 border-y border-hotel-gold/12">
                    <div class="space-y-1.5">
                        <p class="text-hotel-muted text-[11px] font-bold uppercase tracking-widest">Giá Trải Nghiệm</p>
                        <p class="text-2xl font-serif font-semibold text-hotel-text"
                            x-text="Number(activeRoom.price).toLocaleString('vi-VN') + ' đ'"></p>
                        <p class="text-[10px] text-hotel-muted uppercase tracking-widest">mỗi đêm</p>
                    </div>
                    <div class="space-y-1.5">
                        <p class="text-hotel-muted text-[11px] font-bold uppercase tracking-widest">Sức Chứa Tối Đa</p>
                        <p class="text-2xl font-serif font-semibold text-hotel-text"
                            x-text="activeRoom.cap + ' Khách'"></p>
                    </div>
                </div>

                <!-- Description -->
                <div class="space-y-3">
                    <h4 class="text-[11px] font-bold text-hotel-muted uppercase tracking-[0.3em]">Mô Tả Chi Tiết</h4>
                    <p class="text-hotel-muted font-sans leading-relaxed text-[15px]"
                        x-text="activeRoom.desc || 'Không gian yên bình, nơi sự sang trọng hòa quyện cùng sự tinh tế, mang đến trải nghiệm nghỉ dưỡng hoàn hảo.'">
                    </p>
                </div>

                <!-- CTA Button -->
                <div>
                    <a :href="${empty sessionScope.acc} ? '${pageContext.request.contextPath}/login.jsp?redirect=booking&roomId=' + activeRoom.num : '${pageContext.request.contextPath}/webapp/search.jsp?roomId=' + activeRoom.num"
                        class="btn-gold w-full py-5 rounded-2xl text-white font-bold text-[13px] tracking-[0.2em] uppercase text-center flex items-center justify-center gap-3">
                        <span>Khởi Tạo Đặt Phòng</span>
                        <span class="material-symbols-outlined text-[18px]">event_available</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/common/chat_box.jspf" />
</body>
</html>