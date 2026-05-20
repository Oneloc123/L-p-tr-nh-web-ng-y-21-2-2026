<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bảng điều khiển - LUXCAR</title>
    <%@ include file="/common/header.jsp" %>
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar */
        .dashboard-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: #000000; color: #ffffff; padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 0 20px 20px; border-bottom: 1px solid #333333; text-align: center; }
        .sidebar-header h3 { color: #ffffff; font-size: 24px; font-weight: 600; margin: 0; }
        .sidebar-header p { color: #999999; font-size: 14px; margin-top: 5px; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: #ffffff; text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333333; color: #ffffff; }
        .menu-item.active { background-color: #ffffff; color: #000000; }
        .menu-item.active i { color: #000000; }
        .menu-divider { height: 1px; background-color: #333333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 600; color: #000000; margin-bottom: 10px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #666666; text-decoration: none; }
        .breadcrumb-item.active { color: #000000; font-weight: 500; }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            border: 1px solid #e9ecef;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .stat-info h3 {
            font-size: 26px;
            font-weight: 700;
            color: #000000;
            margin-bottom: 5px;
        }
        .stat-info p {
            font-size: 14px;
            color: #6c757d;
            margin: 0;
        }
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        .stat-icon.orders   { background: #fff3e0; color: #ff9800; }
        .stat-icon.spending { background: #e8f5e9; color: #4caf50; }
        .stat-icon.favorites{ background: #fee8e8; color: #f44336; }
        .stat-icon.reviews  { background: #f3e5f5; color: #9c27b0; }

        /* Dashboard Row */
        .dashboard-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }
        .recent-card, .quick-actions-card, .wishlist-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .card-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .card-header h3 i { color: #000000; }
        .view-all {
            color: #000000;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
        }
        .view-all:hover { text-decoration: underline; }

        /* Recent Orders */
        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 0;
            border-bottom: 1px solid #f0f0f0;
            gap: 10px;
        }
        .order-item:last-child { border-bottom: none; }
        .order-info { flex: 1; min-width: 0; }
        .order-id {
            font-weight: 600;
            color: #000000;
            margin-bottom: 4px;
            font-size: 14px;
        }
        .order-meta {
            font-size: 12px;
            color: #6c757d;
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }
        .order-meta .payment-method {
            background: #f0f0f0;
            padding: 2px 7px;
            border-radius: 4px;
            font-size: 11px;
        }
        .order-amount {
            font-weight: 700;
            color: #000000;
            font-size: 14px;
            white-space: nowrap;
        }
        .order-amount.unpaid { color: #c62828; }

        /* Order Status Badges — mapped to order_status values */
        .order-status {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        /* Chờ xác nhận / Pending */
        .status-pending   { background: #fff8e1; color: #f57f17; border: 1px solid #ffe082; }
        /* Đang xử lý / Processing */
        .status-processing{ background: #e3f2fd; color: #1565c0; border: 1px solid #90caf9; }
        /* Đang giao / Shipping */
        .status-shipping  { background: #e8f5e9; color: #2e7d32; border: 1px solid #a5d6a7; }
        /* Đã giao / Delivered */
        .status-delivered { background: #e0f2f1; color: #00695c; border: 1px solid #80cbc4; }
        /* Đã hủy / Cancelled */
        .status-cancelled { background: #ffebee; color: #b71c1c; border: 1px solid #ef9a9a; }
        /* Mặc định */
        .status-default   { background: #f5f5f5; color: #616161; border: 1px solid #e0e0e0; }

        /* Payment Status */
        .payment-status {
            display: inline-block;
            font-size: 11px;
            font-weight: 500;
        }
        .payment-paid   { color: #2e7d32; }
        .payment-unpaid { color: #c62828; }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
        }
        .empty-state i {
            font-size: 48px;
            color: #ddd;
            display: block;
            margin-bottom: 12px;
        }
        .empty-state p { color: #6c757d; margin-bottom: 15px; }
        .btn-shop {
            display: inline-block;
            background: #000;
            color: #fff;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .btn-shop:hover { background: #333; color: #fff; }

        /* Wishlist / Review summary */
        .wishlist-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .wishlist-item:last-child { border-bottom: none; }
        .wishlist-img {
            width: 48px;
            height: 48px;
            border-radius: 8px;
            object-fit: cover;
            background: #f0f0f0;
            flex-shrink: 0;
        }
        .wishlist-info { flex: 1; min-width: 0; }
        .wishlist-name {
            font-size: 13px;
            font-weight: 600;
            color: #000;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .wishlist-price { font-size: 12px; color: #6c757d; }
        .wishlist-price .final { color: #000; font-weight: 600; }
        .wishlist-price .original {
            text-decoration: line-through;
            font-size: 11px;
            margin-left: 4px;
        }
        .wishlist-price .badge-disc {
            background: #fee8e8;
            color: #f44336;
            font-size: 10px;
            padding: 1px 5px;
            border-radius: 4px;
            margin-left: 4px;
        }

        /* Quick Actions */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s;
            border: 1px solid #e9ecef;
        }
        .action-btn:hover { background: #000000; transform: translateY(-3px); }
        .action-btn i {
            font-size: 26px;
            color: #000000;
            margin-bottom: 10px;
            transition: color 0.3s;
        }
        .action-btn span {
            font-size: 13px;
            font-weight: 500;
            color: #495057;
            transition: color 0.3s;
            text-align: center;
        }
        .action-btn:hover i,
        .action-btn:hover span { color: #ffffff; }

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #000000 0%, #333333 100%);
            border-radius: 16px;
            padding: 25px 30px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .welcome-text h2 { color: white; font-size: 22px; margin-bottom: 8px; }
        .welcome-text p { color: rgba(255,255,255,0.75); margin: 0; font-size: 14px; }
        .welcome-stats { display: flex; gap: 30px; }
        .welcome-stat { text-align: center; }
        .welcome-stat .number { color: white; font-size: 26px; font-weight: 700; }
        .welcome-stat .label { color: rgba(255,255,255,0.65); font-size: 12px; margin-top: 2px; }

        /* Order status breakdown */
        .status-summary {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }
        .status-pill {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            background: #fff;
            border: 1px solid #e9ecef;
            box-shadow: 0 1px 4px rgba(0,0,0,0.04);
        }
        .status-pill .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }
        .dot-pending    { background: #f57f17; }
        .dot-processing { background: #1565c0; }
        .dot-shipping   { background: #2e7d32; }
        .dot-delivered  { background: #00695c; }
        .dot-cancelled  { background: #b71c1c; }

        /* Responsive */
        @media (max-width: 1024px) {
            .dashboard-row { grid-template-columns: 1fr; }
        }
        @media (max-width: 768px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
            .sidebar-menu { width: 0; display: none; }
            .welcome-banner { flex-direction: column; text-align: center; gap: 20px; }
            .welcome-stats { justify-content: center; }
            .actions-grid { grid-template-columns: 1fr; }
            .status-summary { gap: 6px; }
        }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
    <!-- Sidebar Menu (không chỉnh sửa) -->
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item active">
                <i class="fas fa-chart-pie"></i>
                <span>Bảng điều khiển</span>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                <i class="fas fa-user-circle"></i>
                <span>Thông tin cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item">
                <i class="fas fa-user-edit"></i>
                <span>Chỉnh sửa thông tin</span>
            </a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item">
                <i class="fas fa-lock"></i>
                <span>Đổi mật khẩu</span>
            </a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item">
                <i class="fas fa-shopping-bag"></i>
                <span>Đơn hàng của tôi</span>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item">
                <i class="fas fa-shopping-cart"></i>
                <span>Giỏ hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item">
                <i class="fas fa-heart"></i>
                <span>Sản phẩm yêu thích</span>
            </a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="content-header">
            <h1>Bảng điều khiển</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Dashboard</li>
                </ol>
            </nav>
        </div>

        <!-- Welcome Banner -->
        <%--
            Dữ liệu từ servlet:
            - user         : object Users (fullname từ cột `fullname` bảng users)
            - totalOrders  : COUNT(*) FROM `order` WHERE user_id = ?
            - totalSpending: SUM(total_price) FROM `order` WHERE user_id = ? AND order_status != 'Đã hủy'
            - totalFavorites: COUNT(*) FROM wishlist_item WHERE user_id = ?
            - totalReviews : COUNT(*) FROM reviews WHERE user_id = ?
        --%>
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Chào mừng trở lại, <c:out value="${user.fullname}"/>!</h2>
                <p>Dưới đây là tổng quan hoạt động của bạn tại LUXCAR</p>
            </div>
            <div class="welcome-stats">
                <div class="welcome-stat">
                    <div class="number">${totalOrders}</div>
                    <div class="label">Tổng đơn hàng</div>
                </div>
                <div class="welcome-stat">
                    <div class="number">
                        <fmt:formatNumber value="${totalSpending}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </div>
                    <div class="label">Tổng chi tiêu</div>
                </div>
                <div class="welcome-stat">
                    <div class="number">${totalFavorites}</div>
                    <div class="label">Yêu thích</div>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <%--
            Mapping với DB:
            - totalOrders    : COUNT(*) FROM `order` WHERE user_id = ?
            - totalSpending  : SUM(total_price) FROM `order` WHERE user_id = ? AND order_status NOT IN ('Đã hủy')
            - totalFavorites : COUNT(*) FROM wishlist_item WHERE user_id = ?
            - totalReviews   : COUNT(*) FROM reviews WHERE user_id = ?
        --%>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>${totalOrders}</h3>
                    <p>Tổng đơn hàng</p>
                </div>
                <div class="stat-icon orders">
                    <i class="fas fa-shopping-bag"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>
                        <fmt:formatNumber value="${totalSpending}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </h3>
                    <p>Tổng chi tiêu (đơn thành công)</p>
                </div>
                <div class="stat-icon spending">
                    <i class="fas fa-chart-line"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>${totalFavorites}</h3>
                    <p>Sản phẩm yêu thích</p>
                </div>
                <div class="stat-icon favorites">
                    <i class="fas fa-heart"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>${totalReviews}</h3>
                    <p>Đánh giá đã viết</p>
                </div>
                <div class="stat-icon reviews">
                    <i class="fas fa-star"></i>
                </div>
            </div>
        </div>

        <%--
            Tổng hợp đơn hàng theo trạng thái (order_status).
            Servlet cần truyền các biến:
            - countPending    : đơn "Chờ xác nhận"
            - countProcessing : đơn "Đang xử lý"
            - countShipping   : đơn "Đang giao"
            - countDelivered  : đơn "Đã giao"
            - countCancelled  : đơn "Đã hủy"
        --%>
        <c:if test="${totalOrders > 0}">
            <div class="status-summary">
                <c:if test="${countPending > 0}">
                    <a href="${pageContext.request.contextPath}/order?status=pending" class="status-pill" style="text-decoration:none;color:inherit;">
                        <span class="dot dot-pending"></span>
                        Chờ xác nhận: <strong>${countPending}</strong>
                    </a>
                </c:if>
                <c:if test="${countProcessing > 0}">
                    <a href="${pageContext.request.contextPath}/order?status=processing" class="status-pill" style="text-decoration:none;color:inherit;">
                        <span class="dot dot-processing"></span>
                        Đang xử lý: <strong>${countProcessing}</strong>
                    </a>
                </c:if>
                <c:if test="${countShipping > 0}">
                    <a href="${pageContext.request.contextPath}/order?status=shipping" class="status-pill" style="text-decoration:none;color:inherit;">
                        <span class="dot dot-shipping"></span>
                        Đang giao: <strong>${countShipping}</strong>
                    </a>
                </c:if>
                <c:if test="${countDelivered > 0}">
                    <a href="${pageContext.request.contextPath}/order?status=delivered" class="status-pill" style="text-decoration:none;color:inherit;">
                        <span class="dot dot-delivered"></span>
                        Đã giao: <strong>${countDelivered}</strong>
                    </a>
                </c:if>
                <c:if test="${countCancelled > 0}">
                    <a href="${pageContext.request.contextPath}/order?status=cancelled" class="status-pill" style="text-decoration:none;color:inherit;">
                        <span class="dot dot-cancelled"></span>
                        Đã hủy: <strong>${countCancelled}</strong>
                    </a>
                </c:if>
            </div>
        </c:if>

        <!-- Dashboard Row: Recent Orders & Wishlist -->
        <div class="dashboard-row">

            <%--
                Đơn hàng gần đây — listOrder: List<Order>
                Mapping từ bảng `order`:
                  order.id           → #ĐH
                  order.orderDate    → cột order_date (datetime)
                  order.totalPrice   → cột total_price (decimal 18,2)
                  order.orderStatus  → cột order_status (varchar)
                  order.paymentMethod → cột payment_method (varchar)
                  order.paymentStatus → cột payment_status (varchar)
                Lấy 5 đơn gần nhất: ORDER BY order_date DESC LIMIT 5
            --%>
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-clock"></i> Đơn hàng gần đây</h3>
                    <a href="${pageContext.request.contextPath}/order" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
                </div>

                <c:choose>
                    <c:when test="${not empty listOrder}">
                        <c:forEach var="order" items="${listOrder}">
                            <%-- Xác định class badge theo order_status --%>
                            <c:set var="statusClass" value="status-default"/>
                            <c:choose>
                                <c:when test="${order.orderStatus == 'Chờ xác nhận' or order.orderStatus == 'Pending'}">
                                    <c:set var="statusClass" value="status-pending"/>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Đang xử lý' or order.orderStatus == 'Processing'}">
                                    <c:set var="statusClass" value="status-processing"/>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Đang giao' or order.orderStatus == 'Shipping'}">
                                    <c:set var="statusClass" value="status-shipping"/>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Đã giao' or order.orderStatus == 'Delivered'}">
                                    <c:set var="statusClass" value="status-delivered"/>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Đã hủy' or order.orderStatus == 'Cancelled'}">
                                    <c:set var="statusClass" value="status-cancelled"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-shopping-bag"></i>
                            <p>Bạn chưa có đơn hàng nào</p>
                            <a href="${pageContext.request.contextPath}/shop" class="btn-shop">Mua sắm ngay</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%--
                Sản phẩm yêu thích gần đây — listWishlist: List<WishlistItem> (join product)
                Mapping từ bảng wishlist_item JOIN product:
                  wishlistItem.product.name         → tên sản phẩm (product.name)
                  wishlistItem.product.finalPrice   → giá sau giảm (product.final_price)
                  wishlistItem.product.price         → giá gốc (product.price)
                  wishlistItem.product.discountPercent → % giảm (product.discount_percent)
                  wishlistItem.product.imgUrl (từ bảng product_image hoặc field riêng)
                Lấy 5 sản phẩm gần nhất: ORDER BY wishlist_item.CreateAt DESC LIMIT 5
            --%>
            <div class="wishlist-card">
                <div class="card-header">
                    <h3><i class="fas fa-heart"></i> Yêu thích gần đây</h3>
                    <a href="${pageContext.request.contextPath}/favorites" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
                </div>

                <c:choose>
                    <c:when test="${not empty listWishlist}">
                        <c:forEach var="item" items="${listWishlist}">
                            <div class="wishlist-item">
                                <img
                                        src="${not empty item.product.imgUrl ? pageContext.request.contextPath.concat('/').concat(item.product.imgUrl) : pageContext.request.contextPath.concat('/images/no-image.png')}"
                                        alt="${item.product.name}"
                                        class="wishlist-img"
                                        onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'"
                                />
                                <div class="wishlist-info">
                                    <div class="wishlist-name" title="${item.product.name}">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}" style="color:inherit;text-decoration:none;">
                                                ${item.product.name}
                                        </a>
                                    </div>
                                    <div class="wishlist-price">
                                        <c:choose>
                                            <c:when test="${item.product.discountPercent > 0}">
                                                <span class="final">
                                                    <fmt:formatNumber value="${item.product.finalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                                <span class="original">
                                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                                <span class="badge-disc">-<fmt:formatNumber value="${item.product.discountPercent}" maxFractionDigits="0"/>%</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="final">
                                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-heart"></i>
                            <p>Chưa có sản phẩm yêu thích nào</p>
                            <a href="${pageContext.request.contextPath}/shop" class="btn-shop">Khám phá ngay</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions-card">
            <div class="card-header">
                <h3><i class="fas fa-bolt"></i> Thao tác nhanh</h3>
            </div>
            <div class="actions-grid">
                <a href="${pageContext.request.contextPath}/shop" class="action-btn">
                    <i class="fas fa-store"></i>
                    <span>Tiếp tục mua sắm</span>
                </a>
                <a href="${pageContext.request.contextPath}/cart" class="action-btn">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Xem giỏ hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/order" class="action-btn">
                    <i class="fas fa-truck"></i>
                    <span>Theo dõi đơn hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/favorites" class="action-btn">
                    <i class="fas fa-heart"></i>
                    <span>Sản phẩm yêu thích</span>
                </a>
            </div>
        </div>
    </div><!-- end main-content -->
</div><!-- end dashboard-wrapper -->

<%@ include file="/common/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
