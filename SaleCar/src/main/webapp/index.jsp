<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/common/header.jsp" %>

<title>LUXCAR - Mô Hình Xe Sang Trọng</title>

<style>
    /* ==================== GLOBAL STYLES ==================== */
    :root {
        --black: #000000;
        --gold: #D4AF37;
        --white: #FFFFFF;
        --light-gold: #f5e7b2;
        --dark-gold: #b8960f;
        --gray-bg: #f8f9fa;
    }

    body {
        font-family: 'Inter', sans-serif;
        background: var(--gray-bg);
    }

    .section-title {
        text-align: center;
        margin-bottom: 50px;
        position: relative;
        font-weight: 700;
        font-size: 32px;
        color: var(--black);
    }

    .section-title:after {
        content: '';
        position: absolute;
        bottom: -15px;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background: var(--gold);
    }

    /* ==================== HERO BANNER SLIDER ==================== */
    .hero-slider {
        position: relative;
        width: 100%;
        height: 600px;
        overflow: hidden;
        background: var(--black);
    }

    .slider-container {
        position: relative;
        width: 100%;
        height: 100%;
    }

    .slide {
        position: absolute;
        width: 100%;
        height: 100%;
        opacity: 0;
        transition: opacity 0.8s ease-in-out;
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
    }

    .slide.active {
        opacity: 1;
        z-index: 1;
    }

    .slide::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.4) 100%);
        z-index: 1;
    }

    .slide-content {
        position: absolute;
        bottom: 30%;
        left: 10%;
        right: 10%;
        z-index: 2;
        color: var(--white);
        max-width: 600px;
        animation: slideUp 0.8s ease;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .slide-content h1 {
        font-size: 48px;
        font-weight: 700;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .slide-content p {
        font-size: 18px;
        margin-bottom: 30px;
        line-height: 1.6;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .slide-btn {
        display: inline-block;
        padding: 12px 35px;
        background: var(--gold);
        color: var(--black);
        text-decoration: none;
        font-weight: 600;
        border-radius: 30px;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }

    .slide-btn:hover {
        background: transparent;
        border-color: var(--gold);
        color: var(--gold);
        transform: translateY(-2px);
    }

    /* Slider Navigation */
    .slider-nav {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        width: 100%;
        display: flex;
        justify-content: space-between;
        padding: 0 20px;
        z-index: 10;
        pointer-events: none;
    }

    .slider-nav button {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: rgba(212, 175, 55, 0.8);
        border: none;
        color: var(--black);
        font-size: 24px;
        cursor: pointer;
        transition: all 0.3s ease;
        pointer-events: auto;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .slider-nav button:hover {
        background: var(--gold);
        transform: scale(1.1);
    }

    /* Slider Indicators */
    .slider-indicators {
        position: absolute;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 12px;
        z-index: 10;
    }

    .indicator {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.5);
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .indicator.active {
        background: var(--gold);
        width: 30px;
        border-radius: 6px;
    }

    /* ==================== BRAND LOGOS ==================== */
    .brands-section {
        padding: 80px 0;
        background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
        position: relative;
        overflow: hidden;
    }

    .brands-section::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle at 30% 50%, rgba(212, 175, 55, 0.03) 0%, transparent 50%);
        pointer-events: none;
    }

    .brands-section .section-title {
        color: var(--white);
    }

    .brands-section .section-title:after {
        background: var(--gold);
    }

    .brands-subtitle {
        text-align: center;
        color: rgba(255, 255, 255, 0.6);
        font-size: 15px;
        margin-top: -35px;
        margin-bottom: 50px;
        letter-spacing: 0.5px;
    }

    .brands-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        gap: 30px;
        position: relative;
        z-index: 1;
    }

    .brand-item {
        text-align: center;
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        cursor: pointer;
        padding: 30px 35px 40px;
        background: rgba(255, 255, 255, 0.03);
        border-radius: 16px;
        border: 1px solid rgba(255, 255, 255, 0.06);
        min-width: 160px;
        position: relative;
    }

    .brand-item::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%) scaleX(0);
        width: 60%;
        height: 2px;
        background: var(--gold);
        border-radius: 2px;
        transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .brand-item:hover {
        transform: translateY(-8px);
        background: rgba(255, 255, 255, 0.06);
        border-color: rgba(212, 175, 55, 0.3);
        box-shadow: 0 20px 60px rgba(212, 175, 55, 0.1);
    }

    .brand-item:hover::after {
        transform: translateX(-50%) scaleX(1);
    }

    .brand-logo {
        width: 90px;
        height: 90px;
        object-fit: contain;
        filter: grayscale(100%) brightness(0.8);
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .brand-item:hover .brand-logo {
        filter: grayscale(0%) brightness(1);
        transform: scale(1.1);
    }

    .brand-name {
        margin-top: 14px;
        font-size: 13px;
        font-weight: 600;
        color: rgba(255, 255, 255, 0.7);
        letter-spacing: 1px;
        text-transform: uppercase;
        transition: color 0.3s ease;
    }

    .brand-item:hover .brand-name {
        color: var(--gold);
    }

    .brand-item .brand-hover-hint {
        position: absolute;
        bottom: 14px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 11px;
        color: var(--gold);
        opacity: 0;
        transition: all 0.3s ease;
        white-space: nowrap;
        font-weight: 500;
        letter-spacing: 0.5px;
    }

    .brand-item:hover .brand-hover-hint {
        opacity: 1;
    }

    /* ==================== CATEGORY SECTION ==================== */
    .category-section {
        padding: 80px 0;
        background: var(--gray-bg);
        position: relative;
    }

    .category-section .section-subtitle {
        text-align: center;
        color: #888;
        font-size: 15px;
        margin-top: -35px;
        margin-bottom: 50px;
    }

    .category-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
    }

    .category-card {
        position: relative;
        background: var(--white);
        border-radius: 20px;
        overflow: hidden;
        text-decoration: none;
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
        min-height: 320px;
        display: flex;
        flex-direction: column;
    }

    .category-card:hover {
        transform: translateY(-12px);
        box-shadow: 0 25px 50px rgba(212, 175, 55, 0.15);
    }

    .category-card .category-img-wrapper {
        position: relative;
        overflow: hidden;
        height: 200px;
        flex-shrink: 0;
    }

    .category-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .category-card:hover .category-img {
        transform: scale(1.1);
    }

    .category-img-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.6) 0%, transparent 60%);
        opacity: 0;
        transition: opacity 0.4s ease;
    }

    .category-card:hover .category-img-overlay {
        opacity: 1;
    }

    .category-card .category-count-badge {
        position: absolute;
        top: 15px;
        right: 15px;
        background: rgba(212, 175, 55, 0.9);
        color: var(--black);
        font-size: 12px;
        font-weight: 700;
        padding: 5px 12px;
        border-radius: 20px;
        backdrop-filter: blur(5px);
        opacity: 0;
        transform: translateY(-10px);
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        z-index: 2;
    }

    .category-card:hover .category-count-badge {
        opacity: 1;
        transform: translateY(0);
    }

    .category-info {
        padding: 22px 24px 24px;
        text-align: left;
        flex: 1;
        display: flex;
        flex-direction: column;
        position: relative;
    }

    .category-info-top {
        display: flex;
        align-items: center;
        gap: 14px;
        margin-bottom: 8px;
    }

    .category-icon {
        font-size: 32px;
        color: var(--gold);
        transition: transform 0.4s ease;
        flex-shrink: 0;
    }

    .category-card:hover .category-icon {
        transform: scale(1.15) rotate(-5deg);
    }

    .category-name {
        font-size: 20px;
        font-weight: 700;
        color: var(--black);
        margin: 0;
        transition: color 0.3s ease;
    }

    .category-card:hover .category-name {
        color: var(--gold);
    }

    .category-desc {
        font-size: 13px;
        color: #999;
        margin: 6px 0 0 0;
        line-height: 1.5;
        flex: 1;
    }

    .category-cta {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-top: 14px;
        font-size: 13px;
        font-weight: 600;
        color: var(--gold);
        transition: all 0.3s ease;
        opacity: 0;
        transform: translateX(-8px);
    }

    .category-cta i {
        transition: transform 0.3s ease;
        font-size: 12px;
    }

    .category-card:hover .category-cta {
        opacity: 1;
        transform: translateX(0);
    }

    .category-cta:hover {
        gap: 12px;
        color: var(--dark-gold);
    }

    .category-cta:hover i {
        transform: translateX(4px);
    }

    /* ==================== PRODUCT CARD ==================== */
    .product-section {
        padding: 80px 0;
    }

    .product-section.bg-white {
        background: var(--white);
    }

    .product-section .section-subtitle {
        text-align: center;
        color: #888;
        font-size: 15px;
        margin-top: -35px;
        margin-bottom: 50px;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
    }

    .product-card {
        background: var(--white);
        border-radius: 16px;
        overflow: hidden;
        transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        position: relative;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        border: 1px solid rgba(0, 0, 0, 0.04);
    }

    .product-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--gold), var(--light-gold), var(--gold));
        transform: scaleX(0);
        transform-origin: left;
        transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        z-index: 5;
    }

    .product-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 50px rgba(212, 175, 55, 0.12);
        border-color: rgba(212, 175, 55, 0.15);
    }

    .product-card:hover::before {
        transform: scaleX(1);
    }

    /* ─── Badges ─── */
    .product-badge {
        position: absolute;
        top: 14px;
        left: 14px;
        z-index: 3;
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .badge-custom {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        animation: badgePulse 2s ease-in-out infinite;
    }

    @keyframes badgePulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }

    .badge-hot {
        background: linear-gradient(135deg, #ff4757, #ff6b81);
        color: #fff;
    }

    .badge-new {
        background: linear-gradient(135deg, #2ed573, #7bed9f);
        color: #fff;
    }

    .badge-sale {
        background: linear-gradient(135deg, #e74c3c, #ff7675);
        color: #fff;
    }

    .badge-custom i {
        font-size: 12px;
    }

    /* ─── Image ─── */
    .product-img-wrapper {
        position: relative;
        overflow: hidden;
        cursor: pointer;
        background: #f5f5f5;
    }

    .product-img {
        width: 100%;
        height: 280px;
        object-fit: cover;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .product-card:hover .product-img {
        transform: scale(1.12);
    }

    .product-img-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.5) 0%, transparent 50%);
        opacity: 0;
        transition: opacity 0.4s ease;
        z-index: 1;
    }

    .product-card:hover .product-img-overlay {
        opacity: 1;
    }

    /* ─── Discount Badge ─── */
    .product-discount-badge {
        position: absolute;
        top: 14px;
        right: 14px;
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: #fff;
        font-size: 13px;
        font-weight: 800;
        padding: 6px 10px;
        border-radius: 8px;
        z-index: 3;
        box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
        transform: rotate(3deg);
        transition: transform 0.3s ease;
        line-height: 1;
    }

    .product-card:hover .product-discount-badge {
        transform: rotate(0deg) scale(1.1);
    }

    /* ─── Action Buttons ─── */
    .product-actions {
        position: absolute;
        top: 14px;
        right: 14px;
        display: flex;
        flex-direction: column;
        gap: 8px;
        z-index: 3;
    }

    .action-btn {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.95);
        border: none;
        color: var(--black);
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        opacity: 0;
        transform: translateX(10px);
    }

    .product-card:hover .action-btn {
        opacity: 1;
        transform: translateX(0);
    }

    .product-card .action-btn:nth-child(2) {
        transition-delay: 0.05s;
    }

    .product-card:hover .action-btn:hover {
        background: var(--gold);
        color: var(--black);
        transform: scale(1.1);
        box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);
    }

    .action-btn i {
        pointer-events: none;
    }

    /* ─── Info Section ─── */
    .product-info {
        padding: 20px 22px 22px;
        position: relative;
    }

    .product-info-top {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
    }

    .product-brand {
        font-size: 11px;
        color: var(--gold);
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .product-scale {
        font-size: 11px;
        color: #999;
        background: #f5f5f5;
        padding: 3px 8px;
        border-radius: 4px;
        font-weight: 500;
    }

    .product-name {
        font-size: 16px;
        font-weight: 600;
        color: var(--black);
        margin-bottom: 10px;
        text-decoration: none;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        line-height: 1.4;
        min-height: 44px;
        transition: color 0.3s ease;
    }

    .product-name:hover {
        color: var(--gold);
    }

    .product-rating {
        display: flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 12px;
    }

    .stars {
        color: #f39c12;
        font-size: 12px;
        display: flex;
        gap: 1px;
    }

    .review-count {
        font-size: 11px;
        color: #aaa;
    }

    .product-price {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 16px;
        flex-wrap: wrap;
    }

    .current-price {
        font-size: 20px;
        font-weight: 800;
        color: var(--gold);
    }

    .old-price {
        font-size: 13px;
        color: #bbb;
        text-decoration: line-through;
    }

    /* ─── View Detail CTA ─── */
    .product-card .product-view-detail {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        width: 100%;
        padding: 10px 16px;
        background: transparent;
        color: var(--black);
        border: 2px solid #eee;
        border-radius: 10px;
        font-weight: 600;
        font-size: 13px;
        transition: all 0.3s ease;
        text-decoration: none;
        box-sizing: border-box;
    }

    .product-card:hover .product-view-detail {
        border-color: var(--gold);
        background: var(--gold);
        color: var(--black);
        gap: 12px;
    }

    .product-view-detail i {
        font-size: 12px;
        transition: transform 0.3s ease;
    }

    .product-card:hover .product-view-detail i {
        transform: translateX(4px);
    }

    /* Wishlist Toast Notification */
    .toast-notification {
        position: fixed;
        bottom: 30px;
        right: 30px;
        background: var(--black);
        color: var(--gold);
        padding: 15px 25px;
        border-radius: 8px;
        border-left: 4px solid var(--gold);
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        z-index: 9999;
        transform: translateX(400px);
        transition: transform 0.3s ease;
        font-weight: 500;
    }

    .toast-notification.show {
        transform: translateX(0);
    }

    /* Responsive */
    @media (max-width: 991px) {
        .hero-slider {
            height: 500px;
        }

        .slide-content h1 {
            font-size: 32px;
        }

        .slide-content p {
            font-size: 14px;
        }
    }

    @media (max-width: 991px) {
        .category-grid {
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        }
        .brand-item {
            min-width: 130px;
            padding: 20px 24px 34px;
        }
        .brand-logo {
            width: 70px;
            height: 70px;
        }
    }

    @media (max-width: 768px) {
        .hero-slider {
            height: 400px;
        }

        .section-title {
            font-size: 24px;
        }

        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .category-grid {
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 18px;
        }

        .brands-wrapper {
            gap: 16px;
        }

        .brand-item {
            min-width: 110px;
            padding: 16px 18px 30px;
        }

        .brand-logo {
            width: 60px;
            height: 60px;
        }

        .brands-section {
            padding: 50px 0;
        }

        .category-section {
            padding: 50px 0;
        }
    }
</style>

<c:if test="${not empty banners}">
<!-- ==================== HERO BANNER SLIDER ==================== -->
<section class="hero-slider">
    <div class="slider-container">
        <c:forEach var="banner" items="${banners}" varStatus="status">
            <div class="slide" data-link="${not empty banner.redirectUrl ? banner.redirectUrl : '#'}" data-slide="${status.index}"
                 style="background-image: url('${pageContext.request.contextPath}${banner.imageUrl}');">
                <div class="slide-content">
                    <h1>${banner.title}</h1>
                    <c:if test="${not empty banner.description}">
                        <p>${banner.description}</p>
                    </c:if>
                    <c:if test="${not empty banner.redirectUrl}">
                        <a href="${banner.redirectUrl}" class="slide-btn">Khám phá ngay</a>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="slider-nav">
        <button class="prev-slide"><i class="bi bi-chevron-left"></i></button>
        <button class="next-slide"><i class="bi bi-chevron-right"></i></button>
    </div>

    <div class="slider-indicators">
        <c:forEach var="banner" items="${banners}" varStatus="status">
            <div class="indicator" data-slide="${status.index}"></div>
        </c:forEach>
    </div>
</section>
</c:if>

<!-- ==================== BRAND LOGOS SECTION ==================== -->
<section class="brands-section">
    <div class="container">
        <h2 class="section-title">Thương Hiệu Đối Tác</h2>
        <p class="brands-subtitle">Những thương hiệu xe hơi danh tiếng hợp tác cùng chúng tôi</p>
        <div class="brands-wrapper">
            <c:forEach var="br" items="${brands}">
                <div class="brand-item" onclick="location.href='/products?brand=${br.name}'">
                    <img src="${pageContext.request.contextPath}${br.logo}"
                         alt="${br.name}" class="brand-logo">
                    <p class="brand-name">${br.name}</p>
                    <span class="brand-hover-hint">Khám phá →</span>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== CATEGORY SECTION ==================== -->
<section class="category-section">
    <div class="container">
        <h2 class="section-title">Danh Mục Mô Hình Xe</h2>
        <p class="section-subtitle">Lựa chọn theo dòng xe yêu thích của bạn</p>
        <div class="category-grid">
            <c:forEach var="ca" items="${categories}">
                <a href="/products?category=${ca.name}" class="category-card">
                    <div class="category-img-wrapper">
                        <img src="${ca.image}"
                             alt="${ca.name}" class="category-img">
                        <div class="category-img-overlay"></div>
                        <span class="category-count-badge"><i class="bi bi-box me-1"></i>Xem thêm</span>
                    </div>
                    <div class="category-info">
                        <div class="category-info-top">
                            <i class="bi ${ca.icon} category-icon"></i>
                            <h3 class="category-name">${ca.name}</h3>
                        </div>
                        <p class="category-desc">Bộ sưu tập mô hình xe ${ca.name} cao cấp</p>
                        <span class="category-cta">Xem sản phẩm <i class="bi bi-arrow-right"></i></span>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== SẢN PHẨM BÁN CHẠY ==================== -->
<section class="product-section bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Bán Chạy</h2>
        <p class="section-subtitle">Những mẫu xe được yêu thích nhất hiện nay</p>
        <div class="product-grid">
            <c:forEach var="product" items="${productHot}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <span class="badge-custom badge-hot"><i class="bi bi-fire"></i> Bán chạy</span>
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? product.image : 'https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                        <div class="product-img-overlay"></div>
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}" title="Thêm vào yêu thích">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}" title="Xem nhanh">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-info-top">
                            <span class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</span>
                            <span class="product-scale">1:${product.ratio ne null ? product.ratio : '18'}</span>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                        <div class="product-rating">
                            <div class="stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-half"></i>
                            </div>
                            <span class="review-count">(${product.reviewCount ne null ? product.reviewCount : 12} đánh giá)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">
                                <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                            </span>
                            <c:if test="${product.price ne null && product.price gt product.finalPrice}">
                                <span class="old-price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </c:if>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-view-detail">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== SẢN PHẨM MỚI ==================== -->
<section class="product-section">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Mới</h2>
        <p class="section-subtitle">Những mẫu xe vừa ra mắt tại LUXCAR</p>
        <div class="product-grid">
            <c:forEach var="product" items="${productNew}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <span class="badge-custom badge-new"><i class="bi bi-stars"></i> Mới</span>
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? product.image : 'https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                        <div class="product-img-overlay"></div>
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}" title="Thêm vào yêu thích">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}" title="Xem nhanh">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-info-top">
                            <span class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</span>
                            <span class="product-scale">1:${product.ratio ne null ? product.ratio : '18'}</span>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                        <div class="product-rating">
                            <div class="stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star"></i>
                            </div>
                            <span class="review-count">(0 đánh giá)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">
                                <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                            </span>
                            <c:if test="${product.finalPrice ne null && product.finalPrice gt product.price}">
                                <span class="old-price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </c:if>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-view-detail">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== SẢN PHẨM KHUYẾN MÃI ==================== -->
<section class="product-section bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Khuyến Mãi</h2>
        <p class="section-subtitle">Cơ hội sở hữu mô hình xe với giá ưu đãi</p>
        <div class="product-grid">
            <c:forEach var="product" items="${productSale}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <span class="badge-custom badge-sale"><i class="bi bi-tag"></i> Giảm ${not empty product.discountPercent and product.discountPercent ne 0 ? product.discountPercent : ''}%</span>
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? product.image : 'https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                        <div class="product-img-overlay"></div>
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}" title="Thêm vào yêu thích">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}" title="Xem nhanh">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-info-top">
                            <span class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</span>
                            <span class="product-scale">1:${product.ratio ne null ? product.ratio : '18'}</span>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                        <div class="product-rating">
                            <div class="stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                            </div>
                            <span class="review-count">(${product.reviewCount ne null ? product.reviewCount : 8} đánh giá)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">
                                <fmt:formatNumber
                                        value="${product.discountPercent ne 0 ? product.discountPercent : product.finalPrice}"
                                        type="number" groupingUsed="true"/> ₫
                            </span>
                            <c:if test="${not empty product.price}">
                                <span class="old-price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </c:if>
                        </div>
                        <a href="/product-detail?id=${product.id}" class="product-view-detail">
                            Xem chi tiết <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty productSale}">
                <c:forEach begin="1" end="4">
                    <div class="product-card">
                        <div class="product-badge">
                            <span class="badge-custom badge-sale"><i class="bi bi-tag"></i> Giảm 30%</span>
                        </div>
                        <div class="product-img-wrapper">
                            <img src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"
                                 alt="Ferrari 296 GTB" class="product-img">
                            <div class="product-img-overlay"></div>
                        </div>
                        <div class="product-actions">
                            <button class="action-btn add-to-wishlist" title="Thêm vào yêu thích"><i class="bi bi-heart"></i></button>
                            <button class="action-btn quick-view" title="Xem nhanh"><i class="bi bi-eye"></i></button>
                        </div>
                        <div class="product-info">
                            <div class="product-info-top">
                                <span class="product-brand">Ferrari</span>
                                <span class="product-scale">1:18</span>
                            </div>
                            <a href="/product-detail?id=1" class="product-name">Ferrari 296 GTB Assetto Fiorano</a>
                            <div class="product-rating">
                                <div class="stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                                        class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                                        class="bi bi-star-fill"></i></div>
                                <span class="review-count">(15 đánh giá)</span>
                            </div>
                            <div class="product-price">
                                <span class="current-price">1,750,000 ₫</span>
                                <span class="old-price">2,500,000 ₫</span>
                            </div>
                            <a href="/product-detail?id=1" class="product-view-detail">
                                Xem chi tiết <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
</section>

<!-- Toast Notification Container -->
<%--<div id="toastNotification" class="toast-notification"></div>--%>

<script>
    // ==================== SLIDER FUNCTIONALITY ====================
    document.addEventListener('DOMContentLoaded', function () {
        const slides = document.querySelectorAll('.slide');

        slides.forEach((slide) => {
            slide.style.backgroundSize = 'cover';
            slide.style.backgroundPosition = 'center';
        });

        let currentSlide = 0;
        const totalSlides = slides.length;
        let autoSlideInterval;

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.remove('active');
                document.querySelectorAll('.indicator')[i].classList.remove('active');
            });

            currentSlide = (index + totalSlides) % totalSlides;
            slides[currentSlide].classList.add('active');
            document.querySelectorAll('.indicator')[currentSlide].classList.add('active');
        }

        function nextSlide() {
            showSlide(currentSlide + 1);
        }

        function prevSlide() {
            showSlide(currentSlide - 1);
        }

        function startAutoSlide() {
            autoSlideInterval = setInterval(nextSlide, 5000);
        }

        function stopAutoSlide() {
            clearInterval(autoSlideInterval);
        }

        // Event listeners
        document.querySelector('.next-slide').addEventListener('click', () => {
            stopAutoSlide();
            nextSlide();
            startAutoSlide();
        });

        document.querySelector('.prev-slide').addEventListener('click', () => {
            stopAutoSlide();
            prevSlide();
            startAutoSlide();
        });

        document.querySelectorAll('.indicator').forEach((indicator, i) => {
            indicator.addEventListener('click', () => {
                stopAutoSlide();
                showSlide(i);
                startAutoSlide();
            });
        });

        // Click on slide to navigate
        slides.forEach(slide => {
            slide.addEventListener('click', (e) => {
                if (e.target.tagName !== 'A' && !e.target.closest('.slide-btn')) {
                    const link = slide.getAttribute('data-link');
                    if (link) {
                        window.location.href = link;
                    }
                }
            });
        });

        // Start auto slide
        showSlide(0);
        startAutoSlide();

        // ==================== WISHLIST FUNCTIONALITY ====================
        const wishlistButtons = document.querySelectorAll('.add-to-wishlist');
        // const toast = document.getElementById('toastNotification');

        // function showToast(message, isSuccess = true) {
        //     toast.textContent = message;
        //     toast.style.background = isSuccess ? 'var(--black)' : '#dc3545';
        //     toast.style.color = isSuccess ? 'var(--gold)' : 'white';
        //     toast.classList.add('show');
        //
        //     setTimeout(() => {
        //         toast.classList.remove('show');
        //     }, 3000);
        // }

        wishlistButtons.forEach(button => {
            button.addEventListener('click', async function (e) {
                e.stopPropagation();
                const productId = this.getAttribute('data-product-id');

                <c:choose>
                <c:when test="${sessionScope.user != null}">
                // User logged in - add to wishlist via AJAX
                try {
                    const response = await fetch('${pageContext.request.contextPath}/api/wishlist/add', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `productId=${productId}`
                    });

                    if (response.ok) {
                        const result = await response.json();
                        showAlert('Đã thêm vào yêu thích!', 'success');
                        // Change heart icon style
                        this.querySelector('i').classList.remove('bi-heart');
                        this.querySelector('i').classList.add('bi-heart-fill');
                    } else {
                        showToast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showAlert('Có lỗi xảy ra!', 'error');
                }
                </c:when>
                <c:otherwise>
                // Not logged in - redirect to login
                showAlert('Vui lòng đăng nhập để thêm vào yêu thích!', 'warning');
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }, 1500);
                </c:otherwise>
                </c:choose>
            });
        });

        // ==================== QUICK VIEW FUNCTIONALITY ====================
        const quickViewButtons = document.querySelectorAll('.quick-view');

        quickViewButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                e.stopPropagation();
                const productId = this.getAttribute('data-product-id');
                // Implement quick view modal here
                window.location.href = `/product-detail?id=${productId}`;
            });
        });

        // ==================== PRODUCT CARD CLICK ====================
        const productCards = document.querySelectorAll('.product-card');
        productCards.forEach(card => {
            card.addEventListener('click', function (e) {
                if (!e.target.closest('.action-btn') && !e.target.closest('.product-view-detail')) {
                    const productLink = this.querySelector('.product-name');
                    if (productLink) {
                        window.location.href = productLink.getAttribute('href');
                    }
                }
            });
        });
    });
</script>

<%@ include file="/common/footer.jsp" %>