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


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.productName} - LUXCAR</title>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        /* =============================================
           DARK LUXURY AUTOMOTIVE THEME
           SaleCar — LUXCAR Product Detail
           ============================================= */

        :root {
            --black: #0a0a0a;
            --bg-primary: #101010;
            --bg-surface: #181818;
            --bg-elevated: #1f1f1f;
            --bg-elevated-hover: #252525;
            --gold: #D4AF37;
            --gold-dark: #b8960f;
            --gold-light: #e9d6b0;
            --text-primary: #f0f0f0;
            --text-secondary: #9f9f9f;
            --text-muted: #666666;
            --border-subtle: rgba(255, 255, 255, 0.06);
            --border-gold: rgba(212, 175, 55, 0.15);
            --border-gold-strong: rgba(212, 175, 55, 0.25);
            --shadow-card: 0 8px 32px rgba(0, 0, 0, 0.3);
            --shadow-card-hover: 0 16px 48px rgba(0, 0, 0, 0.5);
            --success: #2ecc71;
            --danger: #e74c3c;
            --warning: #f39c12;
            --radius-sm: 8px;
            --radius-md: 14px;
            --radius-lg: 20px;
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        /* ============================================
           BACK BUTTON
        ============================================ */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            transition: color var(--transition-fast);
        }
        .back-link:hover { color: var(--gold); }

        /* ============================================
           PRODUCT GALLERY
        ============================================ */
        .product-gallery { position: sticky; top: 100px; }

        .main-image-wrapper {
            background: var(--bg-elevated);
            border-radius: var(--radius-lg);
            overflow: hidden;
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
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
            background: var(--bg-elevated);
            cursor: zoom-in;
            transition: transform 0.3s ease;
        }

        .main-image.zoomed { transform: scale(1.5); cursor: zoom-out; }

        .thumbnail-list {
            display: flex;
            gap: 12px;
            overflow-x: auto;
            padding-bottom: 8px;
        }
        .thumbnail-list::-webkit-scrollbar { height: 4px; }
        .thumbnail-list::-webkit-scrollbar-track { background: rgba(255,255,255,0.05); border-radius: 4px; }
        .thumbnail-list::-webkit-scrollbar-thumb { background: var(--gold); border-radius: 4px; }

        .thumbnail-item {
            width: 90px;
            height: 90px;
            flex-shrink: 0;
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all var(--transition-fast);
            background: var(--bg-elevated);
            box-shadow: var(--shadow-card);
        }
        .thumbnail-item.active { border-color: var(--gold); transform: scale(1.02); }
        .thumbnail-item img { width: 100%; height: 100%; object-fit: cover; }

        /* ============================================
           PRODUCT INFO CARD
        ============================================ */
        .product-info {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            padding: 28px;
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
        }

        .product-title {
            font-size: 28px;
            font-weight: 700;
            font-family: 'Playfair Display', serif;
            margin-bottom: 12px;
            color: var(--text-primary);
            line-height: 1.3;
        }

        .product-sku {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border-subtle);
        }

        /* Rating */
        .rating-container {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .stars { display: flex; gap: 4px; color: #f0c040; font-size: 16px; }
        .rating-value { font-weight: 600; color: var(--text-primary); }
        .review-count { color: var(--text-muted); font-size: 14px; }

        /* Price */
        .price-container {
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            padding: 20px;
            border-radius: var(--radius-md);
            margin: 20px 0;
        }
        .current-price {
            font-size: 32px;
            font-weight: 700;
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            letter-spacing: -0.3px;
        }
        .old-price {
            font-size: 18px;
            color: var(--text-muted);
            text-decoration: line-through;
            margin-left: 12px;
            opacity: 0.5;
        }
        .discount-badge {
            display: inline-block;
            background: linear-gradient(135deg, #d32f2f, #b71c1c);
            color: #fff;
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

        /* Info Badges */
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
            padding: 6px 14px;
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            border-radius: 20px;
            font-size: 13px;
            color: var(--text-secondary);
        }
        .info-badge i { color: var(--gold); }

        /* Delivery */
        .delivery-info {
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-md);
            padding: 16px;
            margin: 20px 0;
        }
        .delivery-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            font-size: 13px;
            color: var(--text-secondary);
        }
        .delivery-item:last-child { margin-bottom: 0; }
        .delivery-item i { color: var(--gold); font-size: 16px; width: 24px; }

        /* Quantity */
        .quantity-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 20px 0;
        }
        .quantity-label { font-weight: 600; color: var(--text-primary); }
        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid var(--border-subtle);
            border-radius: 40px;
            overflow: hidden;
        }
        .qty-btn {
            width: 40px;
            height: 40px;
            background: var(--bg-elevated);
            color: var(--text-primary);
            border: none;
            font-size: 18px;
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        .qty-btn:hover { background: var(--gold); color: #101010; }
        .quantity-input {
            width: 60px;
            height: 40px;
            text-align: center;
            border: none;
            border-left: 1px solid var(--border-subtle);
            border-right: 1px solid var(--border-subtle);
            font-weight: 600;
            background: var(--bg-surface);
            color: var(--text-primary);
        }
        .quantity-input:focus { outline: none; }
        .stock-status { font-size: 13px; color: var(--success); }
        .stock-status.out-of-stock { color: var(--danger); }

        /* ============================================
           VARIANT SELECTOR (DARK)
        ============================================ */
        .variant-section { margin: 20px 0; }
        .variant-label {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .variant-label small { font-weight: 400; color: var(--text-muted); font-size: 13px; }
        .variant-list { display: flex; flex-wrap: wrap; gap: 10px; }

        .variant-btn {
            position: relative;
            padding: 10px 18px;
            border: 2px solid var(--border-subtle);
            border-radius: 10px;
            background: var(--bg-elevated);
            cursor: pointer;
            transition: all var(--transition-fast);
            text-align: center;
            min-width: 80px;
            font-family: 'Inter', sans-serif;
            color: var(--text-secondary);
        }
        .variant-btn:hover:not(.disabled) {
            border-color: var(--gold);
            background: rgba(212, 175, 55, 0.04);
        }
        .variant-btn.selected {
            border-color: var(--gold);
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
            box-shadow: 0 4px 12px rgba(212, 175, 55, 0.25);
        }
        .variant-btn.selected .variant-price-tag { opacity: 1; }
        .variant-btn .variant-name { font-size: 14px; font-weight: 600; display: block; }
        .variant-btn .variant-price-tag { font-size: 11px; opacity: 0.7; display: block; margin-top: 2px; }

        .variant-btn.disabled {
            opacity: 0.35;
            cursor: not-allowed;
            border-style: dashed;
        }
        .variant-btn.disabled::after {
            content: 'Hết hàng';
            position: absolute;
            top: -6px;
            right: -6px;
            background: var(--danger);
            color: white;
            font-size: 9px;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 10px;
            line-height: 1.2;
        }
        .variant-btn.disabled.selected {
            opacity: 0.5;
            border-color: rgba(212, 175, 55, 0.3);
            background: rgba(212, 175, 55, 0.08);
            color: var(--text-secondary);
        }
        .no-variant-msg {
            padding: 10px 16px;
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            border-radius: 10px;
            color: var(--text-muted);
            font-size: 13px;
            font-style: italic;
        }

        /* ============================================
           ACTION BUTTONS (DARK LUXURY)
        ============================================ */
        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 24px;
            width: 100%;
        }
        .action-buttons form { flex: 1; margin: 0; }

        .btn-action {
            width: 100%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px 0;
            border-radius: 40px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all var(--transition-base);
            text-align: center;
            border: none;
            text-decoration: none;
            white-space: nowrap;
        }

        .btn-add-cart {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            border: 1.5px solid var(--border-subtle);
        }
        .btn-add-cart:hover {
            background: rgba(212, 175, 55, 0.1);
            border-color: var(--gold);
            color: var(--gold);
        }

        .btn-buy-now {
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
        }
        .btn-buy-now:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.3);
        }

        .btn-wishlist {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-secondary);
            border: 1.5px solid var(--border-subtle);
        }
        .btn-wishlist:hover {
            background: rgba(212, 175, 55, 0.1);
            border-color: var(--gold);
            color: var(--gold);
        }

        @media (max-width: 768px) {
            .action-buttons { flex-wrap: wrap; gap: 10px; }
            .action-buttons form { flex: 1; min-width: calc(33.333% - 7px); }
            .btn-action, .btn-wishlist { padding: 12px 0; font-size: 13px; }
        }

        /* ============================================
           TABS (DARK)
        ============================================ */
        .details-tabs {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            margin-top: 40px;
            overflow: hidden;
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
        }
        .tabs-header {
            display: flex;
            border-bottom: 1px solid var(--border-subtle);
            background: var(--bg-surface);
        }
        .tab-btn {
            padding: 16px 28px;
            background: transparent;
            border: none;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all var(--transition-fast);
            color: var(--text-muted);
            position: relative;
        }
        .tab-btn:hover { color: var(--text-primary); }
        .tab-btn.active { color: var(--gold); }
        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 2px;
            background: var(--gold);
            border-radius: 1px;
        }
        .tab-content { padding: 32px; display: none; }
        .tab-content.active { display: block; animation: fadeIn 0.3s ease; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Specifications Table */
        .specs-table { width: 100%; border-collapse: collapse; }
        .specs-table tr { border-bottom: 1px solid var(--border-subtle); }
        .specs-table th {
            width: 180px;
            padding: 14px 0;
            text-align: left;
            font-weight: 600;
            color: var(--text-primary);
        }
        .specs-table td { padding: 14px 0; color: var(--text-secondary); }
        .description-content { line-height: 1.7; color: var(--text-secondary); }

        /* Reviews */
        .review-summary {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid var(--border-subtle);
        }
        .avg-rating { text-align: center; }
        .avg-number { font-size: 48px; font-weight: 700; color: var(--gold); font-family: 'Playfair Display', serif; }
        .rating-bars { flex: 1; min-width: 250px; }
        .rating-bar-item { display: flex; align-items: center; gap: 12px; margin-bottom: 10px; }
        .rating-bar-label { width: 45px; font-size: 13px; color: var(--text-secondary); }
        .rating-bar-track {
            flex: 1;
            height: 6px;
            background: rgba(255,255,255,0.06);
            border-radius: 3px;
            overflow: hidden;
        }
        .rating-bar-fill { height: 100%; background: var(--gold); border-radius: 3px; }
        .rating-bar-percent { width: 45px; font-size: 12px; color: var(--text-muted); }

        .review-card {
            display: flex;
            gap: 16px;
            padding: 20px 0;
            border-bottom: 1px solid var(--border-subtle);
        }
        .review-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            overflow: hidden;
            background: var(--bg-elevated);
            flex-shrink: 0;
        }
        .review-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .review-header {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 8px;
        }
        .review-name { font-weight: 600; color: var(--text-primary); }
        .review-date { font-size: 12px; color: var(--text-muted); }
        .review-comment { color: var(--text-secondary); line-height: 1.6; margin-top: 8px; }

        .review-form {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid var(--border-subtle);
        }
        .review-form h4 { color: var(--text-primary); margin-bottom: 20px; }
        .review-form .form-label { color: var(--text-secondary); }
        .review-form .form-select,
        .review-form .form-control {
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            color: var(--text-primary);
            border-radius: var(--radius-sm);
        }
        .review-form .form-select:focus,
        .review-form .form-control:focus {
            outline: none;
            border-color: var(--border-gold-strong);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.06);
        }

        /* Empty reviews */
        .text-center.py-5 i { font-size: 48px; color: rgba(255,255,255,0.08); }
        .text-center.py-5 p { color: var(--text-muted); }

        /* ============================================
           RELATED PRODUCTS (DARK)
        ============================================ */
        .related-section { margin-top: 60px; }
        .section-title {
            font-size: 28px;
            font-weight: 700;
            font-family: 'Playfair Display', serif;
            margin-bottom: 32px;
            text-align: center;
            position: relative;
            color: var(--text-primary);
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
            background: var(--bg-elevated);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: all var(--transition-slow, 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94));
            text-decoration: none;
            display: block;
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
        }
        .related-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-card-hover);
            border-color: var(--border-gold);
            background: var(--bg-elevated-hover);
        }
        .related-image {
            position: relative;
            height: 220px;
            overflow: hidden;
            background: linear-gradient(135deg, #141414 0%, #0d0d0d 50%, #161616 100%);
        }
        .related-image::after {
            content: '';
            position: absolute;
            inset: 0;
            box-shadow: inset 0 0 50px 15px rgba(0, 0, 0, 0.45);
            pointer-events: none;
            z-index: 1;
        }
        .related-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            position: relative;
            z-index: 0;
        }
        .related-card:hover .related-image img { transform: scale(1.08); }
        .related-discount {
            position: absolute;
            top: 12px;
            left: 12px;
            background: linear-gradient(135deg, #d32f2f, #b71c1c);
            color: #fff;
            font-size: 12px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
            z-index: 2;
        }
        .related-info { padding: 16px; }
        .related-brand {
            font-size: 11px;
            color: var(--gold);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            opacity: 0.7;
        }
        .related-name {
            font-size: 15px;
            font-weight: 500;
            color: var(--text-primary);
            margin: 8px 0;
            line-height: 1.4;
            min-height: 42px;
        }
        .related-price { display: flex; align-items: center; gap: 8px; margin: 8px 0; }
        .related-current-price { font-weight: 700; color: var(--gold); }
        .related-old-price { font-size: 12px; color: var(--text-muted); text-decoration: line-through; opacity: 0.5; }
        .related-rating { display: flex; align-items: center; gap: 6px; font-size: 12px; }
        .related-rating .stars { font-size: 11px; }

        /* Existing specific styles overrides */
        .btn-outline-dark {
            color: var(--text-primary);
            border-color: var(--border-subtle);
            background: transparent;
            border-radius: 40px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all var(--transition-base);
        }
        .btn-outline-dark:hover {
            background: rgba(212, 175, 55, 0.1);
            border-color: var(--gold);
            color: var(--gold);
        }
        .btn-outline-dark:disabled {
            opacity: 0.35;
            cursor: not-allowed;
        }
        .btn-buy {
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
            border: none;
            border-radius: 40px;
            padding: 12px 24px;
            font-weight: 700;
            transition: all var(--transition-base);
        }
        .btn-buy:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.3);
            color: #101010;
        }
        .btn-buy:disabled { opacity: 0.35; cursor: not-allowed; transform: none; box-shadow: none; }
        .star-btn {
            color: var(--text-secondary);
            border: 1.5px solid var(--border-subtle);
            background: rgba(255,255,255,0.03);
            border-radius: 40px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all var(--transition-base);
        }
        .star-btn:hover {
            background: rgba(212, 175, 55, 0.1);
            border-color: var(--gold);
            color: var(--gold);
        }

        /* ============================================
           RESPONSIVE
        ============================================ */
        @media (max-width: 992px) {
            .product-gallery { position: static; margin-bottom: 32px; }
            .main-image-wrapper { min-height: 400px; }
            .main-image { height: 400px; }
            .thumbnail-item { width: 70px; height: 70px; }
            .product-info { padding: 20px; }
            .product-title { font-size: 24px; }
            .current-price { font-size: 28px; }
        }
        @media (max-width: 768px) {
            .main-image-wrapper { min-height: 320px; }
            .main-image { height: 320px; }
            .tab-btn { padding: 12px 20px; font-size: 13px; }
            .tab-content { padding: 20px; }
            .review-summary { flex-direction: column; gap: 20px; }
            .action-buttons { flex-wrap: wrap; }
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
                        <c:when test="${not empty product.images and fn:length(product.images) > 0}">
                            <img src="${pageContext.request.contextPath}/uploads/${product.images[0]}" alt="${product.productName}" class="main-image" id="galleryMain">
                        </c:when>
                        <c:otherwise>
                            <!-- Fixed: set size trước cho ảnh mặc định -->
                            <img src="https://via.placeholder.com/600x480?text=LUXCAR" alt="${product.productName}"
                                 class="main-image" style="width: 100%; height: 100%; object-fit: contain;">
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Thumbnails - Fixed: chỉ hiển thị tối đa 4 ảnh con -->
                <div class="thumbnail-list">
                    <c:forEach items="${product.images}" var="img" varStatus="status" end="3">
                        <div class="thumbnail-item ${status.first ? 'active' : ''}" data-image="${pageContext.request.contextPath}/uploads/${img}">
                            <img src="${pageContext.request.contextPath}/uploads/${img}" alt="Thumbnail ${status.index + 1}">
                        </div>
                    </c:forEach>
                    <c:if test="${empty product.images or fn:length(product.images) == 0}">
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
                <h1 class="product-title">${product.productName}</h1>
                <div class="product-sku">
                    Mã sản phẩm: LUX-${product.productId}
                </div>

                <!-- Rating -->
                <div class="rating-container">
                    <div class="stars">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= product.averageRating}">
                                    <i class="bi bi-star-fill"></i>
                                </c:when>
                                <c:when test="${i - 0.5 <= product.averageRating}">
                                    <i class="bi bi-star-half"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-star"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <span class="rating-value">
                        <fmt:formatNumber value="${product.averageRating}" maxFractionDigits="1"/>
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

                <!-- ============================== -->
                <!-- VARIANT SELECTOR -->
                <!-- ============================== -->
                <div class="variant-section">
                    <div class="variant-label">
                        <i class="bi bi-palette"></i> Chọn biến thể
                        <small id="variantSkuDisplay">
                            <c:if test="${not empty product.variants and fn:length(product.variants) > 0}">
                                SKU: ${product.variants[0].sku}
                            </c:if>
                        </small>
                    </div>

                    <div class="variant-list" id="variantList">
                        <c:choose>
                            <%-- Có variant -> render từng button --%>
                            <c:when test="${not empty product.variants and fn:length(product.variants) > 0}">
                                <c:forEach var="v" items="${product.variants}" varStatus="vs">
                                    <c:set var="isFirst" value="${vs.first}" />
                                    <c:set var="stockQty" value="${v.quantity}" />
                                    <c:set var="isOutOfStock" value="${stockQty <= 0}" />
                                    <c:set var="vPrice" value="${v.finalPrice != null ? v.finalPrice : v.price}" />
                                    <div class="variant-btn ${isFirst ? 'selected' : ''} ${isOutOfStock ? 'disabled' : ''}"
                                         data-variant-id="${v.id}"
                                         data-variant-name="${v.variantName}"
                                         data-variant-sku="${v.sku}"
                                         data-variant-price="${v.price}"
                                         data-variant-final-price="${vPrice}"
                                         data-variant-stock="${stockQty}"
                                         data-variant-discount="${product.discountPercent}"
                                         onclick="selectVariant(this)"
                                         title="${isOutOfStock ? 'Biến thể này đã hết hàng' : v.variantName}">
                                        <span class="variant-name">${v.variantName}</span>
                                        <span class="variant-price-tag">
                                            <fmt:formatNumber value="${vPrice}" type="number" groupingUsed="true"/> ₫
                                        </span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <%-- Không có variant -> thông báo + disable toàn bộ --%>
                            <c:otherwise>
                                <c:set var="hasNoVariants" value="true" scope="page" />
                                <div class="no-variant-msg">
                                    <i class="bi bi-info-circle"></i>
                                    Sản phẩm tạm thời không khả dụng
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- ============================== -->
                <!-- / VARIANT SELECTOR -->
                <!-- ============================== -->

                <!-- Price -->
                <div class="price-container" id="priceContainer">
                    <div>
                        <span class="current-price" id="displayFinalPrice">
                            <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                        </span>
                        <span class="old-price" id="displayOldPrice" style="${product.discountPercent > 0 ? '' : 'display:none;'}">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                        </span>
                        <span class="discount-badge" id="displayDiscountBadge" style="${product.discountPercent > 0 ? '' : 'display:none;'}">
                            -<span id="displayDiscountPercent">${product.discountPercent}</span>%
                        </span>
                    </div>
                    <div class="savings" id="displaySavings" style="${product.discountPercent > 0 ? '' : 'display:none;'}">
                        <i class="bi bi-piggy-bank"></i> Tiết kiệm:
                        <span id="displaySavingsAmount">
                            <fmt:formatNumber value="${product.price - product.finalPrice}" type="number" groupingUsed="true"/>
                        </span> ₫
                    </div>
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
                        <input type="number" name="quantity" id="quantity" class="quantity-input" value="1" min="1"
                               max="99"
                               form="add-to-cart">
                        <button type="button" class="qty-btn" id="qtyPlus">+</button>
                    </div>
                    <span class="stock-status ${pageScope.hasNoVariants ? 'out-of-stock' : ''}" id="stockStatus">
                        <c:choose>
                            <c:when test="${pageScope.hasNoVariants}">
                                <i class="bi bi-x-circle-fill"></i> Không khả dụng
                            </c:when>
                            <%-- Có variant: hiển thị dựa trên stock của variant đầu tiên --%>
                            <c:when test="${not empty product.variants and fn:length(product.variants) > 0 and product.variants[0].quantity le 0}">
                                <i class="bi bi-x-circle-fill"></i> Hết hàng
                            </c:when>
                            <c:when test="${not empty product.variants and fn:length(product.variants) > 0 and product.variants[0].quantity le 5}">
                                <i class="bi bi-exclamation-triangle-fill"></i> Chỉ còn ${product.variants[0].quantity} sản phẩm
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-check-circle-fill"></i> Còn hàng
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <!-- Action Buttons -->
                <div class="d-grid gap-2">

                    <!-- them sp vao cart -->
                    <form id="add-to-cart" action="cart-add" method="get" class="w-100">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <input type="hidden" name="variantId" id="variantIdInputAddCart" value="0">

                        <button type="button" class="btn btn-outline-dark w-100"
                                ${pageScope.hasNoVariants ? 'disabled' : ''}
                                onclick="addToCartAjax(event,'${product.productId}', '${fn:replace(product.productName, "'", "\\'")}', false)">
                            <i class="bi bi-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                    </form>

                    <form id="buy-now" action="buy-now" method="get" class="w-100">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <input type="hidden" name="variantId" id="variantIdInputBuyNow" value="0">

                        <button type="button" class="btn btn-buy w-100"
                                ${pageScope.hasNoVariants ? 'disabled' : ''}
                                onclick="addToCartAjax(event,'${product.productId}', '${fn:replace(product.productName, "'", "\\'")}', true)">
                            <i class="bi bi-lightning-charge"></i> Mua ngay
                        </button>
                    </form>

                    <form method="post" action="${pageContext.request.contextPath}/favorites" class="w-100">
                        <button type="submit"
                                class="btn star-btn w-100"
                                name="productid"
                                value="${product.productId}">
                            <i class="bi bi-star me-2"></i>
                            Thêm vào yêu thích
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
                    <td>LUX-${product.productId}</td>
                </tr>
            </table>
        </div>

        <!-- Tab 3: Reviews -->
        <div class="tab-content" id="reviews">
            <!-- Rating Summary -->
            <div class="review-summary">
                <div class="avg-rating">
                    <div class="avg-number">
                        <fmt:formatNumber value="${product.averageRating}" maxFractionDigits="1"/>
                    </div>
                    <div class="stars mt-2">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= product.averageRating}">
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
                    <c:if test="${not empty product.ratingDist}">
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">5 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.ratingDist.fiveStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.ratingDist.fiveStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">4 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.ratingDist.fourStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.ratingDist.fourStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">3 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.ratingDist.threeStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.ratingDist.threeStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">2 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.ratingDist.twoStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.ratingDist.twoStar}</span>
                        </div>
                        <div class="rating-bar-item">
                            <span class="rating-bar-label">1 <i class="bi bi-star-fill"></i></span>
                            <div class="rating-bar-track">
                                <div class="rating-bar-fill"
                                     style="width: ${product.ratingDist.oneStar / product.totalReviews * 100}%"></div>
                            </div>
                            <span class="rating-bar-percent">${product.ratingDist.oneStar}</span>
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
                                    <span class="review-date">${review.createdAt}</span>
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
                    <input type="hidden" name="productId" value="${product.productId}">
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
                    <a href="${pageContext.request.contextPath}/product-detail?id=${rl.productId}" class="related-card">
                        <div class="related-image">
                            <c:choose>
                                <c:when test="${not empty rl.images and fn:length(rl.images) > 0}">
                                    <img src="${pageContext.request.contextPath}/uploads/${rl.images[0]}" alt="${rl.productName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/300x220?text=LUXCAR" alt="${rl.productName}">
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${rl.discountPercent > 0}">
                                <span class="related-discount">-${rl.discountPercent}%</span>
                            </c:if>
                        </div>
                        <div class="related-info">
                            <div class="related-brand">${rl.brandName}</div>
                            <div class="related-name">${rl.productName}</div>
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
                                            <c:when test="${i <= rl.averageRating}">
                                                <i class="bi bi-star-fill"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>
<!-- khai bao TOAST -->
<div id="customToast"
     style="visibility: hidden; min-width: 250px; background-color: #28a745; color: white; text-align: center; border-radius: 5px; padding: 16px; position: fixed; z-index: 9999; right: 30px; top: 30px; font-weight: bold; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); transition: opacity 1s;">
    <i class="bi bi-check-circle-fill"></i> <span id="toastMessage"> Đã thêm vào giỏ!</span>
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


<script>
    /**
     * Hàm format số tiền VNĐ.
     */
    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN').format(Math.round(amount)) + ' ₫';
    }

    /**
     * Biến lưu variant đang chọn.
     */
    let selectedVariant = null;

    /**
     * Xử lý khi user click chọn variant button.
     */
    function selectVariant(btn) {
        // Nếu button bị disabled (hết hàng) thì không cho chọn
        if (btn.classList.contains('disabled')) {
            return;
        }

        // Bỏ selected tất cả
        document.querySelectorAll('.variant-btn').forEach(function (b) {
            b.classList.remove('selected');
        });

        // Đánh dấu selected
        btn.classList.add('selected');

        // Lấy thông tin variant từ data attributes
        var variantId = btn.getAttribute('data-variant-id');
        var variantName = btn.getAttribute('data-variant-name');
        var variantSku = btn.getAttribute('data-variant-sku');
        var variantPrice = parseFloat(btn.getAttribute('data-variant-price'));
        var variantFinalPrice = parseFloat(btn.getAttribute('data-variant-final-price'));
        var variantStock = parseInt(btn.getAttribute('data-variant-stock'));
        var discountPercent = parseFloat(btn.getAttribute('data-variant-discount')) || 0;

        selectedVariant = {
            id: parseInt(variantId),
            name: variantName,
            sku: variantSku,
            price: variantPrice,
            finalPrice: variantFinalPrice,
            stock: variantStock
        };

        // Cập nhật hidden input
        document.getElementById('variantIdInputAddCart').value = variantId;
        document.getElementById('variantIdInputBuyNow').value = variantId;

        // Cập nhật SKU hiển thị
        document.getElementById('variantSkuDisplay').textContent = 'SKU: ' + variantSku;

        // Cập nhật giá real-time
        updatePriceDisplay(variantPrice, variantFinalPrice, discountPercent);

        // Cập nhật tồn kho
        updateStockDisplay(variantStock);

        // Reset số lượng về 1
        var qtyInput = document.getElementById('quantity');
        if (qtyInput) {
            qtyInput.value = 1;
            qtyInput.max = Math.max(1, variantStock);
        }
    }

    /**
     * Cập nhật hiển thị giá real-time dựa trên variant.
     * Tính discount % từ originalPrice và finalPrice (không phụ thuộc product-level).
     */
    function updatePriceDisplay(originalPrice, finalPrice, discountPercent) {
        var displayFinal = document.getElementById('displayFinalPrice');
        var displayOld = document.getElementById('displayOldPrice');
        var displayBadge = document.getElementById('displayDiscountBadge');
        var displayPercent = document.getElementById('displayDiscountPercent');
        var displaySavings = document.getElementById('displaySavings');
        var displaySavingsAmount = document.getElementById('displaySavingsAmount');

        displayFinal.textContent = formatVND(finalPrice);

        /* Tính discount thực tế dựa trên chênh lệch giá variant */
        var actualDiscount = 0;
        if (originalPrice > 0 && finalPrice < originalPrice) {
            actualDiscount = Math.round((originalPrice - finalPrice) / originalPrice * 100);
        }

        if (actualDiscount > 0) {
            displayOld.textContent = formatVND(originalPrice);
            displayOld.style.display = 'inline';
            displayBadge.style.display = 'inline';
            displayPercent.textContent = actualDiscount;
            displaySavings.style.display = 'block';
            displaySavingsAmount.textContent = formatVND(originalPrice - finalPrice);
        } else {
            displayOld.style.display = 'none';
            displayBadge.style.display = 'none';
            displaySavings.style.display = 'none';
        }
    }

    /**
     * Cập nhật hiển thị tồn kho real-time.
     * - stock <= 0: OUT_OF_STOCK (đỏ, disable buttons)
     * - stock <= 5: LOW_STOCK (cam, cảnh báo)
     * - stock > 5: IN_STOCK (xanh, bình thường)
     */
    function updateStockDisplay(stock) {
        var stockEl = document.getElementById('stockStatus');
        var addCartBtn = document.querySelector('#add-to-cart button');
        var buyNowBtn = document.querySelector('#buy-now button');

        if (stock <= 0) {
            stockEl.innerHTML = '<i class="bi bi-x-circle-fill"></i> Hết hàng';
            stockEl.className = 'stock-status out-of-stock';
            if (addCartBtn) addCartBtn.disabled = true;
            if (buyNowBtn) buyNowBtn.disabled = true;
        } else if (stock <= 5) {
            stockEl.innerHTML = '<i class="bi bi-exclamation-triangle-fill"></i> Chỉ còn ' + stock + ' sản phẩm';
            stockEl.style.color = 'var(--warning)';
            stockEl.className = 'stock-status';
            if (addCartBtn) addCartBtn.disabled = false;
            if (buyNowBtn) buyNowBtn.disabled = false;
        } else {
            stockEl.innerHTML = '<i class="bi bi-check-circle-fill"></i> Còn ' + stock + ' sản phẩm';
            stockEl.style.color = '';
            stockEl.className = 'stock-status';
            if (addCartBtn) addCartBtn.disabled = false;
            if (buyNowBtn) buyNowBtn.disabled = false;
        }
    }

    /**
     * Cập nhật addToCart để gửi kèm variantId.
     */
    function addToCartAjax(event, productId, productName, isBuyNow) {
        event.preventDefault();

        let quantityInput = document.querySelector('input[name="quantity"]');
        let quantity;

        if (quantityInput != null) {
            quantity = quantityInput.value
        } else {
            quantity = 1;
        }

        // Lấy variantId từ hidden input
        var variantId;
        if (isBuyNow) {
            variantId = document.getElementById('variantIdInputBuyNow').value;
        } else {
            variantId = document.getElementById('variantIdInputAddCart').value;
        }

        let apiUrl;
        if (isBuyNow == true) {
            apiUrl = 'buy-now';
        } else {
            apiUrl = 'cart-add';
        }

        fetch(apiUrl + '?productId=' + productId + '&variantId=' + variantId + '&quantity=' + quantity + '&ajax=true')
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


    document.addEventListener('DOMContentLoaded', function () {
        // ========== IMAGE GALLERY ==========
        const mainImage = document.getElementById('galleryMain');
        const thumbItems = document.querySelectorAll('.thumbnail-item');

        thumbItems.forEach(thumb => {
            thumb.addEventListener('click', function () {
                const imgSrc = this.getAttribute('data-image');
                if (imgSrc && mainImage) {
                    mainImage.src = imgSrc;
                    thumbItems.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                }
            });
        });

        // ========== ZOOM FUNCTION ==========
        const galleryMain = document.getElementById('galleryMain');
        if (galleryMain) {
            let zoomed = false;
            galleryMain.addEventListener('click', function () {
                if (window.innerWidth > 768) {
                    zoomed = !zoomed;
                    if (zoomed) {
                        this.classList.add('zoomed');
                    } else {
                        this.classList.remove('zoomed');
                    }
                }
            });

            galleryMain.addEventListener('mouseleave', function () {
                if (zoomed) {
                    zoomed = false;
                    this.classList.remove('zoomed');
                }
            });
        }

        // ========== QUANTITY SELECTOR ==========
        const quantityInput = document.getElementById('quantity');
        const qtyMinus = document.getElementById('qtyMinus');
        const qtyPlus = document.getElementById('qtyPlus');

        function updateQuantity(value) {

            let newVal = parseInt(value);

            if (isNaN(newVal)) newVal = 1;

            newVal = Math.max(1, Math.min(99, newVal));

            quantityInput.value = newVal;
        }

        qtyMinus.addEventListener('click', () => {
            updateQuantity(parseInt(quantityInput.value) - 1);
        });

        qtyPlus.addEventListener('click', () => {
            updateQuantity(parseInt(quantityInput.value) + 1);
        });

        quantityInput.addEventListener('change', () => {
            updateQuantity(quantityInput.value);
        });

        // ========== VARIANT INITIALIZATION ==========
        // Auto-select variant đầu tiên còn hàng khi trang load.
        // Nếu tất cả variant đều hết hàng → hiển thị "Hết hàng" + disable buttons.
        var variantBtns = document.querySelectorAll('.variant-btn');
        var firstUsableBtn = null;
        var allDisabled = true;

        variantBtns.forEach(function (btn) {
            if (!btn.classList.contains('disabled')) {
                allDisabled = false;
                if (!firstUsableBtn) {
                    firstUsableBtn = btn;
                }
            }
        });

        if (variantBtns.length > 0) {
            if (firstUsableBtn) {
                // Có ít nhất 1 variant còn hàng → auto-select
                selectVariant(firstUsableBtn);
            } else if (allDisabled) {
                // Tất cả variant đều hết hàng → hiển thị "Hết hàng" + disable buttons
                var stockEl = document.getElementById('stockStatus');
                var addCartBtn = document.querySelector('#add-to-cart button');
                var buyNowBtn = document.querySelector('#buy-now button');
                if (stockEl) {
                    stockEl.innerHTML = '<i class="bi bi-x-circle-fill"></i> Hết hàng';
                    stockEl.className = 'stock-status out-of-stock';
                }
                if (addCartBtn) addCartBtn.disabled = true;
                if (buyNowBtn) buyNowBtn.disabled = true;
            }
        }
    })

    // ========== TAB SWITCHING ==========
    document.addEventListener("DOMContentLoaded", function () {

        const tabBtns = document.querySelectorAll('.tab-btn');
        const tabContents = document.querySelectorAll('.tab-content');

        tabBtns.forEach(btn => {
            btn.addEventListener('click', function () {

                const tabId = this.getAttribute('data-tab');

                tabBtns.forEach(b => b.classList.remove('active'));
                tabContents.forEach(p => p.classList.remove('active'));

                this.classList.add('active');
                document.getElementById(tabId).classList.add('active');

            });
        });

    });
</script>

<%@ include file="/common/footer.jsp" %>
