<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ page import="model.Customer" %>
            <%@ page import="java.util.List" %>
                <% List<Customer> customers = (List<Customer>) request.getAttribute("customers"); %>
                        <!DOCTYPE html>
                        <html lang="vi">

                        <head>
                            <meta charset="utf-8" />
                            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                            <title>Quản Lý Khách Hàng - SmartHotel</title>

                            <!-- Premium Fonts -->
                            <link
                                href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap"
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
                                                    chocolate: "#4A4238",
                                                },
                                                accent: {
                                                    emerald: "#4F7942",
                                                    ruby: "#8B0000"
                                                }
                                            },
                                            fontFamily: {
                                                serif: ["Cormorant Garamond", "serif"],
                                                sans: ["Inter", "Be Vietnam Pro", "sans-serif"],
                                            }
                                        },
                                    },
                                }
                            </script>
                            <style>
                                .card-elegant {
                                    background: #FFFFFF;
                                    border: 1px solid rgba(184, 154, 108, 0.1);
                                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.02);
                                    transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
                                }

                                .tier-badge {
                                    font-weight: 700;
                                    letter-spacing: 1px;
                                    text-transform: uppercase;
                                    font-size: 9px;
                                    padding: 4px 12px;
                                    border-radius: 99px;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 6px;
                                }

                                .tier-diamond {
                                    background: #2C2722;
                                    color: #FAF9F6;
                                    border: 1px solid #4A4238;
                                }

                                .tier-gold {
                                    background: #B89A6C;
                                    color: #FFFFFF;
                                }

                                .tier-silver {
                                    background: #FAF9F6;
                                    color: #70685F;
                                    border: 1px solid rgba(184, 154, 108, 0.2);
                                }

                                .tier-standard {
                                    background: #FDFCFB;
                                    color: #70685F;
                                    border: 1px solid rgba(112, 104, 95, 0.1);
                                }

                                .input-elegant {
                                    background: #FDFCFB;
                                    border: 1px solid rgba(184, 154, 108, 0.15);
                                    color: #2C2722;
                                    transition: all 0.3s ease;
                                }

                                .input-elegant:focus {
                                    border-color: #B89A6C;
                                    background: #FFFFFF;
                                    box-shadow: 0 0 0 4px rgba(184, 154, 108, 0.05);
                                    outline: none;
                                }

                                .table-elegant th {
                                    font-family: 'Inter', sans-serif;
                                    font-size: 10px;
                                    font-weight: 700;
                                    text-transform: uppercase;
                                    letter-spacing: 0.1em;
                                    color: #70685F;
                                    padding: 20px 16px;
                                    border-bottom: 1px solid rgba(184, 154, 108, 0.1);
                                    opacity: 0.6;
                                }

                                .table-elegant td {
                                    padding: 20px 16px;
                                    border-bottom: 1px solid rgba(184, 154, 108, 0.05);
                                }

                                .table-elegant th:last-child, .table-elegant td:last-child {
                                    padding-right: 40px; /* Thêm không gian cho cột cuối */
                                    white-space: nowrap;
                                }

                                /* Ẩn múi tên tăng/giảm của thẻ input number */
                                input[type="number"]::-webkit-outer-spin-button,
                                input[type="number"]::-webkit-inner-spin-button {
                                    -webkit-appearance: none;
                                    margin: 0;
                                }
                                input[type="number"] {
                                    -moz-appearance: textfield;
                                }

                                @keyframes fadeIn {
                                    from {
                                        opacity: 0;
                                        transform: translateY(10px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }
                            </style>
                        </head>

                        <body
                            class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

                            <jsp:include page="/common/neural_shell_top.jspf">
                                <jsp:param name="active" value="crm" />
                            </jsp:include>

                            <!-- CRM Page Content -->
                            <div class="flex-1 h-screen overflow-y-auto pb-32">
                                <div class="max-w-7xl mx-auto px-8 lg:px-12 py-12 animate-[fadeIn_0.6s_ease-out] space-y-12">
                                    <!-- Header Section -->
                                    <div class="flex flex-col lg:flex-row lg:items-end justify-between gap-8 lg:gap-12">
                                        <div class="space-y-4 lg:space-y-6">
                                            <div
                                                class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold uppercase tracking-[0.3em]">
                                                CRM Engine
                                            </div>
                                            <h2
                                                class="text-4xl md:text-5xl lg:text-6xl font-serif font-bold text-hotel-text tracking-tight leading-tight uppercase">
                                                Hồ Sơ<br /><span class="text-hotel-gold italic text-5xl md:text-6xl lg:text-7xl lowercase">Khách hàng.</span>
                                            </h2>
                                        </div>
                                        <div class="flex flex-col sm:flex-row gap-4 items-stretch sm:items-center">
                                            <button
                                                class="px-8 py-4 rounded-xl border border-hotel-gold/20 text-hotel-muted text-sm font-bold uppercase tracking-widest hover:bg-white transition-all order-2 sm:order-1">Xuất
                                                Dữ Liệu</button>
                                            <div
                                                class="card-elegant p-5 lg:p-6 rounded-[2rem] flex items-center gap-6 relative overflow-hidden group border-hotel-gold/10 order-1 sm:order-2">
                                                <div
                                                    class="absolute inset-0 bg-hotel-gold/5 opacity-0 group-hover:opacity-100 transition-opacity">
                                                </div>
                                                <span
                                                    class="material-symbols-outlined text-hotel-gold text-3xl lg:text-4xl group-hover:scale-110 transition-transform">workspace_premium</span>
                                                <div class="relative">
                                                    <p
                                                        class="text-sm font-bold text-hotel-muted uppercase tracking-[0.3em] mb-1 opacity-60">
                                                        Hội viên</p>
                                                    <p
                                                        class="text-2xl lg:text-3xl font-serif font-bold text-hotel-text tracking-tighter">
                                                        <%= customers !=null ? customers.size() : 0 %>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Desktop Table View (Hidden on mobile) -->
                                    <div class="hidden lg:block card-elegant rounded-[3rem] overflow-hidden p-8 border-hotel-gold/10 shadow-xl">
                                        <div class="overflow-x-auto">
                                            <table class="w-full text-left border-collapse table-elegant">
                                                <thead>
                                                    <tr>
                                                        <th class="w-[25%] text-left">Hội Viên</th>
                                                        <th class="w-[20%] text-left">Liên Lạc</th>
                                                        <th class="w-[12%] text-left">Hạng</th>
                                                        <th class="w-[13%] text-left">Tích Lũy</th>
                                                        <th class="w-[15%] text-right">Chi Tiêu</th>
                                                        <th class="w-[15%] text-center">Thao Tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% if (customers !=null && !customers.isEmpty()) { 
                                                        for (Customer c : customers) { 
                                                            String tier = c.getMemberType() !=null ? c.getMemberType() : "Standard"; 
                                                            String tierClass = "tier-standard"; String icon = "verified";
                                                            if(tier.toUpperCase().contains("DIAMOND")) { tierClass = "tier-diamond"; icon = "diamond"; } 
                                                            else if(tier.toUpperCase().contains("GOLD") || tier.toUpperCase().contains("VIP") || tier.toUpperCase().contains("PLATINUM")) { tierClass = "tier-gold"; icon = "star"; } 
                                                            else if(tier.toUpperCase().contains("SILVER")) { tierClass = "tier-silver"; icon = "military_tech"; } 
                                                    %>
                                                        <tr class="group hover:bg-hotel-gold/[0.02] transition-colors">
                                                            <td>
                                                                <div class="flex items-center gap-4">
                                                                    <div class="w-12 h-16 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-muted/40 group-hover:text-hotel-gold transition-all duration-500">
                                                                        <span class="material-symbols-outlined text-2xl">account_circle</span>
                                                                    </div>
                                                                    <div>
                                                                        <p class="font-bold text-hotel-text group-hover:text-hotel-gold transition-colors tracking-tight uppercase text-base">
                                                                            <%= c.getFullName() %>
                                                                        </p>
                                                                        <p class="text-sm text-hotel-muted font-bold tracking-widest opacity-40">#<%= c.getCustomerID() %></p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="space-y-1">
                                                                    <p class="text-base font-medium text-hotel-text opacity-70"><%= c.getEmail() !=null ? c.getEmail() : "-" %></p>
                                                                    <p class="text-sm text-hotel-muted font-bold tracking-widest opacity-40"><%= c.getPhone() !=null ? c.getPhone() : "N/A" %></p>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="tier-badge <%= tierClass %>">
                                                                    <span class="material-symbols-outlined text-base"><%= icon %></span>
                                                                    <%= tier %>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <div class="flex items-baseline gap-1">
                                                                    <span class="text-xl font-serif font-bold text-hotel-text tabular-nums"><%= c.getPoints() %></span>
                                                                    <span class="text-xs text-hotel-muted font-bold tracking-widest uppercase opacity-40">điểm</span>
                                                                </div>
                                                            </td>
                                                            <td class="text-right">
                                                                <span class="text-hotel-text font-serif font-bold text-lg tracking-tight">
                                                                    <%= String.format("%,.0f", c.getTotalSpending()) %>
                                                                    <span class="text-sm text-hotel-muted font-sans font-bold opacity-30 ml-1">VNĐ</span>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <form action="${pageContext.request.contextPath}/admin/customers" method="post" class="flex items-center justify-center gap-3">
                                                                    <input type="hidden" name="action" value="addPoints" />
                                                                    <input type="hidden" name="customerId" value="<%=c.getCustomerID()%>" />
                                                                    <input class="w-20 h-12 rounded-xl text-center font-serif font-bold text-lg input-elegant border-hotel-gold/20 shadow-sm" name="points" type="number" value="10" min="1" />
                                                                    <button type="submit" title="Tặng điểm" class="w-12 h-12 rounded-xl bg-hotel-gold text-white hover:bg-hotel-text transition-all flex items-center justify-center active:scale-90 shadow-lg group">
                                                                        <span class="material-symbols-outlined text-xl group-hover:rotate-12 transition-transform">bolt</span>
                                                                    </button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    <% } } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Mobile Card View (Visible on mobile) -->
                                    <div class="lg:hidden space-y-6">
                                        <% if (customers !=null && !customers.isEmpty()) { 
                                            for (Customer c : customers) { 
                                                String tier = c.getMemberType() !=null ? c.getMemberType() : "Standard";
                                                String tierClass = "tier-standard"; String icon = "verified";
                                                if(tier.toUpperCase().contains("DIAMOND")) { tierClass = "tier-diamond"; icon = "diamond"; } 
                                                else if(tier.toUpperCase().contains("GOLD") || tier.toUpperCase().contains("VIP") || tier.toUpperCase().contains("PLATINUM")) { tierClass = "tier-gold"; icon = "star"; } 
                                                else if(tier.toUpperCase().contains("SILVER")) { tierClass = "tier-silver"; icon = "military_tech"; }
                                        %>
                                            <div class="card-elegant rounded-3xl p-6 space-y-6 border-hotel-gold/10">
                                                <div class="flex items-start justify-between">
                                                    <div class="flex items-center gap-4">
                                                        <div class="w-12 h-16 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-gold">
                                                            <span class="material-symbols-outlined text-2xl">account_circle</span>
                                                        </div>
                                                        <div>
                                                            <h4 class="font-bold text-hotel-text uppercase text-sm tracking-tight"><%= c.getFullName() %></h4>
                                                            <p class="text-sm text-hotel-muted font-bold tracking-widest opacity-40 uppercase">#<%= c.getCustomerID() %></p>
                                                        </div>
                                                    </div>
                                                    <span class="tier-badge <%= tierClass %>">
                                                        <span class="material-symbols-outlined text-base"><%= icon %></span>
                                                        <%= tier %>
                                                    </span>
                                                </div>
                                                
                                                <div class="grid grid-cols-2 gap-4 pb-4 border-b border-hotel-gold/5">
                                                    <div>
                                                        <p class="text-xs font-bold text-hotel-muted uppercase tracking-widest mb-1">Tích Lũy</p>
                                                        <p class="text-xl font-serif font-bold text-hotel-text"><%= c.getPoints() %><span class="text-xs ml-1 opacity-40">điểm</span></p>
                                                    </div>
                                                    <div class="text-right">
                                                        <p class="text-xs font-bold text-hotel-muted uppercase tracking-widest mb-1">Chi Tiêu</p>
                                                        <p class="text-xl font-serif font-bold text-hotel-gold"><%= String.format("%,.0f", c.getTotalSpending()) %><span class="text-xs ml-1 opacity-40">VNĐ</span></p>
                                                    </div>
                                                </div>

                                                <div class="flex items-center justify-between gap-4">
                                                    <div class="flex-1 min-w-0">
                                                        <p class="text-sm font-medium text-hotel-text truncate opacity-70"><%= c.getEmail() %></p>
                                                        <p class="text-sm text-hotel-muted font-bold tracking-widest opacity-40"><%= c.getPhone() %></p>
                                                    </div>
                                                    <form action="${pageContext.request.contextPath}/admin/customers" method="post" class="flex items-center gap-2">
                                                        <input type="hidden" name="action" value="addPoints" />
                                                        <input type="hidden" name="customerId" value="<%=c.getCustomerID()%>" />
                                                        <input class="w-14 h-10 rounded-lg text-center font-serif font-bold text-sm input-elegant border-hotel-gold/10" name="points" type="number" value="10" />
                                                        <button type="submit" class="w-10 h-10 rounded-lg bg-hotel-gold text-white flex items-center justify-center shadow-md">
                                                            <span class="material-symbols-outlined text-sm">bolt</span>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        <% } } else { %>
                                            <div class="py-12 text-center text-hotel-muted/40 font-serif italic text-lg uppercase tracking-widest">
                                                Không tìm thấy dữ liệu hội viên
                                            </div>
                                        <% } %>
                                    </div>
le>
                                        </div>
                                    </div>

                                    <div class="text-center opacity-30 pt-8">
                                        <p
                                            class="font-serif italic text-hotel-muted text-base tracking-[0.5em] uppercase">
                                            SmartHotel CRM Engine • Intelligence Layer v2.0</p>
                                    </div>
                                </div>
                            </div>

                            <jsp:include page="/common/neural_shell_bottom.jspf" />
                        </body>

                        </html>

                        </html>