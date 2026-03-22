<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>SmartHotel - Đăng Nhập Hội Viên</title>

    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;0,700;1,400;1,600&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        hotel: {
                            gold:  "#B89A6C",
                            cream: "#FAF9F6",
                            bone:  "#FDFCFB",
                            text:  "#2C2722",
                            muted: "#70685F",
                            dark:  "#17120f",
                        }
                    },
                    fontFamily: {
                        serif: ["Cormorant Garamond", "serif"],
                        sans:  ["Outfit", "sans-serif"],
                    }
                },
            },
        }
    </script>

    <style>
        /* ── Base ─────────────────── */
        *, *::before, *::after { box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: #F5F2EE; }

        /* ── Left Panel ─────────────── */
        .left-panel {
            position: relative;
            overflow: hidden;
        }
        .left-panel img {
            width: 100%; height: 100%;
            object-fit: cover;
            transform: scale(1.04);
            transition: transform 18s ease-out;
        }
        .left-panel:hover img { transform: scale(1); }
        .left-panel .panel-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(
                160deg,
                rgba(23,18,15,0.25) 0%,
                rgba(23,18,15,0.65) 60%,
                rgba(23,18,15,0.88) 100%
            );
        }
        /* Decorative gold lines */
        .left-panel .panel-lines {
            position: absolute;
            top: 48px; left: 48px;
            display: flex; gap: 6px;
        }
        .left-panel .panel-lines span {
            display: block; width: 2px; border-radius: 2px;
            background: linear-gradient(to bottom, #B89A6C, transparent);
        }

        /* ── Glass Card ─────────────── */
        .glass-form {
            background: rgba(255,252,249,0.97);
            backdrop-filter: blur(32px);
            -webkit-backdrop-filter: blur(32px);
            border: 1px solid rgba(184,154,108,0.12);
            box-shadow:
                0 0 0 1px rgba(255,255,255,0.6) inset,
                0 32px 64px -24px rgba(44,39,34,0.12),
                0 8px 24px -8px rgba(44,39,34,0.06);
            border-radius: 28px;
        }

        /* ── Input ─────────────────── */
        .input-luxury {
            width: 100%;
            height: 64px;
            padding-left: 52px;
            padding-right: 20px;
            font-family: 'Outfit', sans-serif;
            font-size: 15px;
            font-weight: 500;
            color: #2C2722;
            background: #ffffff;
            border: 1.5px solid rgba(184,154,108,0.18);
            border-radius: 16px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease, transform 0.3s ease;
        }
        .input-luxury::placeholder { color: rgba(112,104,95,0.38); }
        .input-luxury:focus {
            border-color: #B89A6C;
            box-shadow: 0 0 0 4px rgba(184,154,108,0.10), 0 12px 28px -10px rgba(184,154,108,0.18);
            transform: translateY(-1px);
        }

        /* Icon inside input */
        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
            color: #B89A6C;
            opacity: 0.38;
            transition: opacity 0.3s;
            pointer-events: none;
        }
        .input-group:focus-within .input-icon { opacity: 1; }

        /* ── Label ─────────────────── */
        .field-label {
            display: block;
            font-family: 'Outfit', sans-serif;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.22em;
            color: #70685F;
            margin-bottom: 10px;
            opacity: 0.75;
        }

        /* ── Primary CTA ─────────────── */
        .btn-primary {
            width: 100%;
            height: 62px;
            border: none;
            border-radius: 18px;
            cursor: pointer;
            font-family: 'Outfit', sans-serif;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.22em;
            text-transform: uppercase;
            color: #fff;
            background: linear-gradient(135deg, #c9a87c 0%, #9c7f52 100%);
            box-shadow: 0 10px 32px -8px rgba(184,154,108,0.55), 0 2px 8px -2px rgba(0,0,0,0.10);
            transition: transform 0.3s cubic-bezier(0.23,1,0.32,1), box-shadow 0.3s ease;
            display: flex; align-items: center; justify-content: center; gap: 14px;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 18px 40px -10px rgba(184,154,108,0.65), 0 4px 12px -4px rgba(0,0,0,0.12);
        }
        .btn-primary:active { transform: translateY(0); }
        .btn-primary .arrow { transition: transform 0.3s ease; }
        .btn-primary:hover .arrow { transform: translateX(6px); }

        /* ── Google Button ─────────────── */
        .btn-google {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            width: 100%; height: 56px;
            background: #fff;
            border: 1.5px solid rgba(184,154,108,0.20);
            border-radius: 16px;
            font-family: 'Outfit', sans-serif;
            font-size: 13px; font-weight: 600;
            letter-spacing: 0.08em;
            color: #2C2722;
            transition: border-color 0.3s, box-shadow 0.3s, transform 0.3s;
            text-decoration: none;
        }
        .btn-google:hover {
            border-color: #B89A6C;
            box-shadow: 0 8px 20px -8px rgba(184,154,108,0.25);
            transform: translateY(-2px);
        }

        /* ── Register Link ─────────────── */
        .btn-register {
            display: flex; align-items: center; justify-content: center;
            width: 100%; height: 56px;
            border: 1.5px solid rgba(184,154,108,0.28);
            border-radius: 16px;
            font-family: 'Outfit', sans-serif;
            font-size: 12px; font-weight: 700;
            letter-spacing: 0.18em; text-transform: uppercase;
            color: #B89A6C;
            text-decoration: none;
            transition: background 0.3s, color 0.3s, transform 0.3s, box-shadow 0.3s;
        }
        .btn-register:hover {
            background: linear-gradient(135deg, #c9a87c, #9c7f52);
            color: #fff;
            border-color: transparent;
            transform: translateY(-2px);
            box-shadow: 0 10px 28px -8px rgba(184,154,108,0.5);
        }

        /* ── Divider ─────────────────── */
        .divider { display: flex; align-items: center; gap: 16px; }
        .divider::before, .divider::after {
            content: ''; flex: 1; height: 1px;
            background: rgba(184,154,108,0.14);
        }
        .divider span {
            font-size: 10px; font-weight: 700; letter-spacing: 0.22em;
            text-transform: uppercase; color: rgba(112,104,95,0.5);
        }

        /* ── Animated bg orbs ─────────── */
        .orb {
            position: fixed; border-radius: 50%;
            filter: blur(100px); pointer-events: none; z-index: 0;
        }
        .orb-1 { width: 500px; height: 500px; background: rgba(184,154,108,0.08); top:-10%; right:-5%; }
        .orb-2 { width: 350px; height: 350px; background: rgba(184,154,108,0.05); bottom:5%; right:25%; }

        /* ── Password Eye ─────────────── */
        .eye-toggle {
            position: absolute; right: 16px; top: 50%; transform: translateY(-50%);
            background: none; border: none; cursor: pointer;
            color: #B89A6C; opacity: 0.45;
            transition: opacity 0.2s;
            display: flex; align-items: center;
        }
        .eye-toggle:hover { opacity: 1; }

        /* ── Entrance animation ──────── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .fade-up { animation: fadeUp 0.55s cubic-bezier(0.23,1,0.32,1) both; }
        .fade-up-1 { animation-delay: 0.05s; }
        .fade-up-2 { animation-delay: 0.12s; }
        .fade-up-3 { animation-delay: 0.19s; }
        .fade-up-4 { animation-delay: 0.26s; }
        .fade-up-5 { animation-delay: 0.33s; }
    </style>
</head>

<body class="antialiased min-h-screen overflow-hidden">

    <!-- Ambient orbs -->
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <main class="flex w-full min-h-screen relative z-10">

        <!-- ══ Left Panel: Cinematic Image ══ -->
        <div class="hidden lg:flex left-panel w-[52%]">
            <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=90&w=2670&auto=format&fit=crop" alt="SmartHotel Exterior">
            <div class="panel-overlay"></div>

            <!-- Decorative vertical lines -->
            <div class="panel-lines">
                <span style="height:60px; opacity:0.7;"></span>
                <span style="height:40px; opacity:0.4;"></span>
                <span style="height:80px; opacity:0.55;"></span>
            </div>

            <!-- Back to lobby button -->
            <div class="absolute top-8 left-10 z-20">
                <a href="${pageContext.request.contextPath}/"
                   class="inline-flex items-center gap-2 px-5 py-2.5 rounded-full text-white/80 text-[11px] font-bold uppercase tracking-[0.25em] transition-all duration-300"
                   style="background: rgba(255,255,255,0.10); border: 1px solid rgba(255,255,255,0.18); backdrop-filter: blur(10px);"
                   onmouseover="this.style.background='rgba(184,154,108,0.55)'; this.style.borderColor='rgba(184,154,108,0.7)'; this.style.color='#fff';"
                   onmouseout="this.style.background='rgba(255,255,255,0.10)'; this.style.borderColor='rgba(255,255,255,0.18)'; this.style.color='rgba(255,255,255,0.8)';">
                    <span class="material-symbols-outlined" style="font-size:16px;">arrow_back</span>
                    Quay về Sảnh
                </a>
            </div>

            <!-- Content bottom -->
            <div class="absolute bottom-0 left-0 right-0 p-14 z-10">
                <!-- Gold label -->
                <div class="flex items-center gap-3 mb-6">
                    <div class="w-8 h-px bg-hotel-gold"></div>
                    <span class="text-hotel-gold text-[10px] font-bold uppercase tracking-[0.45em]">SmartHotel Boutique</span>
                </div>

                <h1 class="font-serif text-white text-6xl leading-tight mb-5">
                    Hành trình<br><em class="text-hotel-gold">Tận Hưởng.</em>
                </h1>
                <p class="text-white/55 text-sm font-sans leading-relaxed tracking-wider max-w-sm">
                    Đăng nhập để tiếp tục trải nghiệm không gian nghỉ dưỡng tinh tế và các dịch vụ cá nhân hóa đỉnh cao.
                </p>

                <!-- Testimonial card -->
                <div class="mt-10 flex items-center gap-4 p-5 rounded-2xl border border-white/10 bg-white/6 backdrop-blur-md w-fit">
                    <div class="flex -space-x-2">
                        <img src="https://i.pravatar.cc/32?img=1" class="w-8 h-8 rounded-full border-2 border-white/30 object-cover" alt="">
                        <img src="https://i.pravatar.cc/32?img=5" class="w-8 h-8 rounded-full border-2 border-white/30 object-cover" alt="">
                        <img src="https://i.pravatar.cc/32?img=8" class="w-8 h-8 rounded-full border-2 border-white/30 object-cover" alt="">
                    </div>
                    <div>
                        <div class="flex gap-0.5 mb-1">
                            <span class="text-hotel-gold text-[12px]">★★★★★</span>
                        </div>
                        <p class="text-white/65 text-[11px] font-sans tracking-wide">+2,400 hội viên tin tưởng</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- ══ Right Panel: Login Form ══ -->
        <div class="w-full lg:w-[48%] flex flex-col items-center justify-center p-6 md:p-12 relative min-h-screen overflow-y-auto">

            <div class="w-full max-w-[420px] fade-up fade-up-1">

                <!-- Logo -->
                <div class="text-center mb-10 fade-up fade-up-1">
                    <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-3 mb-6">
                        <span class="material-symbols-outlined text-hotel-gold text-[30px]">local_hotel</span>
                        <span class="font-sans font-bold text-[17px] tracking-[0.25em] uppercase text-hotel-text">SmartHotel</span>
                    </a>
                    <h2 class="font-serif text-[40px] font-semibold text-hotel-text italic leading-tight">Hành trình mới.</h2>
                    <p class="text-hotel-muted text-[10px] font-bold uppercase tracking-[0.35em] mt-2 opacity-55">
                        Xác thực quyền truy cập hội viên
                    </p>
                </div>

                <!-- Form card -->
                <div class="glass-form p-8 md:p-10 space-y-6 fade-up fade-up-2">

                    <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-5">

                        <!-- Username -->
                        <div class="fade-up fade-up-3">
                            <label class="field-label">Tên Đăng Nhập</label>
                            <div class="input-group relative">
                                <span class="input-icon material-symbols-outlined">person</span>
                                <input
                                    class="input-luxury"
                                    name="username"
                                    required
                                    type="text"
                                    placeholder="Nhập tên đăng nhập của bạn"
                                    autocomplete="username" />
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="fade-up fade-up-4">
                            <label class="field-label">Mật Khẩu</label>
                            <div class="input-group relative">
                                <span class="input-icon material-symbols-outlined">lock</span>
                                <input
                                    class="input-luxury"
                                    id="password-input"
                                    name="password"
                                    required
                                    type="password"
                                    placeholder="Nhập mật khẩu"
                                    autocomplete="current-password"
                                    style="padding-right: 48px;" />
                                <button type="button" class="eye-toggle" onclick="togglePassword()" aria-label="Hiện/Ẩn mật khẩu">
                                    <span class="material-symbols-outlined text-[20px]" id="eye-icon">visibility</span>
                                </button>
                            </div>
                        </div>

                        <!-- Submit -->
                        <div class="pt-2 fade-up fade-up-5">
                            <button type="submit" class="btn-primary">
                                <span>Vào Sảnh Hội Viên</span>
                                <span class="material-symbols-outlined text-[20px] arrow">east</span>
                            </button>
                        </div>
                    </form>

                    <!-- Divider -->
                    <div class="divider fade-up fade-up-5">
                        <span>Hoặc tiếp tục với</span>
                    </div>

                    <!-- Google -->
                    <div class="fade-up fade-up-5">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/Hotelll/login/google&response_type=code&client_id=1078937497673-5046k9djoj4a9rfivr54qev9kjp202b0.apps.googleusercontent.com&prompt=consent"
                            class="btn-google">
                            <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google" class="w-5 h-5" />
                            Đăng nhập với Google
                        </a>
                    </div>
                </div>

                <!-- Register link -->
                <div class="mt-6 space-y-3 text-center fade-up fade-up-5">
                    <p class="text-hotel-muted text-[11px] font-bold uppercase tracking-[0.22em] opacity-60">Chưa có tài khoản?</p>
                    <a href="${pageContext.request.contextPath}/guest/register.jsp" class="btn-register">
                        Đăng ký tham gia hội viên
                    </a>
                </div>

                <!-- Footer -->
                <p class="text-center text-[10px] text-hotel-muted/40 uppercase tracking-[0.35em] mt-10 fade-up fade-up-5">
                    © 2026 SmartHotel Management &nbsp;•&nbsp; Harmony Interface V5
                </p>
            </div>
        </div>
    </main>

    <c:if test="${not empty param.err}">
        <script>window.onload = () => showToast("${param.err}", "error");</script>
    </c:if>
    <c:if test="${not empty requestScope.err}">
        <script>window.onload = () => showToast("${requestScope.err}", "error");</script>
    </c:if>

    <%@ include file="/common/toast.jspf" %>

    <script>
        function togglePassword() {
            const inp  = document.getElementById('password-input');
            const icon = document.getElementById('eye-icon');
            if (inp.type === 'password') {
                inp.type  = 'text';
                icon.textContent = 'visibility_off';
            } else {
                inp.type  = 'password';
                icon.textContent = 'visibility';
            }
        }
    </script>
</body>

</html>