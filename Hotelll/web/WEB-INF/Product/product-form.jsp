<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Sản phẩm | Quản lý Kho</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: url('${pageContext.request.contextPath}/picture&background/warehouse.jpg') no-repeat center center fixed; background-size: cover; color: #334155; padding-bottom: 3rem; }
        body::before { content: ""; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(241, 245, 249, 0.85); z-index: -1; }
        .page-header { margin-top: 2rem; margin-bottom: 2rem; text-align: center; }
        .card-form { background: #ffffff; border-radius: 16px; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.06); border: none; overflow: hidden; max-width: 800px; margin: auto; }
        .card-header-custom { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); color: #ffffff; padding: 1.5rem 2rem; border-bottom: none; }
        .card-header-custom h4 { margin: 0; font-weight: 700; font-size: 1.4rem; letter-spacing: 0.5px; }
        .card-header-custom h4 i { color: #fbbf24; margin-right: 10px; }
        .card-body-custom { padding: 2.5rem; }
        label { font-weight: 600; color: #475569; margin-bottom: 0.5rem; font-size: 0.95rem; }
        .form-control, .custom-select { border-radius: 8px; border: 1px solid #cbd5e1; padding: 0.6rem 1rem; height: auto; font-size: 1rem; color: #1e293b; transition: all 0.2s; background-color: #f8fafc; }
        .form-control:focus, .custom-select:focus { background-color: #ffffff; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); outline: none; }
        input[readonly] { background-color: #e2e8f0 !important; color: #64748b !important; border-color: #cbd5e1 !important; cursor: not-allowed; }
        .radio-box-container { border: 1px solid #cbd5e1; border-radius: 10px; padding: 1rem 1.5rem; background-color: #ffffff; display: flex; align-items: center; gap: 2rem; }
        .custom-control-label { cursor: pointer; padding-top: 2px; font-size: 1rem; }
        .radio-kd { color: #047857 !important; }
        .radio-nb { color: #be185d !important; }
        .input-group .btn { border-top-right-radius: 8px; border-bottom-right-radius: 8px; font-weight: 600; }
        .btn-action { border-radius: 8px; padding: 0.8rem 1.5rem; font-weight: 700; font-size: 1.05rem; transition: all 0.3s ease; }
        .btn-save { background-color: #3b82f6; border-color: #3b82f6; color: white; box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3); }
        .btn-save:hover { background-color: #2563eb; transform: translateY(-2px); box-shadow: 0 6px 15px rgba(59, 130, 246, 0.4); color: white; }
        .btn-cancel { background-color: #f1f5f9; border-color: #cbd5e1; color: #64748b; }
        .btn-cancel:hover { background-color: #e2e8f0; color: #334155; }
        .text-danger-custom { color: #ef4444; font-size: 0.85rem; font-weight: 500; margin-top: 5px; display: block; }
    </style>
</head>

<body>
    <div class="container">
        <div class="page-header"></div>
        <div class="card card-form">
            <div class="card-header-custom text-center">
                <h4>
                    <c:if test="${product != null}">
                        <i class="fas fa-edit"></i> Cập nhật Thông tin Sản phẩm
                    </c:if>
                    <c:if test="${product == null}">
                        <i class="fas fa-box-open"></i> Nhập Kho Danh Mục Mới
                    </c:if>
                </h4>
            </div>

            <div class="card-body-custom">
                <form action="products" method="post">
                    <c:if test="${product != null}">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" value="${product.itemID}" />
                    </c:if>
                    <c:if test="${product == null}">
                        <input type="hidden" name="action" value="insert" />
                    </c:if>

                    <div class="form-group mb-4">
                        <label><i class="fas fa-tag mr-2 text-primary"></i>Tên vật tư / hàng hóa (*):</label>
                        <input type="text" class="form-control" name="name" value="${product.itemName}"
                            placeholder="Ví dụ: Nước suối Aquafina 500ml" required />
                    </div>

                    <div class="form-group mb-4">
                        <label><i class="fas fa-layer-group mr-2 text-primary"></i>Phân loại mặt hàng (*):</label>
                        <div class="radio-box-container">
                            <div class="custom-control custom-radio">
                                <input type="radio" id="trade1" name="isTradeGood" value="1"
                                    class="custom-control-input" ${product==null || product.isTradeGood ? 'checked' : '' } onclick="toggleSellingPrice(true)">
                                <label class="custom-control-label font-weight-bold radio-kd" for="trade1">
                                    <i class="fas fa-shopping-cart mr-1"></i> Hàng bán lẻ (Kinh doanh)
                                </label>
                            </div>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="trade2" name="isTradeGood" value="0"
                                    class="custom-control-input" ${product !=null && !product.isTradeGood ? 'checked' : '' } onclick="toggleSellingPrice(false)">
                                <label class="custom-control-label font-weight-bold radio-nb" for="trade2">
                                    <i class="fas fa-pump-soap mr-1"></i> Vật tư tiêu hao (Sử dụng nội bộ)
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6 form-group mb-0">
                            <label><i class="fas fa-balance-scale mr-2 text-primary"></i>Đơn vị tính:</label>
                            <input type="text" class="form-control" name="unit" value="${product.unit}" placeholder="Lon, Gói, Lốc, Chai..." required />
                        </div>
                        <div class="col-md-6 form-group mb-0">
                            <label><i class="fas fa-cubes mr-2 text-primary"></i>Số lượng tồn:</label>
                            <input type="number" class="form-control font-weight-bold" name="quantity"
                                value="${product.quantity != null ? product.quantity : '0'}" ${product!=null ? 'readonly' : 'required' } />
                            <c:if test="${product != null}">
                                <small class="text-danger-custom">
                                    <i class="fas fa-info-circle mr-1"></i>Để thay đổi mức tồn kho, vui lòng tạo "Phiếu Nhập".
                                </small>
                            </c:if>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6 form-group mb-0">
                            <label><i class="fas fa-file-invoice-dollar mr-2 text-primary"></i>Giá Nhập (Cost):</label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="costPrice"
                                    value="${product.costPrice != null ? product.costPrice : '0'}" ${product!=null ? 'readonly' : 'required' } />
                                <div class="input-group-append">
                                    <span class="input-group-text font-weight-bold">VNĐ</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 form-group mb-0">
                            <label class="text-success font-weight-bold"><i class="fas fa-money-bill-wave mr-2"></i>Giá Bán ra (Selling):</label>
                            <div class="input-group">
                                <input type="number" id="sellingPriceInput"
                                    class="form-control border-success text-success font-weight-bold" name="sellingPrice"
                                    value="${product.sellingPrice != null ? product.sellingPrice : '0'}" required />
                                <div class="input-group-append">
                                    <span class="input-group-text bg-white border-success text-success font-weight-bold">VNĐ</span>
                                </div>
                            </div>
                            <small id="priceNote" class="text-muted mt-1 d-block"><i class="fas fa-cogs mr-1"></i>Giá này dùng để tính tiền cho khách.</small>
                        </div>
                    </div>

                    <div class="form-group mb-5">
                        <label><i class="fas fa-truck mr-2 text-primary"></i>Nhà cung cấp:</label>
                        <div class="input-group">
                            <select name="supplierID" class="form-control custom-select">
                                <c:forEach var="s" items="${listSuppliers}">
                                    <option value="${s.supplierID}" ${product.supplier.supplierID==s.supplierID ? 'selected' : '' }>${s.supplierName}</option>
                                </c:forEach>
                            </select>
                            <div class="input-group-append">
                                <a href="products?action=newSupplier" class="btn btn-outline-primary" style="border-radius: 0 8px 8px 0; background: #e0e7ff; color: #4338ca; border-color: #cbd5e1;">
                                    <i class="fas fa-plus"></i> NCC Mới
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6 mb-2 mb-sm-0">
                            <a href="products" class="btn btn-cancel btn-action w-100">
                                <i class="fas fa-arrow-left mr-2"></i>Quay lại
                            </a>
                        </div>
                        <div class="col-sm-6">
                            <button type="submit" class="btn btn-save btn-action w-100">
                                <i class="fas fa-save mr-2"></i>Lưu Dữ Liệu
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleSellingPrice(isTrade) {
            var input = document.getElementById("sellingPriceInput");
            var note = document.getElementById("priceNote");
            var inputGroupText = input.nextElementSibling.querySelector('.input-group-text');

            if (isTrade) {
                input.readOnly = false;
                input.style.backgroundColor = "#ffffff";
                input.setAttribute("required", "true");
                input.classList.add("border-success", "text-success");
                if (inputGroupText) {
                    inputGroupText.classList.add("border-success", "text-success", "bg-white");
                    inputGroupText.classList.remove("text-muted");
                }
                note.innerHTML = '<i class="fas fa-cogs mr-1"></i> Giá này dùng để xuất hóa đơn cho khách.';
                note.className = "text-muted mt-1 d-block";
            } else {
                input.value = 0;
                input.readOnly = true;
                input.classList.remove("border-success", "text-success");
                if (inputGroupText) {
                    inputGroupText.classList.remove("border-success", "text-success", "bg-white");
                    inputGroupText.classList.add("text-muted");
                    inputGroupText.style.backgroundColor = "#e2e8f0";
                }
                input.removeAttribute("required");
                note.innerHTML = '<i class="fas fa-ban mr-1"></i> Hàng nội bộ không có giá bán (Mặc định = 0).';
                note.className = "text-danger mt-1 d-block font-weight-bold";
            }
        }
        window.onload = function () {
            var isTrade = document.getElementById("trade1").checked;
            toggleSellingPrice(isTrade);
        };
    </script>
</body>
</html>