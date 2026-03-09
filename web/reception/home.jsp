<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String currentRole = (String) session.getAttribute("ROLE");
    boolean isAdmin = currentRole != null && (currentRole.equalsIgnoreCase("ADMIN") || currentRole.equalsIgnoreCase("MANAGER") || currentRole.equalsIgnoreCase("SUPERADMIN"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel Reception Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "primary": "#1069f9", "secondary": "#ef4444", 
                        "background-light": "#f5f7f8", "background-dark": "#0f1723",
                        "surface-light": "#ffffff", "surface-dark": "#1e293b",
                        "border-light": "#e2e8f0", "border-dark": "#334155",
                    },
                    fontFamily: { "display": ["Manrope", "sans-serif"] },
                },
            },
        }
    </script>
    <style>
        body { font-family: 'Manrope', sans-serif; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark min-h-screen flex flex-col font-display text-slate-900 dark:text-slate-100 transition-colors duration-200">
    
    <header class="sticky top-0 z-50 bg-surface-light dark:bg-surface-dark border-b border-border-light dark:border-border-dark px-6 py-4 shadow-sm">
        <div class="mx-auto max-w-[1440px] flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-primary/10 text-primary">
                    <span class="material-symbols-outlined text-2xl">apartment</span>
                </div>
                <div>
                    <h1 class="text-xl font-bold tracking-tight text-slate-900 dark:text-white">SmartHotel</h1>
                    <p class="text-xs font-medium text-slate-500 dark:text-slate-400">Reception Console v3.0</p>
                </div>
            </div>
            <div class="flex items-center gap-6">
                <div class="hidden md:flex items-center gap-2 px-3 py-1.5 rounded-lg bg-slate-100 dark:bg-slate-800 border border-slate-200 dark:border-slate-700">
                    <span class="relative flex h-2.5 w-2.5">
                        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                        <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-green-500"></span>
                    </span>
                    <span class="text-xs font-medium text-slate-600 dark:text-slate-300">System Online</span>
                </div>
                
                <div class="flex items-center gap-4 pl-6 border-l border-slate-200 dark:border-slate-700">
                    <% if (isAdmin) { %>
                        <a href="<%=request.getContextPath()%>/admin" class="text-sm font-bold text-slate-600 hover:text-primary transition-colors flex items-center gap-1">
                            <span class="material-symbols-outlined text-[18px]">admin_panel_settings</span> Quay lại Admin
                        </a>
                    <% } %>
                    <a href="<%=request.getContextPath()%>/logout" class="flex h-9 items-center justify-center px-4 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold text-sm transition-colors">
                        Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 md:p-6 lg:p-10">
        <div class="mb-10 text-center">
            <h2 class="text-3xl font-extrabold text-slate-900 dark:text-white tracking-tight">Hệ Thống Dành Cho Lễ Tân</h2>
            <p class="text-slate-500 dark:text-slate-400 mt-2 text-lg">Xử lý các nghiệp vụ nhanh chóng, chính xác.</p>
        </div>

        <div class="flex justify-center mb-10">
            <div class="w-full max-w-2xl bg-surface-light dark:bg-surface-dark rounded-2xl p-8 shadow-lg border border-slate-200 dark:border-slate-700 hover:border-primary transition-colors group">
                <div class="flex items-center justify-center w-16 h-16 bg-primary/10 text-primary rounded-2xl mb-6 mx-auto group-hover:scale-110 transition-transform">
                    <span class="material-symbols-outlined text-4xl">sync_alt</span>
                </div>
                <h3 class="text-2xl font-bold text-slate-900 dark:text-white text-center mb-3">Nghiệp vụ Nhận / Trả phòng</h3>
                <p class="text-slate-500 dark:text-slate-400 text-center mb-8 leading-relaxed">
                    Thực hiện quy trình Check-in cho khách đến, Check-out, thanh toán tiền phòng và cập nhật phí dịch vụ Minibar.
                </p>
                <a href="<%=request.getContextPath()%>/reception/checkout.jsp" class="flex w-full justify-center items-center py-4 bg-primary hover:bg-blue-700 text-white font-bold rounded-xl shadow-md transition-all active:scale-[0.98] gap-2">
                    Vào màn hình Check-in / Check-out <span class="material-symbols-outlined">arrow_forward</span>
                </a>
            </div>
        </div>

        <div class="flex justify-center">
            <div class="w-full max-w-2xl bg-amber-50 dark:bg-amber-900/10 border border-amber-200 dark:border-amber-800/30 rounded-xl p-5 flex items-start gap-4">
                <span class="material-symbols-outlined text-amber-500 text-2xl mt-0.5">push_pin</span>
                <div>
                    <h5 class="font-bold text-amber-900 dark:text-amber-500 mb-1">Ghi chú hệ thống:</h5>
                    <p class="text-amber-800 dark:text-amber-400/80 text-sm leading-relaxed">Khi thực hiện <b>Check-out</b>, hệ thống sẽ tự động tạo hóa đơn, trừ số lượng sản phẩm Minibar trong kho và tự động chuyển phòng sang trạng thái <b>Cleaning</b> (Đang dọn dẹp) trên Sơ đồ phòng.</p>
                </div>
            </div>
        </div>
    </main>

    <footer class="mt-auto border-t border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark py-4 px-6 text-sm text-slate-500 flex justify-between">
        <span>Server: SH-RECEPTION-01</span>
        <span>© 2026 SmartHotel Management</span>
    </footer>
</body>
</html>