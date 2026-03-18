<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đơn hàng của tôi - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar (Dùng chung) */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
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

        /* Order Card Styles */
        .order-card { background: #ffffff; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow: hidden; margin-bottom: 30px; border: 1px solid #eee; }

        /* Order Header - Thể hiện các thuộc tính cơ bản của Order.java */
        .order-header { background-color: #fafafa; padding: 20px 30px; border-bottom: 2px solid #000; display: flex; justify-content: space-between; align-items: center; }
        .order-id-date .id { font-size: 18px; font-weight: 700; color: #000; display: block; margin-bottom: 5px; }
        .order-id-date .date { font-size: 13px; color: #666; }
        .order-status { padding: 6px 15px; border-radius: 20px; font-size: 13px; font-weight: 600; }
        .status-processing { background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .status-completed { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }

        /* Order Info Grid - Address, Phone, PaymentMethod */
        .order-info-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; padding: 20px 30px; border-bottom: 1px solid #eee; }
        .info-block h4 { font-size: 12px; text-transform: uppercase; color: #999; margin-bottom: 8px; font-weight: 600; }
        .info-block p { font-size: 14px; color: #333; line-height: 1.5; margin: 0; }
        .info-block i { margin-right: 5px; color: #000; }

        /* Order Items Table - Thể hiện List<OrderItem> */
        .order-items-wrapper { padding: 0 30px 20px; }
        .order-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .order-table th { padding: 10px 0; border-bottom: 1px solid #eee; text-align: left; font-size: 13px; color: #666; text-transform: uppercase; }
        .order-table td { padding: 15px 0; border-bottom: 1px dashed #eee; vertical-align: middle; font-size: 15px; }
        .item-name { font-weight: 500; color: #000; }
        .item-price { color: #666; }
        .item-total { font-weight: 600; color: #000; text-align: right; }
        .col-right { text-align: right; }

        /* Order Footer - TotalAmount */
        .order-footer { padding: 20px 30px; background-color: #fcfcfc; text-align: right; }
        .total-amount-label { font-size: 16px; color: #666; margin-right: 15px; }
        .total-amount-value { font-size: 24px; font-weight: 700; color: #d9534f; }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <div class="sidebar-menu">

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
                <i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span>
            </a>

            <a href="${pageContext.request.contextPath}/favorites" class="menu-item">
                <i class="fas fa-heart"></i>
                <span>Sản phẩm yêu thích</span>
            </a>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/address-list" class="menu-item">
                <i class="fas fa-map-marker-alt"></i>
                <span>Sổ địa chỉ</span>
            </a>

            <a href="${pageContext.request.contextPath}/notifications" class="menu-item">
                <i class="fas fa-bell"></i>
                <span>Thông báo</span>
            </a>

            <a href="${pageContext.request.contextPath}/settings" class="menu-item">
                <i class="fas fa-cog"></i>
                <span>Cài đặt</span>
            </a>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/loggout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>



    <div class="main-content">
        <div class="content-header">
            <h1>Lịch sử đơn hàng</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> <i class="fas fa-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/profile.jsp">Tài khoản</a> <i class="fas fa-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item active">Đơn hàng của tôi</li>
                </ol>
            </nav>
        </div>

<c:forEach var="order" items="${orders}">
    <div class="order-card">
        <div class="order-header">
            <div class="order-id-date">
                <span class="id">Đơn hàng #${order.id}</span>
                <span class="date"><i class="far fa-clock"></i>
                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>

            <div class="order-status status-processing">
                <i class="fas fa-spinner fa-spin"></i> ${order.orderStatus}
            </div>
        </div> <div class="order-info-grid">
            <div class="info-block">
                <h4>Thông tin giao hàng (Shipping Info)</h4>
                <p><i class="fas fa-map-marker-alt"></i> ${order.shippingAddress}</p>
            </div>
            <div class="info-block">
                <h4>Phương thức thanh toán (Payment Method)</h4>
                <p><i class="fas fa-credit-card"></i> ${order.paymentMethod}</p>
            </div>
        </div>

        <div class="order-items-wrapper">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Sản phẩm (Product)</th>
                        <th style="text-align: center;">Số lượng (Qty)</th>
                        <th style="text-align: center;">Đơn giá (Price)</th>
                        <th class="col-right">Thành tiền (Total Price)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td class="item-name">${item.product.name}</td>
                            <td style="text-align: center;">${item.quantity}</td>
                            <td style="text-align: center;" class="item-price">
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

        <div class="order-footer">
            <span class="total-amount-label">Tổng cộng (Total Amount):</span>
            <span class="total-amount-value">
                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫
            </span>
        </div>
    </div>
</c:forEach>

<c:if test="${empty orders}">
    <div class="text-center py-5">
        <i class="fas fa-box-open" style="font-size: 60px; color: #ddd; margin-bottom: 20px;"></i>
        <h4 style="color: #666;">Bạn chưa có đơn hàng nào</h4>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-dark mt-3">Tiếp tục mua sắm</a>
    </div>
</c:if>

        </div>

    </div>
</div>
</body>
</html>