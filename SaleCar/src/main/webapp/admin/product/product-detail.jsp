<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm: ${product.name} | LUXCAR Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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

        .admin-btn-danger:hover {
            background-color: #c82333;
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

        /* ========== IMAGE GALLERY ========== */
        .product-detail-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 16px;
            cursor: pointer;
        }

        .gallery-thumb {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.2s;
        }

        .gallery-thumb:hover,
        .gallery-thumb.active {
            border-color: #2c7da0;
            transform: scale(1.05);
        }

        /* ========== PRICE DISPLAY ========== */
        .price-current {
            font-size: 2rem;
            font-weight: 700;
            color: #2c7da0;
        }

        .price-original {
            font-size: 1rem;
            text-decoration: line-through;
            color: #94a3b8;
        }

        /* ========== BADGES ========== */
        .admin-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-active {
            background-color: #e6f7ec;
            color: #2e7d5e;
        }

        .badge-inactive {
            background-color: #fff0f0;
            color: #c75c5c;
        }

        .badge-draft {
            background-color: #f0f0f0;
            color: #6c757d;
        }

        .badge-low-stock {
            background-color: #fff0f0;
            color: #c75c5c;
        }

        /* ========== REVIEW CARD ========== */
        .review-item {
            border-bottom: 1px solid #e9edf2;
            padding: 1rem 0;
        }

        .review-item:last-child {
            border-bottom: none;
        }

        .review-rating {
            color: #fbbf24;
        }

        /* ========== ACTIVITY LOG ========== */
        .activity-log {
            max-height: 300px;
            overflow-y: auto;
        }

        .log-item {
            padding: 0.75rem;
            border-bottom: 1px solid #e9edf2;
        }

        /* ========== PRODUCT LIST (Related) ========== */
        .related-product-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem;
            border-bottom: 1px solid #e9edf2;
        }

        .related-product-item img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
        }

        /* ========== MODAL ========== */
        .modal-content {
            border-radius: 20px;
            border: none;
        }

        /* ========== TOOLTIP ========== */
        [data-tooltip] {
            position: relative;
            cursor: pointer;
        }

        [data-tooltip]:before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            padding: 4px 8px;
            background-color: #1e293b;
            color: white;
            font-size: 0.75rem;
            border-radius: 4px;
            white-space: nowrap;
            display: none;
            z-index: 10;
        }

        [data-tooltip]:hover:before {
            display: block;
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
                        <li class="breadcrumb-item active">${product.name}</li>
                    </ol>
                </nav>
                <h3 class="fw-bold m-0 mt-2">
                    <i class="bi bi-box-seam me-2" style="color:#2c7da0;"></i>
                    ${product.name}
                </h3>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}" target="_blank"
                   class="admin-btn-outline">
                    <i class="bi bi-eye"></i> Xem trên web
                </a>
                <a href="${pageContext.request.contextPath}/admin/products/edit?id=${product.id}"
                   class="admin-btn-primary">
                    <i class="bi bi-pencil-square"></i> Chỉnh sửa
                </a>
                <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <div class="row">
            <!-- ========== SECTION 1: IMAGE GALLERY ========== -->
            <div class="col-md-5">
                <div class="info-section">
                    <h5><i class="bi bi-images me-2"></i>Hình ảnh sản phẩm</h5>
                    <div class="text-center mb-3">
                        <img id="mainImage"
                             src="${product.image != null && not empty product.image ? product.image[0] : pageContext.request.contextPath.concat('/assets/img/default-product.png')}"
                             class="product-detail-image" alt="${product.name}">
                    </div>
                    <div class="gallery-preview d-flex gap-2 flex-wrap justify-content-center">
                        <c:forEach items="${product.image}" var="img" varStatus="status">
                            <img src="${img}" class="gallery-thumb ${status.index == 0 ? 'active' : ''}"
                                 onclick="changeMainImage('${img}')" alt="Thumb ${status.index + 1}">
                        </c:forEach>
                        <c:if test="${empty product.image}">
                            <div class="text-muted text-center w-100">Chưa có ảnh</div>
                        </c:if>
                    </div>
                    <div class="mt-3 text-center">
                        <form action="${pageContext.request.contextPath}/admin/products/${product.id}/upload-image"
                              method="post" enctype="multipart/form-data" class="d-inline">
                            <input type="file" name="image" accept="image/*" class="d-none" id="uploadImageInput">
                            <button type="button" class="admin-btn-outline btn-sm"
                                    onclick="document.getElementById('uploadImageInput').click()">
                                <i class="bi bi-upload"></i> Upload ảnh
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 2: BASIC INFORMATION ========== -->
            <div class="col-md-7">
                <div class="info-section">
                    <h5><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">ID sản phẩm</div>
                            <div class="info-value">
                                #${product.id}
                                <i class="bi bi-copy ms-2" style="cursor: pointer;"
                                   onclick="copyToClipboard('${product.id}')" data-tooltip="Copy ID"></i>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">SKU</div>
                            <div class="info-value">
                                ${product.sku != null ? product.sku : 'N/A'}
                                <c:if test="${product.sku != null}">
                                    <i class="bi bi-copy ms-2" style="cursor: pointer;"
                                       onclick="copyToClipboard('${product.sku}')" data-tooltip="Copy SKU"></i>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Tên sản phẩm</div>
                            <div class="info-value">${product.name}</div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Trạng thái</div>
                            <div class="info-value">
                                <span class="admin-badge ${product.status ? 'badge-active' : 'badge-inactive'}">
                                    ${product.status ? 'Hoạt động' : 'Không hoạt động'}
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Danh mục</div>
                            <div class="info-value">${product.categoryName != null ? product.categoryName : 'Chưa phân loại'}</div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Thương hiệu</div>
                            <div class="info-value">${product.brandName != null ? product.brandName : 'Chưa có thương hiệu'}</div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Ngày tạo</div>
                            <div class="info-value"><fmt:formatDate value="${product.createdAt}"
                                                                    pattern="dd/MM/yyyy HH:mm"/></div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Cập nhật lần cuối</div>
                            <div class="info-value"><fmt:formatDate value="${product.updatedAt}"
                                                                    pattern="dd/MM/yyyy HH:mm"/></div>
                        </div>
                    </div>
                </div>

                <!-- ========== SECTION 3: PRICE & DISCOUNT ========== -->
                <div class="info-section">
                    <h5><i class="bi bi-tag me-2"></i>Giá & Khuyến mãi</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">Giá gốc</div>
                            <div class="price-original">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Giá sau giảm</div>
                            <div class="price-current">
                                <fmt:formatNumber value="${product.finalPrice}" type="currency" currencySymbol="₫"/>
                            </div>
                        </div>
                        <div class="col-md-12 mt-2">
                            <div class="info-label">Giảm giá</div>
                            <div class="info-value">
                                <span class="badge bg-danger">-${product.discountPercent}%</span>
                                <c:if test="${product.discount != null}">
                                    <small class="text-muted ms-2">
                                        (Áp dụng đến: <fmt:formatDate value="${product.discount.endDate}"
                                                                      pattern="dd/MM/yyyy"/>)
                                    </small>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit-price"
                           class="admin-btn-outline btn-sm">
                            <i class="bi bi-pencil"></i> Chỉnh sửa giá
                        </a>
                        <button type="button" class="admin-btn-outline btn-sm ms-2" data-bs-toggle="modal"
                                data-bs-target="#priceHistoryModal">
                            <i class="bi bi-clock-history"></i> Lịch sử giá
                        </button>
                    </div>
                </div>

                <!-- ========== SECTION 4: INVENTORY ========== -->
                <div class="info-section">
                    <h5><i class="bi bi-boxes me-2"></i>Quản lý tồn kho</h5>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="info-label">Số lượng tồn kho</div>
                            <div class="info-value fw-bold">
                                ${product.quantity}
                                <c:if test="${product.quantity <= 10 && product.quantity > 0}">
                                    <span class="badge badge-low-stock ms-2">Cảnh báo tồn kho thấp</span>
                                </c:if>
                                <c:if test="${product.quantity <= 0}">
                                    <span class="badge badge-inactive ms-2">Hết hàng</span>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="info-label">Đã bán</div>
                            <div class="info-value">${product.soldQuantity != null ? product.soldQuantity : 0}</div>
                        </div>
                        <div class="col-md-4">
                            <div class="info-label">Trạng thái</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${product.quantity > 0}">
                                        <span class="badge badge-active">Còn hàng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive">Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="mt-3">
                        <form action="${pageContext.request.contextPath}/admin/products/${product.id}/update-inventory"
                              method="post" class="row g-2">
                            <div class="col-auto">
                                <input type="number" name="quantity" class="form-control form-control-sm"
                                       placeholder="Số lượng" required style="width: 120px;">
                            </div>
                            <div class="col-auto">
                                <select name="type" class="form-select form-select-sm" style="width: 100px;">
                                    <option value="set">Đặt mới</option>
                                    <option value="add">Thêm</option>
                                    <option value="subtract">Bớt</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="admin-btn-primary btn-sm">Cập nhật</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- ========== SECTION 5: DESCRIPTION ========== -->
        <div class="info-section">
            <h5><i class="bi bi-file-text me-2"></i>Mô tả sản phẩm</h5>
            <div class="row">
                <div class="col-md-12">
                    <div class="info-label">Mô tả chi tiết</div>
                    <div class="info-value mt-2">${product.description != null ? product.description : 'Chưa có mô tả'}</div>
                </div>
                <c:if test="${product.ratio != null || product.size != null || product.material != null || product.origin != null}">
                    <div class="col-md-12 mt-3">
                        <div class="info-label">Thông số kỹ thuật</div>
                        <div class="row mt-2">
                            <c:if test="${product.ratio != null}">
                                <div class="col-md-3">
                                    <small class="text-muted">Tỷ lệ:</small>
                                    <div>${product.ratio}</div>
                                </div>
                            </c:if>
                            <c:if test="${product.size != null}">
                                <div class="col-md-3">
                                    <small class="text-muted">Kích thước:</small>
                                    <div>${product.size}</div>
                                </div>
                            </c:if>
                            <c:if test="${product.material != null}">
                                <div class="col-md-3">
                                    <small class="text-muted">Chất liệu:</small>
                                    <div>${product.material}</div>
                                </div>
                            </c:if>
                            <c:if test="${product.origin != null}">
                                <div class="col-md-3">
                                    <small class="text-muted">Xuất xứ:</small>
                                    <div>${product.origin}</div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit-description"
                   class="admin-btn-outline btn-sm">
                    <i class="bi bi-pencil"></i> Chỉnh sửa mô tả
                </a>
            </div>
        </div>

        <!-- ========== SECTION 6: BRAND & RELATED PRODUCTS ========== -->
        <div class="row">
            <div class="col-md-6">
                <div class="info-section">
                    <h5><i class="bi bi-building me-2"></i>Thông tin thương hiệu</h5>
                    <div class="d-flex align-items-center gap-3">
                        <c:if test="${product.brandLogo != null}">
                            <img src="${product.brandLogo}" style="width: 60px; height: 60px; object-fit: contain;"
                                 alt="Brand Logo">
                        </c:if>
                        <div>
                            <div class="info-value fw-bold">${product.brandName != null ? product.brandName : 'Chưa có thương hiệu'}</div>
                            <c:if test="${product.brandLink != null}">
                                <a href="${product.brandLink}" target="_blank" class="small">Website <i
                                        class="bi bi-box-arrow-up-right"></i></a>
                            </c:if>
                        </div>
                    </div>
                    <c:if test="${not empty relatedProductsByBrand}">
                        <div class="mt-3">
                            <div class="info-label">Sản phẩm cùng thương hiệu</div>
                            <div class="mt-2">
                                <c:forEach items="${relatedProductsByBrand}" var="related" end="2">
                                    <div class="related-product-item">
                                        <img src="${related.image != null && not empty related.image ? related.image[0] : pageContext.request.contextPath.concat('/assets/img/default-product.png')}"
                                             alt="${related.name}">
                                        <div class="flex-grow-1">
                                            <div class="small fw-bold">${related.name}</div>
                                            <div class="small text-muted"><fmt:formatNumber
                                                    value="${related.finalPrice}" type="currency"
                                                    currencySymbol="₫"/></div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/admin/products/detail?id=${related.id}"
                                           class="btn btn-sm btn-outline-primary">Xem</a>
                                    </div>
                                </c:forEach>
                                <c:if test="${fn:length(relatedProductsByBrand) > 3}">
                                    <div class="text-center mt-2">
                                        <a href="#" class="small">Xem thêm ${fn:length(relatedProductsByBrand) - 3} sản
                                            phẩm</a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="col-md-6">
                <div class="info-section">
                    <h5><i class="bi bi-folder me-2"></i>Danh mục sản phẩm</h5>
                    <div class="info-value">${product.categoryName != null ? product.categoryName : 'Chưa phân loại'}</div>
                    <c:if test="${not empty relatedProductsByCategory}">
                        <div class="mt-3">
                            <div class="info-label">Sản phẩm cùng danh mục</div>
                            <div class="mt-2">
                                <c:forEach items="${relatedProductsByCategory}" var="related" end="2">
                                    <div class="related-product-item">
                                        <img src="${related.image != null && not empty related.image ? related.image[0] : pageContext.request.contextPath.concat('/assets/img/default-product.png')}"
                                             alt="${related.name}">
                                        <div class="flex-grow-1">
                                            <div class="small fw-bold">${related.name}</div>
                                            <div class="small text-muted"><fmt:formatNumber
                                                    value="${related.finalPrice}" type="currency"
                                                    currencySymbol="₫"/></div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/admin/products/detail?id=${related.id}"
                                           class="btn btn-sm btn-outline-primary">Xem</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- ========== SECTION 7: REVIEWS ========== -->
        <div class="info-section">
            <h5><i class="bi bi-star me-2"></i>Đánh giá sản phẩm</h5>
            <div class="row">
                <div class="col-md-3 text-center">
                    <div class="display-1 fw-bold text-warning">${product.avgRating != null ? product.avgRating : 0}</div>
                    <div class="review-rating">
                        <c:forEach begin="1" end="5" var="i">
                            <i class="bi bi-star${i <= (product.avgRating != null ? product.avgRating : 0) ? '-fill' : ''}"></i>
                        </c:forEach>
                    </div>
                    <div class="small text-muted">${product.totalReviews != null ? product.totalReviews : 0} đánh giá
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="info-label">Danh sách đánh giá</div>
                    <div class="mt-2" style="max-height: 300px; overflow-y: auto;">
                        <c:choose>
                            <c:when test="${not empty product.reviews}">
                                <c:forEach items="${product.reviews}" var="review">
                                    <div class="review-item">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <strong>${review.userName != null ? review.userName : 'Người dùng'}</strong>
                                                <div class="review-rating small">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="bi bi-star${i <= review.rating ? '-fill' : ''}"></i>
                                                    </c:forEach>
                                                </div>
                                                <div class="small mt-1">${review.comment}</div>
                                            </div>
                                            <div class="text-end">
                                                <c:if test="${not empty review.createdAt}">
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${review.createdAt}"
                                                                        pattern="dd/MM/yyyy"/>
                                                    </small>
                                                </c:if>
                                                <div class="mt-1">
                                                    <button class="btn btn-sm btn-outline-danger"
                                                            onclick="hideReview(${review.id})" data-tooltip="Ẩn review">
                                                        <i class="bi bi-eye-slash"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-warning"
                                                            onclick="reportSpam(${review.id})" data-tooltip="Báo spam">
                                                        <i class="bi bi-flag"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center py-3">Chưa có đánh giá nào</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- ========== SECTION 8: SALES STATISTICS ========== -->
        <div class="row">
            <div class="col-md-6">
                <div class="info-section">
                    <h5><i class="bi bi-graph-up me-2"></i>Thống kê bán hàng</h5>
                    <div class="row text-center">
                        <div class="col-md-4">
                            <%--                            <div class="display-6 fw-bold text-primary">${totalOrders != null ? totalOrders : 0}</div>--%>
                            <div class="small text-muted">Tổng đơn hàng</div>
                        </div>
                        <div class="col-md-4">
                            <div class="display-6 fw-bold text-success">
                                <%--                                <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol="₫"/>--%>
                            </div>
                            <div class="small text-muted">Doanh thu</div>
                        </div>
                        <div class="col-md-4">
                            <%--                            <div class="display-6 fw-bold text-info">${product.viewCount != null ? product.viewCount : 0}</div>--%>
                            <div class="small text-muted">Lượt xem</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="info-section">
                    <h5><i class="bi bi-journal-code me-2"></i>Lịch sử hoạt động</h5>
                    <div class="activity-log">
                        <%--                        <c:if test="${not empty product.activityLogs}">--%>
                        <%--                            <c:forEach items="${product.activityLogs}" var="log">--%>
                        <%--                                <div class="log-item">--%>
                        <%--                                    <div class="d-flex justify-content-between">--%>
                        <%--                                        <strong>${log.action}</strong>--%>
                        <%--                                        <small class="text-muted"><fmt:formatDate value="${log.timestamp}" pattern="dd/MM/yyyy HH:mm"/></small>--%>
                        <%--                                    </div>--%>
                        <%--                                    <div class="small text-muted">Người thực hiện: ${log.user}</div>--%>
                        <%--                                    <div class="small">${log.details}</div>--%>
                        <%--                                </div>--%>
                        <%--                            </c:forEach>--%>
                        <%--                        </c:if>--%>
                        <%--                        <c:otherwise>--%>
                        <%--                            <div class="text-muted text-center py-3">Chưa có hoạt động nào</div>--%>
                        <%--                        </c:otherwise>--%>
                    </div>
                </div>
            </div>
        </div>

        <!-- ========== SECTION 9: DELETE PRODUCT ========== -->
        <div class="info-section border-danger">
            <h5 class="text-danger"><i class="bi bi-exclamation-triangle me-2"></i>Vùng nguy hiểm</h5>
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="fw-bold">Xóa sản phẩm</div>
                    <div class="small text-muted">Hành động này không thể hoàn tác. Sản phẩm sẽ bị xóa vĩnh viễn.</div>
                    <c:if test="${hasOrders}">
                        <div class="small text-danger mt-1">⚠️ Cảnh báo: Sản phẩm đã có đơn hàng!</div>
                    </c:if>
                </div>
                <button type="button" class="admin-btn-danger" onclick="confirmDelete()">
                    <i class="bi bi-trash"></i> Xóa sản phẩm
                </button>
            </div>
        </div>
    </main>
</div>

<!-- ========== MODAL: PRICE HISTORY ========== -->
<div class="modal fade" id="priceHistoryModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Lịch sử thay đổi giá</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-sm">
                        <thead>
                        <tr>
                            <th>Thời gian</th>
                            <th>Giá cũ</th>
                            <th>Giá mới</th>
                            <th>Người thực hiện</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${priceHistory}" var="history">
                            <tr>
                                <td><fmt:formatDate value="${history.changedAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td><fmt:formatNumber value="${history.oldPrice}" type="currency"
                                                      currencySymbol="₫"/></td>
                                <td><fmt:formatNumber value="${history.newPrice}" type="currency"
                                                      currencySymbol="₫"/></td>
                                <td>${history.changedBy}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ========== MODAL: DELETE CONFIRMATION ========== -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Xác nhận xóa sản phẩm</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa sản phẩm <strong>${product.name}</strong>?</p>
                <c:if test="${hasOrders}">
                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle"></i>
                        Sản phẩm đã có ${totalOrders} đơn hàng. Bạn có muốn <strong>soft delete</strong> (ẩn) thay vì
                        xóa vĩnh viễn?
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="softDeleteCheckbox" checked>
                        <label class="form-check-label" for="softDeleteCheckbox">
                            Soft delete (chỉ ẩn sản phẩm, giữ dữ liệu đơn hàng)
                        </label>
                    </div>
                </c:if>
                <p class="text-danger mt-3">⚠️ Hành động này không thể hoàn tác!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="admin-btn-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="${pageContext.request.contextPath}/admin/products/${product.id}/delete" method="post"
                      id="deleteForm">
                    <input type="hidden" name="softDelete" id="softDeleteValue" value="true">
                    <button type="submit" class="admin-btn-danger">Xóa sản phẩm</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Change main image when clicking thumbnail
    function changeMainImage(imageUrl) {
        document.getElementById('mainImage').src = imageUrl;
        document.querySelectorAll('.gallery-thumb').forEach(thumb => {
            thumb.classList.remove('active');
            if (thumb.src === imageUrl) {
                thumb.classList.add('active');
            }
        });
    }

    // Copy to clipboard function
    function copyToClipboard(text) {
        navigator.clipboard.writeText(text).then(() => {
            alert('Đã sao chép: ' + text);
        });
    }

    // Confirm delete with modal
    function confirmDelete() {
        const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        modal.show();
    }

    // Handle soft delete checkbox
    document.addEventListener('DOMContentLoaded', function () {
        const softDeleteCheckbox = document.getElementById('softDeleteCheckbox');
        const softDeleteValue = document.getElementById('softDeleteValue');

        if (softDeleteCheckbox) {
            softDeleteCheckbox.addEventListener('change', function () {
                softDeleteValue.value = this.checked;
            });
        }

        // Trigger file upload
        const uploadInput = document.getElementById('uploadImageInput');
        if (uploadInput) {
            uploadInput.addEventListener('change', function () {
                if (this.files.length > 0) {
                    this.form.submit();
                }
            });
        }
    });

    // Hide review
    function hideReview(reviewId) {
        if (confirm('Bạn có chắc chắn muốn ẩn review này?')) {
            window.location.href = '${pageContext.request.contextPath}/admin/reviews/' + reviewId + '/hide';
        }
    }

    // Report spam
    function reportSpam(reviewId) {
        if (confirm('Báo cáo review này là spam?')) {
            window.location.href = '${pageContext.request.contextPath}/admin/reviews/' + reviewId + '/spam';
        }
    }
</script>
</body>
</html>