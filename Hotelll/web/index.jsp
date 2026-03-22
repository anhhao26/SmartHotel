<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>SmartHotel - Trải Nghiệm Nghỉ Dưỡng Thượng Lưu</title>

        <!-- Premium Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
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
                                cream: "#FAF9F6",
                                bone: "#FDFCFB",
                                gold: "#B89A6C",
                                chocolate: "#4A4238",
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
            body {
                background-color: #FAF9F6;
                color: #2C2722;
            }

            .luxury-shadow {
                box-shadow: 0 20px 50px -15px rgba(74, 66, 56, 0.1);
            }

            .hero-pattern {
                background-color: #FAF9F6;
                background-image: radial-gradient(#B89A6C 0.5px, transparent 0.5px);
                background-size: 24px 24px;
                opacity: 0.15;
            }

            .navbar-blur {
                background: rgba(250, 249, 246, 0.8);
                backdrop-filter: blur(10px);
            }

            .btn-luxury {
                background: #B89A6C;
                color: white;
                transition: all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
                font-family: 'Inter', sans-serif;
            }

            .btn-luxury:hover {
                background: #4A4238;
                transform: translateY(-2px);
                box-shadow: 0 10px 20px -5px rgba(74, 66, 56, 0.3);
            }

            .card-elegant {
                background: #FFFFFF;
                border: 1px solid rgba(184, 154, 108, 0.1);
                transition: all 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
            }

            .card-elegant:hover {
                transform: translateY(-10px);
                border-color: #B89A6C;
                box-shadow: 0 30px 60px -20px rgba(74, 66, 56, 0.15);
            }

            .serif-italic {
                font-family: 'Cormorant Garamond', serif;
                font-style: italic;
            }

            .image-zoom-container {
                overflow: hidden;
            }

            .image-zoom-container img {
                transition: transform 1.5s ease;
            }

            .image-zoom-container:hover img {
                transform: scale(1.05);
            }
        </style>
    </head>

    <body class="font-sans antialiased text-hotel-text selection:bg-hotel-gold selection:text-white">

        <!-- Header Navigation -->
        <header class="fixed top-0 w-full z-50 transition-all duration-500 navbar-blur border-b border-hotel-gold/10">
            <div class="max-w-7xl mx-auto px-6 h-24 flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-hotel-gold text-3xl">local_hotel</span>
                    <h2 class="font-serif text-2xl font-semibold tracking-widest uppercase text-hotel-text">SmartHotel
                    </h2>
                </div>

                <nav class="hidden md:flex items-center gap-8">
                    <a href="${pageContext.request.contextPath}/rooms"
                        class="text-xs font-semibold uppercase tracking-widest text-hotel-muted hover:text-hotel-gold transition-colors">Bộ
                        Sưu Tập</a>
                    
                    <c:choose>
                        <c:when test="${empty sessionScope.acc}">
                            <a href="${pageContext.request.contextPath}/login.jsp"
                                class="text-xs font-semibold uppercase tracking-widest text-hotel-muted hover:text-hotel-gold transition-colors">ĐĂNG NHẬP</a>
                            <a href="${pageContext.request.contextPath}/guest/register.jsp"
                                class="btn-luxury px-12 py-6 rounded-sm text-base font-bold uppercase tracking-[0.2em] shadow-2xl hover:bg-hotel-chocolate transition-all">ĐĂNG KÝ THÀNH VIÊN</a>
                        </c:when>
                        <c:otherwise>
                            <div class="relative group" x-data="{ open: false }">
                                <button @click="open = !open" @click.away="open = false" 
                                    class="flex items-center gap-4 py-3 px-8 bg-white/50 border border-hotel-gold/20 rounded-full hover:border-hotel-gold/40 transition-all shadow-lg">
                                    <span class="material-symbols-outlined text-hotel-gold text-sm">person</span>
                                    <span class="text-base font-bold uppercase tracking-[0.2em] text-hotel-text">
                                        Chào, ${sessionScope.acc.username}
                                    </span>
                                    <span class="material-symbols-outlined text-hotel-gold text-xs transition-transform group-hover:rotate-180">expand_more</span>
                                </button>
                                
                                <div x-show="open" 
                                     x-transition:enter="transition ease-out duration-200"
                                     x-transition:enter-start="opacity-0 translate-y-1"
                                     x-transition:enter-end="opacity-100 translate-y-0"
                                     class="absolute right-0 mt-4 w-60 bg-white rounded-xl shadow-2xl border border-hotel-gold/5 overflow-hidden z-[60]">
                                    <div class="p-2">
                                        <a href="${pageContext.request.contextPath}/guest/profile.jsp" 
                                           class="flex items-center gap-3 px-5 py-4 text-base font-bold text-hotel-muted uppercase tracking-widest hover:bg-hotel-cream hover:text-hotel-gold rounded-lg transition-colors">
                                            <span class="material-symbols-outlined text-sm">person_outline</span> THÔNG TIN
                                        </a>
                                        <a href="${pageContext.request.contextPath}/guest/history.jsp" 
                                           class="flex items-center gap-3 px-5 py-4 text-base font-bold text-hotel-muted uppercase tracking-widest hover:bg-hotel-cream hover:text-hotel-gold rounded-lg transition-colors">
                                            <span class="material-symbols-outlined text-sm">history</span> LỊCH SỬ ĐẶT
                                        </a>
                                        <div class="h-px bg-hotel-gold/5 my-2"></div>
                                        <a href="${pageContext.request.contextPath}/logout" 
                                           class="flex items-center gap-3 px-5 py-5 text-base font-bold text-red-400 uppercase tracking-widest hover:bg-red-50 rounded-lg transition-colors">
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

        <main class="pt-24 min-h-screen">
            <!-- Hero Section -->
            <section class="relative h-[85vh] flex items-center justify-center overflow-hidden">
                <div class="absolute inset-0 z-0">
                    <video autoplay loop muted playsinline class="w-full h-full object-cover brightness-95">
                        <source src="${pageContext.request.contextPath}/background.mp4" type="video/mp4">
                    </video>
                    <div class="absolute inset-0 bg-gradient-to-b from-hotel-cream/20 via-transparent to-hotel-cream">
                    </div>
                </div>

                <div class="relative z-10 text-center space-y-8 px-6 max-w-4xl">
                    <div class="inline-block py-2 px-6 border-b border-hotel-gold/30 mb-6">
                        <span class="text-hotel-gold text-sm md:text-base font-bold uppercase tracking-[0.5em]">Hài Hòa & Tinh Tế</span>
                    </div>
                    <h1 class="text-7xl md:text-9xl font-serif leading-tight text-white drop-shadow-xl">
                        Nơi Cảm Xúc <br> <span class="serif-italic text-hotel-gold">Được Thăng Hoa.</span>
                    </h1>
                    <p class="text-white/90 text-lg md:text-xl font-medium tracking-widest uppercase max-w-3xl mx-auto leading-loose drop-shadow-md">
                        Khám phá không gian nghỉ dưỡng đỉnh cao, nơi di sản kiến trúc hòa quyện cùng nghệ thuật hiếu khách tận tâm.
                    </p>
                    <div class="pt-10">
                        <a href="#welcome"
                            class="inline-flex items-center gap-3 text-hotel-gold text-sm md:text-base font-bold uppercase tracking-widest hover:gap-5 transition-all drop-shadow-md">
                            Khám phá ngay <span class="material-symbols-outlined text-lg">arrow_downward</span>
                        </a>
                    </div>
                </div>
            </section>

            <!-- Access Nodes Section -->
            <section id="welcome" class="py-32 px-6 bg-hotel-cream relative">
                <div class="hero-pattern absolute inset-0"></div>
                <div class="max-w-7xl mx-auto relative z-10">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-12">

                        <c:choose>
                            <c:when test="${not empty sessionScope.acc}">
                                <!-- Đã đăng nhập: Card Đặt Phòng -->
                                <a href="<%=request.getContextPath()%>/rooms"
                                    class="card-elegant p-10 flex flex-col group min-h-[450px]">
                                    <div class="image-zoom-container h-48 mb-10 rounded-sm">
                                        <img src="loyal_customer_premium.png"
                                            class="w-full h-full object-cover grayscale-[0.3] group-hover:grayscale-0">
                                    </div>
                                    <div class="space-y-4">
                                        <span class="text-hotel-gold text-sm uppercase font-bold tracking-[0.3em]">Đặt Phòng</span>
                                        <h3 class="text-3xl font-serif text-hotel-text">Đặt Phòng Ngay</h3>
                                        <p class="text-hotel-muted text-sm leading-relaxed font-light">
                                            Chọn phòng lý tưởng cho kỳ nghỉ của bạn. Khám phá các không gian đẳng cấp và đặt phòng chỉ trong vài bước.
                                        </p>
                                    </div>
                                    <div class="mt-auto pt-8 flex items-center text-hotel-gold text-sm font-bold uppercase tracking-widest group-hover:gap-4 transition-all">
                                        Đặt ngay <span class="material-symbols-outlined text-sm ml-2">east</span>
                                    </div>
                                </a>

                                <!-- Đã đăng nhập: Card Lịch Sử Đặt -->
                                <a href="<%=request.getContextPath()%>/guest/history.jsp"
                                    class="card-elegant p-10 flex flex-col group md:-translate-y-12 bg-hotel-bone border-hotel-gold/30 min-h-[450px]">
                                    <div class="image-zoom-container h-48 mb-10 rounded-sm">
                                        <img src="existing_member_premium.png"
                                            class="w-full h-full object-cover">
                                    </div>
                                    <div class="space-y-4">
                                        <span class="text-hotel-gold text-sm uppercase font-bold tracking-[0.3em]">Hành Trình</span>
                                        <h3 class="text-3xl font-serif text-hotel-text">Lịch Sử Đặt Phòng</h3>
                                        <p class="text-hotel-muted text-sm leading-relaxed font-light">
                                            Xem lại các kỳ nghỉ đã qua, theo dõi đặt phòng hiện tại và tận hưởng ưu đãi thành viên của bạn.
                                        </p>
                                    </div>
                                    <div class="mt-auto pt-8">
                                        <div class="w-full py-7 bg-hotel-gold text-white text-center text-base font-bold uppercase tracking-[0.3em] group-hover:bg-hotel-chocolate transition-all shadow-2xl">
                                            Xem Lịch Sử
                                        </div>
                                    </div>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <!-- Chưa đăng nhập: Card Khách Hàng Cũ -->
                                <a href="<%=request.getContextPath()%>/login.jsp"
                                    class="card-elegant p-10 flex flex-col group min-h-[450px]">
                                    <div class="image-zoom-container h-48 mb-10 rounded-sm">
                                        <img src="loyal_customer_premium.png"
                                            class="w-full h-full object-cover grayscale-[0.3] group-hover:grayscale-0">
                                    </div>
                                    <div class="space-y-4">
                                        <span class="text-hotel-gold text-sm uppercase font-bold tracking-[0.3em]">Hội Viên</span>
                                        <h3 class="text-3xl font-serif text-hotel-text">Khách Hàng Cũ</h3>
                                        <p class="text-hotel-muted text-sm leading-relaxed font-light">
                                            Chào mừng bạn quay lại. Hãy đăng nhập để quản lý kỳ nghỉ và tận hưởng ưu đãi dành riêng cho thành viên.
                                        </p>
                                    </div>
                                    <div class="mt-auto pt-8 flex items-center text-hotel-gold text-sm font-bold uppercase tracking-widest group-hover:gap-4 transition-all">
                                        Tiếp tục hành trình <span class="material-symbols-outlined text-sm ml-2">east</span>
                                    </div>
                                </a>

                                <!-- Chưa đăng nhập: Card Khách Hàng Mới -->
                                <a href="<%=request.getContextPath()%>/guest/register.jsp"
                                    class="card-elegant p-10 flex flex-col group md:-translate-y-12 bg-hotel-bone border-hotel-gold/30 min-h-[450px]">
                                    <div class="image-zoom-container h-48 mb-10 rounded-sm">
                                        <img src="welcome_new_guest_premium.png"
                                            class="w-full h-full object-cover">
                                    </div>
                                    <div class="space-y-4">
                                        <span class="text-hotel-gold text-sm uppercase font-bold tracking-[0.3em]">Bắt Đầu</span>
                                        <h3 class="text-3xl font-serif text-hotel-text">Khách Hàng Mới</h3>
                                        <p class="text-hotel-muted text-sm leading-relaxed font-light">
                                            Trở thành một phần của cộng đồng tinh hoa. Đăng ký ngay để nhận những đặc quyền không giới hạn tại SmartHotel.
                                        </p>
                                    </div>
                                    <div class="mt-auto pt-8">
                                        <div class="w-full py-7 bg-hotel-gold text-white text-center text-base font-bold uppercase tracking-[0.3em] group-hover:bg-hotel-chocolate transition-all shadow-2xl">
                                            Tham Gia Ngay
                                        </div>
                                    </div>
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <!-- Staff Portal -->
                        <a href="<%=request.getContextPath()%>/reception/home.jsp"
                            class="card-elegant p-10 flex flex-col group min-h-[450px]">
                            <div class="image-zoom-container h-48 mb-10 rounded-sm">
                                <img src="staff_portal_professional.png"
                                    class="w-full h-full object-cover grayscale-[0.3] group-hover:grayscale-0">
                            </div>
                            <div class="space-y-4">
                                <span class="text-hotel-gold text-sm uppercase font-bold tracking-[0.3em]">Vận
                                    Hành</span>
                                <h3 class="text-3xl font-serif text-hotel-text">Điều Hành Viên</h3>
                                <p class="text-hotel-muted text-sm leading-relaxed font-light">
                                    Cổng quản trị dành riêng cho cán bộ nhân viên để đảm bảo chất lượng dịch vụ đẳng cấp
                                    5 sao.
                                </p>
                            </div>
                            <div
                                class="mt-auto pt-8 flex items-center text-hotel-text text-sm font-bold uppercase tracking-widest group-hover:gap-4 transition-all">
                                Cổng Nhân Viên <span
                                    class="material-symbols-outlined text-sm ml-2 text-hotel-gold">key</span>
                            </div>
                        </a>

                    </div>
                </div>
            </section>
        </main>

        <footer class="bg-hotel-bone py-20 border-t border-hotel-gold/10">
            <div class="max-w-7xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-10">
                <div class="flex flex-col gap-4">
                    <div class="flex items-center gap-3">
                        <span class="material-symbols-outlined text-hotel-gold">stars</span>
                        <span class="text-hotel-text font-serif text-xl tracking-widest uppercase">SmartHotel</span>
                    </div>
                    <p class="text-sm text-hotel-muted uppercase tracking-[0.4em] font-medium">Boutique Collection •
                        Global Edition</p>
                </div>

                <div class="flex flex-col items-center md:items-end gap-2">
                    <p class="text-sm text-hotel-muted uppercase tracking-widest">© 2026 SmartHotel. Kiến tạo những
                        trải nghiệm tinh tế.</p>
                    <div class="flex gap-6 mt-4">
                        <a href="#"
                            class="text-sm text-hotel-gold uppercase tracking-[0.2em] font-bold hover:text-hotel-chocolate">Facebook</a>
                        <a href="#"
                            class="text-sm text-hotel-gold uppercase tracking-[0.2em] font-bold hover:text-hotel-chocolate">Instagram</a>
                        <a href="#"
                            class="text-sm text-hotel-gold uppercase tracking-[0.2em] font-bold hover:text-hotel-chocolate">Twitter</a>
                    </div>
                </div>
            </div>
        </footer>

        <script>
            // Smooth scroll for anchors
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });

            // Simple Fade In Effect
            const observerOptions = {
                threshold: 0.1
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.card-elegant').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = 'all 1s cubic-bezier(0.165, 0.84, 0.44, 1)';
                observer.observe(card);
            });
        </script>
        <jsp:include page="/common/chat_box.jspf" />
    </body>

    </html>