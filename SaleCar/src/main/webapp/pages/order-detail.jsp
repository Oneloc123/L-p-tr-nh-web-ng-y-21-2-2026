cat > /mnt/user-data/outputs/order-detail.jsp << 'ENDOFFILE'
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết đơn hàng - LUXCAR</title>

    <%@ include file="/common/header.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Jost:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --gold:        #C9A84C;
            --gold-hover:  #E8C96A;
            --gold-dim:    rgba(201,168,76,0.13);
            --gold-border: rgba(201,168,76,0.35);
            --green:       #22c55e;
            --green-dim:   rgba(34,197,94,0.10);
            --black:       #000000;
            --bg:          #0c0c0c;
            --sidebar-bg:  #060606;
            --card-bg:     #ffffff;
            --card-header: #f7f6f3;
            --card-border: #e8e3d8;
            --text-dark:   #111111;
            --text-mid:    #555555;
            --text-light:  #999999;
            --white:       #ffffff;
        }

        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Jost', sans-serif;
            background: var(--bg);
            min-height: 100vh;
        }

        .profile-wrapper { display:flex; align-items:flex-start; min-height:100vh; }

        /* ── SIDEBAR ── */
        .sidebar-menu {
            width: 260px;
            background: var(--sidebar-bg);
            padding: 32px 0;
            position: sticky;
            top: 0;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            border-right: 1px solid rgba(201,168,76,0.18);
            flex-shrink: 0;
        }

        .sidebar-brand {
            padding: 0 24px 28px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
            margin-bottom: 8px;
        }

        .brand-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: 3px;
            color: var(--white);
        }

        .brand-name span { color: var(--gold); }

        .brand-sub {
            font-size: 10px;
            color: var(--text-light);
            letter-spacing: 2.5px;
            text-transform: uppercase;
            margin-top: 4px;
        }

        .menu-items { padding: 8px 0; }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 22px;
            color: #888;
            text-decoration: none;
            transition: all 0.22s;
            margin: 2px 10px;
            border-radius: 7px;
            border: 1px solid transparent;
        }

        .menu-item i { width: 20px; margin-right: 11px; font-size: 15px; }
        .menu-item span { font-size: 13.5px; font-weight: 400; }

        .menu-item:hover {
            background: rgba(255,255,255,0.05);
            color: var(--white);
            border-color: rgba(255,255,255,0.07);
        }

        .menu-item.active {
            background: var(--gold-dim);
            color: var(--gold);
            border-color: var(--gold-border);
        }

        .menu-item.active i { color: var(--gold); }
        .menu-divider { height:1px; background:rgba(255,255,255,0.06); margin:10px 18px; }

        /* ── MAIN ── */
        .main-content {
            flex: 1;
            padding: 38px 32px;
            background: var(--bg);
            min-height: 100vh;
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 28px;
        }

        .content-header h1 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--white);
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .breadcrumb {
            list-style: none;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 0;
            margin: 0;
            background: none;
        }

        .breadcrumb-item a { color: #666; text-decoration: none; font-size: 12px; transition: color 0.2s; }
        .breadcrumb-item a:hover { color: var(--gold); }
        .breadcrumb-item.active { color: var(--gold); font-size: 12px; }
        .breadcrumb-item i { color: #444; font-size: 8px; }

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

        .status-pending  { background:rgba(201,168,76,0.15); color:#92730a; border:1px solid rgba(201,168,76,0.4); }
        .status-shipping { background:rgba(59,130,246,0.10); color:#1e40af; border:1px solid rgba(59,130,246,0.3); }
        .status-completed{ background:var(--green-dim);      color:#166534; border:1px solid rgba(34,197,94,0.35);}
        .status-cancelled{ background:rgba(239,68,68,0.08);  color:#991b1b; border:1px solid rgba(239,68,68,0.3); }

        /* ── INFO CARDS ── */
        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 18px;
            margin-bottom: 22px;
        }

        .info-card {
            background: var(--card-bg);
            border-radius: 11px;
            padding: 22px 24px;
            border: 1px solid var(--card-border);
            box-shadow: 0 2px 12px rgba(0,0,0,0.18);
            transition: box-shadow 0.22s;
        }

        .info-card:hover { box-shadow: 0 4px 24px rgba(201,168,76,0.15); }

        .info-card h4 {
            font-size: 10px;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 1.5px solid rgba(201,168,76,0.25);
            display: flex;
            align-items: center;
            gap: 8px;
            letter-spacing: 1.8px;
            text-transform: uppercase;
        }

        .info-row {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 11px;
            font-size: 13.5px;
            color: var(--text-mid);
        }

        .info-row i { color: var(--gold); margin-top: 2px; width: 15px; flex-shrink: 0; }
        .info-row span { line-height: 1.55; flex: 1; }
        .info-row strong { color: var(--text-dark); font-weight: 600; }

        /* ── TABLE CARD ── */
        .order-card {
            background: var(--card-bg);
            border-radius: 11px;
            border: 1px solid var(--card-border);
            overflow: hidden;
            margin-bottom: 22px;
            box-shadow: 0 2px 14px rgba(0,0,0,0.2);
        }

        .lux-table { width: 100%; border-collapse: collapse; }

        .lux-table thead tr {
            background: var(--black);
            border-bottom: 2px solid var(--gold);
        }

        .lux-table th {
            padding: 15px 20px;
            text-align: left;
            font-size: 10.5px;
            font-weight: 700;
            color: var(--gold);
            text-transform: uppercase;
            letter-spacing: 1.8px;
        }

        .lux-table td {
            padding: 18px 20px;
            border-bottom: 1px solid #f0ede6;
            vertical-align: middle;
            font-size: 13.5px;
            color: var(--text-mid);
        }

        .lux-table tbody tr:last-child td { border-bottom: none; }
        .lux-table tbody tr { transition: background 0.18s; }
        .lux-table tbody tr:hover { background: #faf9f6; }

        .product-col { display: flex; align-items: center; gap: 14px; }

        .product-img {
            width: 56px;
            height: 56px;
            background: #f0ede6;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid #e0d9c8;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-img img { width:100%; height:100%; object-fit:cover; }

        .product-img-placeholder {
            font-family: 'Cormorant Garamond', serif;
            font-size: 9px;
            color: var(--gold);
            letter-spacing: 1px;
        }

        .product-name { font-weight: 700; color: var(--text-dark); font-size: 13.5px; margin-bottom: 4px; }
        .product-meta { font-size: 11.5px; color: var(--text-light); }

        .price-cell { color: var(--text-mid); }

        .total-cell {
            font-weight: 700;
            color: var(--green);
            font-size: 14px;
        }

        /* ── SUMMARY ── */
        .order-summary {
            padding: 22px 24px 26px;
            background: var(--card-header);
            border-top: 1.5px solid var(--gold);
            display: flex;
            justify-content: flex-end;
        }

        .summary-inner { width: 320px; }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            font-size: 13.5px;
            color: var(--text-mid);
            padding: 3px 0;
        }

        .summary-row.total {
            margin-top: 14px;
            padding-top: 14px;
            border-top: 1px dashed #d8d3c8;
            font-size: 15px;
            color: var(--text-dark);
            font-weight: 700;
        }

        .summary-row.total .total-val {
            font-family: 'Jost', sans-serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--green);
        }

        /* ── BACK BUTTON ── */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 22px;
            background: var(--white);
            border: 1.5px solid #d0cac0;
            color: var(--text-dark);
            border-radius: 7px;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            letter-spacing: 0.3px;
            transition: all 0.22s;
        }

        .btn-back:hover {
            background: var(--black);
            color: var(--white);
            border-color: var(--black);
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #111; }
        ::-webkit-scrollbar-thumb { background: #333; border-radius: 10px; }
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
                    <c:when test="${order.orderStatus == 'SHIPPING'}">
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
                    <i class="fas fa-phone"></i>
                    <span>${order.phone}</span>
                </div>
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
                        <span>Tạm tính (chưa trừ voucher):</span>
                        <span><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> &#8363;</span>
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


