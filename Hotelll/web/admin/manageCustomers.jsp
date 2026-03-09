<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.smarthotel.model.Customer" %>
<%@ page import="java.util.List" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel CRM - Customer Management</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#3B82F6", "primary-dark": "#2563EB",
                        "background-light": "#F3F4F6", "background-dark": "#111827",
                        "surface-light": "#FFFFFF", "surface-dark": "#1F2937",
                        "text-light": "#1F2937", "text-dark": "#F9FAFB",
                        "secondary-text-light": "#6B7280", "secondary-text-dark": "#9CA3AF",
                        "border-light": "#E5E7EB", "border-dark": "#374151",
                    },
                    fontFamily: { display: ["Inter", "sans-serif"], sans: ["Inter", "sans-serif"], },
                    backgroundImage: {
                        'diamond-gradient': 'linear-gradient(135deg, #b3e5fc 0%, #29b6f6 50%, #0288d1 100%)',
                        'gold-gradient': 'linear-gradient(135deg, #fff9c4 0%, #fbc02d 50%, #f57f17 100%)',
                        'silver-gradient': 'linear-gradient(135deg, #f5f5f5 0%, #bdbdbd 50%, #616161 100%)',
                    }
                },
            },
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .metallic-text { text-shadow: 0 1px 0 rgba(255,255,255,0.4); }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-text-light dark:text-text-dark transition-colors duration-300 min-h-screen flex flex-col">
    <header class="bg-surface-light dark:bg-surface-dark border-b border-border-light dark:border-border-dark shadow-sm z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center gap-3">
                    <div class="flex-shrink-0 flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary text-3xl">domain</span>
                        <h1 class="text-xl font-bold tracking-tight text-primary">SmartHotel <span class="text-secondary-text-light dark:text-secondary-text-dark font-normal">Admin</span></h1>
                    </div>
                    <div class="hidden sm:ml-6 sm:flex sm:space-x-8">
                        <a class="border-transparent text-secondary-text-light dark:text-secondary-text-dark hover:border-primary hover:text-primary inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium" href="<%=request.getContextPath()%>/admin">Dashboard</a>
                        <a class="border-primary text-primary dark:text-white inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium" href="#">CRM & Loyalty</a>
                    </div>
                </div>
                <div class="flex items-center gap-4">
                    <button class="p-2 rounded-full text-secondary-text-light dark:text-secondary-text-dark hover:bg-gray-100 dark:hover:bg-gray-700" onclick="document.documentElement.classList.toggle('dark')">
                        <span class="material-symbols-outlined block dark:hidden">dark_mode</span>
                        <span class="material-symbols-outlined hidden dark:block">light_mode</span>
                    </button>
                    <a href="<%=request.getContextPath()%>/logout" class="text-sm font-medium text-red-500 hover:text-red-700 ml-4">Sign Out</a>
                </div>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-8">
        <div class="md:flex md:items-center md:justify-between mb-8">
            <div class="min-w-0 flex-1">
                <h2 class="text-2xl font-bold leading-7 text-text-light dark:text-text-dark sm:truncate sm:text-3xl sm:tracking-tight">
                    VIP Loyalty & CRM Dashboard
                </h2>
                <p class="mt-1 text-sm text-secondary-text-light dark:text-secondary-text-dark">
                    Manage guest profiles, loyalty points, and high-value membership status.
                </p>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-surface-light dark:bg-surface-dark rounded-xl shadow-sm border border-border-light dark:border-border-dark p-6 flex items-center">
                <div class="p-3 rounded-full bg-blue-50 dark:bg-blue-900/20 mr-4"><span class="material-symbols-outlined text-primary text-3xl">workspace_premium</span></div>
                <div>
                    <p class="text-sm font-medium text-secondary-text-light dark:text-secondary-text-dark">Total Members</p>
                    <p class="text-2xl font-bold text-text-light dark:text-text-dark"><%= customers != null ? customers.size() : 0 %></p>
                </div>
            </div>
            <div class="bg-surface-light dark:bg-surface-dark rounded-xl shadow-sm border border-border-light dark:border-border-dark p-6 flex items-center">
                <div class="p-3 rounded-full bg-yellow-50 dark:bg-yellow-900/20 mr-4"><span class="material-symbols-outlined text-yellow-600 text-3xl">loyalty</span></div>
                <div>
                    <p class="text-sm font-medium text-secondary-text-light dark:text-secondary-text-dark">Active CRM</p>
                    <p class="text-2xl font-bold text-text-light dark:text-text-dark">Online</p>
                </div>
            </div>
        </div>

        <div class="bg-surface-light dark:bg-surface-dark rounded-xl shadow-lg border border-border-light dark:border-border-dark overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-border-light dark:divide-border-dark">
                    <thead class="bg-gray-50 dark:bg-gray-800">
                        <tr>
                            <th class="py-3.5 pl-4 pr-3 text-left text-xs font-semibold uppercase tracking-wider text-secondary-text-light dark:text-secondary-text-dark sm:pl-6">Member</th>
                            <th class="px-3 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-secondary-text-light dark:text-secondary-text-dark">Contact</th>
                            <th class="px-3 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-secondary-text-light dark:text-secondary-text-dark">Tier Status</th>
                            <th class="px-3 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-secondary-text-light dark:text-secondary-text-dark">Total Points</th>
                            <th class="px-3 py-3.5 text-left text-xs font-semibold uppercase tracking-wider text-secondary-text-light dark:text-secondary-text-dark">Total Spending</th>
                            <th class="px-3 py-3.5 text-center text-xs font-semibold uppercase tracking-wider text-secondary-text-light dark:text-secondary-text-dark">Reward</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-light dark:divide-border-dark bg-surface-light dark:bg-surface-dark">
                        <% if (customers != null && !customers.isEmpty()) {
                            for (Customer c : customers) { 
                                String tier = c.getMemberType() != null ? c.getMemberType() : "Standard";
                                String bgGradient = "bg-gray-100 dark:bg-gray-700 text-gray-600";
                                String icon = "";
                                
                                if(tier.toUpperCase().contains("DIAMOND")) {
                                    bgGradient = "bg-diamond-gradient border border-blue-300 metallic-text text-white"; icon = "diamond";
                                } else if(tier.toUpperCase().contains("GOLD") || tier.toUpperCase().contains("VIP")) {
                                    bgGradient = "bg-gold-gradient border border-yellow-300 metallic-text text-yellow-900"; icon = "star";
                                } else if(tier.toUpperCase().contains("SILVER")) {
                                    bgGradient = "bg-silver-gradient border border-gray-300 metallic-text text-gray-700"; icon = "verified";
                                }
                        %>
                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors group">
                            <td class="whitespace-nowrap py-4 pl-4 pr-3 sm:pl-6">
                                <div class="flex items-center">
                                    <div class="h-10 w-10 flex-shrink-0 relative">
                                        <div class="h-10 w-10 rounded-full bg-blue-100 dark:bg-blue-900 flex items-center justify-center text-blue-600 dark:text-blue-300 font-bold border-2 border-blue-200">
                                            <span class="material-symbols-outlined">person</span>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <div class="font-bold text-text-light dark:text-text-dark"><%= c.getFullName() %></div>
                                        <div class="text-xs text-secondary-text-light dark:text-secondary-text-dark">ID: #<%= c.getCustomerID() %></div>
                                    </div>
                                </div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-secondary-text-light dark:text-secondary-text-dark">
                                <div><%= c.getEmail() != null ? c.getEmail() : "-" %></div>
                                <div class="text-xs mt-0.5 opacity-75"><%= c.getPhone() != null ? c.getPhone() : "-" %></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm">
                                <span class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-bold shadow-sm <%= bgGradient %>">
                                    <% if(!icon.isEmpty()) { %><span class="material-symbols-outlined text-[14px] mr-1"><%= icon %></span><% } %>
                                    <%= tier %>
                                </span>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-text-light dark:text-text-dark font-bold text-base">
                                <%= c.getPoints() %> pts
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-text-light dark:text-text-dark font-medium">
                                <%= String.format("%,.0f", c.getTotalSpending()) %> đ
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-center">
                                <form action="${pageContext.request.contextPath}/admin/customers" method="post" class="flex items-center justify-center gap-2">
                                    <input type="hidden" name="action" value="addPoints"/>
                                    <input type="hidden" name="customerId" value="<%=c.getCustomerID()%>"/>
                                    <input class="w-16 rounded-md border-0 py-1.5 text-text-light dark:text-text-dark bg-gray-50 dark:bg-gray-700 ring-1 ring-inset ring-border-light dark:ring-border-dark focus:ring-2 focus:ring-primary sm:text-xs text-center" name="points" type="number" value="1" min="1"/>
                                    <button type="submit" class="inline-flex items-center justify-center rounded-md bg-green-50 dark:bg-green-900/20 px-2 py-1.5 text-xs font-medium text-green-700 dark:text-green-400 ring-1 ring-inset ring-green-600/20 hover:bg-green-100 dark:hover:bg-green-900/40 transition-colors">
                                        <span class="material-symbols-outlined text-sm mr-1">add_circle</span> Add
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%  }
                        } else { %>
                        <tr>
                            <td colspan="6" class="py-10 text-center text-secondary-text-light dark:text-secondary-text-dark">Chưa có khách hàng trong hệ thống.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>