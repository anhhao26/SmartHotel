<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>SmartHotel - Đăng Nhập Hội Viên</title>

            <!-- Premium Google Fonts -->
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
                body {
                    background-color: #FAF9F6;
                    color: #2C2722;
                }

                .input-elegant {
                    background: #FFFFFF;
                    border: 1px solid rgba(184, 154, 108, 0.1);
                    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                    font-family: 'Inter', sans-serif;
                }

                .input-elegant:focus {
                    outline: none;
                    border-color: #B89A6C;
                    background: #FFFFFF;
                    box-shadow: 0 15px 30px -10px rgba(184, 154, 108, 0.15);
                    transform: translateY(-2px);
                }

                .btn-hotel-gold {
                    background: #B89A6C;
                    color: white;
                    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                    box-shadow: 0 10px 25px -5px rgba(184, 154, 108, 0.4);
                    letter-spacing: 0.2em;
                }

                .btn-hotel-gold:hover {
                    background: #2C2722;
                    transform: translateY(-3px);
                    box-shadow: 0 20px 40px -10px rgba(44, 39, 34, 0.3);
                }

                .social-light {
                    background: #FFFFFF;
                    border: 1px solid rgba(184, 154, 108, 0.1);
                    transition: all 0.3s ease;
                }

                .social-light:hover {
                    border-color: #B89A6C;
                    background: #FDFCFB;
                    transform: translateY(-3px);
                    box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.05);
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

        <body class="font-sans antialiased min-h-screen relative overflow-hidden bg-hotel-cream">

            <main class="flex w-full h-screen overflow-hidden">

                <!-- Left Half: Cinematic Imagery -->
                <div class="hidden lg:flex w-[50%] relative overflow-hidden">
                    <div class="absolute inset-0 bg-black/10 z-10"></div>
                    <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2670&auto=format&fit=crop"
                        class="absolute inset-0 w-full h-full object-cover grayscale-[0.2]" alt="SmartHotel Entrance">

                    <div
                        class="relative z-20 flex flex-col justify-end p-20 h-full max-w-2xl bg-gradient-to-t from-hotel-text/80 to-transparent">
                        <div class="mb-6">
                            <span class="text-hotel-gold text-xs font-bold uppercase tracking-[0.4em]">SmartHotel
                                Boutique</span>
                        </div>
                        <h1 class="text-6xl font-serif text-white leading-tight mb-6">
                            Hành trình <br> <span class="italic text-hotel-gold">Tận Hưởng.</span>
                        </h1>
                        <p class="text-white/70 text-sm font-light leading-relaxed tracking-wider uppercase">
                            Đăng nhập để tiếp tục trải nghiệm không gian nghỉ dưỡng tinh tế và các dịch vụ cá nhân hóa
                            đỉnh cao.
                        </p>
                    </div>
                </div>

                <!-- Right Half: Login Portal -->
                <div class="w-full lg:w-[50%] flex flex-col relative bg-hotel-cream items-center justify-center p-8 overflow-y-auto min-h-screen">

                    <div class="w-full max-w-md pt-12 lg:pt-0 space-y-8">
                        <!-- Branding & Header -->
                        <div class="text-center space-y-3">
                            <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-3 mb-2">
                                <span class="material-symbols-outlined text-hotel-gold text-3xl">local_hotel</span>
                                <h2 class="font-serif text-xl font-bold tracking-widest uppercase text-hotel-text">
                                    SmartHotel</h2>
                            </a>
                            <h3 class="text-4xl font-serif font-bold text-hotel-text italic">Hành trình mới.</h3>
                            <p class="text-hotel-muted text-[9px] font-bold uppercase tracking-[0.4em] opacity-60">Xác
                                thực quyền truy cập hội viên</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-8">

                            <!-- Username Field -->
                            <div class="space-y-2">
                                <label class="label-premium ml-2">Tên Đăng Nhập</label>
                                <div class="relative group">
                                    <span
                                        class="material-symbols-outlined absolute left-6 top-1/2 -translate-y-1/2 text-hotel-gold opacity-30 group-focus-within:opacity-100 transition-opacity">person</span>
                                    <input
                                        class="w-full h-20 pl-14 pr-8 input-elegant rounded-xl text-[16px] font-semibold text-hotel-text placeholder:text-hotel-muted/20"
                                        name="username" required type="text" placeholder="Nhập tên đăng nhập của bạn" />
                                </div>
                            </div>

                            <!-- Password Field -->
                            <div class="space-y-2">
                                <label class="label-premium ml-2">Mật Khẩu</label>
                                <div class="relative group">
                                    <span
                                        class="material-symbols-outlined absolute left-6 top-1/2 -translate-y-1/2 text-hotel-gold opacity-30 group-focus-within:opacity-100 transition-opacity">lock</span>
                                    <input
                                        class="w-full h-20 pl-14 pr-8 input-elegant rounded-xl text-[16px] font-semibold text-hotel-text tracking-[0.5em] placeholder:tracking-normal placeholder:text-hotel-muted/20"
                                        name="password" required type="password" placeholder="••••••••" />
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="pt-6">
                                <button type="submit"
                                    class="w-full h-18 px-[30px] rounded-2xl font-bold text-[14px] tracking-[0.4em] uppercase btn-hotel-gold flex items-center justify-center gap-6 group shadow-2xl hover:shadow-hotel-gold/40">
                                    VÀO SẢNH HỘI VIÊN <span
                                        class="material-symbols-outlined text-xl group-hover:translate-x-3 transition-transform">east</span>
                                </button>
                            </div>

                            <!-- Divider -->
                            <div class="relative flex items-center py-4">
                                <div class="flex-grow border-t border-hotel-gold/10"></div>
                                <span
                                    class="flex-shrink-0 mx-6 text-hotel-muted text-[8px] font-bold tracking-[0.3em] uppercase opacity-40">Hoặc
                                    tiếp tục với</span>
                                <div class="flex-grow border-t border-hotel-gold/10"></div>
                            </div>

                            <!-- Social Login -->
                            <div class="flex justify-center">
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/Hotelll/login/google&response_type=code&client_id=1078937497673-5046k9djoj4a9rfivr54qev9kjp202b0.apps.googleusercontent.com&prompt=consent"
                                    class="social-light flex justify-center items-center h-16 w-full max-w-xs rounded-sm gap-3 font-bold text-[9px] uppercase tracking-widest text-hotel-muted hover:text-hotel-gold">
                                    <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google"
                                        class="w-5 h-5" />
                                    Google
                                </a>
                            </div>
                        </form>

                        <div class="pt-6 text-center border-t border-hotel-gold/5">
                            <p class="text-[11px] font-bold text-hotel-muted uppercase tracking-[0.2em] mb-4">
                                Chưa có tài khoản?
                            </p>
                            <a href="${pageContext.request.contextPath}/guest/register.jsp"
                                class="inline-flex items-center justify-center px-12 h-14 border border-hotel-gold/30 rounded-xl text-hotel-gold hover:bg-hotel-gold hover:text-white font-bold text-[10px] tracking-widest uppercase transition-all shadow-sm">
                                Đăng ký tham gia hội viên
                            </a>
                        </div>
                    </div>

                    <!-- Footer Small -->
                    <div class="absolute bottom-8 text-[8px] text-hotel-muted uppercase tracking-[0.4em] opacity-40">
                        © 2026 SmartHotel Management • Harmony Interface V4
                    </div>
                </div>
            </main>

            <%-- Error Handling with Toast --%>
                <c:if test="${not empty param.err}">
                    <script>window.onload = () => showToast("${param.err}", "error");</script>
                </c:if>
                <% String authErr=(String) request.getAttribute("err"); if (authErr !=null) { %>
                    <script>window.onload = () => showToast("<%= authErr %>", "error");</script>
                    <% } %>

                        <%@ include file="/common/toast.jspf" %>
        </body>

        </html>