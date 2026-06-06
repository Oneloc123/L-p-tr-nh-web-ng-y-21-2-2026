cat > /mnt/user-data/outputs/order-detail.jsp << 'ENDOFFILE'
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết đơn hàng - LUXCAR</title>

    <%@ include file="/common/header.jsp" %>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar (Giống dashboard/profile) */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: #000000; color: #ffffff; padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: #ffffff; text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333333; color: #ffffff; }
        .menu-item.active { background-color: #ffffff; color: #000000; }
        .menu-item.active i { color: #000000; }
        .menu-divider { height: 1px; background-color: #333333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; background-color: #f8f9fa; min-height: 100vh; }
        .content-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 28px; }
        .content-header h1 { font-size: 28px; font-weight: 600; color: #000000; margin-bottom: 10px; }
        .breadcrumb { list-style: none; display: flex; align-items: center; gap: 5px; padding: 0; margin: 0; background: none; }
        .breadcrumb-item a { color: #666; text-decoration: none; font-size: 13px; }
        .breadcrumb-item a:hover { color: #000; }
        .breadcrumb-item.active { color: #000; font-weight: 500; font-size: 13px; }
        .breadcrumb-item i { color: #ccc; font-size: 9px; }

        /* Status badge */
        .status-badge {
            padding: 7px 16px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .status-pending  { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .status-shipping { background: #e0f2fe; color: #0284c7; border: 1px solid #bae6fd; }
        .status-completed{ background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .status-cancelled{ background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        /* Info Cards (profile-card style) */
        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 18px;
            margin-bottom: 22px;
        }
        .info-card {
            background: #fff;
            border-radius: 12px;
            padding: 22px 24px;
            border: 1px solid #eee;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .info-card h4 {
            font-size: 11px;
            font-weight: 700;
            color: #000;
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 2px solid #000;
            display: flex;
            align-items: center;
            gap: 8px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        .info-row {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 11px;
            font-size: 14px;
            color: #555;
        }
        .info-row i { color: #000; margin-top: 2px; width: 15px; flex-shrink: 0; }
        .info-row span { line-height: 1.55; flex: 1; }
        .info-row strong { color: #000; font-weight: 600; }

        /* Table Card */
        .order-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #eee;
            overflow: hidden;
            margin-bottom: 22px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .lux-table { width: 100%; border-collapse: collapse; }
        .lux-table thead tr { background: #000; }
        .lux-table th {
            padding: 15px 20px;
            text-align: left;
            font-size: 11px;
            font-weight: 700;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }
        .lux-table td {
            padding: 18px 20px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
            font-size: 14px;
            color: #555;
        }
        .lux-table tbody tr:last-child td { border-bottom: none; }
        .lux-table tbody tr:hover { background: #f8f9fa; }

        .product-col { display: flex; align-items: center; gap: 14px; }
        .product-img {
            width: 56px; height: 56px; background: #f0f0f0;
            border-radius: 8px; overflow: hidden; flex-shrink: 0;
            display: flex; align-items: center; justify-content: center;
        }
        .product-img img { width:100%; height:100%; object-fit:cover; }
        .product-name { font-weight: 700; color: #000; font-size: 14px; margin-bottom: 4px; }
        .product-meta { font-size: 12px; color: #999; }
        .price-cell { color: #555; }
        .total-cell { font-weight: 700; color: #22c55e; font-size: 14px; }

        /* Summary */
        .order-summary {
            padding: 22px 24px 26px;
            background: #fafafa;
            border-top: 2px solid #000;
            display: flex;
            justify-content: flex-end;
        }
        .summary-inner { width: 320px; }
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            font-size: 14px;
            color: #666;
            padding: 3px 0;
        }
        .summary-row.total {
            margin-top: 14px;
            padding-top: 14px;
            border-top: 1px dashed #ddd;
            font-size: 16px;
            color: #000;
            font-weight: 700;
        }
        .summary-row.total .total-val {
            font-size: 22px;
            font-weight: 700;
            color: #22c55e;
        }

        /* Back button */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 22px;
            background: #fff;
            border: 1.5px solid #000;
            color: #000;
            border-radius: 7px;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            transition: all 0.22s;
        }
        .btn-back:hover {
            background: #000;
            color: #fff;
        }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f1f1f1; }
        ::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <%-- SIDEBAR --%>
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">
                <i class="fas fa-chart-pie"></i><span>Bảng điều khiển</span>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                <i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item">
                <i class="fas fa-user-edit"></i><span>Chỉnh sửa thông tin</span>
            </a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item">
                <i class="fas fa-lock"></i><span>Đổi mật khẩu</span>
            </a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item active">
                <i class="fas fa-shopping-bag"></i><span>Đơn hàng của tôi</span>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item">
                <i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item">
                <i class="fas fa-heart"></i><span>Sản phẩm yêu thích</span>
            </a>
            <a href="${pageContext.request.contextPath}/notifications" class="menu-item">
                <i class="fas fa-bell"></i><span>Thông báo</span>
            </a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <%-- MAIN CONTENT --%>
    <div class="main-content">

        <div class="content-header">
            <div>
                <h1>Chi tiết đơn hàng #${order.id}</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                            <i class="fas fa-chevron-right"></i>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/order">Đơn hàng</a>
                            <i class="fas fa-chevron-right"></i>
                        </li>
                        <li class="breadcrumb-item active">Chi tiết #${order.id}</li>
                    </ol>
                </nav>
            </div>

            <div>
                <c:choose>
                    <c:when test="${order.orderStatus == 'PENDING'}">
                        <span class="status-badge status-pending">
                            <i class="fas fa-clock"></i> Chờ xác nhận
                        </span>
                    </c:when>
                    <c:when test="${order.orderStatus == 'SHIPPING' || fn:contains(order.orderStatus, 'Đang vận chuyển')}">
                        <span class="status-badge status-shipping">
                            <i class="fas fa-truck"></i> Đang giao hàng
                        </span>
                    </c:when>
                    <c:when test="${order.orderStatus == 'COMPLETED'}">
                        <span class="status-badge status-completed">
                            <i class="fas fa-check-circle"></i> Đã giao thành công
                        </span>
                    </c:when>
                    <c:when test="${order.orderStatus == 'CANCELLED'}">
                        <span class="status-badge status-cancelled">
                            <i class="fas fa-times-circle"></i> Đã hủy
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-pending">
                            <i class="fas fa-info-circle"></i> ${order.orderStatus}
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- INFO CARDS --%>
        <div class="order-info-grid">
            <div class="info-card">
                <h4><i class="fas fa-map-marker-alt"></i> Thông tin nhận hàng</h4>

                <div class="info-row">
                    <i class="fas fa-map"></i>
                    <span>${order.shippingAddress}</span>
                </div>
            </div>

            <div class="info-card">
                <h4><i class="fas fa-money-check-alt"></i> Thanh toán &amp; Vận chuyển</h4>
                <div class="info-row">
                    <i class="fas fa-credit-card"></i>
                    <span>Phương thức: <strong>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'COD'}">Thanh toán khi nhận hàng (COD)</c:when>
                            <c:otherwise>Chuyển khoản ngân hàng</c:otherwise>
                        </c:choose>
                    </strong></span>
                </div>
                <div class="info-row">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                </div>
                <div class="info-row">
                    <i class="fas fa-truck"></i>
                    <span>Đơn vị vận chuyển: <strong>LUXCAR Express (Miễn phí)</strong></span>
                </div>
            </div>
        </div>

        <%-- TABLE --%>
        <div class="order-card">
            <div style="overflow-x:auto;">
                <table class="lux-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th style="text-align:center;">Đơn giá</th>
                            <th style="text-align:center;">Số lượng</th>
                            <th style="text-align:right; padding-right:24px;">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.items}">
                            <tr>
                                <td>
                                    <div class="product-col">
                                        <div class="product-img">
                                            <img src="https://placehold.co/100?text=LUXCAR" alt="${item.product.name}">
                                        </div>
                                        <div>
                                            <div class="product-name">${item.product.name}</div>
                                            <div class="product-meta">ID: LUX-${item.productId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="price-cell" style="text-align:center;">
                                    <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> &#8363;
                                </td>
                                <td style="text-align:center; color:#777;">
                                    ${item.quantity}
                                </td>
                                <td class="total-cell" style="text-align:right; padding-right:24px;">
                                    <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/> &#8363;
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="order-summary">
                <div class="summary-inner">
                    <div class="summary-row">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${order.totalAmount - order.shippingFee}" type="number" groupingUsed="true"/> &#8363;</span>
                    </div>
                    <div class="summary-row">
                        <span>Phí vận chuyển:</span>
                        <span style="color:var(--green); font-weight:600;">Miễn phí</span>
                    </div>
                    <div class="summary-row total">
                        <span>Tổng cộng:</span>
                        <span class="total-val">
                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> &#8363;
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/order" class="btn-back">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách đơn hàng
            </a>
        </div>

    </div>
</div>
</body>
</html>


