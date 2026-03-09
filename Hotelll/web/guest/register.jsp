<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Registration</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#11d493", "primary-dark": "#0bb67d", "background-light": "#f6f8f7", "text-main": "#0d1b17", },
                    fontFamily: { display: ["Plus Jakarta Sans", "sans-serif"] },
                },
            },
        }
    </script>
</head>
<body class="bg-background-light font-display text-text-main antialiased min-h-screen flex flex-col">
    
    <header class="sticky top-0 z-50 w-full border-b border-gray-200 bg-white/80 backdrop-blur-md">
        <div class="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
            <div class="flex items-center gap-4">
                <div class="flex items-center justify-center rounded-lg bg-primary/10 p-2 text-primary"><span class="material-symbols-outlined">apartment</span></div>
                <h2 class="text-xl font-bold tracking-tight">SmartHotel</h2>
            </div>
            <a href="<%=request.getContextPath()%>/login.jsp" class="flex items-center justify-center rounded-lg bg-primary px-5 py-2 text-sm font-bold text-white transition hover:bg-primary-dark">Quay lại Đăng nhập</a>
        </div>
    </header>

    <main class="flex-grow">
        <div class="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
            <div class="mx-auto max-w-4xl">
                <div class="mb-10 text-center">
                    <h1 class="mb-3 text-3xl font-extrabold tracking-tight sm:text-4xl">Tạo Tài Khoản Khách Hàng</h1>
                    <p class="text-lg text-slate-500">Tham gia để trải nghiệm dịch vụ lưu trú hoàn hảo và nhận ưu đãi riêng.</p>
                </div>

                <div class="overflow-hidden rounded-2xl bg-white shadow-xl ring-1 ring-slate-900/5">
                    
                    <% String err = (String) request.getAttribute("err"); if (err != null) { %>
                        <div class="bg-red-50 text-red-600 p-4 font-bold border-b border-red-100 text-center"><%= err %></div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/register" method="post" class="p-8 sm:p-12">
                        
                        <div class="mb-10">
                            <div class="mb-6 flex items-center gap-3 border-b border-slate-100 pb-3">
                                <div class="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10 text-primary"><span class="material-symbols-outlined">lock</span></div>
                                <h3 class="text-xl font-bold">Bảo Mật Tài Khoản</h3>
                            </div>
                            <div class="grid grid-cols-1 gap-x-6 gap-y-6 sm:grid-cols-2">
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Username *</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="username" required type="text"/>
                                </div>
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Password *</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="password" required type="password"/>
                                </div>
                            </div>
                        </div>

                        <div class="mb-10">
                            <div class="mb-6 flex items-center gap-3 border-b border-slate-100 pb-3">
                                <div class="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10 text-primary"><span class="material-symbols-outlined">badge</span></div>
                                <h3 class="text-xl font-bold">Thông Tin Cá Nhân</h3>
                            </div>
                            <div class="grid grid-cols-1 gap-x-6 gap-y-6 sm:grid-cols-2">
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Họ và Tên *</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="fullName" required type="text"/>
                                </div>
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Email</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="email" type="email"/>
                                </div>
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Số Điện Thoại</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="phone" type="text"/>
                                </div>
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">CCCD / Passport</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="cccd" type="text"/>
                                </div>
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Giới Tính</label>
                                    <select class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="gender">
                                        <option value="">-- Chọn --</option><option value="Male">Nam</option><option value="Female">Nữ</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Ngày Sinh</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="dob" type="date"/>
                                </div>
                                <div class="sm:col-span-2">
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Quốc Tịch</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="nationality" type="text"/>
                                </div>
                                <div class="sm:col-span-2">
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Địa Chỉ</label>
                                    <input class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="address" type="text"/>
                                </div>
                                <div class="sm:col-span-2">
                                    <label class="mb-2 block text-sm font-semibold text-slate-700">Ghi chú (Preferences)</label>
                                    <textarea class="w-full rounded-lg border-slate-200 bg-slate-50 px-4 py-3 focus:border-primary focus:ring-0" name="preferences" rows="2"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="mt-8 flex flex-col items-center justify-between gap-6 border-t border-slate-100 pt-8 sm:flex-row">
                            <p class="text-sm text-slate-500">Tài khoản sẽ được tự động đăng nhập sau khi tạo.</p>
                            <button type="submit" class="inline-flex w-full items-center justify-center gap-2 rounded-lg bg-primary px-8 py-3 text-base font-bold text-white shadow-lg transition-all hover:bg-primary-dark sm:w-auto">
                                <span class="material-symbols-outlined">how_to_reg</span> Hoàn Tất Đăng Ký
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>