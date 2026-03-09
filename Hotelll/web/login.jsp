<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Login</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#135bec", "primary-dark": "#0e45b5", "background-light": "#f6f6f8", "surface-light": "#ffffff", "text-main": "#0d121b", "text-sub": "#4c669a", "border-light": "#e7ebf3", },
                    fontFamily: { display: ["Plus Jakarta Sans", "sans-serif"], },
                },
            },
        }
    </script>
</head>
<body class="font-display bg-background-light text-text-main min-h-screen flex flex-col antialiased">
    
    <header class="w-full border-b border-border-light bg-surface-light px-6 py-4">
        <div class="mx-auto flex max-w-7xl items-center justify-between">
            <div class="flex items-center gap-3 text-primary">
                <span class="material-symbols-outlined text-3xl">hotel_class</span>
                <h2 class="text-text-main text-xl font-bold">SmartHotel</h2>
            </div>
            <div class="flex items-center gap-4">
                <span class="text-text-sub text-sm">Chưa có tài khoản?</span>
                <a href="<%=request.getContextPath()%>/guest/register.jsp" class="text-primary text-sm font-bold hover:underline">Đăng Ký</a>
            </div>
        </div>
    </header>

    <main class="flex-1 flex flex-col md:flex-row h-[calc(100vh-80px)] overflow-hidden">
<div class="relative w-full md:w-1/2 lg:w-3/5 h-64 md:h-auto bg-cover bg-center overflow-hidden" style="background-image: url('${pageContext.request.contextPath}/images/2690968.jpg');">            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent flex flex-col justify-end p-8 md:p-16 lg:p-24">
                <h1 class="text-3xl md:text-5xl font-bold text-white mb-4">Trải nghiệm sự thanh lịch <br/>trong từng kỳ nghỉ.</h1>
                <p class="text-gray-200 text-sm md:text-base max-w-md">Hãy để SmartHotel mang lại cho bạn những phút giây thư giãn tuyệt vời nhất.</p>
            </div>
        </div>

        <div class="w-full md:w-1/2 lg:w-2/5 flex items-center justify-center p-6 md:p-12 lg:p-16 bg-surface-light overflow-y-auto">
            <div class="w-full max-w-md space-y-8">
                <div class="text-center md:text-left space-y-2">
                    <h2 class="text-3xl font-bold text-text-main tracking-tight">Đăng Nhập</h2>
                    <p class="text-text-sub">Vui lòng nhập thông tin để tiếp tục.</p>
                </div>

                <c:if test="${not empty param.err}">
                    <div class="bg-red-50 text-red-600 p-4 rounded-xl text-sm font-bold border border-red-100 flex items-center gap-2">
                        <span class="material-symbols-outlined">error</span> ${param.err}
                    </div>
                </c:if>
                <% String err = (String) request.getAttribute("err"); if (err != null) { %>
                    <div class="bg-red-50 text-red-600 p-4 rounded-xl text-sm font-bold border border-red-100 flex items-center gap-2">
                        <span class="material-symbols-outlined">error</span> <%= err %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-6 mt-4">
                    <div class="space-y-1.5">
                        <label class="block text-sm font-semibold text-text-main">Tên đăng nhập (Username)</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-text-sub"><span class="material-symbols-outlined text-[20px]">person</span></div>
                            <input class="block w-full pl-10 pr-4 py-3 border border-border-light rounded-xl focus:ring-primary focus:border-primary" name="username" required type="text" placeholder="Nhập username..."/>
                        </div>
                    </div>

                    <div class="space-y-1.5">
                        <label class="block text-sm font-semibold text-text-main">Mật khẩu (Password)</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-text-sub"><span class="material-symbols-outlined text-[20px]">lock</span></div>
                            <input class="block w-full pl-10 pr-4 py-3 border border-border-light rounded-xl focus:ring-primary focus:border-primary" name="password" required type="password" placeholder="••••••••"/>
                        </div>
                    </div>

                    <button type="submit" class="w-full flex justify-center py-3.5 px-4 rounded-xl shadow-md text-sm font-bold text-white bg-primary hover:bg-primary-dark transition-all transform active:scale-95">Đăng Nhập</button>
                </form>

                <div class="pt-6 flex items-center justify-center gap-2 text-xs text-text-sub opacity-70">
                    <span class="material-symbols-outlined text-[16px]">lock</span> Mọi thông tin đều được bảo mật an toàn.
                </div>
            </div>
        </div>
    </main>
</body>
</html>