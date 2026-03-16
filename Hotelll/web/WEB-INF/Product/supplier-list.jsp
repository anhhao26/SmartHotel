<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đối Tác Cung Ứng | SmartHotel Logistics</title>
    
    <!-- Premium Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

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
        .card-elegant:hover {
            transform: translateY(-5px);
            border-color: rgba(184, 154, 108, 0.3);
            box-shadow: 0 20px 60px rgba(184, 154, 108, 0.08);
        }
        .table-row-hover:hover { background-color: rgba(184, 154, 108, 0.02); }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

    <jsp:include page="/common/neural_shell_top.jspf">
        <jsp:param name="active" value="inventory" />
    </jsp:include>

    <!-- Supplier List Content -->
    <div class="flex-1 h-screen overflow-y-auto pb-32">
        <div class="max-w-7xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">
            
            <!-- Header Section -->
            <div class="flex justify-between items-end py-12">
                <div class="space-y-4">
                    <div class="inline-flex items-center gap-3 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold text-[9px] font-bold tracking-[0.3em] uppercase">
                        <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                        Quan hệ đối tác chiến lược
                    </div>
                    <h2 class="text-5xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                        Nhà <span class="text-hotel-gold italic">Cung Cấp.</span>
                    </h2>
                </div>
                
                <div class="flex items-center gap-4">
                    <a href="products" class="inline-flex items-center gap-3 px-6 py-4 rounded-xl bg-white border border-hotel-gold/20 text-hotel-muted text-[10px] font-bold tracking-widest uppercase hover:bg-hotel-gold hover:text-white transition-all shadow-sm">
                        <span class="material-symbols-outlined text-lg">arrow_back</span> Kho Hàng
                    </a>
                    <a href="products?action=newSupplier" class="inline-flex items-center gap-3 px-8 py-4 rounded-xl bg-hotel-gold text-white text-[10px] font-bold tracking-widest uppercase hover:bg-hotel-text transition-all shadow-lg shadow-hotel-gold/20">
                        <span class="material-symbols-outlined text-lg">person_add</span> Thêm Nhà Cung Cấp
                    </a>
                </div>
            </div>

            <c:if test="${param.error != null}">
                <div class="mb-10 p-6 rounded-3xl bg-red-50 border border-red-100 flex items-center gap-5 animate-bounce">
                    <div class="w-12 h-12 rounded-2xl bg-white flex items-center justify-center text-red-500 shadow-sm">
                        <span class="material-symbols-outlined">warning</span>
                    </div>
                    <div>
                        <p class="text-[11px] font-bold text-red-600 uppercase tracking-widest">Không thể xóa đối tác này</p>
                        <p class="text-[9px] text-red-400 font-bold opacity-80">Hệ thống ghi nhận đang có tồn kho từ nhà cung cấp này. Vui lòng kiểm tra lại.</p>
                    </div>
                </div>
            </c:if>

            <!-- Supplier Table -->
            <div class="card-elegant rounded-[2.5rem] overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="bg-hotel-bone/50 border-b border-hotel-gold/10">
                                <th class="px-10 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Mã Đối Tác</th>
                                <th class="px-10 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Tên Đơn Vị</th>
                                <th class="px-10 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em]">Thông Tin Liên Hệ</th>
                                <th class="px-10 py-6 text-[9px] font-bold text-hotel-gold uppercase tracking-[0.2em] text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-hotel-gold/5">
                            <c:forEach var="s" items="${listSuppliers}">
                                <tr class="table-row-hover transition-colors">
                                    <td class="px-10 py-8">
                                        <div class="w-14 h-14 rounded-2xl bg-hotel-cream border border-hotel-gold/10 flex items-center justify-center font-serif font-bold italic text-hotel-gold text-lg">
                                            #${s.supplierID}
                                        </div>
                                    </td>
                                    <td class="px-10 py-8">
                                        <p class="text-[14px] font-bold text-hotel-text uppercase tracking-widest mb-1">${s.supplierName}</p>
                                        <div class="flex items-center gap-2 text-hotel-muted">
                                            <span class="material-symbols-outlined text-[14px] opacity-40">location_on</span>
                                            <p class="text-[9px] font-bold tracking-wider">${s.address}</p>
                                        </div>
                                    </td>
                                    <td class="px-10 py-8">
                                        <div class="inline-flex items-center gap-3 px-5 py-2.5 rounded-xl bg-hotel-gold/5 border border-hotel-gold/10 text-hotel-gold">
                                            <span class="material-symbols-outlined text-sm">phone_in_talk</span>
                                            <span class="text-[12px] font-bold tracking-widest">${s.contactPhone}</span>
                                        </div>
                                    </td>
                                    <td class="px-10 py-8">
                                        <div class="flex items-center justify-center gap-3">
                                            <a href="products?action=editSupplier&id=${s.supplierID}" class="w-12 h-12 rounded-xl bg-hotel-bone border border-hotel-gold/10 flex items-center justify-center text-hotel-muted hover:text-hotel-gold hover:border-hotel-gold hover:shadow-lg transition-all" title="Sửa">
                                                <span class="material-symbols-outlined text-xl">edit_square</span>
                                            </a>
                                            <a href="products?action=deleteSupplier&id=${s.supplierID}" 
                                               onclick="return confirm('XÓA ĐỐI TÁC: Toàn bộ sản phẩm liên quan sẽ bị ảnh hưởng. Tiếp tục?')"
                                               class="w-12 h-12 rounded-xl bg-red-50 border border-red-100 flex items-center justify-center text-red-400 hover:bg-red-500 hover:text-white hover:border-red-500 hover:shadow-lg transition-all" title="Xóa">
                                                <span class="material-symbols-outlined text-xl">person_remove</span>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <c:if test="${empty listSuppliers}">
                <div class="py-32 text-center opacity-30">
                    <span class="material-symbols-outlined text-8xl block mb-6">group_off</span>
                    <h3 class="text-xl font-serif font-bold text-hotel-text uppercase tracking-[0.2em]">Chưa có đối tác cung ứng</h3>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="/common/neural_shell_bottom.jspf" />
</body>
</html>