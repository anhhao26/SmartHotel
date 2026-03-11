<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel Analytics Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#2563EB", secondary: "#10B981", accent: "#F59E0B", danger: "#EF4444",
                        "background-light": "#F3F4F6", "background-dark": "#0F172A",
                        "surface-light": "#FFFFFF", "surface-dark": "#1E293B",
                        "text-main-light": "#111827", "text-main-dark": "#F9FAFB",
                        "text-muted-light": "#6B7280", "text-muted-dark": "#9CA3AF",
                        "sidebar-dark": "#111827",
                    },
                    fontFamily: { display: ["Inter", "sans-serif"], body: ["Inter", "sans-serif"], },
                    boxShadow: { 'soft': '0 4px 20px -2px rgba(0, 0, 0, 0.05)', 'glow': '0 0 15px rgba(37, 99, 235, 0.2)', }
                },
            },
        };
    </script>
</head>
<body class="font-body bg-background-light dark:bg-background-dark text-text-main-light dark:text-text-main-dark transition-colors duration-300 antialiased min-h-screen flex overflow-hidden">
    
    <aside class="w-64 bg-sidebar-dark text-white flex-shrink-0 hidden md:flex flex-col transition-all duration-300 border-r border-gray-800">
        <div class="h-16 flex items-center px-6 border-b border-gray-800 bg-sidebar-dark">
            <span class="material-icons-round text-primary mr-2 text-3xl">domain</span>
            <h1 class="font-bold text-xl tracking-wide">SmartHotel</h1>
        </div>
        <nav class="flex-1 overflow-y-auto py-6 space-y-1">
            <div class="px-4 mb-2 text-xs font-semibold text-gray-500 uppercase tracking-wider">Tổng quan</div>
            <a class="flex items-center px-6 py-3 bg-primary bg-opacity-10 text-primary border-r-4 border-primary" href="#"><span class="material-icons-round mr-3">dashboard</span><span class="font-medium">Dashboard</span></a>
            <div class="px-4 mt-8 mb-2 text-xs font-semibold text-gray-500 uppercase tracking-wider">Quản lý</div>
            
            <a class="flex items-center px-6 py-3 text-gray-400 hover:text-white hover:bg-gray-800 transition-colors" href="<%=request.getContextPath()%>/products"><span class="material-icons-round mr-3" style="color: #F59E0B;">inventory_2</span><span class="font-medium">Kho & Vật Tư</span></a>
            
            <a class="flex items-center px-6 py-3 text-gray-400 hover:text-white hover:bg-gray-800 transition-colors" href="<%=request.getContextPath()%>/admin/customers"><span class="material-icons-round mr-3">groups</span><span class="font-medium">Khách hàng (CRM)</span></a>
            <a class="flex items-center px-6 py-3 text-gray-400 hover:text-white hover:bg-gray-800 transition-colors" href="<%=request.getContextPath()%>/RoomServlet"><span class="material-icons-round mr-3">meeting_room</span><span class="font-medium">Phòng & Sơ đồ</span></a>
            <a class="flex items-center px-6 py-3 text-gray-400 hover:text-white hover:bg-gray-800 transition-colors" href="<%=request.getContextPath()%>/VoucherServlet"><span class="material-icons-round mr-3">local_offer</span><span class="font-medium">Vouchers</span></a>
        </nav>
    </aside>

    <main class="flex-1 flex flex-col h-screen overflow-hidden relative">
        <header class="h-16 bg-surface-light dark:bg-surface-dark shadow-sm border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-6 z-10 flex-shrink-0">
            <div class="flex items-center md:hidden gap-2 text-primary font-bold"><span class="material-icons-round">domain</span> SmartHotel Admin</div>
            <div class="hidden md:flex items-center bg-gray-100 dark:bg-gray-800 rounded-full px-4 py-2 w-96">
                <span class="material-icons-round text-gray-400 text-sm">search</span>
                <input class="bg-transparent border-none focus:ring-0 text-sm w-full text-text-main-light placeholder-gray-400" placeholder="Tìm kiếm nhanh..." type="text"/>
            </div>
            <div class="flex items-center space-x-4">
                <button class="p-2 text-gray-500 hover:text-primary rounded-full hover:bg-gray-100 transition-colors" onclick="document.documentElement.classList.toggle('dark')"><span class="material-icons-round">dark_mode</span></button>
                <a href="<%=request.getContextPath()%>/logout" class="flex items-center px-4 py-2 text-sm font-medium text-danger border border-danger/30 rounded-lg hover:bg-danger hover:text-white transition-colors"><span class="material-icons-round text-lg mr-1">logout</span> Đăng xuất</a>
            </div>
        </header>

        <div class="flex-1 overflow-y-auto p-6 lg:p-10 scroll-smooth">
            <div class="mb-8 flex flex-col md:flex-row md:items-center justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-gray-800 dark:text-white mb-1">Bảng Điều Khiển Trung Tâm</h2>
                    <p class="text-text-muted-light dark:text-text-muted-dark">Xin chào, Quản trị viên. Hệ thống đang hoạt động ổn định.</p>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
                <div class="bg-surface-light dark:bg-surface-dark rounded-xl p-6 shadow-soft border border-gray-100 dark:border-gray-700">
                    <div class="flex justify-between items-start mb-2">
                        <div><p class="text-xs font-semibold text-text-muted-light uppercase tracking-wide">Tổng Doanh Thu</p><h3 class="text-2xl font-bold text-gray-800 dark:text-white mt-1">45.2M <span class="text-sm font-normal text-gray-500">VND</span></h3></div>
                        <div class="bg-blue-100 p-2 rounded-lg text-primary"><span class="material-icons-round text-xl">payments</span></div>
                    </div>
                </div>
                <div class="bg-surface-light dark:bg-surface-dark rounded-xl p-6 shadow-soft border border-gray-100 dark:border-gray-700">
                    <div class="flex justify-between items-start mb-2">
                        <div><p class="text-xs font-semibold text-text-muted-light uppercase tracking-wide">Công Suất Phòng</p><h3 class="text-2xl font-bold text-gray-800 dark:text-white mt-1">85%</h3></div>
                        <div class="bg-green-100 p-2 rounded-lg text-secondary"><span class="material-icons-round text-xl">bed</span></div>
                    </div>
                </div>
                <div class="bg-surface-light dark:bg-surface-dark rounded-xl p-6 shadow-soft border border-gray-100 dark:border-gray-700">
                    <div class="flex justify-between items-start mb-2">
                        <div><p class="text-xs font-semibold text-text-muted-light uppercase tracking-wide">Lượt Check-in</p><h3 class="text-2xl font-bold text-gray-800 dark:text-white mt-1">24 <span class="text-sm font-normal text-gray-500">Khách</span></h3></div>
                        <div class="bg-yellow-100 p-2 rounded-lg text-accent"><span class="material-icons-round text-xl">luggage</span></div>
                    </div>
                </div>
                <div class="bg-surface-light dark:bg-surface-dark rounded-xl p-6 shadow-soft border border-gray-100 dark:border-gray-700">
                    <div class="flex justify-between items-start mb-2">
                        <div><p class="text-xs font-semibold text-text-muted-light uppercase tracking-wide">Voucher Active</p><h3 class="text-2xl font-bold text-gray-800 dark:text-white mt-1">12</h3></div>
                        <div class="bg-purple-100 p-2 rounded-lg text-purple-600"><span class="material-icons-round text-xl">confirmation_number</span></div>
                    </div>
                </div>
            </div>

            <h3 class="text-lg font-bold text-gray-800 dark:text-white mb-6 flex items-center">
                <span class="w-1 h-6 bg-primary rounded-full mr-3"></span> Truy cập nhanh Module
            </h3>
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                
                <div class="bg-surface-light dark:bg-surface-dark rounded-xl overflow-hidden shadow-soft border border-gray-200 dark:border-gray-700 flex flex-col hover:border-accent transition-all duration-300 group h-full">
                    <div class="h-2 bg-accent w-full"></div>
                    <div class="p-6 flex-1 flex flex-col">
                        <div class="flex items-start justify-between mb-4">
                            <div class="bg-yellow-50 dark:bg-yellow-900/20 p-4 rounded-xl"><span class="material-icons-round text-accent text-3xl">inventory_2</span></div>
                            <span class="text-xs font-bold text-accent bg-yellow-100 dark:bg-yellow-900/40 px-2 py-1 rounded">MODULE 2</span>
                        </div>
                        <h4 class="text-xl font-bold text-gray-800 dark:text-white mb-2">Kho & Vật Tư</h4>
                        <p class="text-text-muted-light dark:text-text-muted-dark text-sm mb-6 flex-1">Kiểm soát hàng tồn kho, quản lý danh sách nhà cung cấp và hóa đơn nhập xuất.</p>
                        <a href="<%=request.getContextPath()%>/products" class="w-full py-3 bg-accent hover:bg-yellow-600 text-white font-medium rounded-lg shadow-md transition-all flex justify-center items-center group-hover:translate-y-[-2px]">Mở Quản Lý Kho <span class="material-icons-round ml-2 text-sm">arrow_forward</span></a>
                    </div>
                </div>

                <div class="bg-surface-light dark:bg-surface-dark rounded-xl overflow-hidden shadow-soft border border-gray-200 dark:border-gray-700 flex flex-col hover:border-primary transition-all duration-300 group h-full">
                    <div class="h-2 bg-primary w-full"></div>
                    <div class="p-6 flex-1 flex flex-col">
                        <div class="flex items-start justify-between mb-4">
                            <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-xl"><span class="material-icons-round text-primary text-3xl">groups</span></div>
                            <span class="text-xs font-bold text-primary bg-blue-100 dark:bg-blue-900/40 px-2 py-1 rounded">MODULE 5</span>
                        </div>
                        <h4 class="text-xl font-bold text-gray-800 dark:text-white mb-2">Quản lý Khách hàng (CRM)</h4>
                        <p class="text-text-muted-light dark:text-text-muted-dark text-sm mb-6 flex-1">Xem danh sách khách hàng, quản lý điểm tích lũy, phân hạng VIP.</p>
                        <a href="<%=request.getContextPath()%>/admin/customers" class="w-full py-3 bg-primary hover:bg-blue-700 text-white font-medium rounded-lg shadow-md transition-all flex justify-center items-center group-hover:translate-y-[-2px]">Mở CRM Khách Hàng <span class="material-icons-round ml-2 text-sm">arrow_forward</span></a>
                    </div>
                </div>

                <div class="bg-surface-light dark:bg-surface-dark rounded-xl overflow-hidden shadow-soft border border-gray-200 dark:border-gray-700 flex flex-col hover:border-secondary transition-all duration-300 group h-full">
                    <div class="h-2 bg-secondary w-full"></div>
                    <div class="p-6 flex-1 flex flex-col">
                        <div class="flex items-start justify-between mb-4">
                            <div class="bg-green-50 dark:bg-green-900/20 p-4 rounded-xl"><span class="material-icons-round text-secondary text-3xl">concierge</span></div>
                            <span class="text-xs font-bold text-secondary bg-green-100 dark:bg-green-900/40 px-2 py-1 rounded">MODULE 7</span>
                        </div>
                        <h4 class="text-xl font-bold text-gray-800 dark:text-white mb-2">Quầy Lễ Tân (Reception)</h4>
                        <p class="text-text-muted-light dark:text-text-muted-dark text-sm mb-6 flex-1">Xử lý nhận phòng (Check-in), trả phòng (Check-out) và thanh toán.</p>
                        <a href="<%=request.getContextPath()%>/reception/home.jsp" class="w-full py-3 bg-secondary hover:bg-emerald-600 text-white font-medium rounded-lg shadow-md transition-all flex justify-center items-center group-hover:translate-y-[-2px]">Tới Quầy Lễ Tân <span class="material-icons-round ml-2 text-sm">arrow_forward</span></a>
                    </div>
                </div>

                <div class="bg-surface-light dark:bg-surface-dark rounded-xl overflow-hidden shadow-soft border border-gray-200 dark:border-gray-700 flex flex-col hover:border-danger transition-all duration-300 group h-full">
                    <div class="h-2 bg-danger w-full"></div>
                    <div class="p-6 flex-1 flex flex-col">
                        <div class="flex items-start justify-between mb-4">
                            <div class="bg-red-50 dark:bg-red-900/20 p-4 rounded-xl"><span class="material-icons-round text-danger text-3xl">bed</span></div>
                            <span class="text-xs font-bold text-danger bg-red-100 dark:bg-red-900/40 px-2 py-1 rounded">MODULE 4</span>
                        </div>
                        <h4 class="text-xl font-bold text-gray-800 dark:text-white mb-2">Sơ đồ phòng (Room Board)</h4>
                        <p class="text-text-muted-light dark:text-text-muted-dark text-sm mb-6 flex-1">Kiểm soát trực quan trạng thái phòng: trống, đang ở, đang dọn dẹp.</p>
                        <a href="<%=request.getContextPath()%>/RoomServlet" class="w-full py-3 bg-danger hover:bg-red-600 text-white font-medium rounded-lg shadow-md transition-all flex justify-center items-center group-hover:translate-y-[-2px]">Mở Sơ Đồ Phòng <span class="material-icons-round ml-2 text-sm">arrow_forward</span></a>
                    </div>
                </div>

                <div class="bg-surface-light dark:bg-surface-dark rounded-xl overflow-hidden shadow-soft border border-gray-200 dark:border-gray-700 flex flex-col hover:border-gray-800 transition-all duration-300 group h-full">
                    <div class="h-2 bg-gray-800 dark:bg-gray-400 w-full"></div>
                    <div class="p-6 flex-1 flex flex-col">
                        <div class="flex items-start justify-between mb-4">
                            <div class="bg-gray-100 dark:bg-gray-700 p-4 rounded-xl"><span class="material-icons-round text-gray-700 dark:text-white text-3xl">local_offer</span></div>
                            <span class="text-xs font-bold text-gray-600 dark:text-gray-300 bg-gray-200 dark:bg-gray-700 px-2 py-1 rounded">MODULE 3</span>
                        </div>
                        <h4 class="text-xl font-bold text-gray-800 dark:text-white mb-2">Khuyến mãi (Voucher)</h4>
                        <p class="text-text-muted-light dark:text-text-muted-dark text-sm mb-6 flex-1">Thiết lập mã giảm giá, chương trình khuyến mãi theo mùa.</p>
                        <a href="<%=request.getContextPath()%>/VoucherServlet" class="w-full py-3 bg-gray-800 hover:bg-gray-900 dark:bg-gray-700 dark:hover:bg-gray-600 text-white font-medium rounded-lg shadow-md transition-all flex justify-center items-center group-hover:translate-y-[-2px]">Quản Lý Voucher <span class="material-icons-round ml-2 text-sm">arrow_forward</span></a>
                    </div>
                </div>

                <div class="bg-gradient-to-br from-blue-50 to-white dark:from-slate-800 dark:to-slate-900 rounded-xl overflow-hidden shadow-soft border border-blue-100 dark:border-gray-700 flex flex-col transition-all duration-300 group h-full relative">
                    <div class="absolute top-0 right-0 p-4 opacity-10"><span class="material-icons-round text-9xl text-primary">smartphone</span></div>
                    <div class="p-6 flex-1 flex flex-col relative z-10">
                        <div class="flex items-start justify-between mb-4">
                            <div class="bg-white dark:bg-slate-700 p-4 rounded-xl shadow-sm"><span class="material-icons-round text-primary text-3xl">public</span></div>
                            <span class="text-xs font-bold text-primary bg-white dark:bg-slate-700 px-2 py-1 rounded shadow-sm">MODULE 6</span>
                        </div>
                        <h4 class="text-xl font-bold text-gray-800 dark:text-white mb-2">Trang Khách Đặt Phòng</h4>
                        <p class="text-text-muted-light dark:text-text-muted-dark text-sm mb-6 flex-1">Giao diện public cho khách vãng lai tìm và đặt phòng.</p>
                        <a href="<%=request.getContextPath()%>/webapp/search.jsp" target="_blank" class="w-full py-3 bg-white dark:bg-slate-700 text-primary dark:text-white border border-gray-200 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-slate-600 font-medium rounded-lg shadow-sm transition-all flex justify-center items-center group-hover:translate-y-[-2px]">Xem Giao Diện Khách <span class="material-icons-round ml-2 text-sm">launch</span></a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>