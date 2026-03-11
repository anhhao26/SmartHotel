<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Thống kê Lịch sử Nhập Kho | Quản lý Kho Khách Sạn</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
        rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: url('${pageContext.request.contextPath}/picture&background/warehouse.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #334155;
            padding-bottom: 3rem;
        }

        /* Thêm overlay mờ để nổi bật nội dung trên nền ảnh */
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(241, 245, 249, 0.85);
            /* Lớp phủ màu nền cũ với độ trong suốt 85% */
            z-index: -1;
        }

        /* Navbar Styling */
        .navbar-custom {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%) !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
            letter-spacing: 1px;
            color: #ffffff !important;
        }

        .navbar-brand span {
            color: #10b981;
            /* Điểm nhấn xanh lục cho chức năng báo cáo */
            font-weight: 600;
        }

        /* Container & Page Header */
        .container {
            max-width: 1100px;
            margin-top: 2rem;
        }

        .page-title {
            font-weight: 800;
            color: #0f172a;
            font-size: 1.6rem;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .page-title i {
            color: #3b82f6;
            /* Xanh dương của biểu đồ */
            margin-right: 12px;
            font-size: 1.8rem;
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
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Filter Section */
        .filter-section {
            background: #ffffff;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
            border: 1px solid #e2e8f0;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-form {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 0;
        }

        .filter-label {
            font-weight: 600;
            color: #475569;
            margin: 0;
        }

        .form-control-month {
            border-radius: 8px;
            border: 1px solid #cbd5e1;
            padding: 0.5rem 1rem;
            font-weight: 600;
            color: #1e293b;
            background-color: #f8fafc;
            transition: all 0.2s;
        }

        .form-control-month:focus {
            border-color: #3b82f6;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
            outline: none;
        }

        /* Table Card Container */
        .card-table {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.04);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            border-top: 4px solid #3b82f6;
            /* Nhấn khung trên */
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
            white-space: nowrap;
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

        /* Row Highlighting for Top 1 */
        .top-1-row {
            background-color: #fffbeb !important;
            /* Vàng nhạt cực sang */
        }

        .top-1-row td {
            border-bottom-color: #fde68a !important;
        }

        /* Badges & Text Styling */
        .rank-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            font-weight: 700;
            font-size: 0.95rem;
        }

        .rank-1 {
            background-color: #fbbf24;
            color: #78350f;
            box-shadow: 0 4px 10px rgba(251, 191, 36, 0.4);
        }

        .rank-2 {
            background-color: #94a3b8;
            color: #ffffff;
        }

        .rank-3 {
            background-color: #b45309;
            color: #ffffff;
        }

        .rank-other {
            background-color: #e2e8f0;
            color: #475569;
        }

        .product-id {
            font-weight: 700;
            color: #94a3b8;
        }

        .product-name {
            font-weight: 700;
            color: #1e293b;
            font-size: 1.05rem;
        }

        .supplier-tag {
            color: #64748b;
            font-weight: 500;
        }

        .quantity-tag {
            font-weight: 800;
            color: #059669;
            /* Xanh lá nhấn mạnh (thêm vào kho) */
            font-size: 1.15rem;
            background: #d1fae5;
            padding: 0.4rem 0.8rem;
            border-radius: 8px;
            display: inline-block;
        }

        /* Empty State */
        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
        }

        .empty-icon {
            font-size: 3.5rem;
            color: #cbd5e1;
            margin-bottom: 1.5rem;
        }

        .empty-text {
            color: #64748b;
            font-weight: 600;
            font-size: 1.15rem;
        }
    </style>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <a class="navbar-brand" href="#">
            <i class="fas fa-hotel mr-2 text-warning"></i>HOTEL ADMIN <span>| BÁO CÁO KHO</span>
        </a>
    </nav>

    <div class="container">
        <div class="filter-section">
            <h3 class="page-title">
                <i class="fas fa-chart-line"></i>
                Hàng Nhập Nhiều Nhất Trong Tháng
            </h3>

            <div class="d-flex align-items-center">
                <form action="products" method="get" class="filter-form">
                    <input type="hidden" name="action" value="history">

                    <label class="filter-label"><i class="fas fa-calendar-alt mr-2 text-primary"></i>Chọn
                        tháng:</label>
                    <input type="month" name="monthPicker" class="form-control-month"
                        value="${selectedMonth}" required onchange="this.form.submit()">

                    <button type="submit" class="btn btn-primary d-none">Lọc</button>
                </form>

                <a href="products" class="btn btn-top btn-outline-secondary ml-4">
                    <i class="fas fa-arrow-left"></i> Về Kho Hàng
                </a>
            </div>
        </div>

        <div class="card-table">
            <div class="table-responsive">
                <table class="table table-hover custom-table align-middle">
                    <thead>
                        <tr>
                            <th class="text-center" style="width: 100px;">Thứ Hạng</th>
                            <th>Mã SP</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Nhà Cung Cấp</th>
                            <th class="text-right">Tổng Lượng Nhập</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty importStats}">
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <div class="empty-icon"><i class="fas fa-box-open"></i></div>
                                        <div class="empty-text">Không có giao dịch nhập hàng nào trong tháng
                                            này!</div>
                                    </div>
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="stat" items="${importStats}" varStatus="loop">
                            <tr class="${loop.index == 0 ? 'top-1-row' : ''}">

                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${loop.index == 0}">
                                            <span class="rank-badge rank-1" title="Top 1"><i
                                                    class="fas fa-trophy"></i></span>
                                        </c:when>
                                        <c:when test="${loop.index == 1}">
                                            <span class="rank-badge rank-2" title="Top 2">2</span>
                                        </c:when>
                                        <c:when test="${loop.index == 2}">
                                            <span class="rank-badge rank-3" title="Top 3">3</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="rank-badge rank-other">${loop.index + 1}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="product-id">#${stat[0].itemID}</td>

                                <td class="product-name">
                                    ${stat[0].itemName}
                                    <c:if test="${loop.index == 0}">
                                        <i class="fas fa-fire ml-2 text-danger" title="Trending"></i>
                                    </c:if>
                                </td>

                                <td class="supplier-tag">
                                    <i class="fas fa-building mr-1 text-muted"></i>
                                    ${stat[0].supplier.supplierName}
                                </td>

                                <td class="text-right">
                                    <span class="quantity-tag">
                                        +${stat[1]} ${stat[0].unit}
                                    </span>
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