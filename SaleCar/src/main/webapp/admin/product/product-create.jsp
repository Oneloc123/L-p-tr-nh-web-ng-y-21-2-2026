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
    <!-- TinyMCE for description -->
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

        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }

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

        .sticky-create-btn {
            position: sticky;
            bottom: 2rem;
            text-align: center;
            z-index: 100;
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
        }

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

        .variants-table th, .specs-table th {
            font-size: 0.8rem;
            text-transform: uppercase;
        }

        /* Image preview styles */
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

        .image-preview-item .delete-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            font-size: 0.8rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="admin-header d-flex justify-content-between align-items-center">
            <div>
                <h3 class="fw-bold m-0 mt-2">
                    <i class="bi bi-plus-circle me-2" style="color:#2c7da0;"></i>
                    Tạo sản phẩm mới
                </h3>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard"
                                                       class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/products"
                                                       class="text-decoration-none">Sản phẩm</a></li>
                        <li class="breadcrumb-item active">Tạo sản phẩm mới</li>
                    </ol>
                </nav>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="admin-btn-outline" id="resetBtn">
                    <i class="bi bi-arrow-repeat"></i> Làm mới
                </button>
                <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <!-- Form -->
        <form id="productForm" action="${pageContext.request.contextPath}/admin/products/create" method="post"
              enctype="multipart/form-data">
            <!-- CSRF hidden field (if needed) -->
            <%-- <input type="hidden" name="csrfToken" value="${csrfToken}"> --%>

            <!-- ========== SECTION 1: BASIC INFORMATION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h5>
                <div class="row">
                    <div class="col-md-8 mb-3">
                        <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" name="name" id="productName" class="form-control"
                               required minlength="3" maxlength="255">
                        <div class="invalid-feedback">Tên sản phẩm không được để trống và ít nhất 3 ký tự</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" id="status" class="form-select">
                            <option value="active">Hoạt động</option>
                            <option value="inactive">Không hoạt động</option>
                            <option value="hidden">Ẩn (không thể mua)</option>
                            <option value="draft">Nháp</option>
                        </select>
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
                        <div class="invalid-feedback">Vui lòng chọn danh mục</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Thương hiệu <span class="text-danger">*</span></label>
                        <select name="brandId" id="brandId" class="form-select" required>
                            <option value="">-- Chọn thương hiệu --</option>
                            <c:forEach items="${brands}" var="brand">
                                <option value="${brand.id}">${brand.name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn thương hiệu</div>
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 2: PRODUCT VARIANTS ========== -->
            <div class="info-section">
                <h5><i class="bi bi-collection me-2"></i>Biến thể sản phẩm (Variants)</h5>
                <div class="table-responsive">
                    <table class="table table-borderless align-middle variants-table" id="variantsTable">
                        <thead class="table-light">
                        <tr>
                            <th style="width: 30%">Tên biến thể</th>
                            <th style="width: 20%">SKU</th>
                            <th style="width: 20%">Giá</th>
                            <th style="width: 20%">Giá sau giảm</th>
                            <th style="width: 10%">Xóa</th>
                        </tr>
                        </thead>
                        <tbody id="variantsTbody">
                        <!-- Will be populated via JS -->
                        </tbody>
                    </table>
                </div>
                <button type="button" class="btn btn-sm btn-outline-primary" id="addVariantBtn">
                    <i class="bi bi-plus-lg"></i> Thêm biến thể
                </button>
                <small class="text-muted ms-3">Ít nhất một biến thể là bắt buộc để làm phiên bản gốc.</small>
            </div>

            <!-- ========== SECTION 3: DISCOUNT ========== -->
            <div class="info-section">
                <h5 class="mb-3"><i class="bi bi-tag me-2"></i>Tạo chương trình khuyến mãi riêng cho dòng sản phẩm (áp
                    dụng cho tất cả biến
                    thể)</h5>
                <hr class="my-4">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tên khuyến mãi</label>
                        <input type="text" name="discountName" id="discountName" class="form-control"
                               placeholder="Ví dụ: Sale Tết Nguyên Đán 2026">
                        <small class="text-muted">Để trống nếu không muốn tạo khuyến mãi riêng</small>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Loại khuyến mãi</label>
                        <select name="discountValueType" id="discountValueType" class="form-select">
                            <option value="rate">Phần trăm (%)</option>
                        </select>
                    </div>
                </div>

                <div class="row ">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Giá trị khuyến mãi %</label>
                        <input type="number" name="discountPercent" id="discountPercent" class="form-control"
                               min="0" step="0.01" placeholder="Nhập giá trị">
                        <small class="text-muted">Nhập 0 nếu không giảm giá. Giá sau giảm sẽ tự động hiển thị ở bảng
                            biến thể.</small>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="form-label">Ngày bắt đầu</label>
                        <input type="date" name="discountStartDate" id="discountStartDate" class="form-control">
                        <small class="text-muted">Mặc định: hôm nay</small>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Ngày kết thúc</label>
                        <input type="date" name="discountEndDate" id="discountEndDate" class="form-control">
                        <small class="text-muted">Mặc định: 30 ngày tính từ nay</small>
                    </div>
                    <div class="col-md-3 d-flex flex-column justify-content-end mb-3">
                        <label class="form-label invisible">Reset</label>

                        <button type="button"
                                class="btn btn-outline-secondary w-100 h-100"
                                id="resetDiscountBtn">
                            <i class="bi bi-arrow-repeat"></i>
                            Xóa khuyến mãi
                        </button>
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 4: SPECIFICATIONS (FIXED FIELDS) ========== -->
            <div class="info-section">
                <h5><i class="bi bi-sliders2 me-2"></i>Thông số kỹ thuật</h5>
                <div class="table-responsive">
                    <table class="table table-borderless specs-table">
                        <thead class="table-light">
                        <tr>
                            <th style="width: 35%">Thuộc tính</th>
                            <th style="width: 50%">Giá trị</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><input type="text" class="form-control form-control-sm" name="attributeKey[]"
                                       value="Tỷ lệ (Scale)"
                                       readonly></td>
                            <td><input type="text" class="form-control form-control-sm" name="ratio"
                                       placeholder="Ví dụ: 1:18"></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="form-control form-control-sm" name="attributeKey[]"
                                       value="Kích thước"
                                       readonly></td>
                            <td><input type="text" class="form-control form-control-sm" name="size"
                                       placeholder="Ví dụ: 25 x 10 x 8 cm"></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="form-control form-control-sm" name="attributeKey[]"
                                       value="Chất liệu"
                                       readonly></td>
                            <td><input type="text" class="form-control form-control-sm" name="material"
                                       placeholder="Ví dụ: Diecast, nhựa ABS"></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="form-control form-control-sm" name="attributeKey[]"
                                       value="Xuất xứ"
                                       readonly></td>
                            <td><input type="text" class="form-control form-control-sm" name="origin"
                                       placeholder="Ví dụ: Trung Quốc"></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="form-control form-control-sm" name="attributeKey[]"
                                       value="Màu sắc"
                                       readonly></td>
                            <td><input type="text" class="form-control form-control-sm" name="attributeValue[]"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- ========== SECTION 5: DESCRIPTION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-file-text me-2"></i>Mô tả sản phẩm</h5>
                <div class="mb-3">
                    <label class="form-label">Mô tả ngắn</label>
                    <textarea name="description" id="shortDescription" class="form-control" rows="2"
                              maxlength="300"></textarea>
                    <small><span id="shortDescCounter">0</span>/300 ký tự</small>
                </div>
                <%--                <div class="mb-3">--%>
                <%--                    <label class="form-label">Mô tả chi tiết</label>--%>
                <%--                    <textarea name="description" id="description" class="form-control" rows="8"></textarea>--%>
                <%--                </div>--%>
            </div>

            <!-- ========== SECTION 6: IMAGES (WITH PREVIEW) ========== -->
            <div class="info-section">
                <h5><i class="bi bi-images me-2"></i>Hình ảnh sản phẩm</h5>
                <div class="mb-3">
                    <input type="file" name="galleryImages" id="imageUpload" multiple
                           accept="image/jpeg,image/png,image/webp" class="form-control">
                    <small class="text-muted">Hỗ trợ JPG, PNG, WEBP. Tối đa 5MB/ảnh, tối đa 10 ảnh.</small>
                </div>
                <div id="imagePreviewContainer" class="image-preview-container"></div>
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
    // ========== TINYMCE INIT ==========
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
    function showToast(message, type = 'danger') {
        const container = document.querySelector('.toast-container');
        const toastEl = document.createElement('div');
        toastEl.className = `toast align-items-center text-white bg-${type} border-0`;
        toastEl.setAttribute('role', 'alert');
        toastEl.setAttribute('aria-live', 'assertive');
        toastEl.setAttribute('aria-atomic', 'true');
        toastEl.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">${message}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>`;
        container.appendChild(toastEl);
        const bsToast = new bootstrap.Toast(toastEl);
        bsToast.show();
        toastEl.addEventListener('hidden.bs.toast', () => toastEl.remove());
    }

    function showLoading() {
        document.getElementById('loadingSpinner').style.display = 'flex';
    }

    function hideLoading() {
        document.getElementById('loadingSpinner').style.display = 'none';
    }

    // ========== VARIANTS DYNAMIC ROWS ==========
    const variantsTbody = document.getElementById('variantsTbody');

    function createVariantRow() {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td><input type="text" name="variantName[]" class="form-control form-control-sm" placeholder="Tên biến thể" required></td>
            <td><input type="text" name="sku[]" class="form-control form-control-sm" placeholder="SKU" required pattern="[A-Za-z0-9]+" title="Chỉ chữ và số"></td>
            <td><input type="number" name="price[]" class="form-control form-control-sm variant-price" placeholder="Giá" step="1000" min="0" required></td>
            <td><input type="text" class="form-control form-control-sm variant-discounted" readonly placeholder="Tính tự động"></td>
            <td><button type="button" class="btn btn-sm btn-outline-danger delete-variant-btn"><i class="bi bi-x-circle"></i></button></td>
        `;
        return tr;
    }

    function attachVariantEvents(row) {
        const priceInput = row.querySelector('.variant-price');
        const discountedInput = row.querySelector('.variant-discounted');

        function updateDiscounted() {
            const discountPercent = parseFloat(document.getElementById('discountPercent').value) || 0;
            const price = parseFloat(priceInput.value) || 0;
            if (discountPercent > 0 && price > 0) {
                const discounted = price * (1 - discountPercent / 100);
                discountedInput.value = discounted.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ' ') + ' ₫';
            } else {
                discountedInput.value = price ? price.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ' ') + ' ₫' : '';
            }
        }

        priceInput.addEventListener('input', updateDiscounted);
        document.getElementById('discountPercent').addEventListener('input', function () {
            document.querySelectorAll('.variant-price').forEach(inp => {
                inp.dispatchEvent(new Event('input'));
            });
        });
        updateDiscounted();
    }

    function addVariantRow() {
        const row = createVariantRow();
        variantsTbody.appendChild(row);
        attachVariantEvents(row);
        row.querySelector('.delete-variant-btn').addEventListener('click', function () {
            if (variantsTbody.rows.length > 1) {
                row.remove();
            } else {
                showToast('Phải có ít nhất một biến thể', 'warning');
            }
        });
    }

    // Add initial one row
    addVariantRow();

    document.getElementById('addVariantBtn').addEventListener('click', addVariantRow);

    // ========== IMAGE UPLOAD WITH PREVIEW ==========
    const imageInput = document.getElementById('imageUpload');
    const previewContainer = document.getElementById('imagePreviewContainer');
    let selectedFiles = []; // Maintain list of File objects

    function renderImagePreview() {
        // Clear old previews and revoke object URLs
        previewContainer.innerHTML = '';
        selectedFiles.forEach((file, index) => {
            const url = URL.createObjectURL(file);
            const div = document.createElement('div');
            div.className = 'image-preview-item';
            div.innerHTML = `
                <img src="${url}" alt="Preview ${index}">
                <button type="button" class="delete-btn" data-index="${index}">×</button>
            `;
            previewContainer.appendChild(div);
        });

        // Attach delete events
        previewContainer.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                const idx = parseInt(this.getAttribute('data-index'));
                removeImage(idx);
            });
        });
    }

    function removeImage(index) {
        // Revoke URL to free memory (will be done when re-rendering, but better to revoke now)
        selectedFiles.splice(index, 1);
        // Update the file input's FileList using DataTransfer
        const dt = new DataTransfer();
        selectedFiles.forEach(file => dt.items.add(file));
        imageInput.files = dt.files;
        renderImagePreview();
    }

    imageInput.addEventListener('change', function (e) {
        const newFiles = Array.from(e.target.files);
        let addedCount = 0;
        for (let file of newFiles) {
            // Validate type
            if (!['image/jpeg', 'image/png', 'image/webp'].includes(file.type)) {
                showToast('Chỉ hỗ trợ JPG, PNG, WEBP!', 'danger');
                continue;
            }
            if (file.size > 5 * 1024 * 1024) {
                showToast('Kích thước ảnh tối đa 5MB!', 'danger');
                continue;
            }
            if (selectedFiles.length >= 10) {
                showToast('Tối đa 10 ảnh!', 'danger');
                break;
            }
            // Avoid duplicate names? Not strictly needed, but can check
            selectedFiles.push(file);
            addedCount++;
        }

        // Update the input's FileList to reflect actual accepted files
        const dt = new DataTransfer();
        selectedFiles.forEach(f => dt.items.add(f));
        imageInput.files = dt.files;

        renderImagePreview();
    });

    // ========== SHORT DESCRIPTION COUNTER ==========
    document.getElementById('shortDescription').addEventListener('input', function () {
        document.getElementById('shortDescCounter').textContent = this.value.length;
    });

    // ========== RESET FORM ==========
    document.getElementById('resetBtn').addEventListener('click', function () {
        if (confirm('Bạn có chắc chắn muốn làm mới toàn bộ form?')) {
            document.getElementById('productForm').reset();
            // Clear variants except first
            while (variantsTbody.rows.length > 1) {
                variantsTbody.deleteRow(1);
            }
            const firstRow = variantsTbody.rows[0];
            firstRow.querySelectorAll('input').forEach(input => {
                if (input.name && input.name.includes('[]')) input.value = '';
                if (input.classList.contains('variant-discounted')) input.value = '';
            });
            // Clear images
            selectedFiles = [];
            const dt = new DataTransfer();
            imageInput.files = dt.files;
            previewContainer.innerHTML = '';
            // Clear TinyMCE
            if (tinymce.get('description')) {
                tinymce.get('description').setContent('');
            }
            // Reset counter
            document.getElementById('shortDescCounter').textContent = '0';
            hideLoading();
        }
    });

    // ========== DISCOUNT FORM HANDLERS ==========
    document.getElementById('resetDiscountBtn').addEventListener('click', function () {
        document.getElementById('discountName').value = '';
        document.getElementById('discountValueType').value = '';
        document.getElementById('discountPercent').value = '';
        document.getElementById('discountStartDate').value = '';
        document.getElementById('discountEndDate').value = '';
    });

    // Set default dates for discount
    document.addEventListener('DOMContentLoaded', function () {
        const today = new Date();
        const todayString = today.toISOString().split('T')[0];

        const thirtyDaysLater = new Date(today.getTime() + 30 * 24 * 60 * 60 * 1000);
        const thirtyDaysString = thirtyDaysLater.toISOString().split('T')[0];

        // don't set by default, let user choose
        // document.getElementById('discountStartDate').value = todayString;
        // document.getElementById('discountEndDate').value = thirtyDaysString;
    });

    // ========== FORM VALIDATION & SUBMIT ==========
    document.getElementById('productForm').addEventListener('submit', function (e) {
        e.preventDefault();

        let isValid = true;
        const productName = document.getElementById('productName');
        if (!productName.value.trim() || productName.value.trim().length < 3) {
            productName.classList.add('is-invalid');
            isValid = false;
        } else {
            productName.classList.remove('is-invalid');
        }

        const category = document.getElementById('categoryId');
        if (!category.value) {
            category.classList.add('is-invalid');
            isValid = false;
        } else {
            category.classList.remove('is-invalid');
        }

        const brand = document.getElementById('brandId');
        if (!brand.value) {
            brand.classList.add('is-invalid');
            isValid = false;
        } else {
            brand.classList.remove('is-invalid');
        }

        // Validate variants
        const variantRows = variantsTbody.querySelectorAll('tr');
        let variantValid = true;
        variantRows.forEach(row => {
            const nameInput = row.querySelector('input[name="variantName[]"]');
            const skuInput = row.querySelector('input[name="sku[]"]');
            const priceInput = row.querySelector('input[name="price[]"]');
            if (!nameInput.value.trim() || !skuInput.value.trim() || !priceInput.value || parseFloat(priceInput.value) <= 0) {
                nameInput.classList.add('is-invalid');
                skuInput.classList.add('is-invalid');
                priceInput.classList.add('is-invalid');
                variantValid = false;
            } else {
                nameInput.classList.remove('is-invalid');
                skuInput.classList.remove('is-invalid');
                priceInput.classList.remove('is-invalid');
            }
        });
        if (!variantValid) {
            isValid = false;
            showToast('Vui lòng điền đầy đủ thông tin cho tất cả biến thể (tên, SKU, giá > 0)', 'danger');
        }

        const discount = document.getElementById('discountPercent');
        if (discount.value && (parseFloat(discount.value) < 0 || parseFloat(discount.value) > 100)) {
            discount.classList.add('is-invalid');
            isValid = false;
        } else {
            discount.classList.remove('is-invalid');
        }

        if (!isValid) {
            const firstError = document.querySelector('.is-invalid');
            if (firstError) {
                firstError.scrollIntoView({behavior: 'smooth', block: 'center'});
            }
            return;
        }

        const submitBtn = document.getElementById('createProductBtn');
        const originalHTML = submitBtn.innerHTML;
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang tạo...';
        showLoading();

        this.submit();
    });

    // ========== UNSAVED CHANGES WARNING ==========
    let formChanged = false;
    const allInputs = document.querySelectorAll('#productForm input, #productForm select, #productForm textarea');
    allInputs.forEach(inp => {
        inp.addEventListener('change', () => {
            formChanged = true;
        });
        inp.addEventListener('input', () => {
            formChanged = true;
        });
    });
    window.addEventListener('beforeunload', function (e) {
        if (formChanged) {
            e.preventDefault();
            e.returnValue = 'Bạn có thay đổi chưa lưu. Bạn có chắc chắn muốn rời đi?';
            return e.returnValue;
        }
    });
</script>
<
</body>
</html>