<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Danh Sách Nhà Cung Cấp - SmartHotel</title>

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
                    box-shadow: 0 20px 40px -15px rgba(74, 66, 56, 0.05);
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .card-elegant:hover {
                    border-color: rgba(184, 154, 108, 0.3);
                    transform: translateY(-2px);
                    box-shadow: 0 30px 60px -20px rgba(74, 66, 56, 0.1);
                }

                .btn-gold {
                    background: #B89A6C;
                    color: white;
                    transition: all 0.3s ease;
                }

                .btn-gold:hover {
                    background: #4A4238;
                    transform: translateY(-1px);
                }

                .table-header {
                    background: rgba(184, 154, 108, 0.03);
                    border-bottom: 2px solid rgba(184, 154, 108, 0.1);
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

        <body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

            <jsp:include page="/common/neural_shell_top.jspf">
                <jsp:param name="active" value="inventory" />
            </jsp:include>

            <!-- Supplier Registry Content -->
            <div class="flex-1 h-screen overflow-y-auto pb-32">
                <div class="max-w-7xl mx-auto px-8 py-12 animate-[fadeIn_0.6s_ease-out] space-y-12">

                    <!-- Header Section -->
                    <div class="flex flex-col md:flex-row md:items-end justify-between gap-8">
                        <div class="space-y-4">
                            <div
                                class="inline-flex items-center gap-2 px-4 py-1 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold tracking-[0.2em] uppercase">
                                Hệ Thống Quản Lý Đối Tác
                            </div>
                            <h2
                                class="text-6xl font-serif font-bold text-hotel-text tracking-tight leading-tight italic uppercase">
                                Đối Tác <span class="text-hotel-gold">Cung Ứng.</span>
                            </h2>
                            <p
                                class="text-hotel-muted text-lg font-medium tracking-tight border-l-2 border-hotel-gold pl-6 py-1 opacity-80 uppercase tracking-widest">
                                Quản lý mạng lưới nhà cung cấp và chuỗi giá trị SmartHotel.
                            </p>
                        </div>
                        <div class="flex gap-4">
                            <a href="products?action=newSupplier"
                                class="px-8 py-4 rounded-xl btn-gold font-bold text-sm tracking-[0.2em] uppercase flex items-center gap-3 shadow-lg">
                                <span class="material-symbols-outlined text-lg text-white/80">person_add</span> Thêm nhà
                                cung cấp
                            </a>
                        </div>
                    </div>

                    <c:if test="${param.error != null}">
                        <div
                            class="p-8 rounded-[2rem] bg-accent-ruby/5 border border-accent-ruby/20 flex items-center gap-6 group animate-[bounce_2s_infinite]">
                            <span class="material-symbols-outlined text-accent-ruby text-3xl">report</span>
                            <p
                                class="text-base font-bold text-accent-ruby uppercase tracking-widest italic leading-relaxed">
                                Hệ thống: Vui lòng kiểm tra tồn kho liên quan hoặc các liên kết dữ liệu trước khi xóa
                                nhà cung cấp này.
                            </p>
                        </div>
                    </c:if>

                    <!-- Registry Table -->
                    <div
                        class="card-elegant rounded-[2.5rem] border border-hotel-gold/10 overflow-hidden relative shadow-xl">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left">
                                <thead class="table-header">
                                    <tr class="text-sm font-bold text-hotel-chocolate uppercase tracking-[0.4em]">
                                        <th class="px-10 py-8">Mã số đối tác</th>
                                        <th class="px-10 py-8">Tên Công Ty / Đối Tác</th>
                                        <th class="px-10 py-8">Thông tin Liên hệ</th>
                                        <th class="px-10 py-8">Văn phòng / Địa chỉ</th>
                                        <th class="px-10 py-8 text-center">Thao tác quản lý</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-hotel-gold/5">
                                    <c:forEach var="s" items="${listSuppliers}">
                                        <tr class="hover:bg-hotel-gold/5 transition-all duration-300 group">
                                            <td class="px-10 py-8">
                                                <span
                                                    class="text-base font-bold text-hotel-muted/40 italic tracking-widest group-hover:text-hotel-gold transition-colors">
                                                    SUPP_#${s.supplierID}</span>
                                            </td>
                                            <td class="px-10 py-8">
                                                <div class="flex items-center gap-5">
                                                    <div
                                                        class="w-12 h-16 rounded-xl bg-hotel-gold/10 flex items-center justify-center text-hotel-gold border border-hotel-gold/10 group-hover:scale-110 transition-transform">
                                                        <span class="material-symbols-outlined text-2xl">business</span>
                                                    </div>
                                                    <span
                                                        class="text-lg font-serif font-bold text-hotel-text uppercase italic tracking-tight group-hover:text-hotel-gold transition-colors">
                                                        ${s.supplierName}</span>
                                                </div>
                                            </td>
                                            <td class="px-10 py-8">
                                                <div
                                                    class="flex items-center gap-2 text-hotel-muted font-bold tracking-widest text-base">
                                                    <span
                                                        class="material-symbols-outlined text-sm opacity-40">call</span>
                                                    ${s.contactPhone}
                                                </div>
                                            </td>
                                            <td class="px-10 py-8">
                                                <p
                                                    class="text-base font-medium text-hotel-muted group-hover:text-hotel-text transition-colors uppercase tracking-wider italic truncate max-w-[250px]">
                                                    ${s.address}</p>
                                            </td>
                                            <td class="px-10 py-8">
                                                <div class="flex items-center justify-center gap-4">
                                                    <a href="products?action=editSupplier&id=${s.supplierID}"
                                                        class="w-12 h-16 rounded-xl bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold hover:bg-hotel-gold hover:text-white transition-all flex items-center justify-center shadow-sm active:scale-90"
                                                        title="Chỉnh sửa">
                                                        <span class="material-symbols-outlined text-xl">edit</span>
                                                    </a>
                                                    <a href="products?action=deleteSupplier&id=${s.supplierID}"
                                                        onclick="return confirm('CẢNH BÁO: Tiếp tục gỡ bỏ đối tác? Các sản phẩm liên kết sẽ bị ảnh hưởng.');"
                                                        class="w-12 h-16 rounded-xl bg-accent-ruby/5 border border-accent-ruby/10 text-accent-ruby hover:bg-accent-ruby hover:text-white transition-all flex items-center justify-center shadow-sm active:scale-90"
                                                        title="Xóa đối tác">
                                                        <span class="material-symbols-outlined text-xl">delete</span>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty listSuppliers}">
                                        <tr>
                                            <td colspan="5" class="py-40 text-center opacity-40 italic">
                                                <div class="flex flex-col items-center gap-8">
                                                    <span
                                                        class="material-symbols-outlined text-8xl text-hotel-gold">public_off</span>
                                                    <p
                                                        class="text-base font-bold text-hotel-muted uppercase tracking-[0.5em]">
                                                        Hiện chưa có thông tin đối tác cung cấp</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="text-center opacity-40 py-8">
                        <p class="font-serif italic text-hotel-muted text-base tracking-[0.5em] uppercase">SmartHotel
                            Luxury Management System • Partner Network v2.0</p>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/neural_shell_bottom.jspf" />
        </body>

        </html>

        </html>