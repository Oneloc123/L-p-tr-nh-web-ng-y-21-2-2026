<!DOCTYPE html>
<html lang="vi">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa sản phẩm: ${product.name} | LUXCAR Admin</title>
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
                        <li class="breadcrumb-item active">Chỉnh sửa: ${product.name}</li>
                    </ol>
                </nav>
                <h3 class="fw-bold m-0 mt-2">
                    <i class="bi bi-pencil-square me-2" style="color:#2c7da0;"></i>
                    Chỉnh sửa sản phẩm
                </h3>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}" target="_blank" class="admin-btn-outline">
                    <i class="bi bi-eye"></i> Xem trên web
                </a>
                <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <!-- Unsaved changes warning will be managed by JS -->
        <form id="globalFormWatcher"></form>

        <!-- 1. BASIC INFORMATION SECTION -->
        <div class="info-section" id="basicInfoSection">
            <h5><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h5>
            <form id="basicInfoForm" action="${pageContext.request.contextPath}/admin/product/update-basic-info" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" value="${product.name}" placeholder="${product.name}" required minlength="3" maxlength="255">
                        <div class="invalid-feedback">Tên phải từ 3-255 ký tự</div><div id="nameError" class="text-danger"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">SKU <span class="text-danger">*</span></label>
                        <input type="text" class="form-control sku-input" name="sku" value="${product.sku}" required pattern="[A-Za-z0-9-]+" placeholder="Chức năng đang phát triển">
                        <div class="invalid-feedback">SKU chỉ gồm chữ, số và dấu gạch ngang, phải duy nhất</div><div id="skuError" class="text-danger"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Danh mục</label>
                        <select class="form-select" name="categoryId">
                            <option value="">-- Chọn danh mục --</option>
                           <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                        <div id="categoryIdError" class="text-danger"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Thương hiệu</label>
                        <select class="form-select" name="brandId">
                            <option value="">-- Chọn thương hiệu --</option>
                            <c:forEach var="brand" items="${brandList}">
                                <option value="${brand.id}" ${product.brandId == brand.id ? 'selected' : ''}>${brand.name}</option>
                            </c:forEach>
                        </select>
                        <div id="brandIdError" class="text-danger"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" name="status">
                            <option value="1" ${product.status == 1? 'selected' : ''}>Hoạt động (Active)</option>
                            <option value="0" ${product.status == 0 ? 'selected' : ''}>Không hoạt động (Inactive)</option>
                        </select>
                        <small class="text-muted">Inactive: sản phẩm tạm ẩn trên shop</small>
                        <div id="statusError" class="text-danger"></div>
                    </div>
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="basicInfoForm"><i class="bi bi-save"></i> Lưu thông tin</button>
                </div>
            </form>
        </div>

        <!-- 2. PRICE & DISCOUNT SECTION -->
        <div class="info-section" id="priceSection">
            <h5><i class="bi bi-tag me-2"></i>Giá & khuyến mãi</h5>
            <h5 class="text-danger">chức năng đang phát triển</h5>

            <form id="priceForm" action="${pageContext.request.contextPath}/admin/product/update-price" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="row">

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá gốc (VND)</label>
                        <fmt:formatNumber value="${product.price}" pattern="0" var="priceValue"/>

                        <input
                                type="number"
                                step="1000"
                                class="form-control"
                                name="price"
                                value="${priceValue}"
                                placeholder="${formattedPrice}"
                                required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá khuyến mãi (VND)</label>
                        <fmt:formatNumber value="${product.finalPrice}" pattern="0" var="priceValue"/>

                        <input
                                type="number"
                                step="1000"
                                class="form-control"
                                name="finalPrice"
                                value="${priceValue}"
                                placeholder="${formattedPrice}"
                                required>
                        <small class="text-muted">Phải nhỏ hơn giá gốc</small>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">% giảm</label>
                        <input type="number" step="0.01" class="form-control" name="discountPercent" value="${product.discountPercent}" readonly disabled>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ngày bắt đầu khuyến mãi</label>
                        <input type="datetime-local" class="form-control" name="saleStartDate" value="${saleStartDateValue}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ngày kết thúc khuyến mãi</label>
                        <input type="datetime-local" class="form-control" name="saleEndDate" value="${saleEndDateValue}">
                    </div>
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="priceForm"><i class="bi bi-save"></i> Cập nhật giá</button>
                </div>
            </form>
        </div>

        <!-- 3. IMAGE GALLERY with upload, delete, set main -->
        <div class="info-section" id="imageSection">
            <h5><i class="bi bi-images me-2"></i>Thư viện ảnh</h5>
            <div class="row">
                <div class="col-md-12 mb-3">
                    <form id="uploadImageForm" action="${pageContext.request.contextPath}/admin/product/upload-image" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="productId" value="${product.id}">
                        <div class="input-group">
                            <input type="file" class="form-control" name="imageFile" accept="image/jpeg,image/png,image/webp" multiple>
                            <button class="admin-btn-primary" type="submit">Tải ảnh lên</button>
                        </div>
                        <small class="text-muted">Hỗ trợ JPG, PNG, WEBP, tối đa 5MB/ảnh</small>
                    </form>
                </div>
                <div class="col-md-12">
                    <div class="d-flex flex-wrap gap-3">
                        <c:forEach items="${product.image}" var="imgUrl" varStatus="status">
                            <div class="position-relative" style="width: 100px;">
                                <img src="${imgUrl}" class="gallery-thumb w-100 h-auto" style="height: 80px;">
                                <div class="mt-1 d-flex gap-1 justify-content-center">
                                    <form action="${pageContext.request.contextPath}/admin/product/set-main-image" method="post">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="imageUrl" value="${imgUrl}">
                                        <button type="submit" class="btn btn-sm btn-outline-primary" title="Đặt làm ảnh chính"><i class="bi bi-star-fill"></i></button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/product/delete-image" method="post" onsubmit="return confirm('Xóa ảnh này?')">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="imageUrl" value="${imgUrl}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty product.image}"><div class="text-muted">Chưa có ảnh</div></c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- 4. PRODUCT DESCRIPTION (WYSIWYG) -->
        <div class="info-section">
            <h5><i class="bi bi-file-text me-2"></i>Mô tả sản phẩm</h5>
            <form id="descForm" action="${pageContext.request.contextPath}/admin/product/update-description" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="mb-3">
                    <label class="form-label">Mô tả chi tiết</label>
                    <textarea id="tinyDescription" name="description">${product.description}</textarea>
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="descForm"><i class="bi bi-save"></i> Lưu mô tả</button>
                </div>
            </form>
        </div>

        <!-- 5. ATTRIBUTES SECTION (Scale, Material, Origin, etc.) -->
        <div class="info-section">
            <h5><i class="bi bi-sliders2 me-2"></i>Thuộc tính sản phẩm (Model Car)</h5>
            <form id="attributeForm" action="${pageContext.request.contextPath}/admin/product/update-attributes" method="post">
                <input type="hidden" name="productId" value="${product.id}">
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
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="attributeForm"><i class="bi bi-save"></i> Lưu thuộc tính</button>
                </div>
            </form>
        </div>

        <!-- 6. INVENTORY MANAGEMENT -->
        <div class="info-section">
            <h5><i class="bi bi-boxes me-2"></i>Quản lý kho</h5>
            <h5 class="text-danger">chức năng đang phát triển</h5>

            <form id="inventoryForm" action="${pageContext.request.contextPath}/admin/product/update-inventory" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Số lượng tồn kho</label>
                        <input type="number" class="form-control" name="quantity" value="${product.quantity}" min="0" required>
                        <c:if test="${product.quantity < 5 && product.quantity > 0}"><span class="badge bg-warning">Cảnh báo: tồn kho thấp</span></c:if>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Mã kho / Warehouse</label>
                        <input type="text" class="form-control" name="warehouseCode" value="${warehouseCode}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Ngưỡng cảnh báo</label>
                        <input type="number" class="form-control" name="stockWarningLevel" value="${stockWarningLevel != null ? stockWarningLevel : 5}">
                    </div>
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="inventoryForm"><i class="bi bi-save"></i> Cập nhật kho</button>
                </div>
            </form>
        </div>

        <!-- 7. TAGS & PROMOTION -->
        <div class="info-section">
            <h5><i class="bi bi-tags me-2"></i>Tags / Khuyến mãi đặc biệt</h5>
            <h5 class="text-danger">chức năng đang phát triển</h5>

            <form id="tagsForm" action="${pageContext.request.contextPath}/admin/product/update-tags" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="mb-3">
                    <label class="form-label">Tags (cách nhau bằng dấu phẩy)</label>
                    <input type="text" class="form-control" name="tags" value="${tagString}" placeholder="VD: mới, hot, best-seller">
                </div>
                <div class="mb-3">
                    <label class="form-label">Chương trình khuyến mãi đặc biệt</label>
                    <select class="form-select" name="promotionId">
                        <option value="">-- Không áp dụng --</option>
                        <c:forEach items="${promotionList}" var="promo">
                            <option value="${promo.id}" ${selectedPromoId == promo.id ? 'selected' : ''}>${promo.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="tagsForm"><i class="bi bi-save"></i> Lưu tags</button>
                </div>
            </form>
        </div>

        <!-- 8. PRODUCT URL / SEO -->
        <div class="info-section">
            <h5><i class="bi bi-link-45deg me-2"></i>SEO & URL</h5>
            <form id="seoForm" action="${pageContext.request.contextPath}/admin/product/update-seo" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="mb-3">
                    <label class="form-label">Đường dẫn tĩnh (Slug)</label>
                    <input type="text" class="form-control" name="slug" value="${productSlug}" placeholder="ten-san-pham-dep">
                    <small class="text-muted">Để trống hệ thống tự sinh</small>
                </div>
                <div class="mb-3">
                    <label class="form-label">Liên kết thương hiệu (Brand Link)</label>
                    <input type="url" class="form-control" name="brandLink" value="${product.brandLink}">
                </div>
                <div class="mt-3 d-flex justify-content-end">
                    <button type="submit" class="admin-btn-primary save-btn" data-form="seoForm"><i class="bi bi-save"></i> Cập nhật URL</button>
                </div>
            </form>
        </div>

        <!-- 9. EDIT HISTORY & INFO -->
        <div class="info-section">
            <h5><i class="bi bi-clock-history me-2"></i>Lịch sử chỉnh sửa</h5>
            <div><span class="info-label">Cập nhật lần cuối:</span> <fmt:formatDate value="${product.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss"/></div>
            <div><span class="info-label">Ngày tạo:</span> <fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></div>
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

        <!-- 10. DANGER ZONE: DUPLICATE & DELETE -->
        <div class="info-section border-danger">
            <h5 class="text-danger"><i class="bi bi-exclamation-triangle me-2"></i>Vùng nguy hiểm</h5>
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <div class="fw-bold">Nhân bản sản phẩm</div>
                    <div class="small text-muted">Tạo bản sao với tên mới</div>
                    <form action="${pageContext.request.contextPath}/admin/product/duplicate" method="post">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="admin-btn-outline mt-1"><i class="bi bi-files"></i> Duplicate</button>
                    </form>
                </div>
                <div>
                    <div class="fw-bold">Xóa sản phẩm vĩnh viễn</div>
                    <div class="small text-muted">Hành động không thể hoàn tác</div>
                    <button type="button" class="admin-btn-danger mt-1" data-bs-toggle="modal" data-bs-target="#deleteProductModal"><i class="bi bi-trash3"></i> Xóa sản phẩm</button>
                </div>
            </div>
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
                <p>Xóa sản phẩm <strong>${product.name}</strong> (ID: ${product.id})</p>
                <p>Vui lòng gõ <strong class="text-danger">DELETE</strong> để xác nhận:</p>
                <input type="text" id="deleteConfirmText" class="form-control" placeholder="DELETE">
                <form id="deleteProductForm" action="${pageContext.request.contextPath}/admin/product/delete" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
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

    // Unsaved changes tracking
    let formChanged = false;
    const allForms = document.querySelectorAll('form');
    const inputs = document.querySelectorAll('input, select, textarea:not(#tinyDescription)');
    function markChanged() { formChanged = true; }
    inputs.forEach(el => el.addEventListener('change', markChanged));
    // TinyMCE change detection
    if(tinymce.get('tinyDescription')) {
        tinymce.get('tinyDescription').on('change', markChanged);
    }

    window.addEventListener('beforeunload', function (e) {
        if (formChanged) {
            e.preventDefault();
            e.returnValue = 'Bạn có thay đổi chưa lưu. Rời khỏi sẽ mất dữ liệu.';
            return e.returnValue;
        }
    });

    // Handle each form submit separately, clear changed flag after save
    document.querySelectorAll('.save-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            const formId = this.getAttribute('data-form');
            if(formId) {
                const form = document.getElementById(formId);
                if(form && form.checkValidity()) {
                    formChanged = false;
                } else if(form) {
                    form.reportValidity();
                    e.preventDefault();
                }
            }
        });
    });

    // Global reset: reload page to original state
    document.getElementById('globalResetBtn').addEventListener('click', () => {
        if(confirm('Đặt lại tất cả thay đổi chưa lưu? Trang sẽ tải lại.')) {
            window.location.reload();
        }
    });

    // Global save: iterate all forms and submit sequentially (simple trigger)
    document.getElementById('globalSaveBtn').addEventListener('click', async () => {
        let allValid = true;
        for(let form of allForms) {
            if(form.id && !form.checkValidity()) {
                form.reportValidity();
                allValid = false;
                break;
            }
        }
        if(allValid && confirm('Lưu tất cả thay đổi?')) {
            for(let form of allForms) {
                if(form.id && form.id !== 'globalFormWatcher') {
                    await fetch(form.action, {
                        method: form.method,
                        body: new FormData(form)
                    });
                }
            }
            alert('Đã lưu tất cả thay đổi. Trang sẽ tải lại.');
            window.location.reload();
        }
    });

    // Delete confirmation modal logic
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const deleteConfirmInput = document.getElementById('deleteConfirmText');
    confirmDeleteBtn.addEventListener('click', () => {
        if(deleteConfirmInput.value === 'DELETE') {
            document.getElementById('deleteProductForm').submit();
        } else {
            alert('Vui lòng gõ DELETE để xác nhận');
        }
    });

    // SKU uniqueness client hint (simple)
    const skuInput = document.querySelector('.sku-input');
    if(skuInput) {
        skuInput.addEventListener('blur', function() {
            let sku = this.value;
            if(sku) {
                fetch('${pageContext.request.contextPath}/admin/product/check-sku?sku='+encodeURIComponent(sku)+'&productId=${product.id}')
                    .then(res => res.json())
                    .then(data => {
                        if(data.exists) {
                            skuInput.setCustomValidity('SKU đã tồn tại');
                            skuInput.classList.add('is-invalid');
                        } else {
                            skuInput.setCustomValidity('');
                            skuInput.classList.remove('is-invalid');
                        }
                    });
            }
        });
    }

    // base info
    const errors = {
        name: "${errors.name}",
        sku: "${errors.sku}",
        categoryId: "${errors.categoryId}",
        brandId: "${errors.brandId}",
        status: "${errors.status}"
    };

    for (const key in errors) {

        const message = errors[key];

        if (message && message !== "null" && message !== "") {

            const errorElementId = key + "Error";

            const element = document.getElementById(errorElementId);

            if (element) {
                element.innerText = message;
            }

        }
    }




    // Price validation
    const priceForm = document.getElementById('priceForm');
    if(priceForm) {
        const basePrice = priceForm.querySelector('input[name="price"]');
        const salePrice = priceForm.querySelector('input[name="finalPrice"]');
        function validatePrice() {
            if(parseFloat(salePrice.value) >= parseFloat(basePrice.value) && salePrice.value !== '') {
                salePrice.setCustomValidity('Giá khuyến mãi phải nhỏ hơn giá gốc');
            } else {
                salePrice.setCustomValidity('');
            }
        }
        basePrice.addEventListener('input', validatePrice);
        salePrice.addEventListener('input', validatePrice);
    }


</script>
</body>
</html>