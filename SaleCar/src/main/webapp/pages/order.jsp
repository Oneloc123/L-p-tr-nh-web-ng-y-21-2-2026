<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đơn hàng của tôi - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --gold: #C9A84C;
            --gold-light: #E8C96A;
            --gold-dim: rgba(201, 168, 76, 0.15);
            --black: #000000;
            --black-hover: #222222;
            --white: #ffffff;

            /* Màu nền cho Light Theme */
            --bg-body: #f8f9fa;
            --bg-card: #ffffff;
            --bg-header: #fafafa;

            /* Màu chữ và viền */
            --border-color: #eeeeee;
            --text-main: #111111;
            --text-muted: #666666;

            /* Màu trạng thái & tiền */
            --red: #d9534f;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Jost', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            min-height: 100vh;
        }

        /* ===== SIDEBAR (Giữ nguyên Đen - Vàng) ===== */
        .profile-wrapper {
            display: flex;
            align-items: flex-start;
            min-height: 100vh;
        }

        .sidebar-menu {
            width: 270px;
            background-color: var(--black);
            color: var(--white);
            padding: 35px 0;
            position: sticky;
            top: 0;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            flex-shrink: 0;
        }

        .sidebar-brand {
            padding: 0 25px 30px;
            border-bottom: 1px solid #333;
            margin-bottom: 10px;
        }

        .sidebar-brand .brand-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: 3px;
            color: var(--white);
        }

        .sidebar-brand .brand-name span { color: var(--gold); }

        .sidebar-brand .brand-sub {
            font-size: 11px;
            color: #999;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-top: 3px;
        }

        .menu-items { padding: 10px 0; }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 13px 25px;
            color: #aaa;
            text-decoration: none;
            transition: all 0.25s ease;
            margin: 3px 12px;
            border-radius: 6px;
        }

        .menu-item i { width: 22px; margin-right: 12px; font-size: 16px; }
        .menu-item span { font-size: 14px; font-weight: 400; letter-spacing: 0.3px; }

        .menu-item:hover {
            background-color: var(--black-hover);
            color: var(--white);
        }

        .menu-item.active {
            background-color: var(--white);
            color: var(--black);
        }
        .menu-item.active i { color: var(--black); }

        .menu-divider {
            height: 1px;
            background: #333;
            margin: 12px 20px;
        }

        /* ===== MAIN CONTENT ===== */
        .main-content {
            flex: 1;
            padding: 40px 35px;
            background-color: var(--bg-body);
            min-height: 100vh;
        }

        /* Header */
        .content-header { margin-bottom: 32px; }

        .content-header h1 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 32px;
            font-weight: 600;
            color: var(--text-main);
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .breadcrumb {
            background: none;
            padding: 0;
            margin: 0;
            list-style: none;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .breadcrumb-item a {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 13px;
            transition: color 0.2s;
        }

        .breadcrumb-item a:hover { color: var(--black); }
        .breadcrumb-item.active { color: var(--black); font-size: 13px; font-weight: 600;}
        .breadcrumb-item i { color: #ccc; font-size: 9px; }

        /* ===== ORDER TABS ===== */
        .order-tabs {
            display: flex;
            background: var(--bg-card);
            border-radius: 8px;
            margin-bottom: 28px;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
            overflow: hidden;
        }

        .order-tab {
            flex: 1;
            text-align: center;
            padding: 15px 0;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-muted);
            border-bottom: 2px solid transparent;
            transition: all 0.25s ease;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .order-tab:hover {
            color: var(--text-main);
            background: #fafafa;
        }

        .order-tab.active {
            color: var(--black);
            border-bottom-color: var(--black);
            background: var(--bg-card);
            font-weight: 600;
        }

        /* ===== ORDER CARD ===== */
        .order-card {
            background: var(--bg-card);
            border-radius: 10px;
            border: 1px solid var(--border-color);
            overflow: hidden;
            margin-bottom: 24px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(0,0,0,0.03);
        }

        .order-card:hover {
            border-color: var(--black);
            box-shadow: 0 8px 30px rgba(0,0,0,0.06);
        }

        /* Order Header */
        .order-header {
            background: var(--bg-header);
            padding: 18px 28px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .order-id-date .id {
            font-family: 'Cormorant Garamond', serif;
            font-size: 20px;
            font-weight: 700;
            color: var(--black);
            display: block;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .order-id-date .date {
            font-size: 12px;
            color: var(--text-muted);
            letter-spacing: 0.3px;
        }

        .order-id-date .date i { margin-right: 5px; color: var(--black); }

        .order-header-right {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 8px;
        }

        /* Status badges */
        .order-status {
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-processing { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .status-completed { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .status-cancelled { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .status-confirmed { background: #cce5ff; color: #004085; border: 1px solid #b8daff; }

        /* Reorder button */
        .btn-reorder {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border: 1px solid var(--black);
            color: var(--black);
            background: transparent;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.25s;
            letter-spacing: 0.3px;
            font-family: 'Jost', sans-serif;
        }

        .btn-reorder:hover {
            background: var(--black);
            color: var(--gold);
        }

        /* Cancel button */
        .btn-cancel-order {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border: 1px solid #dc3545;
            color: #dc3545;
            background: transparent;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.25s;
            letter-spacing: 0.3px;
            font-family: 'Jost', sans-serif;
        }

        .btn-cancel-order:hover {
            background: #dc3545;
            color: var(--white);
        }

        /* Info grid */
        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0;
            padding: 20px 28px;
            border-bottom: 1px solid var(--border-color);
            background: var(--bg-card);
        }

        .info-block h4 {
            font-size: 11px;
            text-transform: uppercase;
            color: var(--black);
            margin-bottom: 8px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .info-block p {
            font-size: 13px;
            color: var(--text-muted);
            line-height: 1.6;
            margin: 0;
        }

        .info-block i { margin-right: 6px; color: var(--gold); }

        /* Order items table */
        .order-items-wrapper { padding: 0 28px 20px; }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .order-table th {
            padding: 10px 0;
            border-bottom: 2px solid var(--black);
            text-align: left;
            font-size: 11px;
            color: var(--black);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }

        .order-table td {
            padding: 16px 0;
            border-bottom: 1px dashed #eee;
            vertical-align: middle;
            font-size: 14px;
        }

        .item-name { font-weight: 500; color: var(--text-main); }
        .item-price { color: var(--text-main); font-weight: 500;}

        .item-total {
            font-weight: 700;
            color: var(--red);
            text-align: right;
        }

        .col-right { text-align: right; }
        .col-center { text-align: center; }

        /* Order footer */
        .order-footer {
            padding: 18px 28px;
            background: var(--bg-header);
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-detail {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 9px 20px;
            background: transparent;
            border: 1px solid var(--black);
            color: var(--black);
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            font-size: 13px;
            transition: all 0.25s;
            letter-spacing: 0.3px;
        }

        .btn-detail:hover {
            background: var(--black);
            color: var(--gold);
        }

        .total-amount-label {
            font-size: 13px;
            color: var(--text-muted);
            margin-right: 12px;
        }

         .total-amount-value {
            font-family: 'Jost', sans-serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--red);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 70px 30px;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
            display: block;
        }

        .empty-state h4 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 22px;
            color: var(--black);
            margin-bottom: 20px;
        }

        .btn-shop {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 28px;
            background: var(--black);
            color: var(--white);
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.5px;
            transition: all 0.25s;
        }

        .btn-shop:hover { background: var(--gold); }

        /* ===== MODAL ===== */
        .modal-content {
            background: var(--bg-card) !important;
            border: none !important;
            border-radius: 10px !important;
            color: var(--text-main);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .modal-header {
            border-bottom: 1px solid var(--border-color) !important;
            padding: 20px 25px !important;
        }

        .modal-title {
            color: #dc3545 !important;
            font-family: 'Cormorant Garamond', serif;
            font-size: 20px !important;
            font-weight: 600;
        }

        .btn-close { filter: none !important; opacity: 0.5 !important; }

        .modal-body p { color: var(--text-main); font-size: 15px;}
        .modal-body p strong { color: var(--black); }

        .modal-body label {
            color: var(--text-muted) !important;
            font-size: 13px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-weight: 600;
        }

        .form-select {
            background: #fff !important;
            border: 1px solid #ccc !important;
            color: var(--text-main) !important;
            border-radius: 6px !important;
        }

        .form-select:focus {
            border-color: var(--black) !important;
            box-shadow: 0 0 0 3px rgba(0,0,0,0.1) !important;
        }

        .modal-footer { border-top: none !important; padding: 15px 25px 20px !important; gap: 10px; }

        .btn-keep {
            padding: 9px 20px;
            background: transparent;
            border: 1px solid #ccc;
            color: var(--text-muted);
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            transition: 0.25s;
            font-weight: 500;
        }

        .btn-keep:hover { border-color: var(--black); color: var(--black); }

        .btn-confirm-cancel {
            padding: 9px 22px;
            background: #dc3545;
            border: 1px solid #dc3545;
            color: #fff;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.25s;
        }

        .btn-confirm-cancel:hover { background: #c82333; border-color: #bd2130; }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f1f1f1; }
        ::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--gold); }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <%-- SIDEBAR --%>
    <div class="sidebar-menu">
        <div class="sidebar-brand">
            <div class="brand-name">LUX<span>CAR</span></div>
            <div class="brand-sub">Mô hình xe cao cấp</div>
        </div>

        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">

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
            <a href="${pageContext.request.contextPath}/order" class="menu-item active">
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
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>


    <%-- MAIN CONTENT --%>
    <div class="main-content">
        <div class="content-header">
            <h1>Lịch sử đơn hàng</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">

                        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                        <i class="fas fa-chevron-right"></i>
                    </li>
                    <li class="breadcrumb-item">

                        <a href="${pageContext.request.contextPath}/profile">Tài khoản</a>
                        <i class="fas fa-chevron-right"></i>
                    </li>
                    <li class="breadcrumb-item active">Đơn hàng của tôi</li>
                </ol>

             </nav>
        </div>

        <%-- STATUS TABS --%>
        <div class="order-tabs">
            <div class="order-tab active" onclick="filterOrders('all', this)">Tất cả</div>
            <div class="order-tab" onclick="filterOrders('pending', this)">Đang xử lý</div>
            <div class="order-tab" onclick="filterOrders('completed', this)">Đã Giao</div>
            <div class="order-tab" onclick="filterOrders('cancelled', this)">Đã huỷ</div>

        </div>

        <%-- ORDER LIST --%>
        <c:forEach var="order" items="${orders}">

            <c:set var="statusCategory" value="pending" />

            <c:if test="${fn:contains(order.orderStatus, 'Đã huỷ') ||
 fn:contains(order.orderStatus, 'Đã hủy') || order.orderStatus == 'CANCELLED'}">
                <c:set var="statusCategory" value="cancelled" />
            </c:if>

            <c:if test="${fn:contains(order.orderStatus, 'Đã giao') ||
 fn:contains(order.orderStatus, 'Thành công') || order.orderStatus == 'DELIVERED'}">
                <c:set var="statusCategory" value="completed" />
            </c:if>

            <div class="order-card order-item-card" data-status="${statusCategory}">

                <%-- ORDER HEADER --%>
                <div class="order-header">

                    <div class="order-id-date">
                        <span class="id">Đơn hàng #${order.id}</span>
                        <span class="date">
                            <i class="far fa-clock"></i>

                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>

                    <div class="order-header-right">

                        <c:choose>
                            <%-- HUỶ --%>
                            <c:when test="${statusCategory == 'cancelled'}">

                                <span class="order-status status-cancelled">
                                    <i class="fas fa-times-circle"></i> ${order.orderStatus}
                                </span>

                                <button type="button" class="btn-reorder" onclick="reOrder('${order.id}')">
                                    <i class="fas fa-redo"></i> Mua lại đơn này
                                </button>

                             </c:when>

                            <%-- ĐÃ GIAO --%>
                            <c:when test="${statusCategory == 'completed'}">

                                <span class="order-status status-completed">
                                    <i class="fas fa-check-circle"></i> ${order.orderStatus}
                                </span>

                                <button type="button" class="btn-reorder" onclick="reOrder('${order.id}')">
                                    <i class="fas fa-redo"></i> Mua lại lần nữa
                                </button>

                             </c:when>

                            <%-- XÁC NHẬN --%>
                            <c:when test="${order.orderStatus == 'CONFIRMED' ||
 fn:contains(order.orderStatus, 'Đã xác nhận')}">
                                <span class="order-status status-confirmed">
                                    <i class="fas fa-check-double"></i> ${order.orderStatus}

                                </span>
                            </c:when>

                            <%-- ĐANG XỬ LÝ --%>
                            <c:otherwise>

                                <span class="order-status status-processing">
                                    <i class="fas fa-spinner fa-spin"></i> ${order.orderStatus}

                                </span>
                                <c:if test="${order.orderStatus == 'Đang xử lý' ||
 order.orderStatus == 'PENDING'}">
                                    <button type="button" class="btn-cancel-order" onclick="openCancelModal('${order.id}')">
                                        <i class="fas fa-times"></i> Huỷ đơn hàng

                                     </button>
                                </c:if>
                            </c:otherwise>

                         </c:choose>
                    </div>
                </div>

                <%-- INFO GRID --%>
                <div class="order-info-grid">
                    <div class="info-block">

                        <h4>Thông tin giao hàng</h4>
                        <p><i class="fas fa-map-marker-alt"></i> ${order.shippingAddress}</p>
                    </div>
                    <div class="info-block">

                        <h4>Phương thức thanh toán</h4>
                        <p><i class="fas fa-credit-card"></i> ${order.paymentMethod}</p>
                    </div>
                </div>


                <%-- ITEMS TABLE --%>
                <div class="order-items-wrapper">
                    <table class="order-table">
                        <thead>
                            <tr>

                                 <th>Sản phẩm</th>
                                <th class="col-center">Số lượng</th>
                                <th class="col-center">Đơn giá</th>

                                 <th class="col-right">Thành tiền</th>
                            </tr>
                        </thead>

                    <tbody>
                            <c:forEach var="item" items="${order.items}">
                                <tr>

                                    <td class="item-name">${item.product.name}</td>
                                    <td class="col-center">${item.quantity}</td>
                                    <td class="col-center item-price">

                                        <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> ₫
                                    </td>
                                    <td class="item-total">

                                        <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/> ₫
                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>


                <%-- FOOTER --%>
                <div class="order-footer">
                    <a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" class="btn-detail">
                        <i class="fas fa-info-circle"></i> Xem chi tiết

                    </a>
                    <div>
                        <span class="total-amount-label">Tổng cộng:</span>
                        <span class="total-amount-value">

                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫
                        </span>
                    </div>
                </div>
            </div>
        </c:forEach>

        <%-- EMPTY STATE --%>

        <c:if test="${empty orders}">
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <h4>Bạn chưa có đơn hàng nào</h4>
                <a href="${pageContext.request.contextPath}/home" class="btn-shop">
                    <i class="fas fa-arrow-right"></i> Tiếp tục
 mua sắm
                </a>
            </div>
        </c:if>

    </div>
</div>

<%-- CANCEL MODAL --%>
<div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="cancel-order" method="POST">
                <div class="modal-header">

                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2" style="color: #dc3545;"></i>Xác nhận hủy đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                 </div>

                <div class="modal-body" style="padding: 25px;">
                    <p>Bạn có chắc muốn hủy đơn hàng <strong>#<span id="displayOrderId"></span></strong>?</p>
                    <input type="hidden" name="orderId" id="cancelOrderId" value="">
                    <div class="mt-4">
                        <label class="fw-bold mb-2 d-block">Vui lòng chọn lý do hủy:</label>
                        <select name="cancelReason" class="form-select" required>
                            <option value="">-- Chọn lý do --</option>

                             <option value="Tôi muốn thay đổi địa chỉ nhận hàng">Tôi muốn thay đổi địa chỉ nhận hàng</option>
                            <option value="Tôi muốn thay đổi sản phẩm/số lượng">Tôi muốn thay đổi sản phẩm/số lượng</option>

                            <option value="Tôi tìm thấy chỗ khác giá rẻ hơn">Tôi tìm thấy chỗ khác giá rẻ hơn</option>
                            <option value="Tôi đổi ý, không muốn mua nữa">Tôi đổi ý, không muốn mua nữa</option>
                            <option value="Lý do khác">Lý do khác</option>

                         </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-keep" data-bs-dismiss="modal">Không hủy nữa</button>

                    <button type="submit" class="btn-confirm-cancel">Đồng ý hủy đơn</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openCancelModal(orderId) {
        document.getElementById('displayOrderId').innerText = orderId;
        document.getElementById('cancelOrderId').value = orderId;
        let cancelModal = new bootstrap.Modal(document.getElementById('cancelOrderModal'));
        cancelModal.show();
    }

    function filterOrders(statusTarget, clickedTab) {
        document.querySelectorAll('.order-tab').forEach(tab => tab.classList.remove('active'));
        clickedTab.classList.add('active');

        document.querySelectorAll('.order-item-card').forEach(order => {
            const orderStatus = order.getAttribute('data-status');
            order.style.display = (statusTarget === 'all' || orderStatus === statusTarget) ? 'block' : 'none';
        });
    }

    function reOrder(orderId) {
        if (confirm('Bạn muốn mua lại đơn hàng #' + orderId + '?')) {
            window.location.href = '${pageContext.request.contextPath}/reorder?id=' + orderId;
        }
    }
</script>

</body>
</html>