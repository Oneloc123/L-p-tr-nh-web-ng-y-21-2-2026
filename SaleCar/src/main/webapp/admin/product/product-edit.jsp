
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa sản phẩm: ${product.productName} | LUXCAR Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Include TinyMCE for rich description editor -->
    <script src="https://cdn.tiny.cloud/1/YOUR_API_KEY/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
    <style>
        /* ========== GLOBAL STYLES (consistent with product-detail.jsp) ========== */
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

        /* gallery thumbnails */
        .gallery-thumb {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.2s;
        }
        .gallery-thumb.active {
            border-color: #2c7da0;
            transform: scale(1.02);
        }

        /* highlight changed field */
        .highlight-change {
            transition: background-color 0.3s;
            background-color: #fff9e0;
            border-radius: 6px;
            padding: 2px 4px;
        }

        .sticky-save {
            position: sticky;
            bottom: 20px;
            background: white;
            padding: 12px 24px;
            border-radius: 60px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            z-index: 100;
            text-align: center;
            width: fit-content;
            margin: 0 auto;
        }

        /* loading spinner */
        .spinner-sm {
            width: 1rem;
            height: 1rem;
            border-width: 0.15em;
        }

        /* ========== IMAGE GALLERY STYLES ========== */
        .image-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
            gap: 1rem;
        }

        .image-card {
            background: #f8fafc;
            border: 1px solid #e9edf2;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.2s ease;
            position: relative;
        }

        .image-card:hover {
            border-color: #2c7da0;
            box-shadow: 0 4px 12px rgba(44, 125, 160, 0.12);
            transform: translateY(-2px);
        }

        .image-card.main-image {
            border-color: #f59e0b;
            box-shadow: 0 0 0 2px rgba(245, 158, 11, 0.3);
        }

        .image-card-img-wrapper {
            position: relative;
            width: 100%;
            padding-top: 75%;
            overflow: hidden;
            background: #e9edf2;
        }

        .image-card-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .image-card-img:hover {
            transform: scale(1.08);
        }

        .main-badge {
            position: absolute;
            top: 6px;
            left: 6px;
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
            font-size: 0.7rem;
            font-weight: 600;
            padding: 2px 8px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            gap: 3px;
            box-shadow: 0 2px 6px rgba(245, 158, 11, 0.4);
            z-index: 2;
        }

        .main-badge i {
            font-size: 0.6rem;
        }

        .image-card-actions {
            display: flex;
            justify-content: center;
            gap: 4px;
            padding: 6px 8px;
            background: #fff;
        }

        .btn-action {
            width: 32px;
            height: 32px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 0.9rem;
            padding: 0;
        }

        .btn-set-main {
            color: #f59e0b;
        }
        .btn-set-main:hover {
            background: #fef3c7;
            border-color: #f59e0b;
        }

        .btn-delete {
            color: #ef4444;
        }
        .btn-delete:hover {
            background: #fee2e2;
            border-color: #ef4444;
        }

        /* Upload preview */
        .preview-thumb {
            width: 72px;
            height: 72px;
            border-radius: 8px;
            overflow: hidden;
            border: 2px solid #e2e8f0;
            flex-shrink: 0;
        }

        .preview-thumb-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        #filePreview {
            max-height: 90px;
            overflow-y: auto;
        }

        /* Image preview modal */
        #imagePreviewModal .modal-content {
            border: none;
            border-radius: 12px;
            overflow: hidden;
        }
        #imagePreviewModal .modal-header {
            padding: 8px 12px;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp" %>
    <main class="main-content">
        <!-- Header -->
        <header class="admin-header d-flex justify-content-between align-items-center">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard" class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/products" class="text-decoration-none">Sản phẩm</a></li>
                        <li class="breadcrumb-item active">Chỉnh sửa: ${product.productName}</li>
                    </ol>
                </nav>
                <h3 class="fw-bold m-0 mt-2">
                    <i class="bi bi-pencil-square me-2" style="color:#2c7da0;"></i>
                    Chỉnh sửa sản phẩm
                </h3>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}" target="_blank" class="admin-btn-outline">
                    <i class="bi bi-eye"></i> Xem trên web
                </a>
                <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <!-- 3. IMAGE GALLERY with upload, delete, set main, preview -->
        <div class="info-section" id="imageSection">
            <h5><i class="bi bi-images me-2"></i>Thư viện ảnh</h5>

            <!-- Upload form -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <form id="uploadImageForm" action="${pageContext.request.contextPath}/admin/products/upload-image" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <div class="input-group">
                            <input type="file" class="form-control" id="imageFileInput" name="imageFile" accept="image/jpeg,image/png,image/webp" multiple>
                            <button class="admin-btn-primary" type="submit" id="uploadBtn">
                                <i class="bi bi-cloud-upload"></i> Tải ảnh lên
                            </button>
                        </div>
                        <small class="text-muted">Hỗ trợ JPG, PNG, WEBP, tối đa 5MB/ảnh</small>
                        <!-- Preview area for newly selected files -->
                        <div id="filePreview" class="d-flex flex-wrap gap-2 mt-2"></div>
                    </form>
                </div>
            </div>

            <!-- Image grid -->
            <div class="row">
                <div class="col-md-12">
                    <c:choose>
                        <c:when test="${not empty product.images}">
                            <div class="image-grid">
                                <c:forEach items="${product.images}" var="imgUrl" varStatus="status">
                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/uploads/${imgUrl}"/>
                                    <div class="image-card ${status.first ? 'main-image' : ''}">
                                        <div class="image-card-img-wrapper">
                                            <img src="${imgSrc}" alt="Ảnh ${status.count}" class="image-card-img" onclick="previewImage('${imgSrc}')">
                                            <c:if test="${status.first}">
                                                <span class="main-badge"><i class="bi bi-star-fill"></i> Chính</span>
                                            </c:if>
                                        </div>
                                        <div class="image-card-actions">
                                            <c:if test="${not status.first}">
                                                <form action="${pageContext.request.contextPath}/admin/products/set-main-image" method="post" class="d-inline">
                                                    <input type="hidden" name="productId" value="${product.productId}">
                                                    <input type="hidden" name="imageUrl" value="${imgUrl}">
                                                    <button type="submit" class="btn-action btn-set-main" title="Đặt làm ảnh chính">
                                                        <i class="bi bi-star"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/admin/products/delete-image" method="post" class="d-inline delete-image-form">
                                                <input type="hidden" name="productId" value="${product.productId}">
                                                <input type="hidden" name="imageUrl" value="${imgUrl}">
                                                <button type="button" class="btn-action btn-delete" title="Xóa ảnh" onclick="confirmDeleteImage(this)">
                                                    <i class="bi bi-trash3"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-image" style="font-size: 3rem;"></i>
                                <p class="mt-2">Chưa có ảnh nào. Hãy tải ảnh lên để hiển thị.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Image Preview Modal -->
        <div class="modal fade" id="imagePreviewModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content bg-dark">
                    <div class="modal-header border-0">
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center p-0">
                        <img id="previewModalImage" src="" alt="Preview" class="img-fluid" style="max-height: 80vh;">
                    </div>
                </div>
            </div>
        </div>

        <!-- 1. MAIN PRODUCT EDIT FORM (basic info + attributes + description + variants) -->
        <form id="productEditForm" action="${pageContext.request.contextPath}/admin/products/edit" method="post">
            <input type="hidden" name="productId" value="${product.productId}">

            <!-- Basic Info -->
            <div class="info-section" id="basicInfoSection">
                <h5><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" class="form-control ${not empty errors.name ? 'is-invalid' : ''}" name="name" value="${product.productName}" required minlength="3" maxlength="255">
                        <div class="invalid-feedback">${errors.name != null ? errors.name : 'Tên phải từ 3-255 ký tự'}</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Danh mục</label>
                        <select class="form-select ${not empty errors.categoryId ? 'is-invalid' : ''}" name="categoryId">
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">${errors.categoryId != null ? errors.categoryId : ''}</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Thương hiệu</label>
                        <select class="form-select ${not empty errors.brandId ? 'is-invalid' : ''}" name="brandId">
                            <option value="">-- Chọn thương hiệu --</option>
                            <c:forEach var="brand" items="${brandList}">
                                <option value="${brand.id}" ${product.brandId == brand.id ? 'selected' : ''}>${brand.name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">${errors.brandId != null ? errors.brandId : ''}</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" name="status">
                            <option value="1" ${product.status.code == 1 ? 'selected' : ''}>Hoạt động (Active)</option>
                            <option value="0" ${product.status.code == 0 ? 'selected' : ''}>Không hoạt động (Inactive)</option>
                        </select>
                        <small class="text-muted">Inactive: sản phẩm tạm ẩn trên shop</small>
                    </div>
                </div>
            </div>

            <!-- Attributes -->
            <div class="info-section" id="attributesSection">
                <h5><i class="bi bi-sliders2 me-2"></i>Thuộc tính sản phẩm</h5>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Tỷ lệ (Scale)</label>
                        <input type="text" class="form-control" name="ratio" value="${product.ratio}">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Kích thước</label>
                        <input type="text" class="form-control" name="size" value="${product.size}">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Chất liệu</label>
                        <input type="text" class="form-control" name="material" value="${product.material}">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Xuất xứ</label>
                        <input type="text" class="form-control" name="origin" value="${product.origin}">
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="info-section" id="descriptionSection">
                <h5><i class="bi bi-file-text me-2"></i>Mô tả sản phẩm</h5>
                <div class="mb-3">
                    <textarea id="tinyDescription" name="description">${product.description}</textarea>
                </div>
            </div>

            <!-- Variants -->
            <div class="info-section" id="variantsSection">
                <h5><i class="bi bi-diagram-3 me-2"></i>Biến thể (Variants)</h5>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle" id="variantsTable">
                        <thead class="table-light">
                            <tr>
                                <th style="min-width:160px;">Tên biến thể <span class="text-danger">*</span></th>
                                <th style="min-width:120px;">SKU</th>
                                <th style="min-width:140px;">Giá (VND) <span class="text-danger">*</span></th>
                                <th style="width:80px;">Tồn kho</th>
                                <th style="width:60px;"></th>
                            </tr>
                        </thead>
                        <tbody id="variantsBody">
                            <c:forEach var="variant" items="${product.variants}" varStatus="vs">
                            <tr class="variant-row">
                                <td>
                                    <input type="hidden" name="variantId[]" value="${variant.id}">
                                    <input type="text" class="form-control form-control-sm" name="variantName[]"
                                           value="${variant.variantName}" required placeholder="VD: Đỏ, Xanh">
                                    <c:set var="vk" value="variant_${vs.index}"/>
                                    <c:if test="${not empty errors[vk]}">
                                        <div class="text-danger small">${errors[vk]}</div>
                                    </c:if>
                                </td>
                                <td>
                                    <input type="text" class="form-control form-control-sm" name="variantSku[]"
                                           value="${variant.sku}" placeholder="Mã SKU">
                                </td>
                                <td>
                                    <input type="number" step="1000" class="form-control form-control-sm variant-price"
                                           name="variantPrice[]" value="${variant.price}" required min="1">
                                    <c:set var="pvk" value="variantPrice_${vs.index}"/>
                                    <c:if test="${not empty errors[pvk]}">
                                        <div class="text-danger small">${errors[pvk]}</div>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-info">${variant.quantity}</span>
                                </td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-sm btn-outline-danger remove-variant-btn" title="Xoá biến thể">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <button type="button" id="addVariantBtn" class="admin-btn-outline mt-2">
                    <i class="bi bi-plus-circle"></i> Thêm biến thể
                </button>
            </div>

            <!-- Submit -->
            <div class="mt-3 d-flex justify-content-end gap-2">
                <button type="submit" class="admin-btn-primary save-btn" id="mainSaveBtn">
                    <i class="bi bi-save"></i> Lưu thông tin
                </button>
                <button type="reset" class="admin-btn-outline">
                    <i class="bi bi-arrow-repeat"></i> Đặt lại
                </button>
            </div>
        </form>




        <!-- 9. EDIT HISTORY & INFO -->
        <div class="info-section">
            <h5><i class="bi bi-clock-history me-2"></i>Lịch sử chỉnh sửa</h5>
            <div><span class="info-label">Cập nhật lần cuối:</span> <fmt:formatDate value="${product.updatedAtDate}" pattern="dd/MM/yyyy HH:mm:ss"/></div>
            <div><span class="info-label">Ngày tạo:</span> <fmt:formatDate value="${product.createdAtDate}" pattern="dd/MM/yyyy HH:mm:ss"/></div>
            <c:if test="${not empty priceHistoryList}">
                <div class="mt-2"><button class="btn btn-sm admin-btn-outline" type="button" data-bs-toggle="collapse" data-bs-target="#priceHistoryCollapse">Xem lịch sử giá</button></div>
                <div class="collapse mt-2" id="priceHistoryCollapse">
                    <table class="table table-sm">
                        <thead><tr><th>Thời gian</th><th>Giá cũ</th><th>Giá mới</th><th>Người thay đổi</th></tr></thead>
                        <tbody>
                        <c:forEach items="${priceHistoryList}" var="hist">
                            <tr><td><fmt:formatDate value="${hist.changedAt}" pattern="dd/MM/yyyy HH:mm"/></td><td><fmt:formatNumber value="${hist.oldPrice}" type="currency"/></td><td><fmt:formatNumber value="${hist.newPrice}" type="currency"/></td><td>${hist.changedBy}</td></tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>

        <!-- Sticky Save Bar -->
        <div class="sticky-save d-flex gap-3 justify-content-center">
            <button type="button" id="globalResetBtn" class="admin-btn-outline"><i class="bi bi-arrow-repeat"></i> Đặt lại</button>
            <button type="button" id="globalSaveBtn" class="admin-btn-primary"><i class="bi bi-cloud-upload"></i> Lưu tất cả thay đổi</button>
        </div>
    </main>
</div>

<!-- DELETE MODAL with confirmation text -->
<div class="modal fade" id="deleteProductModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Xác nhận xóa vĩnh viễn</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Xóa sản phẩm <strong>${product.productName}</strong> (ID: ${product.productId})</p>
                <p>Vui lòng gõ <strong class="text-danger">DELETE</strong> để xác nhận:</p>
                <input type="text" id="deleteConfirmText" class="form-control" placeholder="DELETE">
                <form id="deleteProductForm" action="${pageContext.request.contextPath}/admin/products/delete" method="post">
                    <input type="hidden" name="productId" value="${product.productId}">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="admin-btn-outline" data-bs-dismiss="modal">Hủy</button>
                <button type="button" id="confirmDeleteBtn" class="admin-btn-danger">Xóa vĩnh viễn</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize TinyMCE
    tinymce.init({
        selector: '#tinyDescription',
        height: 300,
        menubar: false,
        plugins: 'advlist autolink lists link image charmap preview anchor',
        toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright | bullist numlist outdent indent | link',
        content_style: 'body { font-family:Inter, sans-serif; }'
    });

    // ===== Unsaved changes tracking =====
    let formChanged = false;
    const editForm = document.getElementById('productEditForm');
    const formInputs = editForm ? editForm.querySelectorAll('input, select') : [];
    function markChanged() { formChanged = true; }
    formInputs.forEach(el => el.addEventListener('change', markChanged));

    // TinyMCE change detection
    tinymce.get('tinyDescription')?.on('change', markChanged);

    window.addEventListener('beforeunload', function (e) {
        if (formChanged) {
            e.preventDefault();
            e.returnValue = 'Bạn có thay đổi chưa lưu. Rời khỏi sẽ mất dữ liệu.';
            return e.returnValue;
        }
    });

    // Sync TinyMCE content before form submit
    editForm?.addEventListener('submit', function(e) {
        // Push TinyMCE content into the textarea
        if (tinymce.get('tinyDescription')) {
            tinymce.get('tinyDescription').save();
        }
        // Validate variant rows
        const variantRows = document.querySelectorAll('#variantsBody .variant-row');
        let variantValid = true;
        variantRows.forEach(row => {
            const nameInput = row.querySelector('[name="variantName[]"]');
            const priceInput = row.querySelector('[name="variantPrice[]"]');
            if (!nameInput.value.trim()) {
                nameInput.classList.add('is-invalid');
                variantValid = false;
            } else {
                nameInput.classList.remove('is-invalid');
            }
            if (!priceInput.value || parseFloat(priceInput.value) <= 0) {
                priceInput.classList.add('is-invalid');
                variantValid = false;
            } else {
                priceInput.classList.remove('is-invalid');
            }
        });
        if (!variantValid) {
            e.preventDefault();
            Swal.fire({
                icon: 'warning',
                title: 'Vui lòng kiểm tra lại',
                text: 'Có lỗi ở phần biến thể. Vui lòng điền đầy đủ thông tin.',
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            return false;
        }
        formChanged = false;
    });

    // ===== Variant rows: add / remove =====
    const variantsBody = document.getElementById('variantsBody');

    // Remove variant row
    variantsBody?.addEventListener('click', function(e) {
        const removeBtn = e.target.closest('.remove-variant-btn');
        if (!removeBtn) return;
        const row = removeBtn.closest('tr');
        if (row && row.parentNode === variantsBody) {
            Swal.fire({
                title: 'Xoá biến thể?',
                text: 'Biến thể này sẽ bị xoá khỏi sản phẩm.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Xoá',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    row.remove();
                    formChanged = true;
                }
            });
        }
    });

    // Add new variant row
    document.getElementById('addVariantBtn')?.addEventListener('click', function() {
        const row = document.createElement('tr');
        row.className = 'variant-row';
        row.innerHTML = `
            <td>
                <input type="hidden" name="variantId[]" value="0">
                <input type="text" class="form-control form-control-sm" name="variantName[]" required placeholder="VD: Đỏ, Xanh">
            </td>
            <td>
                <input type="text" class="form-control form-control-sm" name="variantSku[]" placeholder="Mã SKU">
            </td>
            <td>
                <input type="number" step="1000" class="form-control form-control-sm variant-price" name="variantPrice[]" required min="1" placeholder="VD: 500000">
            </td>
            <td class="text-center text-muted small">
                <span class="badge bg-secondary">Mới</span>
            </td>
            <td class="text-center">
                <button type="button" class="btn btn-sm btn-outline-danger remove-variant-btn" title="Xoá biến thể">
                    <i class="bi bi-x-lg"></i>
                </button>
            </td>
        `;
        variantsBody.appendChild(row);
        formChanged = true;
    });

    // ===== Sticky Save (submit main form) =====
    document.getElementById('globalResetBtn')?.addEventListener('click', () => {
        Swal.fire({
            title: 'Đặt lại thay đổi?',
            text: 'Đặt lại tất cả thay đổi chưa lưu. Trang sẽ tải lại.',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#6c757d',
            cancelButtonColor: '#2c7da0',
            confirmButtonText: 'Đặt lại',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if(result.isConfirmed) {
                window.location.reload();
            }
        });
    });

    document.getElementById('globalSaveBtn')?.addEventListener('click', async () => {
        if (!editForm) return;
        // Sync TinyMCE
        if (tinymce.get('tinyDescription')) {
            tinymce.get('tinyDescription').save();
        }
        if (!editForm.checkValidity()) {
            editForm.reportValidity();
            return;
        }
        const result = await Swal.fire({
            title: 'Xác nhận lưu',
            text: 'Lưu tất cả thay đổi?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#2c7da0',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Lưu',
            cancelButtonText: 'Hủy'
        });
        if(result.isConfirmed) {
            formChanged = false;
            editForm.submit();
        }
    });

    // Delete confirmation modal logic
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const deleteConfirmInput = document.getElementById('deleteConfirmText');
    confirmDeleteBtn.addEventListener('click', () => {
        if(deleteConfirmInput.value === 'DELETE') {
            document.getElementById('deleteProductForm').submit();
        } else {
            Swal.fire({
                icon: 'warning',
                title: 'Xác nhận thất bại',
                text: 'Vui lòng gõ DELETE để xác nhận',
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
        }
    });

    // ===== IMAGE GALLERY: File preview before upload =====
    const imageFileInput = document.getElementById('imageFileInput');
    const filePreview = document.getElementById('filePreview');

    if (imageFileInput) {
        imageFileInput.addEventListener('change', function() {
            filePreview.innerHTML = '';
            const files = this.files;
            if (files.length === 0) return;

            for (let i = 0; i < Math.min(files.length, 10); i++) {
                const file = files[i];
                const ext = file.name.split('.').pop().toLowerCase();
                const allowed = ['jpg', 'jpeg', 'png', 'webp'];

                if (!allowed.includes(ext)) {
                    const badge = document.createElement('span');
                    badge.className = 'badge bg-danger';
                    badge.textContent = file.name + ' (không hỗ trợ)';
                    filePreview.appendChild(badge);
                    continue;
                }
                if (file.size > 5 * 1024 * 1024) {
                    const badge = document.createElement('span');
                    badge.className = 'badge bg-warning text-dark';
                    badge.textContent = file.name + ' (>5MB)';
                    filePreview.appendChild(badge);
                    continue;
                }

                const reader = new FileReader();
                const imgWrapper = document.createElement('div');
                imgWrapper.className = 'preview-thumb';
                imgWrapper.title = file.name;

                reader.onload = function(e) {
                    imgWrapper.innerHTML = '<img src="' + e.target.result + '" class="preview-thumb-img">';
                };
                reader.readAsDataURL(file);
                filePreview.appendChild(imgWrapper);
            }

            if (files.length > 10) {
                const more = document.createElement('span');
                more.className = 'badge bg-secondary';
                more.textContent = '+' + (files.length - 10) + ' ảnh nữa';
                filePreview.appendChild(more);
            }
        });
    }

    // ===== IMAGE GALLERY: Preview modal =====
    function previewImage(src) {
        const modal = new bootstrap.Modal(document.getElementById('imagePreviewModal'));
        document.getElementById('previewModalImage').src = src;
        modal.show();
    }

    // ===== IMAGE GALLERY: SweetAlert2 delete confirm =====
    function confirmDeleteImage(btn) {
        const form = btn.closest('form');
        Swal.fire({
            title: 'Xóa ảnh?',
            text: 'Ảnh sẽ bị xóa vĩnh viễn. Hành động này không thể hoàn tác.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                form.submit();
            }
        });
    }

    // ===== IMAGE GALLERY: Show processing state on upload button =====
    document.getElementById('uploadImageForm')?.addEventListener('submit', function() {
        const btn = document.getElementById('uploadBtn');
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Đang tải...';
    });

</script>
</body>
</html>