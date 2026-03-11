<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý Kho Khách Sạn (Module 2)</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: url('${pageContext.request.contextPath}/picture&background/warehouse.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #334155;
        }

        /* Thêm overlay mờ để nổi bật nội dung trên nền ảnh */
        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(241, 245, 249, 0.85); /* Lớp phủ màu nền cũ với độ trong suốt 85% */
            z-index: -1;
        }

        /* Navbar Styling */
        .navbar-custom {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%) !important;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 1rem 2rem;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
            letter-spacing: 1px;
            color: #ffffff !important;
        }
        .navbar-brand span {
            color: #fbbf24; /* Điểm nhấn viền vàng kim của khách sạn */
            font-weight: 600;
        }

        /* Container & Page Header */
        .container-fluid {
            padding: 1.5rem 3rem 3rem;
        }
        .page-title {
            font-weight: 800;
            color: #0f172a;
            font-size: 1.8rem;
            margin: 0;
        }
        .page-title i {
            color: #3b82f6;
        }

        /* Top Action Buttons */
        .btn-top {
            border-radius: 8px;
            font-weight: 600;
            padding: 0.6rem 1.2rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }
        .btn-top i {
            margin-right: 8px;
            font-size: 1.1rem;
        }
        .btn-top:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Custom Switch toggle */
        .custom-control-input:checked ~ .custom-control-label::before {
            background-color: #3b82f6;
            border-color: #3b82f6;
        }
        .custom-switch .custom-control-label {
            cursor: pointer;
            color: #475569;
            font-weight: 600;
            padding-top: 2px;
        }

        /* Table Card Container */
        .card-table {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.04);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            border-top: 4px solid #0f172a; /* Nhấn khung trên */
        }

        /* Table Customization */
        .custom-table {
            margin-bottom: 0;
        }
        .custom-table thead th {
            background-color: #f8fafc;
            color: #64748b;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 1.2rem 1.5rem;
            border-bottom: 2px solid #e2e8f0;
            border-top: none;
        }
        .custom-table tbody td {
            vertical-align: middle;
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.95rem;
            color: #334155;
        }
        .custom-table tbody tr {
            transition: background-color 0.2s ease;
        }
        .custom-table tbody tr:hover {
            background-color: #f8fafc;
        }

        /* Text Styles */
        .product-id { font-weight: 700; color: #94a3b8; }
        .product-name { font-weight: 700; color: #1e293b; }
        .cost-tag { font-weight: 600; color: #64748b; }
        .price-tag { font-weight: 700; color: #059669; font-size: 1.05rem; } /* Xanh ngọc sang trọng */

        /* Badges */
        .badge {
            padding: 0.5rem 0.8rem;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
        }
        .badge-kd { background-color: #e0e7ff; color: #4338ca; }
        .badge-nb { background-color: #fce7f3; color: #be185d; }
        .badge-success-soft { background-color: #d1fae5; color: #047857; }
        .badge-secondary-soft { background-color: #f1f5f9; color: #64748b; }

        /* Stock Warning Status */
        .stock-crit {
            background-color: #fee2e2;
            color: #dc2626 !important;
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            font-weight: 700;
            display: inline-block;
        }
        .stock-normal { font-weight: 700; color: #334155; }

        /* Action Buttons Inside Table */
        .btn-action {
            border-radius: 6px;
            padding: 0.4rem 0.75rem;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .btn-action i { font-size: 0.9rem; }
        
        .btn-warning { background-color: #f59e0b; border-color: #f59e0b; color: #fff !important; }
        .btn-warning:hover { background-color: #d97706; border-color: #d97706; }

        /* Dimmed Row for Inactive Products */
        .dimmed-row { background-color: #f8fafc !important; }
        .dimmed-row .product-name,
        .dimmed-row .product-id,
        .dimmed-row .cost-tag,
        .dimmed-row .price-tag,
        .dimmed-row .stock-normal {
            color: #94a3b8 !important;
        }
    </style>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
        <a class="navbar-brand" href="#">
            <i class="fas fa-hotel mr-2 text-warning"></i>HOTEL ADMIN <span>| MODULE 2 (KHO)</span>
        </a>
    </nav>

    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="page-title"><i class="fas fa-boxes mr-2"></i>Danh sách Vật tư & Hàng hóa</h3>

            <div class="d-flex align-items-center">
                <form action="products" method="get" class="mr-4 mb-0" id="filterForm">
                    <input type="hidden" name="action" value="list">

                    <div class="custom-control custom-switch">
                        <input type="checkbox" class="custom-control-input" id="switchHidden"
                            name="showHidden" value="true" ${isShowHidden ? 'checked' : '' }
                            onchange="document.getElementById('filterForm').submit()">
                        <label class="custom-control-label" for="switchHidden">
                            Hiện cả hàng đã ẩn
                        </label>
                    </div>
                </form>
                
                <a href="products?action=history" class="btn btn-top btn-outline-info mr-2">
                    <i class="fas fa-history"></i> Báo cáo Nhập Kho
                </a>
                <a href="products?action=listSuppliers" class="btn btn-top btn-outline-primary mr-2">
                    <i class="fas fa-truck"></i> Quản lý NCC
                </a>
                <a href="products?action=new" class="btn btn-top btn-success">
                    <i class="fas fa-plus-circle"></i> Nhập hàng mới
                </a>
            </div>
        </div>

        <div class="card-table">
            <div class="table-responsive">
                <table class="table table-hover custom-table align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Loại hàng</th>
                            <th>Đơn vị</th>
                            <th>Tồn kho</th>
                            <th>Giá Nhập</th>
                            <th>Giá Bán</th>
                            <th>Trạng thái</th>
                            <th class="text-center" style="width: 290px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${listProducts}">
                            <tr class="${p.isActive ? '' : 'dimmed-row'}">
                                
                                <td class="product-id">#${p.itemID}</td>
                                
                                <td class="product-name">${p.itemName}</td>

                                <td>
                                    <c:if test="${p.isTradeGood}">
                                        <span class="badge badge-kd"><i class="fas fa-tags mr-1"></i>Hàng bán (KD)</span>
                                    </c:if>
                                    <c:if test="${!p.isTradeGood}">
                                        <span class="badge badge-nb"><i class="fas fa-pump-soap mr-1"></i>Tiêu hao (NB)</span>
                                    </c:if>
                                </td>

                                <td class="font-weight-bold text-secondary">${p.unit}</td>

                                <td>
                                    <span class="${p.quantity <= 10 ? 'stock-crit' : 'stock-normal'}">
                                        <c:if test="${p.quantity <= 10}">
                                            <i class="fas fa-exclamation-triangle mr-1"></i>
                                        </c:if>
                                        ${p.quantity}
                                    </span>
                                </td>

                                <td class="cost-tag">${p.costPrice}</td>
                                <td class="price-tag">${p.sellingPrice}</td>

                                <td>
                                    <c:if test="${p.isActive}">
                                        <span class="badge badge-success-soft"><i class="fas fa-check-circle mr-1"></i>Đang bán</span>
                                    </c:if>
                                    <c:if test="${!p.isActive}">
                                        <span class="badge badge-secondary-soft"><i class="fas fa-ban mr-1"></i>Ngừng KD</span>
                                    </c:if>
                                </td>

                                <td class="text-center" style="white-space: nowrap;">
                                    <c:if test="${p.isActive}">
                                        <a href="products?action=edit&id=${p.itemID}"
                                            class="btn btn-action btn-info mr-1" title="Sửa thông tin">
                                            <i class="fas fa-edit mr-1"></i>Sửa
                                        </a>
                                        <a href="products?action=import&id=${p.itemID}"
                                            class="btn btn-action btn-success mr-1" title="Khởi tạo phiếu nhập">
                                            <i class="fas fa-box-open mr-1"></i>Nhập
                                        </a>

                                        <form action="products" method="POST" style="display:inline;" class="mr-1">
                                            <input type="hidden" name="action" value="softDelete">
                                            <input type="hidden" name="id" value="${p.itemID}">
                                            <button type="submit" class="btn btn-action btn-warning"
                                                onclick="return confirm('Bạn có chắc muốn ngừng kinh doanh sản phẩm này?');" title="Ẩn hiển thị">
                                                <i class="fas fa-eye-slash mr-1"></i>Ẩn
                                            </button>
                                        </form>
                                    </c:if>

                                    <c:if test="${!p.isActive}">
                                        <form action="products" method="POST" style="display:inline;" class="mr-1">
                                            <input type="hidden" name="action" value="restore">
                                            <input type="hidden" name="id" value="${p.itemID}">
                                            <button type="submit" class="btn btn-action btn-primary" title="Khôi phục trạng thái">
                                                <i class="fas fa-undo mr-1"></i>Khôi phục
                                            </button>
                                        </form>
                                    </c:if>

                                    <form action="products" method="POST" style="display:inline;">
                                        <input type="hidden" name="action" value="hardDelete">
                                        <input type="hidden" name="id" value="${p.itemID}">
                                        <button type="submit" class="btn btn-action btn-danger"
                                            onclick="return confirm('Nguy hiểm: Xóa vĩnh viễn không thể khôi phục? (Toàn bộ dữ liệu liên quan sẽ biến mất!');" title="Xóa vĩnh viễn">
                                            <i class="fas fa-trash-alt mr-1"></i>Xóa
                                        </button>
                                    </form>
                                </td>
                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>