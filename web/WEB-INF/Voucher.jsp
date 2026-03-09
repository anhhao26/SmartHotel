<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel Voucher Management</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#144aeb", "primary-hover": "#0f3ab5",
                        "background-light": "#f6f6f8", "background-dark": "#101522",
                        secondary: "#475569", success: "#22c55e", danger: "#ef4444",
                    },
                    fontFamily: { display: ["Manrope", "sans-serif"], },
                },
            },
        }
    </script>
</head>
<body class="bg-background-light text-slate-900 font-display antialiased min-h-screen flex flex-col overflow-x-hidden">
    
    <header class="sticky top-0 z-50 bg-white border-b border-slate-200 px-6 py-4 flex items-center justify-between shadow-sm">
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-primary/10 rounded-lg flex items-center justify-center text-primary">
                <span class="material-symbols-outlined text-2xl">hotel_class</span>
            </div>
            <div>
                <h1 class="text-xl font-bold text-slate-900 leading-tight">SmartHotel</h1>
                <p class="text-xs text-slate-500 font-medium">Voucher Management System</p>
            </div>
        </div>
        <div class="flex items-center gap-4">
            <a href="<%=request.getContextPath()%>/admin" class="font-bold text-sm text-slate-500 hover:text-primary flex items-center"><span class="material-symbols-outlined text-[18px] mr-1">arrow_back</span> Dashboard</a>
        </div>
    </header>

    <main class="flex-1 p-6 lg:px-8 lg:py-8 max-w-[1600px] mx-auto w-full">
        <div class="flex items-center justify-between mb-6">
            <div>
                <h2 class="text-2xl font-bold text-slate-900">Voucher Dashboard</h2>
                <p class="text-slate-500 mt-1">Manage promotional codes and track performance.</p>
            </div>
        </div>

        <c:if test="${not empty errorMessage}"><div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl font-bold">${errorMessage}</div></c:if>
        <c:if test="${not empty successMessage}"><div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-700 rounded-xl font-bold">${successMessage}</div></c:if>

        <div class="grid grid-cols-1 xl:grid-cols-12 gap-6 mb-8">
            <div class="xl:col-span-4 flex flex-col gap-6">
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden h-full">
                    <div class="p-6 border-b border-slate-100 bg-slate-50/50 flex justify-between items-center">
                        <div>
                            <h3 class="font-bold text-lg text-slate-900">Issue New Voucher</h3>
                            <p class="text-sm text-slate-500">Create a promotional code</p>
                        </div>
                        <div class="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center text-primary">
                            <span class="material-symbols-outlined">confirmation_number</span>
                        </div>
                    </div>
                    
                    <form action="<%=request.getContextPath()%>/VoucherServlet" method="POST" class="p-6 flex flex-col gap-5">
                        <input type="hidden" name="action" value="save">
                        
                        <label class="flex flex-col gap-2">
                            <span class="text-sm font-semibold text-slate-700">Voucher Code *</span>
                            <div class="relative">
                                <input name="voucherCode" required class="w-full h-11 pl-10 pr-4 rounded-lg border-slate-200 focus:border-primary focus:ring-primary text-slate-900 font-bold uppercase" placeholder="SUMMER2026" type="text"/>
                                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">tag</span>
                            </div>
                        </label>
                        
                        <label class="flex flex-col gap-2">
                            <span class="text-sm font-semibold text-slate-700">Discount Value (VNĐ) *</span>
                            <div class="relative">
                                <input name="discountValue" required class="w-full h-11 pl-10 pr-4 rounded-lg border-slate-200 focus:border-primary focus:ring-primary text-danger font-bold" placeholder="100000" type="number"/>
                                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">payments</span>
                            </div>
                        </label>

                        <div class="grid grid-cols-2 gap-4">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-semibold text-slate-700">Valid From</span>
                                <input name="startDate" required class="w-full h-11 px-3 rounded-lg border-slate-200 focus:border-primary text-slate-900 text-sm" type="datetime-local"/>
                            </label>
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-semibold text-slate-700">Valid Until</span>
                                <input name="endDate" required class="w-full h-11 px-3 rounded-lg border-slate-200 focus:border-primary text-slate-900 text-sm" type="datetime-local"/>
                            </label>
                        </div>
                        
                        <div class="grid grid-cols-2 gap-4">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-semibold text-slate-700">Min Order (VNĐ)</span>
                                <input name="minOrderValue" value="0" class="w-full h-11 px-4 rounded-lg border-slate-200 focus:border-primary text-slate-900" type="number"/>
                            </label>
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-semibold text-slate-700">Usage Limit</span>
                                <input name="usageLimit" value="50" class="w-full h-11 px-4 rounded-lg border-slate-200 focus:border-primary text-slate-900 font-bold" type="number"/>
                            </label>
                        </div>
                        
                        <div class="mt-4 pt-4 border-t border-slate-100 flex gap-3">
                            <button type="submit" class="w-full h-12 bg-primary hover:bg-primary-hover text-white rounded-lg font-bold shadow-md shadow-primary/20 transition-all flex items-center justify-center gap-2">
                                <span class="material-symbols-outlined text-[20px]">send</span> Generate Voucher
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="xl:col-span-8 flex flex-col gap-6">
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden h-full flex flex-col">
                    <div class="p-6 border-b border-slate-100 flex flex-col sm:flex-row justify-between sm:items-center gap-4 bg-slate-50/30">
                        <div>
                            <h3 class="font-bold text-lg text-slate-900">Active Vouchers</h3>
                            <p class="text-sm text-slate-500">List of currently valid promotional codes</p>
                        </div>
                    </div>
                    <div class="overflow-x-auto flex-1">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-slate-50 border-b border-slate-100 text-xs uppercase tracking-wider text-slate-500 font-semibold">
                                    <th class="px-6 py-4">Voucher Code</th>
                                    <th class="px-6 py-4">Discount</th>
                                    <th class="px-6 py-4">Validity Period</th>
                                    <th class="px-6 py-4 w-1/4">Usage Progress</th>
                                    <th class="px-6 py-4 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 text-sm">
                                <c:forEach items="${voucherList}" var="v">
                                    <tr class="group hover:bg-slate-50 transition-colors">
                                        <td class="px-6 py-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-10 rounded-lg bg-blue-50 flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-white transition-colors">
                                                    <span class="material-symbols-outlined text-xl">sell</span>
                                                </div>
                                                <span class="font-bold text-primary bg-primary/5 px-2.5 py-1 rounded text-sm font-mono border border-primary/10">${v.voucherCode}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="font-bold text-danger text-base"><fmt:formatNumber value="${v.discountValue}" pattern="#,###"/> đ</span>
                                            <span class="block text-xs text-slate-400 mt-1">Min: <fmt:formatNumber value="${v.minOrderValue}" pattern="#,###"/></span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex flex-col gap-1 text-xs text-slate-600 font-medium">
                                                <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm text-green-500">play_circle</span> <fmt:formatDate value="${v.startDate}" pattern="dd/MM/yy HH:mm"/></span>
                                                <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm text-red-500">stop_circle</span> <fmt:formatDate value="${v.endDate}" pattern="dd/MM/yy HH:mm"/></span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex justify-between text-xs mb-1.5 font-medium">
                                                <span class="text-slate-600">${v.usedCount} redeemed</span>
                                                <span class="text-slate-400">Limit: ${v.usageLimit}</span>
                                            </div>
                                            <div class="h-2 w-full bg-slate-100 rounded-full overflow-hidden">
                                                <div class="h-full bg-primary rounded-full shadow-[0_0_10px_rgba(20,74,235,0.4)]" style="width: ${(v.usedCount / v.usageLimit) * 100}%"></div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <a href="<%=request.getContextPath()%>/VoucherServlet?action=delete&code=${v.voucherCode}" onclick="return confirm('Xác nhận xóa mã này?');" class="text-slate-400 hover:text-danger transition-colors p-2 hover:bg-white rounded-lg inline-block shadow-sm">
                                                <span class="material-symbols-outlined">delete</span>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty voucherList}">
                                    <tr><td colspan="5" class="py-12 text-center text-slate-500 font-bold">Chưa có mã giảm giá nào hoạt động.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>