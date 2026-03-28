<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 8:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/header.jsp" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Sản phẩm - LUXCAR</title>

<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<!-- Font luxury -->
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Inter:wght@300;400;500;600&display=swap"
      rel="stylesheet">

<!-- noUiSlider for price range -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.1/nouislider.min.css" rel="stylesheet">

<style>
    /* ================= GLOBAL ================= */
    :root {
        --black: #1a1a1a;
        --gold: #C5A028;
        --white: #FFFFFF;
        --light-gold: #e9d6b0;
        --dark-gold: #9e7e2c;
        --gray-light: #f5f5f5;
        --gray-border: #e0e0e0;
        --text-primary: #2c2c2c;
        --text-secondary: #666666;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    html, body {
        height: 100%;
        font-family: 'Inter', sans-serif;
        background-color: var(--gray-light);
        color: var(--text-primary);
    }

    h1, h2, h3, h4, h5 {
        font-family: 'Cormorant Garamond', serif;
        font-weight: 600;
        letter-spacing: 0.5px;
    }

    .container-fluid {
        /*min-height: 100vh;*/
        height: 100vh;
        /*overflow: hidden;*/
    }

    .row {
        height: 100%;
        margin: 0;
    }

    /* ================= SIDEBAR ================= */
    .sidebar {
        background: #fff;
        padding: 30px 25px;
        border-right: 1px solid var(--gray-border);
        height: 100%;
        overflow-y: auto;
        box-shadow: 2px 0 20px rgba(0, 0, 0, 0.03);
    }

    .sidebar::-webkit-scrollbar {
        width: 4px;
    }

    .sidebar::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 4px;
    }

    .sidebar-footer {
        position: sticky;
        bottom: 0;
        background: #fff;
        padding: 20px 0 10px;
        margin-top: 20px;
        border-top: 1px solid var(--gray-border);
        z-index: 10;
    }

    /* ================= FILTER STYLE ================= */
    .filter-section {
        margin-bottom: 20px;
        border-bottom: 1px solid var(--gray-border);
        padding-bottom: 15px;
    }

    .filter-title {
        font-weight: 600;
        font-size: 16px;
        margin-bottom: 12px;
        color: var(--text-primary);
        letter-spacing: 0.3px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        cursor: pointer;
        transition: 0.2s;
        text-transform: uppercase;
        font-family: 'Inter', sans-serif;
    }

    .filter-title:hover {
        color: var(--gold);
    }

    .filter-title i {
        transition: transform 0.3s ease;
        color: var(--text-secondary);
        font-size: 14px;
    }

    .filter-title[aria-expanded="true"] i {
        transform: rotate(180deg);
    }

    .filter-scroll {
        max-height: 200px;
        overflow-y: auto;
        padding-right: 5px;
        margin-top: 5px;
    }

    .filter-scroll::-webkit-scrollbar {
        width: 3px;
    }

    .filter-scroll::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 3px;
    }

    /* Custom checkbox and radio */
    .form-check {
        margin-bottom: 8px;
        padding-left: 24px;
    }

    .form-check-input {
        width: 16px;
        height: 16px;
        margin-left: -24px;
        border: 1.5px solid #d0d0d0;
        transition: all 0.2s;
        cursor: pointer;
    }

    .form-check-input:checked {
        background-color: var(--gold);
        border-color: var(--gold);
    }

    .form-check-input:focus {
        box-shadow: none;
        border-color: var(--gold);
    }

    .form-check-label {
        font-size: 14px;
        color: var(--text-secondary);
        cursor: pointer;
        transition: 0.2s;
    }

    .form-check-label:hover {
        color: var(--gold);
    }

    /* Price Range Slider */
    .price-range-container {
        padding: 5px 5px 15px;
    }

    #price-range {
        margin: 15px 0 20px;
        height: 4px;
    }

    .noUi-connect {
        background: var(--gold);
    }

    .noUi-handle {
        border: 2px solid var(--gold);
        border-radius: 50%;
        background: #fff;
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        width: 18px !important;
        height: 18px !important;
        right: -9px !important;
        top: -7px !important;
    }

    .noUi-handle:before,
    .noUi-handle:after {
        display: none;
    }

    .noUi-handle:hover {
        transform: scale(1.1);
    }

    .price-inputs {
        display: flex;
        gap: 8px;
        margin-top: 10px;
    }

    .price-input {
        flex: 1;
        padding: 8px 10px;
        border: 1px solid var(--gray-border);
        border-radius: 4px;
        font-size: 13px;
        transition: 0.2s;
        background: #fafafa;
        color: var(--text-primary);
        font-weight: 500;
    }

    .price-input:focus {
        outline: none;
        border-color: var(--gold);
    }

    /* ================= SORT BAR ================= */
    .sort-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding: 12px 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
    }

    .sort-buttons {
        display: flex;
        gap: 8px;
    }

    .sort-btn {
        padding: 6px 16px;
        border: 1px solid var(--gray-border);
        background: #fff;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.2s;
        cursor: pointer;
        color: var(--text-secondary);
    }

    .sort-btn:hover {
        border-color: var(--gold);
        color: var(--gold);
    }

    .sort-btn.active {
        background: var(--black);
        border-color: var(--black);
        color: #fff;
    }

    .result-count {
        color: var(--text-secondary);
        font-size: 20px;
    }

    .result-count span {
        color: var(--gold);
        font-weight: 700;
        font-size: 25px;
    }

    /* ================= PRODUCT WRAPPER ================= */

    .product-wrapper {
        height: 100%;
        overflow-y: auto;
        /*padding: 2rem 2rem 1rem;*/
        padding: 2rem;
        display: flex;
        flex-direction: column;
    }

    .product-wrapper > .row {
        flex: 1 0 auto;
    }

    .product-wrapper > .pagination-container {
        flex-shrink: 0;
    }

    .product-wrapper::-webkit-scrollbar {
        width: 4px;
    }

    .product-wrapper::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .product-wrapper::-webkit-scrollbar-thumb {
        background: var(--gold);
        border-radius: 4px;
    }

    /* ================= PRODUCT CARD ================= */
    .product-card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        transition: 0.3s;
        height: 100%;
        display: flex;
        flex-direction: column;
        background: #fff;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.02);
        position: relative;
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
    }

    .product-image-wrapper {
        height: 240px;
        overflow: hidden;
        position: relative;
    }

    .product-image-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: 0.5s;
    }

    .product-card:hover .product-image-wrapper img {
        transform: scale(1.03);
    }

    .product-badge {
        position: absolute;
        top: 12px;
        left: 12px;
        background: var(--gold);
        color: #fff;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        z-index: 2;
        letter-spacing: 0.3px;
    }

    .product-badge.discount {
        background: #d32f2f;
    }

    .card-body {
        padding: 16px 15px 15px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .product-category {
        font-size: 11px;
        color: var(--gold);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 4px;
    }

    .product-name {
        font-weight: 600;
        margin-bottom: 4px;
        font-size: 28px;
        color: var(--text-primary);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        font-family: 'Cormorant Garamond', serif;
    }

    .product-model {
        font-size: 12px;
        color: var(--text-secondary);
        margin-bottom: 8px;
    }

    .product-model i {
        color: var(--gold);
        margin-right: 3px;
        font-size: 11px;
    }

    .product-price-section {
        margin: 8px 0;
    }

    .product-price-old {
        font-size: 12px;
        text-decoration: line-through;
        color: #999;
        display: block;
    }

    .product-price-current {
        font-size: 32px;
        font-weight: 700;
        color: var(--black);
        font-family: 'Cormorant Garamond', serif;
        line-height: 1.2;
    }

    .product-actions {
        display: flex;
        gap: 6px;
        margin-top: auto;
        border-top: 1px solid #f0f0f0;
        padding-top: 12px;
    }

    .btn-buy {
        flex: 2;
        background: var(--black);
        color: #fff;
        border: none;
        padding: 8px 0;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 500;
        transition: 0.2s;
    }

    .btn-buy:hover {
        background: var(--gold);
    }

    .btn-action {
        flex: 1;
        background: #f8f8f8;
        color: var(--text-secondary);
        border: none;
        padding: 8px 0;
        border-radius: 30px;
        transition: 0.2s;
    }

    .btn-action:hover {
        background: var(--gold);
        color: #fff;
    }

    /* ================= RATING STYLE ================= */
    .rating {
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 13px;
        color: var(--gold);
        margin: 8px 0;
    }

    .rating i {
        font-size: 12px;
    }

    .rating span {
        color: var(--text-secondary);
        margin-right: 5px;
        font-weight: 500;
    }

    /* ================= EMPTY STATE ================= */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: #fff;
        border-radius: 12px;
    }

    .empty-state i {
        font-size: 60px;
        color: var(--gold);
        opacity: 0.3;
        margin-bottom: 15px;
    }

    .empty-state h4 {
        font-size: 22px;
        margin-bottom: 8px;
        color: var(--text-primary);
    }

    .empty-state p {
        color: var(--text-secondary);
        margin-bottom: 20px;
        font-size: 14px;
    }

    .btn-reset {
        background: var(--gold);
        color: #fff;
        border: none;
        padding: 10px 30px;
        border-radius: 30px;
        font-weight: 500;
        transition: 0.2s;
    }

    .btn-reset:hover {
        background: var(--dark-gold);
    }

    /* ================= PRODUCT WRAPPER ================= */
    .product-wrapper {
        height: 100%;
        overflow-y: auto;
        padding: 2rem 2rem 0;
        display: flex;
        flex-direction: column;
    }

    /* Phần content chính (sort bar + products) */
    .product-content {
        flex: 1 0 auto;
    }

    /* Product grid */
    .product-grid {
        margin-bottom: 30px;
    }

    /* ================= PAGINATION ================= */
    .pagination-container {
        /*flex-shrink: 0;*/
        /*margin-top: 20px;*/
        margin-top: auto;
        padding: 30px 0;
        padding: 30px 0 40px;
        width: 100%;
        border-top: 2px solid var(--gray-border);
        background: transparent;
    }

    .pagination {
        display: flex;
        justify-content: center;
        gap: 8px;
        margin: 0;
        padding: 0;
        list-style: none;
        flex-wrap: wrap;
    }

    .pagination .page-item {
        margin: 0;
    }

    .pagination .page-link {
        color: var(--text-secondary);
        border: 1px solid var(--gray-border);
        border-radius: 8px;
        transition: all 0.25s ease;
        width: 42px;
        height: 42px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 15px;
        font-weight: 500;
        padding: 0;
        text-decoration: none;
        background: #fff;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.03);
    }

    .pagination .page-link:hover {
        background: var(--gold);
        color: #fff;
        border-color: var(--gold);
        transform: translateY(-3px);
        box-shadow: 0 5px 12px rgba(197, 160, 40, 0.2);
    }

    .pagination .page-item.active .page-link {
        background: var(--gold);
        border-color: var(--gold);
        color: #fff;
        font-weight: 600;
        box-shadow: 0 4px 10px rgba(197, 160, 40, 0.25);
    }

    .pagination .page-item.disabled .page-link {
        background: #f8f8f8;
        color: #ccc;
        border-color: #eee;
        pointer-events: none;
        box-shadow: none;
        transform: none;
    }


    /* ================= VOUCHER ================= */
    .voucher-box {
        background: linear-gradient(135deg, #fff 0%, #fcf9f0 100%);
        padding: 20px;
        border: 1px dashed var(--gold);
        border-radius: 8px;
        margin-top: 20px;
    }

    .voucher-item {
        background: #fff;
        border-radius: 6px;
        padding: 10px;
        margin-bottom: 8px;
        border-left: 3px solid var(--gold);
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.02);
    }

    .voucher-code {
        font-weight: 600;
        color: var(--text-primary);
        font-size: 13px;
    }

    .voucher-discount {
        color: var(--gold);
        font-weight: 500;
        font-size: 12px;
    }
</style>

<body>

<!-- Alert Container -->
<%--<div id="alertContainer" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>--%>

<div class="container-fluid">
    <div class="row align-items-start">

        <!-- ================= SIDEBAR FILTER ================= -->
        <div class="col-lg-3 col-md-4 sidebar p-0">
            <form id="filterForm" action="products" method="get"
                  style="height: 100%; display: flex; flex-direction: column;">
                <div style="flex: 1; overflow-y: auto; padding: 25px 20px 10px;">
                    <!-- Tìm kiếm -->
                    <div class="filter-section">
                        <div class="filter-title">
                            <span><i class="bi bi-search me-2"></i>Tìm kiếm</span>
                        </div>
                        <input name="keyword" value="${find}" type="text" class="form-control form-control-sm"
                               placeholder="Tìm kiếm sản phẩm..."
                               style="border-radius: 30px; padding: 8px 15px; font-size: 13px;">
                    </div>

                    <!-- Sort (hidden inputs) -->
                    <input type="hidden" name="sort" id="sortInput" value="${param.sort != null ? param.sort : ''}">
                    <input type="hidden" name="minPrice" id="minPriceInput" value="${param.minPrice}">
                    <input type="hidden" name="maxPrice" id="maxPriceInput" value="${param.maxPrice}">

                    <!-- Phân loại theo Model Scale -->
                    <div class="filter-section">
                        <div class="filter-title" data-bs-toggle="collapse" data-bs-target="#scaleCollapse"
                             aria-expanded="true" aria-controls="scaleCollapse">
                            <span><i class="bi bi-grid-3x3-gap me-2"></i>Tỉ lệ mô hình (${totalScale})</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="collapse show" id="scaleCollapse">
                            <div class="filter-scroll">
                                <c:forEach items="${scaleName}" var="scale">
                                    <c:set var="checked" value="false"/>
                                    <c:forEach items="${paramValues.scale}" var="s">
                                        <c:if test="${s == scale}">
                                            <c:set var="checked" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input name="scale" value="${scale}" class="form-check-input"
                                               type="checkbox" ${checked ? 'checked' : ''}>
                                        <label class="form-check-label">Tỉ lệ ${scale}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Phân loại theo Hãng -->
                    <div class="filter-section">
                        <div class="filter-title" data-bs-toggle="collapse" data-bs-target="#brandCollapse"
                             aria-expanded="false" aria-controls="brandCollapse">
                            <span><i class="bi bi-tags me-2"></i>Thương hiệu (${totalBrand})</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="collapse" id="brandCollapse">
                            <div class="filter-scroll">
                                <c:forEach var="bn" items="${brandName}">
                                    <c:set var="checked" value="false"/>
                                    <c:forEach items="${paramValues.brand}" var="b">
                                        <c:if test="${b == bn}">
                                            <c:set var="checked" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input name="brand" value="${bn}" class="form-check-input"
                                               type="checkbox" ${checked ? 'checked' : ''}>
                                        <label class="form-check-label">${bn}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Phân loại theo Loại -->
                    <div class="filter-section">
                        <div class="filter-title" data-bs-toggle="collapse" data-bs-target="#categoryCollapse"
                             aria-expanded="false" aria-controls="categoryCollapse">
                            <span><i class="bi bi-collection me-2"></i>Danh mục (${totalCategory})</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="collapse" id="categoryCollapse">
                            <div class="filter-scroll">
                                <c:forEach var="cn" items="${categoryName}">
                                    <c:set var="checked" value="false"/>
                                    <c:forEach items="${paramValues.category}" var="c">
                                        <c:if test="${c == cn}">
                                            <c:set var="checked" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input name="category" value="${cn}" class="form-check-input"
                                               type="checkbox" ${checked ? 'checked' : ''}>
                                        <label class="form-check-label">${cn}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Price Range Slider -->
                    <div class="filter-section">
                        <div class="filter-title" data-bs-toggle="collapse" data-bs-target="#priceCollapse"
                             aria-expanded="true" aria-controls="priceCollapse">
                            <span><i class="bi bi-currency-dollar me-2"></i>Khoảng giá</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="collapse show" id="priceCollapse">
                            <div class="price-range-container">
                                <div id="price-range"></div>
                                <div class="price-inputs">
                                    <input type="text" class="price-input" id="min-price"
                                           value="${param.minPrice != null ? param.minPrice : 0}" placeholder="Từ"
                                           readonly>
                                    <input type="text" class="price-input" id="max-price"
                                           value="${param.maxPrice != null ? param.maxPrice : requestScope.maxPrice}"
                                           placeholder="Đến" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Discount Options -->
                    <%--                                        <div class="filter-section">--%>
                    <%--                                            <div class="filter-title" data-bs-toggle="collapse" data-bs-target="#discountCollapse"--%>
                    <%--                                                 aria-expanded="false">--%>
                    <%--                                                <span><i class="bi bi-gift me-2"></i>Khuyến mãi</span>--%>
                    <%--                                                <i class="bi bi-chevron-down"></i>--%>
                    <%--                                            </div>--%>
                    <%--                                            <div class="collapse" id="discountCollapse">--%>
                    <%--                                                <div class="form-check">--%>
                    <%--                                                    <input name="discount" value="newest" class="form-check-input" type="checkbox"--%>
                    <%--                                                    ${param.discount == 'newest' ? 'checked' : ''}>--%>
                    <%--                                                    <label class="form-check-label">Giảm giá mới nhất <img--%>
                    <%--                                                            src="https://nettruyen.work/assets/images/icon-hot.gif"--%>
                    <%--                                                            style="height: 12px; margin-left: 3px;"></label>--%>
                    <%--                                                </div>--%>
                    <%--                                                <div class="form-check">--%>
                    <%--                                                    <input name="discount" value="highest" class="form-check-input" type="checkbox"--%>
                    <%--                                                    ${param.discount == 'highest' ? 'checked' : ''}>--%>
                    <%--                                                    <label class="form-check-label">Giảm giá nhiều nhất <img--%>
                    <%--                                                            src="https://nettruyen.work/assets/images/icon-hot.gif"--%>
                    <%--                                                            style="height: 12px; margin-left: 3px;"></label>--%>
                    <%--                                                </div>--%>
                    <%--                                            </div>--%>
                    <%--                                        </div>--%>
                </div>

                <!-- Footer buttons - always at bottom -->
                <div class="sidebar-footer px-3">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn w-75"
                                style="background: var(--black); color: #fff; border-radius: 30px; padding: 10px; font-size: 14px;">
                            <i class="bi bi-funnel me-2"></i>Áp dụng
                        </button>
                        <button type="button" class="btn w-25"
                                style="border: 1px solid var(--black); border-radius: 30px; padding: 10px; background: #fff;"
                                onclick="resetFilters()">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </button>
                    </div>
                </div>
            </form>

            <!-- Voucher Section -->
            <div class="voucher-box mx-3 mb-3">
                <button class="btn w-100"
                        style="background: var(--gold); color: #fff; border-radius: 30px; padding: 10px; font-size: 13px; font-weight: 500;"
                        data-bs-toggle="collapse" data-bs-target="#voucherArea">
                    <i class="bi bi-ticket-perforated me-2"></i>Xem Voucher
                </button>
                <div class="collapse mt-2" id="voucherArea">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="voucher-item">
                            <div class="voucher-code">${v.code}</div>
                            <div class="voucher-discount">Giảm ${v.discount}</div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty vouchers}">
                        <p class="text-center text-muted small mt-2">Bạn chưa có voucher nào</p>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- ================= PRODUCT LIST ================= -->
        <div class="col-lg-9 col-md-8 product-wrapper">
            <!-- Sort Bar -->
            <div class="sort-bar">
                <div class="sort-buttons">
                    <button type="button" class="sort-btn ${param.sort == 'price_asc' ? 'active' : ''}"
                            onclick="setSort('price_asc')">
                        <i class="bi bi-arrow-up me-1"></i>Giá tăng dần
                    </button>
                    <button type="button" class="sort-btn ${param.sort == 'price_desc' ? 'active' : ''}"
                            onclick="setSort('price_desc')">
                        <i class="bi bi-arrow-down me-1"></i>Giá giảm dần
                    </button>
                    <button type="button" class="sort-btn ${param.sort == 'newest' ? 'active' : ''}"
                            onclick="setSort('newest')">
                        <i class="bi bi-clock me-1"></i>Mới nhất
                    </button>
                </div>
                <div class="result-count">
                    <span>${totalProduct}</span> sản phẩm
                </div>
            </div>

            <!-- Product Grid -->
            <div class="product-content">
                <div class="row g-3">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <div class="col-xl-4 col-lg-6 col-md-6">
                                    <div class="card product-card">
                                        <div class="product-image-wrapper">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                                <img src="${p.image}"
                                                     class="card-img-top" alt="${p.name}">
                                            </a>
                                            <c:if test="${p.discountPercent > 0}">
                                                <span class="product-badge discount">-${p.discountPercent}%</span>
                                            </c:if>
                                        </div>
                                        <div class="card-body">
                                            <div class="product-category">${p.categoryName}</div>
                                            <h6 class="product-name">${p.name}</h6>
                                            <div class="product-model">
                                                <i class="bi bi-cpu"></i> Tỉ lệ ${p.ratio}
                                            </div>
                                            <div class="rating mb-2">
                                                <fmt:formatNumber
                                                        value="${p.avgRating}"
                                                        maxFractionDigits="1"/>
                                                <c:forEach begin="1" end="5" var="i">
                                                    <c:choose>
                                                        <c:when test="${i le p.avgRating}">
                                                            <i class="bi bi-star-fill"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="bi bi-star"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                            <div class="product-price-section">
                                                <c:if test="${p.discountPercent > 0}">
                                                <span class="product-price-old">
                                                    <fmt:formatNumber value="${p.price}" type="number"
                                                                      groupingUsed="true"/> ₫
                                                </span>
                                                </c:if>
                                                <div class="product-price-current">
                                                    <fmt:formatNumber value="${p.finalPrice}" type="number"
                                                                      groupingUsed="true"/> ₫
                                                </div>
                                            </div>


                                            <div class="product-actions">

                                                <form action="buy-now" method="get" style="display: contents;">
                                                    <input type="hidden" name="productId" value="${p.id}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="button" class="btn-buy"
                                                            onclick="addToCartAjax(event,'${p.id}', '${p.name}', true)">
                                                        <i class="bi bi-lightning-charge me-1"></i>Mua
                                                    </button>
                                                </form>

                                                <form action="cart-add" method="get" style="display: contents;">
                                                    <input type="hidden" name="productId" value="${p.id}">
                                                    <input type="hidden" name="quantity" value="1">


                                                    <!--sua type act thanh btt -->
                                                    <button type="button" class="btn-action"
                                                            onclick="addToCartAjax(event,'${p.id}', '${p.name}', false)">
                                                        <i class="bi bi-cart-plus"></i>
                                                    </button>

                                                </form>




                                                <form method="post" action="/favorites" style="display: contents;">
                                                    <button class="btn-action" name="productid" value="${p.id}">
                                                        <i class="bi bi-star"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="empty-state">
                                    <i class="bi bi-search"></i>
                                    <h4>Không tìm thấy sản phẩm</h4>
                                    <p>Không có sản phẩm nào phù hợp với bộ lọc của bạn.</p>
                                    <button class="btn-reset" onclick="resetFilters()">
                                        <i class="bi bi-arrow-counterclockwise me-2"></i>Đặt lại bộ lọc
                                    </button>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <!-- Pagination -->
            <c:if test="${totalPage > 1}">
                <div class="pagination-container">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage - 1})"
                                   aria-label="Previous">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>

                            <c:forEach begin="1" end="${totalPage}" var="i">
                                <c:if test="${i == 1 || i == totalPage || (i >= currentPage-2 && i <= currentPage+2)}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="javascript:void(0)"
                                           onclick="changePage(${i})">${i}</a>
                                    </li>
                                </c:if>
                                <c:if test="${i == currentPage-3 && i > 2}">
                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                </c:if>
                                <c:if test="${i == currentPage+3 && i < totalPage-1}">
                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                </c:if>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage + 1})"
                                   aria-label="Next">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</div>
<div id="customToast"
     style="visibility: hidden; min-width: 250px; background-color: #28a745; color: white; text-align: center; border-radius: 5px; padding: 16px; position: fixed; z-index: 9999; right: 30px; top: 30px; font-weight: bold; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); transition: opacity 1s;">
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
                <i class="bi bi-person-circle"
                   style="font-size: 50px; color: #ddd; margin-bottom: 15px; display: block;"></i>
                <h6 style="font-size: 16px; color: #333; line-height: 1.5;">Vui lòng đăng nhập để thêm mặt hàng này vào
                    giỏ nhé!</h6>
            </div>

            <div class="modal-footer justify-content-center" style="border-top: none; padding-bottom: 25px;">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal"
                        style="border-radius: 30px; padding: 8px 24px; font-weight: 500;">
                    Tiếp tục lướt
                </button>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark"
                   style="border-radius: 30px; padding: 8px 24px; background-color: var(--black); font-weight: 500;">
                    Đi đến đăng nhập
                </a>
            </div>
        </div>
    </div>
</div>
</body>


<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.1/nouislider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/wnumb/1.2.0/wNumb.min.js"></script>

<script>
    function addToCartAjax(event, productId, productName, isBuyNow) {
        event.preventDefault();

        let quantityInput = document.querySelector('input[name="quantity"]');
        let quantity;

        if (quantityInput != null) {
            quantity = quantityInput.value
        } else {
            quantity = 1;
        }

        let apiUrl;
        if (isBuyNow == true) {
            apiUrl = 'buy-now';
        } else {
            apiUrl = 'cart-add';
        }

        fetch(apiUrl + '?productId=' + productId + '&quantity=' + quantity + '&ajax=true')
            .then(function (response) {
                return response.text();
            })
            .then(function (data) {
                if (data.trim() === 'success') {

                    if (isBuyNow === true) {
                        window.location.href = "checkout?type=buynow";
                    } else {

                        // hien thi thong bao(TOAST)
                        let toast = document.getElementById("customToast");
                        document.getElementById("toastMessage").innerText = "Đã thêm " + quantity + " chiếc [" + productName + "] vào giỏ!";

                        toast.style.visibility = "visible";
                        toast.style.opacity = "1";

                        setTimeout(function () {
                            toast.style.opacity = "0";

                            setTimeout(function () {
                                toast.style.visibility = "hidden";
                            }, 500);
                        }, 3000);

                        // CỘNG SỐ GIỎ HÀNG
                        let count = document.getElementById("cart-count");

                        if (count != null) {
                            let crrNumber = parseInt(count.innerText);

                            if (isNaN(crrNumber)) {
                                crrNumber = 0;
                            }
                            count.innerText = crrNumber + parseInt(quantity);
                        }
                    }


                } else if (data.trim() === 'need_login') {
                    let loginModal = new bootstrap.Modal(document.getElementById("requireLoginModal"));
                    loginModal.show();
                }
            })
            .catch(function (error) {
                console.error("Lỗi khi thêm giỏ hàng:", error);
                alert("có lỗi xãy ra, vui lòng thử lại!");
            });
    }


    // Initialize price range slider
    const priceSlider = document.getElementById('price-range');
    const minPriceInput = document.getElementById('min-price');
    const maxPriceInput = document.getElementById('max-price');
    const minPriceHidden = document.getElementById('minPriceInput');
    const maxPriceHidden = document.getElementById('maxPriceInput');

    const urlParams = new URLSearchParams(window.location.search);
    const minPrice = urlParams.get('minPrice') ? parseInt(urlParams.get('minPrice')) : 0;
    const maxPrice = urlParams.get('maxPrice') ? parseInt(urlParams.get('maxPrice')) : ${maxPrice};

    noUiSlider.create(priceSlider, {
        start: [minPrice, maxPrice],
        connect: true,
        step: 100000,
        range: {
            'min': 0,
            'max': ${maxPrice}
        },
        format: wNumb({
            decimals: 0,
            thousand: '.',
            suffix: ' ₫'
        })
    });

    priceSlider.noUiSlider.on('update', function (values, handle) {
        const value = values[handle].replace(/[^0-9]/g, '');
        if (handle) {
            maxPriceInput.value = values[handle];
            maxPriceHidden.value = value;
        } else {
            minPriceInput.value = values[handle];
            minPriceHidden.value = value;
        }
    });

    function setSort(sortValue) {
        document.getElementById('sortInput').value = sortValue;
        document.getElementById('filterForm').submit();
    }

    function resetFilters() {
        window.location.href = 'products';
    }

    function changePage(page) {
        const form = document.getElementById('filterForm');
        const pageInput = document.createElement('input');
        pageInput.type = 'hidden';
        pageInput.name = 'page';
        pageInput.value = page;
        form.appendChild(pageInput);
        form.submit();
    }


    // function showAlert(message, type) {
    //     const alertDiv = document.createElement('div');
    //     alertDiv.className = 'alert-custom';
    //     if (type === 'success') {
    //         alertDiv.classList.add('success');
    //     }
    //
    //     // Chọn icon phù hợp
    //     let icon = 'bi-check-circle-fill';
    //     if (type === 'warning') {
    //         icon = 'bi-exclamation-triangle-fill';
    //     } else if (type === 'success') {
    //         icon = 'bi-check-circle-fill';
    //     }
    //
    //     alertDiv.innerHTML = `
    //         <div class="d-flex align-items-center">
    //             <i class="bi ` + icon + ` me-3" style="font-size: 24px;"></i>
    //             <div>
    //                 <strong>LUXCAR</strong><br>
    //                 <span style="font-size: 14px;">` + message + `</span>
    //             </div>
    //         </div>
    //         <div style="position: absolute; bottom: 0; left: 0; height: 3px; width: 100%; background: linear-gradient(90deg, var(--gold), var(--light-gold)); transform-origin: left; animation: progress 3s linear;"></div>
    //     `;
    //     document.getElementById('alertContainer').appendChild(alertDiv);
    //
    //     // Thêm animation progress bar
    //     const style = document.createElement('style');
    //     style.innerHTML = `
    //         @keyframes progress {
    //             0% { transform: scaleX(1); }
    //             100% { transform: scaleX(0); }
    //         }
    //     `;
    //     document.head.appendChild(style);
    //
    //     setTimeout(() => {
    //         alertDiv.style.animation = 'slideOutRight 0.3s ease';
    //         setTimeout(() => alertDiv.remove(), 300);
    //     }, 3000);
    // }


    <!-- Thêm phần này để kiểm tra URL parameter -->
    document.addEventListener('DOMContentLoaded', function () {
        <c:if test="${empty products}">
        showAlert('Không có sản phẩm nào phù hợp với bộ lọc của bạn', 'warning');
        </c:if>
    });
    document.addEventListener('DOMContentLoaded', function () {
        // Lấy parameters từ URL
        const urlParams = new URLSearchParams(window.location.search);
        const cartSuccess = urlParams.get('cartSuccess');
        const productName = urlParams.get('productName');

        if (cartSuccess === 'true' && productName) {
            showAlert('Đã thêm ' + decodeURIComponent(productName) + ' vào giỏ hàng thành công!', 'success');

            // Xóa parameters khỏi URL (tùy chọn)
            const newUrl = window.location.pathname + window.location.search.replace(/[?&]cartSuccess=true&productName=[^&]*/g, '');
            window.history.replaceState({}, document.title, newUrl);
        }
    });
</script>
<%--<c:if test="${not empty toastMessage}">--%>
<%--    <script>--%>
<%--        showAlert("${toastMessage}", "${toastType}");--%>
<%--    </script>--%>
<%--</c:if>--%>
<%@ include file="/common/footer.jsp" %>
