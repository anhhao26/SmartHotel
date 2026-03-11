<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Immersive Welcome</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#11d493", "background-light": "#f6f8f7", "background-dark": "#10221c",
                        "glass-surface": "rgba(255, 255, 255, 0.08)", "glass-border": "rgba(255, 255, 255, 0.15)",
                    },
                    fontFamily: { display: ["Plus Jakarta Sans", "sans-serif"], },
                    backgroundImage: { 'hero-pattern': "linear-gradient(to bottom, rgba(16, 34, 28, 0.4), rgba(16, 34, 28, 0.85))", }
                },
            },
        }
    </script>
    <style>
        .glass-card { background: rgba(23, 48, 40, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); }
        .text-glow { text-shadow: 0 0 20px rgba(17, 212, 147, 0.3); }
    </style>
</head>
<body class="bg-background-dark text-slate-100 font-display antialiased selection:bg-primary selection:text-background-dark flex flex-col min-h-screen">
    
    <header class="fixed top-0 w-full z-50 transition-all duration-300 border-b border-glass-border bg-background-dark/80 backdrop-blur-md">
        <div class="max-w-[1440px] mx-auto px-6 h-20 flex items-center justify-between">
            <div class="flex items-center gap-3 text-white">
                <div class="w-8 h-8 flex items-center justify-center text-primary"><span class="material-symbols-outlined text-3xl">domain</span></div>
                <h2 class="text-white text-xl font-bold tracking-tight">SmartHotel</h2>
            </div>
            <a href="<%=request.getContextPath()%>/guest/register.jsp" class="hidden md:flex items-center justify-center rounded-lg h-10 px-5 bg-primary hover:bg-primary/90 text-background-dark text-sm font-bold transition-all shadow-[0_0_15px_rgba(17,212,147,0.3)]">Đăng Ký Ngay</a>
        </div>
    </header>

    <main class="flex-grow relative">
        <div class="absolute inset-0 z-0">
            <div class="w-full h-full bg-cover bg-center bg-no-repeat bg-fixed" style="background-image: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070');">
                <div class="absolute inset-0 bg-hero-pattern"></div>
            </div>
        </div>

        <div class="relative z-10 flex flex-col items-center justify-center min-h-screen px-4 pt-20 pb-12 text-center">
            <div class="space-y-6 mb-16 max-w-4xl mx-auto">
                <h1 class="text-5xl md:text-7xl font-black text-white tracking-tight text-glow leading-tight">SmartHotel</h1>
                <p class="text-lg md:text-xl text-slate-300 font-light max-w-2xl mx-auto">Trải nghiệm tương lai của sự sang trọng, nơi công nghệ hội tụ cùng lòng hiếu khách.</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-full max-w-5xl px-4">
                <a href="<%=request.getContextPath()%>/login.jsp" class="group glass-card rounded-2xl p-8 flex flex-col items-center gap-6 hover:bg-[#1e40af]/20 transition-all duration-300 hover:-translate-y-1 hover:border-blue-400/50">
                    <div class="w-16 h-16 rounded-full bg-blue-500/20 flex items-center justify-center text-blue-400 group-hover:text-white group-hover:bg-blue-500 transition-colors"><span class="material-symbols-outlined text-3xl">person</span></div>
                    <div class="space-y-2"><h3 class="text-xl font-bold text-white">Khách Hàng</h3><p class="text-sm text-slate-400">Đăng nhập để xem hồ sơ và đặt phòng.</p></div>
                    <button class="mt-auto w-full py-3 rounded-lg border border-blue-500/30 text-blue-300 text-sm font-bold group-hover:bg-blue-500 group-hover:text-white transition-all">Đăng nhập Khách</button>
                </a>

                <a href="<%=request.getContextPath()%>/guest/register.jsp" class="group glass-card rounded-2xl p-8 flex flex-col items-center gap-6 bg-primary/5 hover:bg-primary/10 border-primary/30 hover:border-primary transition-all duration-300 hover:-translate-y-1 relative overflow-hidden shadow-[0_0_30px_rgba(17,212,147,0.1)]">
                    <div class="absolute top-0 right-0 bg-primary text-[#10221c] text-[10px] font-bold px-3 py-1 rounded-bl-lg">NEW</div>
                    <div class="w-16 h-16 rounded-full bg-primary/20 flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-[#10221c] transition-colors"><span class="material-symbols-outlined text-3xl">card_membership</span></div>
                    <div class="space-y-2"><h3 class="text-xl font-bold text-white">Thành Viên Mới</h3><p class="text-sm text-slate-300">Tạo tài khoản để nhận ưu đãi VIP.</p></div>
                    <button class="mt-auto w-full py-3 rounded-lg bg-primary text-[#10221c] text-sm font-bold hover:bg-primary/90 transition-all">Đăng Ký Ngay</button>
                </a>

                <a href="<%=request.getContextPath()%>/reception/home.jsp" class="group glass-card rounded-2xl p-8 flex flex-col items-center gap-6 hover:bg-slate-700/30 transition-all duration-300 hover:-translate-y-1">
                    <div class="w-16 h-16 rounded-full bg-slate-500/20 flex items-center justify-center text-slate-400 group-hover:bg-slate-500 group-hover:text-white transition-colors"><span class="material-symbols-outlined text-3xl">badge</span></div>
                    <div class="space-y-2"><h3 class="text-xl font-bold text-white">Nhân Viên</h3><p class="text-sm text-slate-400">Cổng truy cập nghiệp vụ nội bộ khách sạn.</p></div>
                    <button class="mt-auto w-full py-3 rounded-lg border border-slate-600 text-slate-400 text-sm font-bold group-hover:border-white group-hover:text-white transition-all">Đăng nhập Nội bộ</button>
                </a>
            </div>
        </div>
    </main>

    <footer class="bg-background-dark border-t border-[#23483c] relative z-20">
        <div class="max-w-[1440px] mx-auto px-6 py-6 flex justify-between items-center text-[#92c9b7] text-sm">
            <div class="flex items-center gap-2"><span class="material-symbols-outlined text-primary">domain</span> <strong>SmartHotel</strong></div>
            <p>© 2026 SmartHotel. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>