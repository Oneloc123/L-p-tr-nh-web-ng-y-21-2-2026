<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty product ? 'Thêm mới' : 'Cập nhật'} Sản phẩm | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ========== RESET & GLOBAL ========== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
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
            box-shadow: 0 2px 4px rgba(44,125,160,0.08);
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
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .admin-btn-primary:hover {
            background-color: #1f5e7a;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2);
            color: #fff;
        }

        .admin-btn-outline {
            border: 1px solid #e2e8f0;
            background: transparent;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .admin-btn-outline:hover {
            border-color: #2c7da0;
            color: #2c7da0;
            background-color: #f8fafc;
        }

        .admin-btn-secondary {
            background-color: #eef2ff;
            border: none;
            padding: 6px 12px;
            border-radius: 30px;
            color: #2c7da0;
            font-weight: 500;
            transition: 0.2s;
        }

        .admin-btn-secondary:hover {
            background-color: #e0e8f5;
            color: #1f5e7a;
        }

        /* ========== FORM CONTROLS ========== */
        .admin-input, .admin-select, .admin-textarea {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            color: #1e293b;
            border-radius: 14px;
            padding: 10px 16px;
            width: 100%;
        }

        .admin-input:focus, .admin-select:focus, .admin-textarea:focus {
            background-color: #ffffff;
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
            color: #1e293b;
            outline: none;
        }

        .admin-textarea {
            resize: vertical;
        }

        /* ========== FORM SECTIONS ========== */
        .admin-form-section {
            background: #fefefe;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .admin-section-title {
            font-size: 14px;
            font-weight: 600;
            color: #2c7da0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ========== BADGES ========== */
        .admin-badge {
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .admin-badge-info {
            background-color: #eef2ff;
            color: #2c7da0;
            border: 0.5px solid #cbdff2;
        }

        .admin-badge-success {
            background-color: #e6f7ec;
            color: #2e7d5e;
            border: 0.5px solid #b8e0c2;
        }

        .admin-badge-warning {
            background-color: #fff8e8;
            color: #c9772e;
            border: 0.5px solid #f0d8b0;
        }

        .admin-badge-danger {
            background-color: #fff0f0;
            color: #c75c5c;
            border: 0.5px solid #f0c0c0;
        }

        /* ========== PRICE PREVIEW ========== */
        .admin-price-preview {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 15px;
            margin-top: 10px;
        }

        /* ========== IMAGE UPLOAD ========== */
        .admin-drag-drop {
            border: 2px dashed #e2e8f0;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .admin-drag-drop.drag-over {
            border-color: #2c7da0;
            background: #f0f9ff;
        }

        .admin-image-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid #e9edf2;
            margin: 10px;
        }

        .admin-gallery-preview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .admin-gallery-item {
            position: relative;
            width: 100px;
            height: 100px;
        }

        .admin-gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
        }

        .admin-remove-gallery {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 12px;
        }

        .admin-remove-gallery:hover {
            background: #c82333;
        }

        /* ========== SEO PREVIEW ========== */
        .admin-seo-preview {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 12px;
            margin-top: 15px;
        }

        .admin-slug-preview {
            font-family: monospace;
            color: #2c7da0;
            font-size: 12px;
            margin-top: 5px;
        }

        .admin-error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
        }

        /* ========== FORM ACTIONS ========== */
        .admin-form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        /* ========== CHECKBOX GROUP ========== */
        .admin-checkbox-group {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .admin-checkbox {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .admin-checkbox input {
            width: 18px;
            height: 18px;
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 1rem 0.5rem;
            }

            .sidebar .logo span {
                display: none;
            }

            .sidebar nav ul li a span {
                display: none;
            }

            .sidebar nav ul li a i {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp"%>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0">
                <i class="bi bi-${empty product ? 'plus-circle' : 'pencil-square'} me-2" style="color:#2c7da0;"></i>
                ${empty product ? 'Thêm mới sản phẩm' : 'Cập nhật sản phẩm'}
            </h3>
            <div>
                <a href="/productList" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <form id="productForm" action="${empty product ? '/addProduct' : '/updateProduct'}"
              method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${product.id}" datatype="Long">

            <!-- Basic Information -->
            <div class="admin-form-section">
                <h3 class="admin-section-title">
                    <i class="bi bi-info-circle"></i> Thông tin cơ bản
                </h3>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" class="admin-input" id="productName" name="productName"
                               datatype="String" value="${product.productName}" required
                               onkeyup="generateSlug()">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">SKU <span class="text-danger">*</span></label>
                        <input type="text" class="admin-input" id="sku" name="sku"
                               datatype="String" value="${product.sku}" required>
                        <div id="skuError" class="admin-error-message"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Slug (URL)</label>
                        <input type="text" class="admin-input" id="slug" name="slug"
                               datatype="String" value="${product.slug}">
                        <div class="admin-slug-preview">URL: /product/<span id="slugPreview">${product.slug}</span></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Danh mục <span class="text-danger">*</span></label>
                        <select class="admin-select" id="categoryId" name="categoryId" datatype="Long" required>
                            <option value="">Chọn danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>
                                        ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Thương hiệu</label>
                        <select class="admin-select" id="brandId" name="brandId" datatype="Long">
                            <option value="">Chọn thương hiệu</option>
                            <c:forEach items="${brands}" var="brand">
                                <option value="${brand.id}" ${product.brandId == brand.id ? 'selected' : ''}>
                                        ${brand.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tags</label>
                        <input type="text" class="admin-input" id="tags" name="tags"
                               datatype="String" value="${product.tags}"
                               placeholder="Nhập tag cách nhau bằng dấu phẩy">
                    </div>
                    <div class="col-12 mb-3">
                        <label class="form-label">Mô tả ngắn</label>
                        <textarea class="admin-textarea" id="shortDescription" name="shortDescription"
                                  datatype="String" rows="2">${product.shortDescription}</textarea>
                    </div>
                    <div class="col-12 mb-3">
                        <label class="form-label">Mô tả chi tiết</label>
                        <textarea class="admin-textarea" id="description" name="description"
                                  datatype="String" rows="5">${product.description}</textarea>
                    </div>
                </div>
            </div>

            <!-- Pricing Information -->
            <div class="admin-form-section">
                <h3 class="admin-section-title">
                    <i class="bi bi-tag"></i> Thông tin giá
                </h3>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá gốc <span class="text-danger">*</span></label>
                        <input type="number" class="admin-input" id="originalPrice" name="originalPrice"
                               datatype="double" step="1000" value="${product.originalPrice}" required
                               onchange="calculateFinalPrice()">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giảm giá (%)</label>
                        <input type="number" class="admin-input" id="discountPercent" name="discountPercent"
                               datatype="double" min="0" max="100" step="1" value="${product.discountPercent}"
                               onchange="calculateFinalPrice()">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá cuối cùng</label>
                        <input type="text" class="admin-input" id="finalPrice" name="finalPrice"
                               datatype="double" readonly>
                    </div>
                </div>
                <div class="admin-price-preview">
                    <div class="row">
                        <div class="col-md-4">
                            <small class="text-muted">Giá gốc:</small>
                            <strong id="previewOriginalPrice">0</strong> ₫
                        </div>
                        <div class="col-md-4">
                            <small class="text-muted">Giảm giá:</small>
                            <strong id="previewDiscountPercent">0</strong>%
                        </div>
                        <div class="col-md-4">
                            <small class="text-muted">Giá bán:</small>
                            <strong class="text-primary" id="previewFinalPrice">0</strong> ₫
                        </div>
                    </div>
                </div>
            </div>

            <!-- Inventory Information -->
            <div class="admin-form-section">
                <h3 class="admin-section-title">
                    <i class="bi bi-box"></i> Quản lý kho
                </h3>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Số lượng <span class="text-danger">*</span></label>
                        <input type="number" class="admin-input" id="quantity" name="quantity"
                               datatype="int" min="0" value="${product.quantity}" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Kho hàng</label>
                        <select class="admin-select" id="warehouseId" name="warehouseId" datatype="Long">
                            <option value="">Chọn kho</option>
                            <c:forEach items="${warehouses}" var="warehouse">
                                <option value="${warehouse.id}" ${product.warehouseId == warehouse.id ? 'selected' : ''}>
                                        ${warehouse.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Cảnh báo tồn kho thấp</label>
                        <input type="number" class="admin-input" id="lowStockThreshold" name="lowStockThreshold"
                               datatype="int" value="${product.lowStockThreshold}" placeholder="Số lượng cảnh báo">
                    </div>
                </div>
            </div>

            <!-- Status Information -->
            <div class="admin-form-section">
                <h3 class="admin-section-title">
                    <i class="bi bi-toggle-on"></i> Trạng thái
                </h3>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Trạng thái sản phẩm</label>
                        <select class="admin-select" id="status" name="status" datatype="String">
                            <option value="active" ${product.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                            <option value="inactive" ${product.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                            <option value="draft" ${product.status == 'draft' ? 'selected' : ''}>Nháp</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Đặc biệt</label>
                        <div class="admin-checkbox-group">
                            <label class="admin-checkbox">
                                <input type="checkbox" id="featured" name="featured" datatype="boolean" value="true" ${product.featured ? 'checked' : ''}>
                                <span>Sản phẩm nổi bật</span>
                            </label>
                            <label class="admin-checkbox">
                                <input type="checkbox" id="newArrival" name="newArrival" datatype="boolean" value="true" ${product.newArrival ? 'checked' : ''}>
                                <span>Hàng mới về</span>
                            </label>
                            <label class="admin-checkbox">
                                <input type="checkbox" id="bestSeller" name="bestSeller" datatype="boolean" value="true" ${product.bestSeller ? 'checked' : ''}>
                                <span>Bán chạy</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Image Management -->
            <div class="admin-form-section">
                <h3 class="admin-section-title">
                    <i class="bi bi-image"></i> Quản lý hình ảnh
                </h3>

                <!-- Main Image -->
                <div class="mb-4">
                    <label class="form-label">Ảnh đại diện <span class="text-danger">*</span></label>
                    <div class="admin-drag-drop" id="mainImageDrop">
                        <i class="bi bi-cloud-upload fs-1"></i>
                        <p>Kéo thả ảnh vào đây hoặc click để chọn</p>
                        <input type="file" id="mainImage" name="mainImage" accept="image/*" style="display: none;">
                    </div>
                    <div id="mainImagePreview" class="mt-2">
                        <c:if test="${not empty product.mainImage}">
                            <img src="${product.mainImage}" class="admin-image-preview" alt="Main image">
                        </c:if>
                    </div>
                </div>

                <!-- Gallery Images -->
                <div>
                    <label class="form-label">Thư viện ảnh</label>
                    <div class="admin-drag-drop" id="galleryDrop">
                        <i class="bi bi-images fs-1"></i>
                        <p>Kéo thả ảnh vào đây hoặc click để chọn (có thể chọn nhiều ảnh)</p>
                        <input type="file" id="galleryImages" name="galleryImages" accept="image/*" multiple style="display: none;">
                    </div>
                    <div id="galleryPreview" class="admin-gallery-preview">
                        <c:forEach items="${product.galleryImages}" var="img">
                            <div class="admin-gallery-item">
                                <img src="${img}" alt="Gallery">
                                <div class="admin-remove-gallery" onclick="removeGalleryImage('${img}')">×</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- SEO Information -->
            <div class="admin-form-section">
                <h3 class="admin-section-title">
                    <i class="bi bi-search"></i> SEO
                </h3>
                <div class="row">
                    <div class="col-12 mb-3">
                        <label class="form-label">Meta Title</label>
                        <input type="text" class="admin-input" id="metaTitle" name="metaTitle"
                               datatype="String" value="${product.metaTitle}">
                    </div>
                    <div class="col-12 mb-3">
                        <label class="form-label">Meta Description</label>
                        <textarea class="admin-textarea" id="metaDescription" name="metaDescription"
                                  datatype="String" rows="2">${product.metaDescription}</textarea>
                    </div>
                    <div class="col-12 mb-3">
                        <label class="form-label">Meta Keywords</label>
                        <input type="text" class="admin-input" id="metaKeywords" name="metaKeywords"
                               datatype="String" value="${product.metaKeywords}">
                    </div>
                </div>
                <div class="admin-seo-preview">
                    <strong>Xem trước trên Google:</strong>
                    <div class="mt-2">
                        <div class="text-primary" id="previewTitle">${empty product.metaTitle ? product.productName : product.metaTitle}</div>
                        <div class="text-success small" id="previewUrl">https://luxcar.com/product/${product.slug}</div>
                        <div class="text-secondary small" id="previewDescription">${product.metaDescription}</div>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="admin-form-actions">
                <button type="button" class="admin-btn-outline" onclick="location.href='/productList'">
                    <i class="bi bi-x-lg"></i> Hủy
                </button>
                <button type="reset" class="admin-btn-outline">
                    <i class="bi bi-arrow-repeat"></i> Reset
                </button>
                <button type="submit" class="admin-btn-primary" id="saveBtn">
                    <i class="bi bi-save"></i> ${empty product ? 'Lưu' : 'Cập nhật'}
                </button>
                <c:if test="${empty product}">
                    <button type="button" class="admin-btn-primary" onclick="saveAndContinue()">
                        <i class="bi bi-save"></i> Lưu & Tiếp tục
                    </button>
                </c:if>
            </div>
        </form>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto calculate final price
    function calculateFinalPrice() {
        const originalPrice = parseFloat(document.getElementById('originalPrice').value) || 0;
        const discountPercent = parseFloat(document.getElementById('discountPercent').value) || 0;
        const finalPrice = originalPrice * (1 - discountPercent / 100);

        document.getElementById('finalPrice').value = finalPrice.toFixed(0);
        document.getElementById('previewOriginalPrice').innerText = originalPrice.toLocaleString();
        document.getElementById('previewDiscountPercent').innerText = discountPercent;
        document.getElementById('previewFinalPrice').innerText = finalPrice.toFixed(0).toLocaleString();
    }

    // Generate slug from product name
    function generateSlug() {
        const productName = document.getElementById('productName').value;
        const slug = productName.toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/[đĐ]/g, 'd')
            .replace(/[^a-z0-9\s-]/g, '')
            .replace(/\s+/g, '-')
            .replace(/-+/g, '-');

        document.getElementById('slug').value = slug;
        document.getElementById('slugPreview').innerText = slug;
        updateSEOPreview();
    }

    // Update SEO preview
    function updateSEOPreview() {
        const metaTitle = document.getElementById('metaTitle').value || document.getElementById('productName').value;
        const metaDescription = document.getElementById('metaDescription').value;
        const slug = document.getElementById('slug').value;

        document.getElementById('previewTitle').innerText = metaTitle;
        document.getElementById('previewUrl').innerText = `https://luxcar.com/product/${slug}`;
        document.getElementById('previewDescription').innerText = metaDescription;
    }

    // Check SKU uniqueness
    document.getElementById('sku').addEventListener('blur', function() {
        const sku = this.value;
        const productId = document.querySelector('input[name="id"]').value;

        if (sku) {
            fetch(`/api/check-sku?sku=${sku}&productId=${productId}`)
                .then(response => response.json())
                .then(data => {
                    if (!data.available) {
                        document.getElementById('skuError').innerText = 'SKU đã tồn tại!';
                        document.getElementById('saveBtn').disabled = true;
                    } else {
                        document.getElementById('skuError').innerText = '';
                        document.getElementById('saveBtn').disabled = false;
                    }
                });
        }
    });

    // Image upload handlers
    const mainImageDrop = document.getElementById('mainImageDrop');
    const mainImageInput = document.getElementById('mainImage');
    const galleryDrop = document.getElementById('galleryDrop');
    const galleryInput = document.getElementById('galleryImages');

    mainImageDrop.addEventListener('click', () => mainImageInput.click());
    mainImageDrop.addEventListener('dragover', (e) => {
        e.preventDefault();
        mainImageDrop.classList.add('drag-over');
    });
    mainImageDrop.addEventListener('dragleave', () => {
        mainImageDrop.classList.remove('drag-over');
    });
    mainImageDrop.addEventListener('drop', (e) => {
        e.preventDefault();
        mainImageDrop.classList.remove('drag-over');
        const file = e.dataTransfer.files[0];
        if (file && file.type.startsWith('image/')) {
            mainImageInput.files = e.dataTransfer.files;
            previewImage(file, 'mainImagePreview');
        }
    });

    mainImageInput.addEventListener('change', (e) => {
        if (e.target.files[0]) {
            previewImage(e.target.files[0], 'mainImagePreview');
        }
    });

    galleryDrop.addEventListener('click', () => galleryInput.click());
    galleryDrop.addEventListener('dragover', (e) => {
        e.preventDefault();
        galleryDrop.classList.add('drag-over');
    });
    galleryDrop.addEventListener('dragleave', () => {
        galleryDrop.classList.remove('drag-over');
    });
    galleryDrop.addEventListener('drop', (e) => {
        e.preventDefault();
        galleryDrop.classList.remove('drag-over');
        const files = Array.from(e.dataTransfer.files).filter(f => f.type.startsWith('image/'));
        if (files.length) {
            galleryInput.files = e.dataTransfer.files;
            files.forEach(file => previewGalleryImage(file));
        }
    });

    galleryInput.addEventListener('change', (e) => {
        const files = Array.from(e.target.files);
        files.forEach(file => previewGalleryImage(file));
    });

    function previewImage(file, containerId) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const container = document.getElementById(containerId);
            container.innerHTML = `<img src="${e.target.result}" class="admin-image-preview" alt="Preview">`;
        };
        reader.readAsDataURL(file);
    }

    function previewGalleryImage(file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const galleryPreview = document.getElementById('galleryPreview');
            const div = document.createElement('div');
            div.className = 'admin-gallery-item';
            div.innerHTML = `
                <img src="${e.target.result}" alt="Gallery">
                <div class="admin-remove-gallery" onclick="this.parentElement.remove()">×</div>
            `;
            galleryPreview.appendChild(div);
        };
        reader.readAsDataURL(file);
    }

    function removeGalleryImage(imageUrl) {
        const hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'deleteGalleryImages';
        hiddenInput.value = imageUrl;
        document.getElementById('productForm').appendChild(hiddenInput);

        const items = document.querySelectorAll('.admin-gallery-item');
        items.forEach(item => {
            if (item.querySelector('img').src === imageUrl) {
                item.remove();
            }
        });
    }

    function saveAndContinue() {
        const form = document.getElementById('productForm');
        form.action = '/addProduct?continue=true';
        form.submit();
    }

    // Validate form before submit
    document.getElementById('productForm').addEventListener('submit', function(e) {
        const productName = document.getElementById('productName').value;
        const originalPrice = parseFloat(document.getElementById('originalPrice').value);
        const quantity = parseInt(document.getElementById('quantity').value);
        const sku = document.getElementById('sku').value;

        if (!productName) {
            alert('Vui lòng nhập tên sản phẩm');
            e.preventDefault();
            return;
        }

        if (!originalPrice || originalPrice <= 0) {
            alert('Giá sản phẩm phải lớn hơn 0');
            e.preventDefault();
            return;
        }

        if (quantity < 0) {
            alert('Số lượng không được âm');
            e.preventDefault();
            return;
        }

        if (!sku) {
            alert('Vui lòng nhập SKU');
            e.preventDefault();
            return;
        }

        const discountPercent = parseFloat(document.getElementById('discountPercent').value);
        if (discountPercent < 0 || discountPercent > 100) {
            alert('Phần trăm giảm giá phải từ 0-100');
            e.preventDefault();
            return;
        }
    });

    // Initialize
    calculateFinalPrice();
    generateSlug();

    // Add event listeners for SEO preview
    document.getElementById('metaTitle').addEventListener('input', updateSEOPreview);
    document.getElementById('metaDescription').addEventListener('input', updateSEOPreview);
</script>
</body>
</html>