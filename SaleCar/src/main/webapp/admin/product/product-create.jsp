<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo sản phẩm mới | LUXCAR Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Include TinyMCE for rich text editor -->
    <script src="https://cdn.tiny.cloud/1/YOUR_API_KEY/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
    <style>
        /* ========== GLOBAL STYLES ========== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
            color: #1e293b;
        }

        /* ========== SIDEBAR STYLES ========== */
        .sidebar {
            width: 280px;
            background-color: #ffffff;
            border-right: 1px solid #e9edf2;
            height: 100vh;
            position: sticky;
            top: 0;
            padding: 2rem 1.2rem;
            transition: all 0.3s;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1e2a3a, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 2.5rem;
            letter-spacing: -0.5px;
        }

        .logo i {
            background: none;
            color: #2c7da0;
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
        }

        .sidebar nav ul li {
            margin-bottom: 0.6rem;
        }

        .sidebar nav ul li a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 18px;
            border-radius: 14px;
            color: #5a6e7c;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 0.95rem;
        }

        .sidebar nav ul li a i {
            font-size: 1.3rem;
            width: 24px;
        }

        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #f0f9ff;
            color: #2c7da0;
            box-shadow: 0 2px 4px rgba(44, 125, 160, 0.08);
            border-left: 2px solid #2c7da0;
        }

        /* ========== MAIN CONTENT ========== */
        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }

        /* ========== HEADER ========== */
        .admin-header {
            background: #ffffff;
            padding: 1rem 1.8rem;
            border-radius: 24px;
            margin-bottom: 2rem;
            border: 1px solid #e9edf2;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .admin-header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        /* ========== BUTTONS ========== */
        .admin-btn-primary {
            background-color: #2c7da0;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
            cursor: pointer;
        }

        .admin-btn-primary:hover {
            background-color: #1f5e7a;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44, 125, 160, 0.2);
        }

        .admin-btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
            cursor: pointer;
        }

        .admin-btn-outline {
            border: 1px solid #e2e8f0;
            background: transparent;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
            cursor: pointer;
        }

        .admin-btn-outline:hover {
            border-color: #2c7da0;
            color: #2c7da0;
            background-color: #f8fafc;
        }

        .admin-btn-secondary {
            background-color: #6c757d;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
            cursor: pointer;
        }

        /* ========== CARDS ========== */
        .info-section {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s;
        }

        .info-section h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.2rem;
            color: #1e293b;
            border-left: 3px solid #2c7da0;
            padding-left: 0.75rem;
        }

        .info-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
            margin-bottom: 0.25rem;
            font-weight: 600;
        }

        .info-value {
            font-size: 0.95rem;
            font-weight: 500;
            color: #1e293b;
            word-break: break-word;
        }

        /* Form styles */
        .form-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 0.6rem 1rem;
            font-size: 0.9rem;
            transition: all 0.2s;
        }

        .form-control:focus, .form-select:focus {
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44, 125, 160, 0.1);
        }

        .is-invalid {
            border-color: #dc3545;
        }

        .invalid-feedback {
            font-size: 0.75rem;
            margin-top: 0.25rem;
        }

        /* Image gallery styles */
        .image-preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 1rem;
        }

        .image-preview-item {
            position: relative;
            width: 100px;
            height: 100px;
            border-radius: 8px;
            overflow: hidden;
            border: 2px solid #e2e8f0;
        }

        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-preview-item .main-badge {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: #2c7da0;
            color: white;
            font-size: 0.7rem;
            text-align: center;
            padding: 2px;
        }

        .image-preview-item .delete-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 0.7rem;
            cursor: pointer;
        }

        /* Attribute styles */
        .attribute-row {
            background: #f8fafc;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 0.5rem;
        }

        /* Tag styles */
        .tag-item {
            display: inline-flex;
            align-items: center;
            background: #e2e8f0;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            font-size: 0.85rem;
        }

        .tag-item .remove-tag {
            margin-left: 0.5rem;
            cursor: pointer;
            color: #64748b;
        }

        /* Toast message */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
        }

        /* Loading spinner */
        .spinner-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1200;
        }

        .sticky-create-btn {
            position: sticky;
            bottom: 2rem;
            text-align: center;
            z-index: 100;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <main class="main-content">
        <!-- Header with Breadcrumb -->
        <header class="admin-header d-flex justify-content-between align-items-center">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard"
                                                       class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/products"
                                                       class="text-decoration-none">Sản phẩm</a></li>
                        <li class="breadcrumb-item active">Tạo sản phẩm mới</li>
                    </ol>
                </nav>
                <h3 class="fw-bold m-0 mt-2">
                    <i class="bi bi-plus-circle me-2" style="color:#2c7da0;"></i>
                    Tạo sản phẩm mới
                </h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="admin-btn-outline" id="previewBtn">
                    <i class="bi bi-eye"></i> Xem trước
                </button>
                <button type="button" class="admin-btn-secondary" id="saveDraftBtn">
                    <i class="bi bi-save"></i> Lưu nháp
                </button>
                <button type="button" class="admin-btn-outline" id="resetBtn">
                    <i class="bi bi-arrow-repeat"></i> Làm mới
                </button>
                <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <!-- Main Form - will submit to CreateProductServlet -->
        <form id="productForm" action="${pageContext.request.contextPath}/admin/products/create" method="post" enctype="multipart/form-data">
            <!-- CSRF Token (implement as needed) -->
            <input type="hidden" name="csrfToken" value="${csrfToken}">

            <!-- ========== SECTION 1: BASIC INFORMATION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h5>
                <div class="row">
                    <div class="col-md-8 mb-3">
                        <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" name="name" id="productName" class="form-control"
                               required minlength="3" maxlength="255"
                               data-error-message="Product name cannot be empty">
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">SKU <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="text" name="sku" id="sku" class="form-control" required
                                   pattern="[A-Za-z0-9]+" title="Only letters and numbers">
                            <button type="button" class="btn btn-outline-secondary" id="generateSkuBtn">
                                <i class="bi bi-shuffle"></i> Tự động
                            </button>
                        </div>
                        <div id="skuCheckMessage" class="small mt-1"></div>
                        <div class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Danh mục <span class="text-danger">*</span></label>
                        <select name="categoryId" id="categoryId" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Category must be selected</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Thương hiệu <span class="text-danger">*</span></label>
                        <select name="brandId" id="brandId" class="form-select" required>
                            <option value="">-- Chọn thương hiệu --</option>
                            <c:forEach items="${brands}" var="brand">
                                <option value="${brand.id}">${brand.name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Brand must be selected</div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" id="status" class="form-select">
                            <option value="active">Hoạt động</option>
                            <option value="inactive">Không hoạt động</option>
                            <option value="hidden">Ẩn (không thể mua)</option>
                            <option value="draft">Nháp</option>
                        </select>
                        <div id="statusWarning" class="small text-warning mt-1" style="display: none;">
                            <i class="bi bi-exclamation-triangle"></i> Products in draft mode will not appear in the store
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 2: PRICE & DISCOUNT ========== -->
            <div class="info-section">
                <h5><i class="bi bi-tag me-2"></i>Giá & Khuyến mãi</h5>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá gốc <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text">₫</span>
                            <input type="number" name="price" id="price" class="form-control"
                                   step="1000" min="0" required>
                        </div>
                        <div class="invalid-feedback">Price must be greater than 0</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá khuyến mãi</label>
                        <div class="input-group">
                            <span class="input-group-text">₫</span>
                            <input type="number" name="finalPrice" id="finalPrice" class="form-control" step="1000">
                        </div>
                        <div id="priceError" class="invalid-feedback">Sale price must be lower than base price</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giảm giá (%)</label>
                        <input type="number" name="discountPercent" id="discountPercent" class="form-control"
                               min="0" max="100" step="1" readonly>
                        <small class="text-muted">Tự động tính từ giá</small>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ngày bắt đầu khuyến mãi</label>
                        <input type="datetime-local" name="saleStartDate" id="saleStartDate" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ngày kết thúc khuyến mãi</label>
                        <input type="datetime-local" name="saleEndDate" id="saleEndDate" class="form-control">
                    </div>
                </div>
                <div id="dateError" class="text-danger small" style="display: none;">Start date must be before end date</div>
            </div>

            <!-- ========== SECTION 3: IMAGE GALLERY ========== -->
            <div class="info-section">
                <h5><i class="bi bi-images me-2"></i>Hình ảnh sản phẩm</h5>
                <div class="mb-3">
                    <input type="file" name="images" id="imageUpload" multiple accept="image/jpeg,image/png,image/webp"
                           class="form-control">
                    <small class="text-muted">Hỗ trợ JPG, PNG, WEBP. Tối đa 5MB/ảnh, tối đa 10 ảnh</small>
                </div>
                <div id="imagePreviewContainer" class="image-preview-container"></div>
                <input type="hidden" name="mainImageIndex" id="mainImageIndex" value="0">
            </div>

            <!-- ========== SECTION 4: PRODUCT DESCRIPTION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-file-text me-2"></i>Mô tả sản phẩm</h5>
                <div class="mb-3">
                    <label class="form-label">Mô tả ngắn</label>
                    <textarea name="shortDescription" id="shortDescription" class="form-control" rows="2" maxlength="300"></textarea>
                    <small><span id="shortDescCounter">0</span>/300 ký tự</small>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mô tả chi tiết</label>
                    <textarea name="description" id="description" class="form-control" rows="8"></textarea>
                </div>
            </div>

            <!-- ========== SECTION 5: PRODUCT ATTRIBUTES ========== -->
            <div class="info-section">
                <h5><i class="bi bi-sliders2 me-2"></i>Thông số kỹ thuật</h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tỷ lệ (Scale)</label>
                        <input type="text" name="ratio" class="form-control" placeholder="Ví dụ: 1:18">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Kích thước</label>
                        <input type="text" name="size" class="form-control" placeholder="Ví dụ: 25 x 10 x 8 cm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Chất liệu</label>
                        <input type="text" name="material" class="form-control" placeholder="Ví dụ: Diecast, nhựa ABS">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Xuất xứ</label>
                        <input type="text" name="origin" class="form-control" placeholder="Ví dụ: Trung Quốc">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nhà sản xuất</label>
                        <input type="text" name="manufacturer" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Năm sản xuất</label>
                        <input type="number" name="releaseYear" class="form-control" min="1900" max="2025">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Màu sắc</label>
                        <input type="text" name="color" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Trọng lượng</label>
                        <input type="text" name="weight" class="form-control" placeholder="Ví dụ: 500g">
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 6: INVENTORY ========== -->
            <div class="info-section">
                <h5><i class="bi bi-boxes me-2"></i>Quản lý tồn kho</h5>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Số lượng tồn kho</label>
                        <input type="number" name="quantity" id="quantity" class="form-control" min="0" value="0">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Cảnh báo tồn kho thấp</label>
                        <input type="number" name="lowStockWarning" class="form-control" value="5" min="0">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Mã kho</label>
                        <input type="text" name="warehouseCode" class="form-control" placeholder="Mã kho">
                    </div>
                </div>
                <div id="stockWarning" class="small text-warning" style="display: none;">
                    <i class="bi bi-exclamation-triangle"></i> Cảnh báo: Tồn kho thấp hơn ngưỡng cảnh báo!
                </div>
            </div>

            <!-- ========== SECTION 7: PRODUCT TAGS ========== -->
            <div class="info-section">
                <h5><i class="bi bi-tags me-2"></i>Tags sản phẩm</h5>
                <div class="mb-3">
                    <div class="input-group">
                        <input type="text" id="tagInput" class="form-control" placeholder="Nhập tag và nhấn Enter">
                        <button type="button" id="addTagBtn" class="btn btn-outline-secondary">Thêm tag</button>
                    </div>
                </div>
                <div id="tagsContainer" class="mb-2"></div>
                <input type="hidden" name="tags" id="tagsHidden">
            </div>

            <!-- ========== SECTION 8: SEO INFORMATION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-search me-2"></i>SEO Information</h5>
                <div class="mb-3">
                    <label class="form-label">Meta Title</label>
                    <input type="text" name="metaTitle" id="metaTitle" class="form-control" maxlength="60">
                    <small><span id="metaTitleCounter">0</span>/60 ký tự</small>
                </div>
                <div class="mb-3">
                    <label class="form-label">Meta Description</label>
                    <textarea name="metaDescription" id="metaDescription" class="form-control" rows="2" maxlength="160"></textarea>
                    <small><span id="metaDescCounter">0</span>/160 ký tự</small>
                </div>
                <div class="mb-3">
                    <label class="form-label">URL Slug</label>
                    <div class="input-group">
                        <span class="input-group-text">/product/</span>
                        <input type="text" name="slug" id="slug" class="form-control" required>
                        <button type="button" class="btn btn-outline-secondary" id="generateSlugBtn">
                            <i class="bi bi-magic"></i> Tự động
                        </button>
                    </div>
                    <div id="slugCheckMessage" class="small mt-1"></div>
                </div>
            </div>

            <!-- Sticky Create Button -->
            <div class="sticky-create-btn">
                <button type="submit" id="createProductBtn" class="admin-btn-primary btn-lg px-5">
                    <i class="bi bi-check-lg"></i> Tạo sản phẩm
                </button>
            </div>
        </form>
    </main>
</div>

<!-- Toast Container -->
<div class="toast-container"></div>

<!-- Loading Spinner -->
<div class="spinner-overlay" id="loadingSpinner">
    <div class="spinner-border text-light" style="width: 3rem; height: 3rem;" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize TinyMCE
    tinymce.init({
        selector: '#description',
        height: 300,
        menubar: false,
        plugins: 'advlist autolink lists link image charmap preview anchor searchreplace visualblocks code fullscreen insertdatetime media table help wordcount',
        toolbar: 'undo redo | blocks | bold italic underline | alignleft aligncenter alignright | bullist numlist | link image | removeformat | help',
        skin: 'oxide',
        content_css: 'default'
    });

    // ========== UTILITY FUNCTIONS ==========
    function showToast(message, type = 'success') {
        const toastContainer = document.querySelector('.toast-container');
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type} border-0`;
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', 'assertive');
        toast.setAttribute('aria-atomic', 'true');
        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">${message}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        `;
        toastContainer.appendChild(toast);
        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();
        toast.addEventListener('hidden.bs.toast', () => toast.remove());
    }

    function showLoading() {
        document.getElementById('loadingSpinner').style.display = 'flex';
    }

    function hideLoading() {
        document.getElementById('loadingSpinner').style.display = 'none';
    }

    // ========== 1. SKU Auto Generate & Check ==========
    document.getElementById('generateSkuBtn').addEventListener('click', function() {
        const productName = document.getElementById('productName').value;
        if (productName) {
            let sku = productName.substring(0, 3).toUpperCase() + '-' + Date.now().toString().slice(-6);
            document.getElementById('sku').value = sku;
        } else {
            document.getElementById('sku').value = 'SKU-' + Date.now().toString().slice(-6);
        }
        checkSkuAvailability();
    });

    function checkSkuAvailability() {
        const sku = document.getElementById('sku').value;
        if (sku.length < 2) return;

        // Simple fetch to check SKU (optional, can be implemented with fetch API)
        // For minimal JS, we'll just show message after blur
        fetch('${pageContext.request.contextPath}/admin/check-sku?sku=' + encodeURIComponent(sku))
            .then(response => response.json())
            .then(data => {
                const msgDiv = document.getElementById('skuCheckMessage');
                if (data.exists) {
                    msgDiv.innerHTML = '<span class="text-danger">SKU already exists!</span>';
                    document.getElementById('sku').classList.add('is-invalid');
                } else {
                    msgDiv.innerHTML = '<span class="text-success">SKU available</span>';
                    document.getElementById('sku').classList.remove('is-invalid');
                }
            })
            .catch(() => {});
    }

    document.getElementById('sku').addEventListener('blur', checkSkuAvailability);

    // ========== 2. Price Calculation ==========
    function calculateDiscount() {
        const price = parseFloat(document.getElementById('price').value) || 0;
        const finalPrice = parseFloat(document.getElementById('finalPrice').value) || 0;
        const discountPercent = document.getElementById('discountPercent');

        if (price > 0 && finalPrice > 0 && finalPrice < price) {
            const discount = ((price - finalPrice) / price * 100).toFixed(0);
            discountPercent.value = discount;
            document.getElementById('priceError').style.display = 'none';
        } else if (finalPrice >= price && finalPrice > 0) {
            document.getElementById('priceError').style.display = 'block';
        } else {
            discountPercent.value = '';
        }
    }

    document.getElementById('price').addEventListener('input', calculateDiscount);
    document.getElementById('finalPrice').addEventListener('input', calculateDiscount);

    // ========== 3. Date Validation ==========
    function validateDates() {
        const start = document.getElementById('saleStartDate').value;
        const end = document.getElementById('saleEndDate').value;
        if (start && end && new Date(start) >= new Date(end)) {
            document.getElementById('dateError').style.display = 'block';
            return false;
        }
        document.getElementById('dateError').style.display = 'none';
        return true;
    }

    document.getElementById('saleStartDate').addEventListener('change', validateDates);
    document.getElementById('saleEndDate').addEventListener('change', validateDates);

    // ========== 4. Image Upload Preview ==========
    let uploadedImages = [];

    document.getElementById('imageUpload').addEventListener('change', function(e) {
        const files = Array.from(e.target.files);
        if (uploadedImages.length + files.length > 10) {
            showToast('Chỉ được tối đa 10 ảnh!', 'danger');
            return;
        }

        for (let file of files) {
            if (!file.type.match('image/jpeg') && !file.type.match('image/png') && !file.type.match('image/webp')) {
                showToast('Chỉ hỗ trợ JPG, PNG, WEBP!', 'danger');
                continue;
            }
            if (file.size > 5 * 1024 * 1024) {
                showToast('Kích thước ảnh tối đa 5MB!', 'danger');
                continue;
            }

            const reader = new FileReader();
            reader.onload = function(evt) {
                uploadedImages.push({
                    data: evt.target.result,
                    file: file,
                    isMain: uploadedImages.length === 0
                });
                renderImagePreview();
            };
            reader.readAsDataURL(file);
        }
    });

    function renderImagePreview() {
        const container = document.getElementById('imagePreviewContainer');
        container.innerHTML = '';
        uploadedImages.forEach((img, index) => {
            const div = document.createElement('div');
            div.className = 'image-preview-item';
            div.innerHTML = `
                <img src="${img.data}" alt="Preview ${index}">
                <button type="button" class="delete-btn" onclick="deleteImage(${index})">×</button>
                ${img.isMain ? '<div class="main-badge">Main</div>' : '<button type="button" class="btn btn-sm btn-outline-primary set-main" style="position:absolute; bottom:5px; left:5px; font-size:10px;" onclick="setMainImage(${index})">Set Main</button>'}
            `;
            container.appendChild(div);
        });
    }

    function deleteImage(index) {
        if (confirm('Are you sure you want to remove this image?')) {
            uploadedImages.splice(index, 1);
            if (uploadedImages.length > 0 && !uploadedImages.some(img => img.isMain)) {
                uploadedImages[0].isMain = true;
            }
            renderImagePreview();
        }
    }

    function setMainImage(index) {
        uploadedImages.forEach((img, i) => {
            img.isMain = (i === index);
        });
        renderImagePreview();
    }

    // ========== 5. Tags Management ==========
    let tags = [];

    function renderTags() {
        const container = document.getElementById('tagsContainer');
        container.innerHTML = '';
        tags.forEach((tag, index) => {
            const span = document.createElement('span');
            span.className = 'tag-item';
            span.innerHTML = `${tag} <i class="bi bi-x-circle remove-tag" data-index="${index}"></i>`;
            container.appendChild(span);
        });
        document.getElementById('tagsHidden').value = tags.join(',');
    }

    document.getElementById('addTagBtn').addEventListener('click', function() {
        const input = document.getElementById('tagInput');
        const tag = input.value.trim();
        if (tag && !tags.includes(tag)) {
            tags.push(tag);
            renderTags();
            input.value = '';
        }
    });

    document.getElementById('tagInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            document.getElementById('addTagBtn').click();
        }
    });

    document.getElementById('tagsContainer').addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-tag')) {
            const index = parseInt(e.target.getAttribute('data-index'));
            tags.splice(index, 1);
            renderTags();
        }
    });

    // ========== 6. Status Warning ==========
    document.getElementById('status').addEventListener('change', function() {
        const warning = document.getElementById('statusWarning');
        warning.style.display = this.value === 'draft' ? 'block' : 'none';
    });

    // ========== 7. Stock Warning ==========
    document.getElementById('quantity').addEventListener('input', function() {
        const qty = parseInt(this.value) || 0;
        const warning = parseInt(document.querySelector('[name="lowStockWarning"]').value) || 5;
        const stockWarning = document.getElementById('stockWarning');
        stockWarning.style.display = qty <= warning ? 'block' : 'none';
    });

    // ========== 8. Character Counters ==========
    document.getElementById('shortDescription').addEventListener('input', function() {
        document.getElementById('shortDescCounter').innerText = this.value.length;
    });
    document.getElementById('metaTitle').addEventListener('input', function() {
        document.getElementById('metaTitleCounter').innerText = this.value.length;
    });
    document.getElementById('metaDescription').addEventListener('input', function() {
        document.getElementById('metaDescCounter').innerText = this.value.length;
    });

    // ========== 9. Auto Generate Slug ==========
    function slugify(text) {
        return text.toString().toLowerCase()
            .replace(/\s+/g, '-')
            .replace(/[^\w\-]+/g, '')
            .replace(/\-\-+/g, '-')
            .replace(/^-+/, '')
            .replace(/-+$/, '');
    }

    document.getElementById('generateSlugBtn').addEventListener('click', function() {
        const name = document.getElementById('productName').value;
        if (name) {
            document.getElementById('slug').value = slugify(name);
            checkSlugAvailability();
        }
    });

    document.getElementById('productName').addEventListener('input', function() {
        if (!document.getElementById('slug').value) {
            document.getElementById('slug').value = slugify(this.value);
        }
    });

    function checkSlugAvailability() {
        const slug = document.getElementById('slug').value;
        if (!slug) return;

        fetch('${pageContext.request.contextPath}/admin/check-slug?slug=' + encodeURIComponent(slug))
            .then(response => response.json())
            .then(data => {
                const msgDiv = document.getElementById('slugCheckMessage');
                if (data.exists) {
                    msgDiv.innerHTML = '<span class="text-danger">Slug already exists! Please change.</span>';
                    document.getElementById('slug').classList.add('is-invalid');
                } else {
                    msgDiv.innerHTML = '<span class="text-success">Slug available</span>';
                    document.getElementById('slug').classList.remove('is-invalid');
                }
            })
            .catch(() => {});
    }

    document.getElementById('slug').addEventListener('blur', checkSlugAvailability);

    // ========== 10. Form Validation & Submit ==========
    function validateForm() {
        let isValid = true;

        // Product name
        const name = document.getElementById('productName');
        if (!name.value.trim()) {
            name.classList.add('is-invalid');
            name.nextElementSibling.innerText = 'Product name cannot be empty';
            isValid = false;
        } else if (name.value.length < 3) {
            name.classList.add('is-invalid');
            name.nextElementSibling.innerText = 'Product name must be at least 3 characters';
            isValid = false;
        } else {
            name.classList.remove('is-invalid');
        }

        // SKU
        const sku = document.getElementById('sku');
        if (!sku.value.trim()) {
            sku.classList.add('is-invalid');
            sku.nextElementSibling.innerText = 'SKU is required';
            isValid = false;
        } else if (!/^[A-Za-z0-9]+$/.test(sku.value)) {
            sku.classList.add('is-invalid');
            sku.nextElementSibling.innerText = 'Only letters and numbers';
            isValid = false;
        } else {
            sku.classList.remove('is-invalid');
        }

        // Category & Brand
        if (!document.getElementById('categoryId').value) {
            document.getElementById('categoryId').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('categoryId').classList.remove('is-invalid');
        }

        if (!document.getElementById('brandId').value) {
            document.getElementById('brandId').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('brandId').classList.remove('is-invalid');
        }

        // Price
        const price = parseFloat(document.getElementById('price').value);
        if (isNaN(price) || price <= 0) {
            document.getElementById('price').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('price').classList.remove('is-invalid');
        }

        // Final price validation
        const finalPrice = parseFloat(document.getElementById('finalPrice').value);
        if (!isNaN(finalPrice) && finalPrice >= price && finalPrice > 0) {
            document.getElementById('priceError').style.display = 'block';
            isValid = false;
        }

        // Date validation
        if (!validateDates()) {
            isValid = false;
        }

        // Slug
        if (!document.getElementById('slug').value.trim()) {
            document.getElementById('slug').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('slug').classList.remove('is-invalid');
        }

        return isValid;
    }

    document.getElementById('productForm').addEventListener('submit', function(e) {
        e.preventDefault();

        if (!validateForm()) {
            // Scroll to first error
            const firstError = document.querySelector('.is-invalid');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            showToast('Please fix the errors before submitting', 'danger');
            return;
        }

        // Prepare form data for submission
        const formData = new FormData(this);

        // Add images
        uploadedImages.forEach((img, index) => {
            formData.append('images', img.file);
            if (img.isMain) {
                formData.append('mainImageIndex', index);
            }
        });

        // Add tags
        formData.append('tags', tags.join(','));

        // Add description from TinyMCE
        formData.append('description', tinymce.get('description').getContent());

        // Disable button and show loading
        const submitBtn = document.getElementById('createProductBtn');
        const originalText = submitBtn.innerHTML;
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang tạo...';
        showLoading();

        fetch(this.action, {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast('Product created successfully!', 'success');
                    window.location.href = data.redirectUrl || '${pageContext.request.contextPath}/admin/products/detail?id=' + data.productId;
                } else {
                    showToast(data.message || 'Failed to create product', 'danger');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalText;
                    hideLoading();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('An error occurred. Please try again.', 'danger');
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalText;
                hideLoading();
            });
    });

    // ========== 11. Save Draft ==========
    document.getElementById('saveDraftBtn').addEventListener('click', function() {
        const statusSelect = document.getElementById('status');
        const originalStatus = statusSelect.value;
        statusSelect.value = 'draft';
        document.getElementById('productForm').dispatchEvent(new Event('submit'));
        statusSelect.value = originalStatus;
    });

    // ========== 12. Reset Form ==========
    document.getElementById('resetBtn').addEventListener('click', function() {
        if (confirm('Are you sure you want to reset all fields?')) {
            document.getElementById('productForm').reset();
            uploadedImages = [];
            tags = [];
            renderTags();
            renderImagePreview();
            if (tinymce.get('description')) {
                tinymce.get('description').setContent('');
            }
        }
    });

    // ========== 13. Unsaved Changes Warning ==========
    let formChanged = false;
    const formInputs = document.querySelectorAll('#productForm input, #productForm select, #productForm textarea');
    formInputs.forEach(input => {
        input.addEventListener('change', () => { formChanged = true; });
        input.addEventListener('input', () => { formChanged = true; });
    });

    window.addEventListener('beforeunload', function(e) {
        if (formChanged) {
            e.preventDefault();
            e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
            return e.returnValue;
        }
    });

    // ========== 14. Preview Product ==========
    document.getElementById('previewBtn').addEventListener('click', function() {
        // Collect data for preview
        const previewData = {
            name: document.getElementById('productName').value,
            price: document.getElementById('price').value,
            finalPrice: document.getElementById('finalPrice').value,
            description: tinymce.get('description')?.getContent() || '',
            // Add more fields as needed
        };

        const previewWindow = window.open('${pageContext.request.contextPath}/admin/preview-product', '_blank');
        previewWindow.onload = function() {
            // You can send data via postMessage or URL params
        };
    });
</script>
</body>
</html>