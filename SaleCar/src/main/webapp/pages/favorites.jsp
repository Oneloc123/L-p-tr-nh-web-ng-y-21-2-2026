<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/common/header.jsp" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sản phẩm yêu thích - SaleCar</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }
        h1, h2 { font-family: 'Cormorant Garamond', serif; }

        .sidebar {
            background: #fff;
            padding: 25px;
            border-right: 1px solid #eee;
        }
        .filter-title {
            font-weight: 600;
            margin-top: 20px;
            margin-bottom: 10px;
        }
        .product-card {
            border: none;
            transition: 0.3s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover { transform: translateY(-5px); }
        .product-img {
            height: 220px;
            overflow: hidden;
        }
        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .price-current { font-weight: 600; }
        .price-old {
            text-decoration: line-through;
            color: #888;
            font-size: 14px;
        }
        .rating i {
            color: #f5b301;
            font-size: 14px;
        }
        .voucher-box {
            background: #fff;
            padding: 20px;
            border: 1px solid #eee;
            margin-top: 20px;
        }
        .empty-state {
            text-align: center;
            padding: 80px 0;
        }
        .empty-state i {
            font-size: 60px;
            color: #ccc;
        }
        .unavailable-badge {
            display: inline-block;
            background: #dc3545;
            color: #fff;
            font-size: 11px;
            font-weight: 600;
            padding: 3px 10px;
            border-radius: 4px;
        }
    </style>
</head>

<body>

<div class="container-fluid py-5">
    <div class="row">

        <!-- SIDEBAR FILTER -->
        <div class="col-lg-3 sidebar">
            <form method="get" action="${pageContext.request.contextPath}/favorites">
                <input type="text" name="keyword" class="form-control mb-3" placeholder="Tìm kiếm yêu thích..." value="${param.keyword}">

                <div class="filter-title">Loại xe</div>
                <select name="category" class="form-select mb-3">
                    <option value="all">Tất cả</option>
                    <c:forEach var="c" items="${category}">
                        <option value="${c}" ${param.category == c ? 'selected' : ''}>${c}</option>
                    </c:forEach>
                </select>

                <div class="filter-title">Hãng</div>
                <select name="brand" class="form-select mb-3">
                    <option value="all">Tất cả</option>
                    <c:forEach var="b" items="${brand}">
                        <option value="${b}" ${param.brand == b ? 'selected' : ''}>${b}</option>
                    </c:forEach>
                </select>

                <div class="filter-title">Khoảng giá</div>
                <select name="price" class="form-select mb-3">
                    <option value="-1">Tất cả</option>
                    <option value="10000000" ${param.price == '10000000' ? 'selected' : ''}>Dưới 10.000.000</option>
                    <option value="50000000" ${param.price == '50000000' ? 'selected' : ''}>Dưới 50.000.000</option>
                    <option value="100000000" ${param.price == '100000000' ? 'selected' : ''}>Dưới 100.000.000</option>
                    <option value="500000000" ${param.price == '500000000' ? 'selected' : ''}>Dưới 500.000.000</option>
                </select>

                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="discount" ${not empty param.discount ? 'checked' : ''}>
                    <label class="form-check-label">Đang giảm giá nhiều nhất</label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="newest" ${not empty param.newest ? 'checked' : ''}>
                    <label class="form-check-label">Giảm giá mới nhất</label>
                </div>

                <button class="btn btn-dark w-100" type="submit">Lọc</button>
                <c:if test="${not empty param.keyword or (not empty param.category and param.category != 'all') or (not empty param.brand and param.brand != 'all') or (not empty param.price and param.price != '-1') or not empty param.discount or not empty param.newest}">
                    <a href="${pageContext.request.contextPath}/favorites" class="btn btn-outline-secondary w-100 mt-2">
                        <i class="bi bi-x-circle"></i> Xóa bộ lọc
                    </a>
                </c:if>
            </form>

            <!-- VOUCHER TOGGLE -->
            <div class="voucher-box">
                <button class="btn btn-outline-dark w-100" data-bs-toggle="collapse" data-bs-target="#voucherArea">
                    Xem Voucher của bạn
                </button>
                <div class="collapse mt-3" id="voucherArea">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="border p-2 mb-2">
                            <strong>${v.code}</strong><br>
                            Giảm <fmt:formatNumber value="${v.value}" type="number"/> ${v.valueType == 'PERCENT' ? '%' : '₫'}
                        </div>
                    </c:forEach>
                    <c:if test="${empty vouchers}">
                        <p class="text-muted text-center mb-0">Bạn chưa có voucher nào</p>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- PRODUCT GRID -->
        <div class="col-lg-9 px-5">
            <h1 class="mb-4">Xe bạn đã yêu thích</h1>

            <c:choose>
                <c:when test="${not empty favorites}">
                    <div class="row g-4">
                        <c:forEach var="p" items="${favorites}">
                            <c:set var="productStatus" value="${p.status}" />
                            <c:set var="isUnavailable" value="${productStatus == null || productStatus.code == 0 || productStatus.code == 2}" />

                            <div class="col-lg-3 col-md-6">
                                <div class="card product-card ${isUnavailable ? 'opacity-50' : ''}">
                                    <a href="${isUnavailable ? '#' : pageContext.request.contextPath.concat('/product-detail?id=').concat(p.productId)}">
                                        <div class="product-img">
                                            <c:choose>
                                                <c:when test="${not empty p.images and fn:length(p.images) > 0}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${p.images[0]}"
                                                         alt="${p.productName}"
                                                         onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=No+Image';">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/400x300?text=LUXCAR" alt="${p.productName}">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </a>
                                    <div class="card-body">
                                        <div>
                                            <h6>${p.productName}</h6>

                                            <c:choose>
                                                <c:when test="${isUnavailable}">
                                                    <span class="unavailable-badge">
                                                        <i class="bi bi-exclamation-triangle"></i> Sản phẩm không còn khả dụng
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="mb-2">
                                                        <span class="price-current">
                                                            <fmt:formatNumber value="${p.finalPrice}" type="number"/> đ
                                                        </span>
                                                        <c:if test="${p.price > 0 and p.discountPercent > 0}">
                                                            <span class="price-old ms-2">
                                                                <fmt:formatNumber value="${p.price}" type="number"/> đ
                                                            </span>
                                                        </c:if>
                                                    </div>

                                                    <div class="rating mb-2">
                                                        <fmt:formatNumber value="${p.averageRating}" maxFractionDigits="1"/>
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when test="${i le p.averageRating}"><i class="bi bi-star-fill"></i></c:when>
                                                                <c:otherwise><i class="bi bi-star"></i></c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <span class="text-muted ms-1">(${p.totalReviews})</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="d-grid gap-2 mt-3">
                                            <c:choose>
                                                <c:when test="${isUnavailable}">
                                                    <form action="${pageContext.request.contextPath}/favorites" method="post">
                                                        <button name="remove" value="${p.productId}" class="btn btn-outline-danger btn-sm w-100">
                                                            <i class="bi bi-trash"></i> Xóa khỏi danh sách
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.productId}" class="btn btn-dark btn-sm">
                                                        <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/favorites" method="post">
                                                        <button name="remove" value="${p.productId}" class="btn btn-outline-danger btn-sm w-100">
                                                            <i class="bi bi-heartbreak"></i> Bỏ yêu thích
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="empty-state">
                        <i class="fa-regular fa-heart"></i>
                        <h4 class="mt-4">Bạn chưa có sản phẩm yêu thích nào</h4>
                        <p class="text-muted">Hãy khám phá các sản phẩm và thêm vào danh sách yêu thích nhé!</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-dark mt-3">
                            <i class="bi bi-search"></i> Khám phá xe ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="/common/footer.jsp" %>
