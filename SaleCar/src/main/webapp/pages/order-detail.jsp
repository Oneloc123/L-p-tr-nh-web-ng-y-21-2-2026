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

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>
        /* ================= STATUS BADGE ================= */
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
        .status-pending  { background: rgba(255,193,7,0.12); color: #ffc107; border: 1px solid rgba(255,193,7,0.2); }
        .status-shipping { background: rgba(52,152,219,0.12); color: #3498db; border: 1px solid rgba(52,152,219,0.2); }
        .status-completed{ background: rgba(46,204,113,0.12); color: #2ecc71; border: 1px solid rgba(46,204,113,0.2); }
        .status-cancelled{ background: rgba(231,76,60,0.12); color: #e74c3c; border: 1px solid rgba(231,76,60,0.2); }

        /* ================= INFO CARDS ================= */
        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 18px;
            margin-bottom: 22px;
        }
        .info-card {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            padding: 22px 24px;
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
            transition: all var(--transition-base);
        }
        .info-card:hover {
            border-color: var(--border-gold);
            transform: translateY(-2px);
            box-shadow: var(--shadow-card-hover);
        }
        .info-card h4 {
            font-size: 11px;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(212,175,55,0.2);
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
            color: var(--text-secondary);
        }
        .info-row i { color: var(--gold); margin-top: 2px; width: 15px; flex-shrink: 0; }
        .info-row span { line-height: 1.55; flex: 1; }
        .info-row strong { color: var(--text-primary); font-weight: 600; }

        /* ================= TABLE CARD ================= */
        .order-card {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-subtle);
            overflow: hidden;
            margin-bottom: 22px;
            box-shadow: var(--shadow-card);
            transition: all var(--transition-base);
        }
        .order-card:hover { border-color: var(--border-gold); box-shadow: var(--shadow-card-hover); }

        .lux-table { width: 100%; border-collapse: collapse; }
        .lux-table thead tr { background: #0a0a0a; }
        .lux-table th {
            padding: 15px 20px;
            text-align: left;
            font-size: 11px;
            font-weight: 700;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            border-bottom: 1px solid var(--border-subtle);
        }
        .lux-table td {
            padding: 18px 20px;
            border-bottom: 1px solid var(--border-subtle);
            vertical-align: middle;
            font-size: 14px;
            color: var(--text-secondary);
            background: var(--bg-surface);
        }
        .lux-table tbody tr:last-child td { border-bottom: none; }
        .lux-table tbody tr:hover td { background: var(--bg-elevated); }

        .product-img {
            width: 56px; height: 56px;
            background: var(--bg-elevated);
            border-radius: var(--radius-sm);
            overflow: hidden; flex-shrink: 0;
            display: flex; align-items: center; justify-content: center;
            border: 1px solid var(--border-subtle);
        }
        .product-img img { width:100%; height:100%; object-fit:cover; }
        .product-name { font-weight: 700; color: var(--text-primary); font-size: 14px; margin-bottom: 4px; }
        .product-meta { font-size: 12px; color: var(--text-muted); }
        .price-cell { color: var(--text-secondary); }
        .total-cell { font-weight: 700; color: var(--gold); font-size: 14px; }

        .product-link {
            text-decoration: none;
            color: inherit;
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .product-link:hover .product-name { color: var(--gold); }

        /* ================= SUMMARY ================= */
        .order-summary {
            padding: 22px 24px 26px;
            background: var(--bg-elevated);
            border-top: 1px solid var(--border-subtle);
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
            color: var(--text-muted);
            padding: 3px 0;
        }
        .summary-row.total {
            margin-top: 14px;
            padding-top: 14px;
            border-top: 1px dashed var(--border-gold);
            font-size: 16px;
            color: var(--text-primary);
            font-weight: 700;
        }
        .summary-row.total .total-val {
            font-size: 22px;
            font-weight: 700;
            color: var(--gold);
            font-family: 'Playfair Display', serif;
        }

        /* ================= BACK BUTTON ================= */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background: transparent;
            border: 1.5px solid var(--border-gold);
            color: var(--gold);
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            transition: all var(--transition-base);
        }
        .btn-back:hover {
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(212,175,55,0.2);
        }

        /* ================= OVERRIDES ================= */
        .main-content { flex: 1; padding: 30px 40px; background: var(--bg-primary); min-height: 100vh; }
        .content-header h1 { font-family: 'Playfair Display', serif; }
        .btn-success {
            background: rgba(34,197,94,0.12) !important;
            border: 1px solid rgba(34,197,94,0.2) !important;
            color: #22c55e !important;
            border-radius: 20px !important;
            padding: 8px 20px !important;
            font-weight: 600 !important;
        }
        .btn-success:hover {
            background: rgba(34,197,94,0.2) !important;
            color: #22c55e !important;
        }
        .breadcrumb-item i { color: var(--text-muted); font-size: 9px; }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <!-- Sidebar chung -->
    <%@ include file="/common/user-sidebar.jsp" %>

    <%-- MAIN CONTENT --%>
    <div class="main-content">

        <div class="content-header">
            <div>
                <h1>Chi tiết đơn hàng #${order.id}</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                            <i class="bi bi-chevron-right"></i>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/order">Đơn hàng</a>
                            <i class="bi bi-chevron-right"></i>
                        </li>
                        <li class="breadcrumb-item active">Chi tiết #${order.id}</li>
                    </ol>
                </nav>
            </div>

            <div>
                <c:choose>
                    <c:when test="${order.orderStatus == 'PENDING'}">
                        <span class="status-badge status-pending">
                            <i class="bi bi-clock"></i> Chờ xác nhận
                        </span>
                    </c:when>
                    <c:when test="${order.orderStatus == 'SHIPPING' || fn:contains(order.orderStatus, 'Đang vận chuyển')}">
                        <span class="status-badge status-shipping">
                            <i class="bi bi-truck"></i> Đang giao hàng
                        </span>
                        <div style="margin-top:12px;">
                            <form action="${pageContext.request.contextPath}/confirm-received" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="${order.id}">
                                <button type="submit" class="btn btn-success btn-sm"
                                        style="border-radius:20px; padding:8px 20px; font-weight:600;
                                               background:#22c55e; border-color:#22c55e;"
                                        onclick="return confirm('Bạn xác nhận đã nhận được hàng?')">
                                    <i class="bi bi-check-circle-fill"></i> Đã nhận được hàng
                                </button>
                            </form>
                        </div>
                    </c:when>
                    <c:when test="${order.orderStatus == 'COMPLETED'}">
                        <span class="status-badge status-completed">
                            <i class="bi bi-check-circle-fill"></i> Đã giao thành công
                        </span>
                    </c:when>
                    <c:when test="${order.orderStatus == 'CANCELLED'}">
                        <span class="status-badge status-cancelled">
                            <i class="bi bi-x-circle-fill"></i> Đã hủy
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-pending">
                            <i class="bi bi-info-circle-fill"></i> ${order.orderStatus}
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- INFO CARDS --%>
        <div class="order-info-grid">
            <div class="info-card">
                <h4><i class="bi bi-geo-alt-fill"></i> Thông tin nhận hàng</h4>

                <div class="info-row">
                    <i class="bi bi-geo-alt"></i>
                    <span>${order.shippingAddress}</span>
                </div>
                <c:if test="${not empty order.note}">
                <div class="info-row">
                    <i class="bi bi-sticky"></i>
                    <span>Ghi chú: <strong>${order.note}</strong></span>
                </div>
                </c:if>
            </div>

            <div class="info-card">
                <h4><i class="bi bi-credit-card-2-front"></i> Thanh toán &amp; Vận chuyển</h4>
                <div class="info-row">
                    <i class="bi bi-credit-card"></i>
                    <span>Phương thức: <strong>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'COD'}">Thanh toán khi nhận hàng (COD)</c:when>
                            <c:otherwise>Chuyển khoản ngân hàng</c:otherwise>
                        </c:choose>
                    </strong></span>
                </div>
                <div class="info-row">
                    <i class="bi bi-calendar3"></i>
                    <span>Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                </div>
                <div class="info-row">
                    <i class="bi bi-truck"></i>
                    <span>Phí vận chuyển: 
                        <strong>
                            <c:choose>
                                <c:when test="${order.shippingFee > 0}">
                                    <fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true"/> &#8363;
                                </c:when>
                                <c:otherwise>
                                    Miễn phí
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </span>
                </div>
                <c:if test="${not empty order.shippingMethod}">
                <div class="info-row">
                    <i class="bi bi-truck"></i>
                    <span>Phương thức giao hàng: <strong>${order.shippingMethod}</strong></span>
                </div>
                </c:if>
                <%-- Tính toán ngày giao dự kiến từ ngày đặt hàng --%>
                <c:if test="${!fn:contains(order.orderStatus, 'Đã huỷ') && !fn:contains(order.orderStatus, 'Đã hủy') && order.orderStatus != 'CANCELLED' && !fn:contains(order.orderStatus, 'Đã giao') && order.orderStatus != 'DELIVERED' && order.orderStatus != 'COMPLETED'}">
                <%
                    code.salecar.model.Order ord = (code.salecar.model.Order) pageContext.findAttribute("order");
                    if (ord != null && ord.getOrderDate() != null) {
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        cal.setTime(ord.getOrderDate());
                        cal.add(java.util.Calendar.DAY_OF_MONTH, 5);
                        pageContext.setAttribute("estFrom", cal.getTime());
                        cal.add(java.util.Calendar.DAY_OF_MONTH, 3);
                        pageContext.setAttribute("estTo", cal.getTime());
                    }
                %>
                <div class="info-row">
                    <i class="bi bi-clock"></i>
                    <span>Nhận hàng dự kiến:
                        <strong>
                            <c:choose>
                                <c:when test="${fn:contains(order.orderStatus, 'SHIPPING') || fn:contains(order.orderStatus, 'Đang vận chuyển')}">
                                    <fmt:formatDate value="${estFrom}" pattern="dd/MM"/> – <fmt:formatDate value="${estTo}" pattern="dd/MM/yyyy"/>
                                    <span style="color:#0284c7; font-size:12px; font-weight:400;">(Đang giao)</span>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatDate value="${estFrom}" pattern="dd/MM"/> – <fmt:formatDate value="${estTo}" pattern="dd/MM/yyyy"/>
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </span>
                </div>
                </c:if>
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
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}"
                                       class="product-link">
                                        <div class="product-img">
                                            <img src="${not empty item.imageUrl ? pageContext.request.contextPath.concat('/uploads/').concat(item.imageUrl) : 'https://placehold.co/100?text=LUXCAR'}"
                                                 alt="${item.product.name}"
                                                 onerror="this.src='https://placehold.co/100?text=LUXCAR'">
                                        </div>
                                        <div>
                                            <div class="product-name">${item.product.name}</div>
                                            <div class="product-meta">ID: LUX-${item.productId}</div>
                                        </div>
                                    </a>
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
                    <%-- Tính tạm tính = tổng tiền - phí ship --%>
                    <c:set var="subtotal" value="${order.totalAmount - order.shippingFee}" />
                    <div class="summary-row">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/> &#8363;</span>
                    </div>
                    <div class="summary-row">
                        <span>Phí vận chuyển:</span>
                        <span style="font-weight:600;">
                            <c:choose>
                                <c:when test="${order.shippingFee > 0}">
                                    <fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true"/> &#8363;
                                </c:when>
                                <c:otherwise>
                                    <span style="color:var(--green);">Miễn phí</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
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
                <i class="bi bi-arrow-left"></i> Quay lại danh sách đơn hàng
            </a>
        </div>

    </div>
</div>
</body>
</html>
