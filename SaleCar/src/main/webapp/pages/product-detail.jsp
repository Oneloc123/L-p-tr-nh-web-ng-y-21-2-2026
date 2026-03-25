<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/common/header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.name} - LUXCAR</title>

    <style>
        /* ============================================
           VARIABLES & RESET
        ============================================ */
        :root {
            --black: #000000;
            --gold: #D4AF37;
            --white: #FFFFFF;
            --dark-gold: #b8960f;
            --gray-dark: #2c2c2c;
            --gray-medium: #666666;
            --gray-light: #f5f5f5;
            --border-light: #e5e5e5;
            --success: #2ecc71;
            --danger: #e74c3c;
            --warning: #f39c12;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--gray-light);
            color: var(--black);
        }

        /* ============================================
           BACK BUTTON - FIXED: quay lại link trước đó
        ============================================ */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--gray-medium);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--gold);
        }

        /* ============================================
           PRODUCT GALLERY
        ============================================ */
        .product-gallery {
            position: sticky;
            top: 100px;
        }

        .main-image-wrapper {
            background: var(--white);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            position: relative;
            min-height: 480px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .main-image {
            width: 100%;
            height: 480px;
            object-fit: contain;
            background: var(--white);
            cursor: zoom-in;
            transition: transform 0.3s ease;
        }

        .main-image.zoomed {
            transform: scale(1.5);
            cursor: zoom-out;
        }

        /* Thumbnail List - chỉ hiển thị 4 ảnh */
        .thumbnail-list {
            display: flex;
            gap: 12px;
            overflow-x: auto;
            padding-bottom: 8px;
        }

        .thumbnail-list::-webkit-scrollbar {
            height: 4px;
        }

        .thumbnail-list::-webkit-scrollbar-track {
            background: var(--border-light);
            border-radius: 4px;
        }

        .thumbnail-list::-webkit-scrollbar-thumb {
            background: var(--gold);
            border-radius: 4px;
        }

        .thumbnail-item {
            width: 90px;
            height: 90px;
            flex-shrink: 0;
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.2s;
            background: var(--white);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .thumbnail-item.active {
            border-color: var(--gold);
            transform: scale(1.02);
        }

        .thumbnail-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* ============================================
           PRODUCT INFO
        ============================================ */
        .product-info {
            background: var(--white);
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .product-title {
            font-size: 28px;
            font-weight: 700;
            font-family: 'Cormorant Garamond', serif;
            margin-bottom: 12px;
            color: var(--black);
            line-height: 1.3;
        }

        .product-sku {
            font-size: 13px;
            color: var(--gray-medium);
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border-light);
        }

        /* Rating */
        .rating-container {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .stars {
            display: flex;
            gap: 4px;
            color: var(--warning);
            font-size: 16px;
        }

        .rating-value {
            font-weight: 600;
            color: var(--black);
        }

        .review-count {
            color: var(--gray-medium);
            font-size: 14px;
        }

        /* Price */
        .price-container {
            background: var(--gray-light);
            padding: 20px;
            border-radius: 12px;
            margin: 20px 0;
        }

        .current-price {
            font-size: 32px;
            font-weight: 700;
            color: var(--gold);
        }

        .old-price {
            font-size: 18px;
            color: var(--gray-medium);
            text-decoration: line-through;
            margin-left: 12px;
        }

        .discount-badge {
            display: inline-block;
            background: var(--danger);
            color: white;
            font-size: 13px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
            margin-left: 12px;
        }

        .savings {
            margin-top: 8px;
            font-size: 13px;
            color: var(--success);
        }

        /* Badges */
        .info-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
        }

        .info-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: var(--gray-light);
            border-radius: 20px;
            font-size: 13px;
        }

        .info-badge i {
            color: var(--gold);
        }

        /* Delivery Info */
        .delivery-info {
            background: var(--gray-light);
            border-radius: 12px;
            padding: 16px;
            margin: 20px 0;
        }

        .delivery-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            font-size: 13px;
        }

        .delivery-item:last-child {
            margin-bottom: 0;
        }

        .delivery-item i {
            color: var(--gold);
            font-size: 16px;
            width: 24px;
        }

        /* Quantity Selector */
        .quantity-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 20px 0;
        }

        .quantity-label {
            font-weight: 600;
            color: var(--black);
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid var(--border-light);
            border-radius: 40px;
            overflow: hidden;
        }

        .qty-btn {
            width: 40px;
            height: 40px;
            background: var(--white);
            border: none;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .qty-btn:hover {
            background: var(--gold);
            color: var(--white);
        }

        .quantity-input {
            width: 60px;
            height: 40px;
            text-align: center;
            border: none;
            border-left: 1px solid var(--border-light);
            border-right: 1px solid var(--border-light);
            font-weight: 600;
        }

        .stock-status {
            font-size: 13px;
            color: var(--success);
        }


        /* ============================================
    ACTION BUTTONS -
 ============================================ */
        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 24px;
            width: 100%;
        }

        .action-buttons form {
            flex: 1; /* MỖI FORM CHIẾM 1 PHẦN BẰNG NHAU */
            margin: 0;
        }

        .btn-action {
            width: 100%; /* CHIẾM HẾT FORM */
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px 0; /* GIẢM PADDING NGANG, TĂNG DỌC */
            border-radius: 40px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
            border: 2px solid;
            text-decoration: none;
            white-space: nowrap;
        }

        .btn-add-cart {
            background: transparent;
            border-color: var(--black);
            color: var(--black);
        }

        .btn-add-cart:hover {
            background: var(--black);
            border-color: var(--gold);
            color: var(--gold);
        }

        .btn-buy-now {
            background: var(--gold);
            border-color: var(--black);
            color: var(--black);
        }

        .btn-buy-now:hover {
            background: var(--black);
            border-color: var(--gold);
            color: var(--gold);
        }

        .btn-wishlist {
            background: transparent;
            border-color: var(--black);
            color: var(--black);
        }


        .btn-wishlist:hover {
            background: var(--black);
            border-color: var(--gold);
            color: var(--gold);
        }

        .btn-wishlist:hover i {
            color: var(--gold);
        }

        /* ============================================
           RESPONSIVE - GIỮ 3 NÚT CÙNG HÀNG
        ============================================ */
        @media (max-width: 768px) {
            .action-buttons {
                flex-wrap: wrap;
                gap: 10px;
            }

            .action-buttons form {
                flex: 1;
                min-width: calc(33.333% - 7px);
            }

            .btn-action, .btn-wishlist {
                padding: 12px 0;
                font-size: 13px;
            }
        }

        /* ============================================
           PRODUCT DETAILS TABS
        ============================================ */
        .details-tabs {
            background: var(--white);
            border-radius: 16px;
            margin-top: 40px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .tabs-header {
            display: flex;
            border-bottom: 1px solid var(--border-light);
            background: var(--white);
        }

        .tab-btn {
            padding: 16px 28px;
            background: transparent;
            border: none;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.2s;
            color: var(--gray-medium);
        }

        .tab-btn.active {
            color: var(--gold);
            border-bottom: 2px solid var(--gold);
        }

        .tab-content {
            padding: 32px;
            display: none;
        }

        .tab-content.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Specifications Table */
        .specs-table {
            width: 100%;
            border-collapse: collapse;
        }

        .specs-table tr {
            border-bottom: 1px solid var(--border-light);
        }

        .specs-table th {
            width: 180px;
            padding: 14px 0;
            text-align: left;
            font-weight: 600;
            color: var(--black);
        }

        .specs-table td {
            padding: 14px 0;
            color: var(--gray-medium);
        }

        .description-content {
            line-height: 1.7;
            color: var(--gray-medium);
        }

        /* Reviews Section */
        .review-summary {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid var(--border-light);
        }

        .avg-rating {
            text-align: center;
        }

        .avg-number {
            font-size: 48px;
            font-weight: 700;
            color: var(--gold);
        }

        .rating-bars {
            flex: 1;
            min-width: 250px;
        }

        .rating-bar-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 10px;
        }

        .rating-bar-label {
            width: 45px;
            font-size: 13px;
        }

        .rating-bar-track {
            flex: 1;
            height: 6px;
            background: var(--border-light);
            border-radius: 3px;
            overflow: hidden;
        }

        .rating-bar-fill {
            height: 100%;
            background: var(--gold);
            border-radius: 3px;
        }

        .rating-bar-percent {
            width: 45px;
            font-size: 12px;
            color: var(--gray-medium);
        }

        .review-card {
            display: flex;
            gap: 16px;
            padding: 20px 0;
            border-bottom: 1px solid var(--border-light);
        }

        .review-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            overflow: hidden;
            background: var(--gray-light);
            flex-shrink: 0;
        }

        .review-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .review-header {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 8px;
        }

        .review-name {
            font-weight: 600;
            color: var(--black);
        }

        .review-date {
            font-size: 12px;
            color: var(--gray-medium);
        }

        .review-comment {
            color: var(--gray-medium);
            line-height: 1.6;
            margin-top: 8px;
        }

        .review-form {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid var(--border-light);
        }

        /* ============================================
           RELATED PRODUCTS
        ============================================ */
        .related-section {
            margin-top: 60px;
        }

        .section-title {
            font-size: 28px;
            font-weight: 700;
            font-family: 'Cormorant Garamond', serif;
            margin-bottom: 32px;
            text-align: center;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: var(--gold);
        }

        .related-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 24px;
        }

        .related-card {
            background: var(--white);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
        }

        .related-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        }

        .related-image {
            position: relative;
            height: 220px;
            overflow: hidden;
            background: var(--gray-light);
        }

        .related-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s;
        }

        .related-card:hover .related-image img {
            transform: scale(1.05);
        }

        .related-discount {
            position: absolute;
            top: 12px;
            left: 12px;
            background: var(--danger);
            color: white;
            font-size: 12px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
        }

        .related-info {
            padding: 16px;
        }

        .related-brand {
            font-size: 11px;
            color: var(--gold);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .related-name {
            font-size: 15px;
            font-weight: 500;
            color: var(--black);
            margin: 8px 0;
            line-height: 1.4;
            min-height: 42px;
        }

        .related-price {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 8px 0;
        }

        .related-current-price {
            font-weight: 700;
            color: var(--gold);
        }

        .related-old-price {
            font-size: 12px;
            color: var(--gray-medium);
            text-decoration: line-through;
        }

        .related-rating {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
        }

        .related-rating .stars {
            font-size: 11px;
        }

        /* ============================================
           RESPONSIVE
        ============================================ */
        @media (max-width: 992px) {
            .product-gallery {
                position: static;
                margin-bottom: 32px;
            }

            .main-image-wrapper {
                min-height: 400px;
            }

            .main-image {
                height: 400px;
            }

            .thumbnail-item {
                width: 70px;
                height: 70px;
            }

            .product-info {
                padding: 20px;
            }

            .product-title {
                font-size: 24px;
            }

            .current-price {
                font-size: 28px;
            }
        }

        @media (max-width: 768px) {
            .main-image-wrapper {
                min-height: 320px;
            }

            .main-image {
                height: 320px;
            }

            .tab-btn {
                padding: 12px 20px;
                font-size: 13px;
            }

            .tab-content {
                padding: 20px;
            }

            .review-summary {
                flex-direction: column;
                gap: 20px;
            }

            .action-buttons {
                flex-wrap: wrap;
            }

        }
    </style>
</head>

<body>

<div class="container py-4">
    <!-- Back Link - FIXED: quay lại link trước đó -->
    <a href="javascript:history.back()" class="back-link">
        <i class="bi bi-arrow-left"></i> Quay lại
    </a>

    <!-- Product Overview Row -->
    <div class="row g-4">
        <!-- Left: Gallery -->
        <div class="col-lg-6">
            <div class="product-gallery">
                <div class="main-image-wrapper">
                    <c:choose>
                        <c:when test="${not empty product.image and fn:length(product.image) > 0}">
                            <img src="${product.image[0]}" alt="${product.name}" class="main-image" id="mainImage">
                        </c:when>
                        <c:otherwise>
                            <!-- Fixed: set size trước cho ảnh mặc định -->
                            <img src="https://via.placeholder.com/600x480?text=LUXCAR" alt="${product.name}"
                                 class="main-image" style="width: 100%; height: 100%; object-fit: contain;">
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Thumbnails - Fixed: chỉ hiển thị tối đa 4 ảnh con -->
                <div class="thumbnail-list">
                    <c:forEach items="${product.image}" var="img" varStatus="status" end="3">
                        <div class="thumbnail-item ${status.first ? 'active' : ''}" data-image="${img}">
                            <img src="${img}" alt="Thumbnail ${status.index + 1}">
                        </div>
                    </c:forEach>
                    <c:if test="${empty product.image or fn:length(product.image) == 0}">
                        <div class="thumbnail-item active">
                            <img src="https://via.placeholder.com/90x90?text=LUXCAR" alt="No Image">
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Right: Product Info -->
        <div class="col-lg-6">
            <div class="product-info">
                <h1 class="product-title">${product.name}</h1>
                <div class="product-sku">
                    Mã sản phẩm: LUX-${product.id}
                </div>

                <!-- Rating -->
                <div class="rating-container">
                    <div class="stars">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= product.avgRating}">
                                    <i class="bi bi-star-fill"></i>
                                </c:when>
                                <c:when test="${i - 0.5 <= product.avgRating}">
                                    <i class="bi bi-star-half"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-star"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <span class="rating-value">
                        <fmt:formatNumber value="${product.avgRating}" maxFractionDigits="1"/>
                    </span>
                    <span class="review-count">(${product.totalReviews} đánh giá)</span>
                </div>

                <!-- Info Badges -->
                <div class="info-badges">
                    <span class="info-badge">
                        <i class="bi bi-building"></i> ${product.brandName}
                    </span>
                    <span class="info-badge">
                        <i class="bi bi-grid"></i> ${product.categoryName}
                    </span>
                    <span class="info-badge">
                        <i class="bi bi-rulers"></i> Tỉ lệ ${product.ratio}
                    </span>
                </div>

                <!-- Price -->
                <div class="price-container">
                    <div>
                        <span class="current-price">
                            <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                        </span>
                        <c:if test="${product.discountPercent > 0}">
                            <span class="old-price">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                            </span>
                            <span class="discount-badge">-${product.discountPercent}%</span>
                        </c:if>
                    </div>
                    <c:if test="${product.discountPercent > 0}">
                        <div class="savings">
                            <i class="bi bi-piggy-bank"></i> Tiết kiệm:
                            <fmt:formatNumber value="${product.price - product.finalPrice}" type="number"
                                              groupingUsed="true"/> ₫
                        </div>
                    </c:if>
                </div>

                <!-- Delivery Info -->
                <div class="delivery-info">
                    <div class="delivery-item">
                        <i class="bi bi-truck"></i>
                        <span>Giao hàng dự kiến: 2-4 ngày làm việc</span>
                    </div>
                    <div class="delivery-item">
                        <i class="bi bi-arrow-repeat"></i>
                        <span>Đổi trả miễn phí trong 7 ngày</span>
                    </div>
                    <div class="delivery-item">
                        <i class="bi bi-shield-check"></i>
                        <span>Bảo hành chính hãng 12 tháng</span>
                    </div>
                </div>

                <!-- Quantity -->
                <div class="quantity-section">
                    <span class="quantity-label">Số lượng:</span>
                    <div class="quantity-control">
                        <button type="button" class="qty-btn" id="qtyMinus">−</button>
                        <input type="number" name="quantity" id= "quantity" class="quantity-input" value="1" min="1" max="99"
                               form="add-to-cart">
                        <button type="button" class="qty-btn" id="qtyPlus">+</button>
                    </div>
                    <span class="stock-status">
                        <i class="bi bi-check-circle-fill"></i> Còn hàng
                    </span>
                </div>

                <!-- Action Buttons - FIXED: cùng hàng, size bằng nhau -->
                <div class="action-buttons">

                    <form action="${pageContext.request.contextPath}/cart-add" method="get" class="flex-grow-1">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="hidden" name="quantity" id="buyQuantity" value="1">
                        <input type="hidden" name="action" value="buyNow">
                        <button type="submit" class="btn-action btn-buy-now">
                            <i class="bi bi-lightning-charge"></i> Mua ngay
                        </button>
                    </form>

                    <form id="add-to-cart" action="${pageContext.request.contextPath}/cart-add" method="get"
                          class="flex-grow-1">

                        <input type="hidden" name="productId" value="${product.id}">
<%--                        <input type="hidden" name="quantity" id="cartQuantity" value="1">--%>
<%--                        <input type="hidden" name="action" value="addCart">--%>
                        <button type="submit" class="btn-action btn-add-cart" onclick="addToCartAjax(event,'${product.id}', '${product.name}', false)">
                            <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/favorites" method="post">
                        <button type="submit" name="productid" value="${product.id}" class="btn-action btn-wishlist">
                            <i class="bi bi-star">Yêu thích</i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabs Section -->
    <div class="details-tabs">
        <div class="tabs-header">
            <button class="tab-btn active" data-tab="description">Mô tả sản phẩm</button>
            <button class="tab-btn" data-tab="specifications">Thông số kỹ thuật</button>
            <button class="tab-btn" data-tab="reviews">Đánh giá (${product.totalReviews})</button>
        </div>

        <!-- Tab 1: Description -->
        <div class="tab-content active" id="description">
            <div class="description-content">
                ${product.description}
            </div>
        </div>

        <!-- Tab 2: Specifications -->
        <div class="tab-content" id="specifications">
            <table class="specs-table">
                <tr>
                    <th>Tỉ lệ mô hình</th>
                    <td>${product.ratio}</td>
                </tr>
                <tr>
                    <th>Kích thước</th>
                    <td>${product.size}</td>
                </tr>
                <tr>
                    <th>Chất liệu</th>
                    <td>${product.material}</td>
                </tr>
                <tr>
                    <th>Thương hiệu</th>
                    <td>${product.brandName}</td>
                </tr>
                <tr>
                    <th>Hãng xe</th>
                    <td>${product.brandName}</td>
                </tr>
                <tr>
                    <th>Xuất xứ</th>
                    <td>${product.origin}</td>
                </tr>
                <tr>
                    <th>Danh mục</th>
                    <td>${product.categoryName}</td>
                </tr>
                <tr>
                    <th>Mã sản phẩm</th>
                    <td>LUX-${product.id}</td>
                </tr>
            </table>
        </div>

        <!-- Tab 3: Reviews -->
        <div class="tab-content" id="reviews">
            <!-- Rating Summary -->
            <div class="review-summary">
                <div class="avg-rating">
                    <div class="avg-number">
                        <fmt:formatNumber value="${product.avgRating}" maxFractionDigits="1"/>
                    </div>
                    <div class="stars mt-2">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= product.avgRating}">
                                    <i class="bi bi-star-fill"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-star"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="review-count mt-1">${product.totalReviews} đánh giá</div>
                </div>

                <div class="rating-bars">
                    <c:if test="${not empty product.rating}">
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">5 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.rating.fiveStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.rating.fiveStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">4 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.rating.fourStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.rating.fourStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">3 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.rating.threeStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.rating.threeStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">2 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.rating.twoStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.rating.twoStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">1 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.rating.oneStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.rating.oneStar}</span>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Review List -->
            <c:choose>
                <c:when test="${not empty product.reviews and fn:length(product.reviews) > 0}">
                    <c:forEach var="review" items="${product.reviews}">
                        <div class="review-card">
                            <div class="review-avatar">
                                <c:choose>
                                    <c:when test="${not empty review.avatar}">
                                        <img src="${review.avatar}" alt="${review.userName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://ui-avatars.com/api/?name=${fn:substring(review.userName, 0, 1)}&background=D4AF37&color=000"
                                             alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="review-content">
                                <div class="review-header">
                                    <span class="review-name">${review.userName}</span>
                                    <div class="stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= review.rating}">
                                                    <i class="bi bi-star-fill" style="font-size: 12px;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star" style="font-size: 12px;"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <span class="review-date">${review.createAt}</span>
                                </div>
                                <p class="review-comment">${review.comment}</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="bi bi-chat-dots" style="font-size: 48px; color: #ddd;"></i>
                        <p class="mt-3 text-muted">Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm
                            này!</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Review Form -->
            <div class="review-form">
                <h4 style="margin-bottom: 20px;">Viết đánh giá của bạn</h4>
                <form action="${pageContext.request.contextPath}/reviews" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">Đánh giá</label>
                            <select name="rating" class="form-select" style="border-radius: 8px;">
                                <option value="5">5 ⭐ - Tuyệt vời</option>
                                <option value="4">4 ⭐ - Tốt</option>
                                <option value="3">3 ⭐ - Trung bình</option>
                                <option value="2">2 ⭐ - Tạm được</option>
                                <option value="1">1 ⭐ - Không hài lòng</option>
                            </select>
                        </div>
                        <div class="col-md-9">
                            <label class="form-label">Nội dung</label>
                            <textarea name="comment" class="form-control" rows="3"
                                      placeholder="Chia sẻ cảm nhận của bạn về sản phẩm..."
                                      style="border-radius: 8px;"></textarea>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn-action btn-buy-now"
                                    style="width: auto; padding: 10px 28px;">
                                <i class="bi bi-send"></i> Gửi đánh giá
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <c:if test="${not empty related}">
        <div class="related-section">
            <h2 class="section-title">Sản phẩm liên quan</h2>
            <div class="related-grid">
                <c:forEach items="${related}" var="rl">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${rl.id}" class="related-card">
                        <div class="related-image">
                            <c:choose>
                                <c:when test="${not empty rl.image and fn:length(rl.image) > 0}">
                                    <img src="${rl.image[0]}" alt="${rl.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/300x220?text=LUXCAR" alt="${rl.name}">
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${rl.discountPercent > 0}">
                                <span class="related-discount">-${rl.discountPercent}%</span>
                            </c:if>
                        </div>
                        <div class="related-info">
                            <div class="related-brand">${rl.brandName}</div>
                            <div class="related-name">${rl.name}</div>
                            <div class="related-price">
                                <span class="related-current-price">
                                    <fmt:formatNumber value="${rl.finalPrice}" type="number" groupingUsed="true"/> ₫
                                </span>
                                <c:if test="${rl.discountPercent > 0}">
                                    <span class="related-old-price">
                                        <fmt:formatNumber value="${rl.price}" type="number" groupingUsed="true"/> ₫
                                    </span>
                                </c:if>
                            </div>
                            <div class="related-rating">
                                <div class="stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= rl.avgRating}">
                                                <i class="bi bi-star-fill"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <span>(${rl.totalReviews})</span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>
<!-- khai bao TOAST -->
<div id="customToast" style="visibility: hidden; min-width: 250px; background-color: #28a745; color: white; text-align: center; border-radius: 5px; padding: 16px; position: fixed; z-index: 9999; right: 30px; top: 30px; font-weight: bold; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); transition: opacity 1s;">
    <i class="fas fa-check-circle"></i> <span id="toastMessage"> Đã thêm vào giỏ!</span>
</div>
<!-- thong bao dang nhap -->
<div class="modal fade" id="requireLoginModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
            <div class="modal-header" style="border-bottom: 1px solid #eee;">
                <h5 class="modal-title" style="color: var(--gold); font-weight: 600;">
                    <i class="bi bi-shield-lock me-2"></i>Yêu cầu đăng nhập
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body text-center" style="padding: 30px 20px;">
                <i class="bi bi-person-circle" style="font-size: 50px; color: #ddd; margin-bottom: 15px; display: block;"></i>
                <h6 style="font-size: 16px; color: #333; line-height: 1.5;">Vui lòng đăng nhập để thêm mặt hàng này vào giỏ nhé!</h6>
            </div>

            <div class="modal-footer justify-content-center" style="border-top: none; padding-bottom: 25px;">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" style="border-radius: 30px; padding: 8px 24px; font-weight: 500;">
                    Tiếp tục lướt
                </button>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark" style="border-radius: 30px; padding: 8px 24px; background-color: var(--black); font-weight: 500;">
                    Đi đến đăng nhập
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    function addToCartAjax(event, productId, productName, isBuyNow){
        event.preventDefault();

        let quantityInput = document.querySelector('input[name="quantity"]');
        let quantity = quantityInput ? quantityInput.value : 1;

        fetch('cart-add?productId=' + productId + '&quantity=' + quantity + '&ajax=true')
            .then(response => response.text())
            .then(data => {
                if (data.trim() === 'success'){

                    if(isBuyNow === true){
                        window.location.href = "checkout";
                    } else {
                        // hien thi thong bao(TOAST)
                        let toast = document.getElementById("customToast");
                        document.getElementById("customToast").innerText = "Đã thêm "+ quantity + " chiếc [" + productName + "] vào giỏ!";

                        toast.style.visibility = "visible";
                        toast.style.opacity = "1";

                        setTimeout( function(){
                            toast.style.opacity = "0";

                            setTimeout(function(){ toast.style.visibility = "hidden"; }, 500);
                        }, 3000);

                        // ---- CỘNG SỐ GIỎ HÀNG ----
                        let count = document.getElementById("cart-count");

                        if (count != null){
                            let crrNumber = parseInt(count.innerText);

                            if (isNaN(crrNumber)){
                                crrNumber = 0; }
                            count.innerText = crrNumber + parseInt(quantity);
                        }
                    }


                } else if (data.trim() === 'need_login'){
                    let loginModal = new bootstrap.Modal(document.getElementById("requireLoginModal"));
                    loginModal.show();
                }
            })
            .catch(error => {
                console.error("Lỗi khi thêm giỏ hàng:", error);
                alert("có lỗi xãy ra, vui lòng thử lại!");
            });
    }
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // ========== IMAGE GALLERY ==========
        const mainImage = document.getElementById('mainImage');
        const thumbnails = document.querySelectorAll('.thumbnail-item');

        if (thumbnails.length > 0 && mainImage) {
            thumbnails.forEach(thumb => {
                thumb.addEventListener('click', function () {
                    const imgSrc = this.getAttribute('data-image');
                    if (imgSrc) {
                        mainImage.src = imgSrc;
                        thumbnails.forEach(t => t.classList.remove('active'));
                        this.classList.add('active');
                    }
                });
            });
        }

        // ========== ZOOM FUNCTION ==========
        if (mainImage) {
            mainImage.addEventListener('click', function () {
                this.classList.toggle('zoomed');
            });
        }

        // ========== tity SELECTOR ==========
        const quantityInput = document.getElementById('quantity');
        const cartQuantity = document.getElementById('cartQuantity');
        const buyQuantity = document.getElementById('buyQuantity');
        const qtyMinus = document.getElementById('qtyMinus');
        const qtyPlus = document.getElementById('qtyPlus');

        function updateQuantity(value) {
            let newValue = parseInt(value);
            if (isNaN(newValue)) newValue = 1;
            newValue = Math.max(1, Math.min(99, newValue));
            if (quantityInput) quantityInput.value = newValue;
            if (cartQuantity) cartQuantity.value = newValue;
            if (buyQuantity) buyQuantity.value = newValue;
        }

        if (qtyMinus) {
            qtyMinus.addEventListener('click', () => updateQuantity(parseInt(quantityInput.value) - 1));
        }
        if (qtyPlus) {
            qtyPlus.addEventListener('click', () => updateQuantity(parseInt(quantityInput.value) + 1));
        }
        if (quantityInput) {
            quantityInput.addEventListener('change', () => updateQuantity(quantityInput.value));
        }

        // ========== TAB SWITCHING ==========
        const tabBtns = document.querySelectorAll('.tab-btn');
        const tabContents = document.querySelectorAll('.tab-content');

        tabBtns.forEach(btn => {
            btn.addEventListener('click', function () {
                const tabId = this.getAttribute('data-tab');

                tabBtns.forEach(b => b.classList.remove('active'));
                this.classList.add('active');

                tabContents.forEach(content => content.classList.remove('active'));
                const activeContent = document.getElementById(tabId);
                if (activeContent) activeContent.classList.add('active');
            });
        });
    });
</script>

<%@ include file="/common/footer.jsp" %>