<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Nhập Kho Cung Ứng | Quản lý Kho Khách Sạn</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: url('${pageContext.request.contextPath}/picture&background/warehouse.jpg') no-repeat center center fixed; background-size: cover; color: #334155; padding-bottom: 3rem; min-height: 100vh; display: flex; align-items: center; }
        body::before { content: ""; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(241, 245, 249, 0.85); z-index: -1; }
        .card-form { background: #ffffff; border-radius: 16px; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.06); border: none; overflow: hidden; width: 100%; margin: auto; }
        .card-header-custom { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); color: #ffffff; padding: 1.5rem 2rem; border-bottom: none; text-align: center; border-top: 4px solid #3b82f6; }
        .card-header-custom h4 { margin: 0; font-weight: 700; font-size: 1.4rem; letter-spacing: 0.5px; }
        .card-header-custom h4 i { color: #3b82f6; margin-right: 10px; }
        .sub-title { font-size: 0.9rem; color: #94a3b8; margin-top: 5px; }
        .card-body-custom { padding: 2.5rem 3rem; }
        label { font-weight: 600; color: #475569; margin-bottom: 0.5rem; font-size: 0.95rem; }
        .form-control { border-radius: 8px; border: 1px solid #cbd5e1; padding: 0.75rem 1rem; height: auto; font-size: 1rem; color: #1e293b; transition: all 0.2s; background-color: #f8fafc; }
        .form-control:focus { background-color: #ffffff; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); outline: none; }
        input[disabled], input[readonly] { background-color: #e2e8f0 !important; color: #64748b !important; border-color: #cbd5e1 !important; cursor: not-allowed; font-weight: 700; }
        .input-group-text { background-color: #f1f5f9; border: 1px solid #cbd5e1; border-right: none; border-radius: 8px 0 0 8px; color: #64748b; }
        .form-control-group { border-left: none; border-radius: 0 8px 8px 0; }
        .btn-action { border-radius: 8px; padding: 0.8rem 1.5rem; font-weight: 700; font-size: 1.05rem; transition: all 0.3s ease; }
        .btn-save { background-color: #3b82f6; border-color: #3b82f6; color: white; box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3); }
        .btn-save:hover { background-color: #2563eb; transform: translateY(-2px); box-shadow: 0 6px 15px rgba(59, 130, 246, 0.4); color: white; }
        .btn-cancel { background-color: #f1f5f9; border-color: #cbd5e1; color: #64748b; }
        .btn-cancel:hover { background-color: #e2e8f0; color: #334155; }
        .product-badge { display: inline-block; background: #e0e7ff; color: #4338ca; padding: 8px 20px; border-radius: 30px; font-size: 1rem; font-weight: 600; margin-bottom: 25px; border: 1px solid #c7d2fe; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); }
        .form-text-custom { font-size: 0.85rem; color: #64748b; margin-top: 6px; display: block; }
    </style>
</head>

<body>
    <div class="container" style="max-width: 650px;">
        <div class="card card-form">
            <div class="card-header-custom">
                <h4><i class="fas fa-box-open"></i> Giao Dịch Nhập Kho</h4>
                <div class="sub-title">Hệ Thống Quản Lý Kho Khách Sạn</div>
            </div>

            <div class="card-body-custom">
                <div class="text-center">
                    <div class="product-badge">
                        <i class="fas fa-tag mr-2"></i> ${product.itemName}
                    </div>
                </div>

                <form action="products" method="post" id="importForm">
                    <input type="hidden" name="action" value="saveImport">
                    <input type="hidden" name="id" value="${product.itemID}">

                    <div class="form-group mb-4">
                        <label><i class="fas fa-cubes mr-2 text-primary"></i>Tồn kho hiện tại:</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-box"></i></span>
                            </div>
                            <input type="text" class="form-control form-control-group text-center"
                                style="font-size: 1.1rem" value="${product.quantity}" disabled>
                        </div>
                    </div>

                    <div class="form-group mb-4">
                        <label><i class="fas fa-truck-loading mr-2 text-primary"></i>Số lượng NHẬP THÊM <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-plus-circle"></i></span>
                            </div>
                            <input type="number" name="quantityToAdd" class="form-control form-control-group" min="1" placeholder="Vui lòng nhập số lượng..." required>
                        </div>
                        <small class="form-text-custom"><i class="fas fa-info-circle mr-1"></i>Số lượng hàng hóa thực tế được bổ sung vào hệ thống kho phòng.</small>
                    </div>

                    <div class="form-group mb-5">
                        <label><i class="fas fa-money-bill-wave mr-2 text-primary"></i>Đơn giá nhập mới (Cost) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-coins"></i></span>
                            </div>
                            <input type="number" name="newCostPrice" class="form-control font-weight-bold text-success" style="border-radius: 0;" value="${product.costPrice}" required>
                            <div class="input-group-append">
                                <span class="input-group-text" style="border-radius: 0 8px 8px 0; border-left: none; background-color: #ffffff; color: #10b981; font-weight: bold;">VNĐ</span>
                            </div>
                        </div>
                        <small class="form-text-custom"><i class="fas fa-check-circle mr-1 text-success"></i>Hệ thống sẽ tự động cập nhật giá vốn nếu có sự thay đổi từ nhà cung cấp.</small>
                    </div>

                    <div class="row mt-2">
                        <div class="col-sm-5 mb-3 mb-sm-0">
                            <a href="products" class="btn btn-cancel btn-action w-100">
                                <i class="fas fa-arrow-left mr-2"></i>Trở về
                            </a>
                        </div>
                        <div class="col-sm-7">
                            <button type="submit" class="btn btn-save btn-action w-100" id="submitBtn">
                                <i class="fas fa-check mr-2"></i>Xác Nhận Lưu Kho
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        document.getElementById('importForm').addEventListener('submit', function () {
            var btn = document.getElementById('submitBtn');
            btn.innerHTML = '<i class="fas fa-circle-notch fa-spin mr-2"></i> Đang cập nhật...';
            btn.style.opacity = '0.8';
            btn.style.pointerEvents = 'none';
        });
    </script>
</body>
</html>