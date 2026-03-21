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
        padding: 60px 0;
        background: var(--white);
    }

    .brands-wrapper {
        display: flex;
        justify-content: space-around;
        align-items: center;
        flex-wrap: wrap;
        gap: 40px;
    }

    .brand-item {
        text-align: center;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .brand-item:hover {
        transform: translateY(-5px);
    }

    .brand-logo {
        width: 100px;
        height: 100px;
        object-fit: contain;
        filter: grayscale(100%);
        transition: all 0.3s ease;
    }

    .brand-item:hover .brand-logo {
        filter: grayscale(0%);
    }

    .brand-name {
        margin-top: 10px;
        font-size: 14px;
        font-weight: 500;
        color: var(--black);
    }

    /* ==================== CATEGORY SECTION ==================== */
    .category-section {
        padding: 80px 0;
        background: var(--gray-bg);
    }

    .category-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 30px;
    }

    .category-card {
        background: var(--white);
        border-radius: 15px;
        overflow: hidden;
        text-decoration: none;
        transition: all 0.4s ease;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
    }

    .category-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 40px rgba(212, 175, 55, 0.2);
    }

    .category-img {
        width: 100%;
        height: 250px;
        object-fit: cover;
        transition: transform 0.4s ease;
    }

    .category-card:hover .category-img {
        transform: scale(1.05);
    }

    .category-info {
        padding: 20px;
        text-align: center;
    }

    .category-icon {
        font-size: 40px;
        color: var(--gold);
        margin-bottom: 10px;
    }

    .category-name {
        font-size: 20px;
        font-weight: 600;
        color: var(--black);
        margin: 0;
    }

    /* ==================== PRODUCT CARD ==================== */
    .product-section {
        padding: 80px 0;
    }

    .product-section.bg-white {
        background: var(--white);
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
    }

    .product-card {
        background: var(--white);
        border-radius: 12px;
        overflow: hidden;
        transition: all 0.4s ease;
        position: relative;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    }

    .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
    }

    .product-badge {
        position: absolute;
        top: 15px;
        left: 15px;
        z-index: 2;
        display: flex;
        gap: 8px;
    }

    .badge-gif {
        width: 50px;
        height: auto;
    }

    .product-img-wrapper {
        position: relative;
        overflow: hidden;
        cursor: pointer;
    }

    .product-img {
        width: 100%;
        height: 280px;
        object-fit: cover;
        transition: transform 0.5s ease;
    }

    .product-card:hover .product-img {
        transform: scale(1.1);
    }

    .product-actions {
        position: absolute;
        bottom: -50px;
        left: 0;
        right: 0;
        display: flex;
        justify-content: center;
        gap: 10px;
        padding: 15px;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
        transition: bottom 0.3s ease;
    }

    .product-card:hover .product-actions {
        bottom: 0;
    }

    .action-btn {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: var(--gold);
        border: none;
        color: var(--black);
        font-size: 18px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .action-btn:hover {
        background: var(--white);
        transform: scale(1.1);
    }

    .product-info {
        padding: 20px;
    }

    .product-brand {
        font-size: 12px;
        color: var(--gold);
        font-weight: 600;
        text-transform: uppercase;
        margin-bottom: 8px;
    }

    .product-name {
        font-size: 18px;
        font-weight: 600;
        color: var(--black);
        margin-bottom: 10px;
        text-decoration: none;
        display: block;
    }

    .product-name:hover {
        color: var(--gold);
    }

    .product-rating {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 10px;
    }

    .stars {
        color: #ffc107;
        font-size: 14px;
    }

    .review-count {
        font-size: 12px;
        color: #666;
    }

    .product-price {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 15px;
        flex-wrap: wrap;
    }

    .current-price {
        font-size: 20px;
        font-weight: 700;
        color: var(--gold);
    }

    .old-price {
        font-size: 14px;
        color: #999;
        text-decoration: line-through;
    }

    .product-scale {
        font-size: 12px;
        color: #666;
        background: #f0f0f0;
        padding: 4px 8px;
        border-radius: 4px;
        display: inline-block;
    }

    .btn-view-detail {
        width: 100%;
        padding: 10px;
        background: var(--black);
        color: var(--white);
        border: none;
        border-radius: 6px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
        text-align: center;
    }

    .btn-view-detail:hover {
        background: var(--gold);
        color: var(--black);
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
    }
</style>

<!-- ==================== HERO BANNER SLIDER ==================== -->
<section class="hero-slider">
    <div class="slider-container">
        <!-- Slide 1 -->
        <div class="slide" data-link="/products?category=sport" data-slide="0">
            <div class="slide-content">
                <h1>Bộ Sưu Tập Xe Thể Thao</h1>
                <p>Trải nghiệm cảm giác tốc độ với những mô hình xe thể thao đẳng cấp, tỉ lệ 1:18 chuẩn xác từng chi
                    tiết.</p>
                <a href="/products?category=sport" class="slide-btn">Khám phá ngay</a>
            </div>
        </div>

        <!-- Slide 2 -->
        <div class="slide" data-link="/products?category=supercar" data-slide="1">
            <div class="slide-content">
                <h1>Siêu Xe Đẳng Cấp</h1>
                <p>Những mẫu siêu xe hàng đầu thế giới được tái hiện chi tiết, hoàn hảo cho bộ sưu tập của bạn.</p>
                <a href="/products?category=supercar" class="slide-btn">Xem bộ sưu tập</a>
            </div>
        </div>

        <!-- Slide 3 -->
        <div class="slide" data-link="/products?category=sale" data-slide="2">
            <div class="slide-content">
                <h1>Khuyến Mãi Lớn</h1>
                <p>Giảm giá lên đến 30% cho các mô hình xe cổ điển. Cơ hội sở hữu ngay hôm nay!</p>
                <a href="/products?category=sale" class="slide-btn">Mua ngay</a>
            </div>
        </div>
    </div>

    <div class="slider-nav">
        <button class="prev-slide"><i class="bi bi-chevron-left"></i></button>
        <button class="next-slide"><i class="bi bi-chevron-right"></i></button>
    </div>

    <div class="slider-indicators">
        <div class="indicator" data-slide="0"></div>
        <div class="indicator" data-slide="1"></div>
        <div class="indicator" data-slide="2"></div>
    </div>
</section>

<!-- ==================== BRAND LOGOS SECTION ==================== -->
<section class="brands-section">
    <div class="container">
        <h2 class="section-title">Thương Hiệu Đối Tác</h2>
        <div class="brands-wrapper">
            <c:forEach var="br" items="${brands}">
                <div class="brand-item" onclick="location.href='/products?brand=${br.name}'">
                    <img src="${br.image}"
                         alt="${br.name}" class="brand-logo">
                    <p class="brand-name">${br.name}</p>
                </div>
            </c:forEach>

        </div>
    </div>
</section>

<!-- ==================== CATEGORY SECTION ==================== -->
<section class="category-section">
    <div class="container">
        <h2 class="section-title">Danh Mục Mô Hình Xe</h2>
        <div class="category-grid">
            <a href="/products?category=sport" class="category-card">
                <img src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"
                     alt="Xe Thể Thao" class="category-img">
                <div class="category-info">
                    <i class="bi bi-speedometer2 category-icon"></i>
                    <h3 class="category-name">Xe Thể Thao</h3>
                </div>
            </a>
            <a href="/products?category=supercar" class="category-card">
                <img src="https://product.hstatic.net/1000328919/product/lamborghini-aventador-svj-1-18-maisto_1eef51a198a043e2a8330ab4b4ed3003_grande.jpg"
                     alt="Siêu Xe" class="category-img">
                <div class="category-info">
                    <i class="bi bi-stars category-icon"></i>
                    <h3 class="category-name">Siêu Xe</h3>
                </div>
            </a>
            <a href="/products?category=classic" class="category-card">
                <img src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-250-gto-1-18-cmc_9e3a3b5d5c6d4c5f8b3e6f2a1c8e9d4f_grande.jpg"
                     alt="Xe Cổ Điển" class="category-img">
                <div class="category-info">
                    <i class="bi bi-clock-history category-icon"></i>
                    <h3 class="category-name">Xe Cổ Điển</h3>
                </div>
            </a>
            <a href="/products?category=limited" class="category-card">
                <img src="https://product.hstatic.net/1000328919/product/bugatti-chiron-1-18-autoart_f8d3a2c5b6e7f8d9c0a1b2c3d4e5f6g7_grande.jpg"
                     alt="Phiên Bản Giới Hạn" class="category-img">
                <div class="category-info">
                    <i class="bi bi-gem category-icon"></i>
                    <h3 class="category-name">Phiên Bản Giới Hạn</h3>
                </div>
            </a>
        </div>
    </div>
</section>

<!-- ==================== SẢN PHẨM BÁN CHẠY ==================== -->
<section class="product-section bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Bán Chạy</h2>
        <div class="product-grid">
            <c:forEach var="product" items="${productHot}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <img src="https://nettruyen.work/assets/images/icon-hot.gif" class="badge-gif" alt="Hot">
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? product.image : 'https://via.placeholder.com/400x300?text=No+Image'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</div>
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
                        <div class="product-scale">Tỉ lệ: ${product.ratio ne null ? product.ratio : '1:18'}</div>
                            <%--                        <a href="/product-detail?id=${product.id}" class="btn-view-detail">Xem chi tiết</a>--%>
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
        <div class="product-grid">
            <c:forEach var="product" items="${productNew}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <img src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmV3X2ZsYXNoX25ld19wcm9kdWN0JmZpcnN0X2hpdF9wcm9kdWN0JmN0PWc&rid=giphy.gif"
                             class="badge-gif" alt="New">
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? product.image : 'https://via.placeholder.com/400x300?text=No+Image'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</div>
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
                        <div class="product-scale">Tỉ lệ: ${product.ratio ne null ? product.ratio : '1:18'}</div>
                            <%--                        <a href="/product-detail?id=${product.id}" class="btn-view-detail">Xem chi tiết</a>--%>
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
        <div class="product-grid">
            <c:forEach var="product" items="${productSale}" varStatus="status">
                <div class="product-card" data-product-id="${product.id}">
                    <div class="product-badge">
                        <img src="https://media1.tenor.com/m/-2t7_3H9cBkAAAAC/sale-sale-sticker.gif"
                             class="badge-gif" alt="Sale">
                    </div>
                    <div class="product-img-wrapper" onclick="location.href='/product-detail?id=${product.id}'">
                        <img src="${product.image ne null ? product.image : 'https://via.placeholder.com/400x300?text=No+Image'}"
                             alt="${product.name}"
                             class="product-img"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/400x300?text=Image+Not+Found';">
                    </div>
                    <div class="product-actions">
                        <button class="action-btn add-to-wishlist" data-product-id="${product.id}">
                            <i class="bi bi-heart"></i>
                        </button>
                        <button class="action-btn quick-view" data-product-id="${product.id}">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="product-info">
                        <div class="product-brand">${product.brandName ne null ? product.brandName : 'LUXCAR'}</div>
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
                            <span class="old-price">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                            </span>
                        </div>
                        <div class="product-scale">Tỉ lệ: ${product.ratio ne null ? product.ratio : '1:18'}</div>
                            <%--                        <a href="/product-detail?id=${product.id}" class="btn-view-detail">Xem chi tiết</a>--%>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty productSale}">
                <c:forEach begin="1" end="4">
                    <div class="product-card">
                        <div class="product-badge">
                            <img src="https://media1.tenor.com/m/-2t7_3H9cBkAAAAC/sale-sale-sticker.gif"
                                 class="badge-gif" alt="Sale">
                        </div>
                        <div class="product-img-wrapper">
                            <img src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"
                                 alt="Ferrari 296 GTB" class="product-img">
                        </div>
                        <div class="product-actions">
                            <button class="action-btn add-to-wishlist"><i class="bi bi-heart"></i></button>
                            <button class="action-btn quick-view"><i class="bi bi-eye"></i></button>
                        </div>
                        <div class="product-info">
                            <div class="product-brand">Ferrari</div>
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
                            <div class="product-scale">Tỉ lệ: 1:18</div>
                                <%--                            <a href="/product-detail?id=1" class="btn-view-detail">Xem chi tiết</a>--%>
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
        // Set background images for slides
        const slides = document.querySelectorAll('.slide');
        const slideImages = [
            'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=1920&h=600&fit=crop',
            'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=1920&h=600&fit=crop',
            'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1920&h=600&fit=crop'
        ];

        slides.forEach((slide, index) => {
            slide.style.backgroundImage = `url('${slideImages[index]}')`;
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
                if (!e.target.closest('.action-btn') && !e.target.closest('.btn-view-detail')) {
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