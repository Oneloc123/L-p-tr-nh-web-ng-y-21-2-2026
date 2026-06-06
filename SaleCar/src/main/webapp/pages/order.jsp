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

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>
        /* ================= ORDER TABS ================= */
        .order-tabs {
            display: flex;
            background: var(--bg-surface);
            border-radius: var(--radius-md);
            margin-bottom: 28px;
            border: 1px solid var(--border-subtle);
            overflow: hidden;
        }
        .order-tab {
            flex: 1;
            text-align: center;
            padding: 15px 0;
            cursor: pointer;
            font-size: 12px;
            font-weight: 500;
            color: var(--text-muted);
            border-bottom: 2px solid transparent;
            transition: all var(--transition-fast);
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .order-tab:hover { color: var(--text-primary); background: var(--bg-elevated); }
        .order-tab.active { color: var(--gold); border-bottom-color: var(--gold); background: rgba(212,175,55,0.04); font-weight: 600; }

        /* ================= ORDER CARD ================= */
        .order-card {
            background: var(--bg-surface);
            border-radius: var(--radius-md);
            border: 1px solid var(--border-subtle);
            overflow: hidden;
            margin-bottom: 24px;
            transition: all var(--transition-base);
            box-shadow: var(--shadow-card);
        }
        .order-card:hover { border-color: var(--border-gold); box-shadow: var(--shadow-card-hover); }

        .order-header {
            background: var(--bg-elevated);
            padding: 18px 28px;
            border-bottom: 1px solid var(--border-subtle);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }
        .order-id-date .id { font-size: 18px; font-weight: 700; color: var(--text-primary); display: block; margin-bottom: 4px; font-family: 'Playfair Display', serif; }
        .order-id-date .date { font-size: 12px; color: var(--text-muted); }
        .order-id-date .date i { margin-right: 5px; }
        .order-header-right { display: flex; flex-direction: column; align-items: flex-end; gap: 8px; }

        /* ================= STATUS BADGES ================= */
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
        .status-processing { background: rgba(255,193,7,0.12); color: #ffc107; border: 1px solid rgba(255,193,7,0.2); }
        .status-completed { background: rgba(46,204,113,0.12); color: #2ecc71; border: 1px solid rgba(46,204,113,0.2); }
        .status-cancelled { background: rgba(231,76,60,0.12); color: #e74c3c; border: 1px solid rgba(231,76,60,0.2); }
        .status-confirmed { background: rgba(52,152,219,0.12); color: #3498db; border: 1px solid rgba(52,152,219,0.2); }
        .status-shipping { background: rgba(52,152,219,0.12); color: #3498db; border: 1px solid rgba(52,152,219,0.2); }

        /* ================= BUTTONS ================= */
        .btn-reorder {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 16px; border: 1.5px solid var(--border-gold); color: var(--gold);
            background: transparent; border-radius: 20px; font-size: 12px;
            font-weight: 600; cursor: pointer; transition: all var(--transition-fast);
        }
        .btn-reorder:hover { background: linear-gradient(135deg, var(--gold), var(--gold-dark)); color: #101010; transform: translateY(-1px); }

        .btn-cancel-order {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 16px; border: 1.5px solid rgba(231,76,60,0.3); color: #e74c3c;
            background: transparent; border-radius: 20px; font-size: 12px;
            font-weight: 600; cursor: pointer; transition: all var(--transition-fast);
        }
        .btn-cancel-order:hover { background: rgba(231,76,60,0.12); color: #e74c3c; transform: translateY(-1px); }

        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0;
            padding: 20px 28px;
            border-bottom: 1px solid var(--border-subtle);
            background: var(--bg-surface);
        }
        .info-block h4 {
            font-size: 11px; text-transform: uppercase;
            color: var(--gold); margin-bottom: 8px;
            font-weight: 700; letter-spacing: 1px;
        }
        .info-block p { font-size: 13px; color: var(--text-secondary); line-height: 1.6; margin: 0; }
        .info-block i { margin-right: 6px; color: var(--gold); }

        .order-items-wrapper { padding: 0 28px 20px; }
        .order-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .order-table th {
            padding: 10px 0; border-bottom: 2px solid var(--border-gold);
            text-align: left; font-size: 11px; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; font-weight: 700;
        }
        .order-table td {
            padding: 16px 0; border-bottom: 1px dashed var(--border-subtle);
            vertical-align: middle; font-size: 14px;
            color: var(--text-secondary); transition: background var(--transition-fast);
        }
        .order-table tbody tr:hover td { background: var(--bg-elevated); }
        .item-name { font-weight: 500; color: var(--text-primary); }
        .item-price { color: var(--text-primary); font-weight: 500; }
        .item-total { font-weight: 700; color: var(--gold); text-align: right; }
        .col-right { text-align: right; }
        .col-center { text-align: center; }

        .order-footer {
            padding: 18px 28px;
            background: var(--bg-elevated);
            border-top: 1px solid var(--border-subtle);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-detail {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 10px 22px; border: 1.5px solid var(--border-gold);
            color: var(--gold); border-radius: 25px; text-decoration: none;
            font-weight: 600; font-size: 13px; transition: all var(--transition-fast);
        }
        .btn-detail:hover { background: linear-gradient(135deg, var(--gold), var(--gold-dark)); color: #101010; transform: translateY(-1px); }
        .total-amount-label { font-size: 13px; color: var(--text-muted); margin-right: 12px; }
        .total-amount-value { font-size: 22px; font-weight: 700; color: var(--gold); font-family: 'Playfair Display', serif; }

        /* ================= EMPTY STATE ================= */
        .empty-state { text-align: center; padding: 70px 30px; }
        .empty-state i { font-size: 64px; color: rgba(255,255,255,0.06); margin-bottom: 20px; display: block; }
        .empty-state h4 { font-size: 22px; color: var(--text-primary); margin-bottom: 20px; }
        .btn-shop {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 12px 28px;
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010; border-radius: 40px; text-decoration: none;
            font-weight: 700; font-size: 14px; transition: all var(--transition-base);
        }
        .btn-shop:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(212,175,55,0.3); }

        /* ================= MODAL ================= */
        .modal-content {
            background: var(--bg-surface) !important;
            border: 1px solid var(--border-subtle) !important;
            border-radius: var(--radius-lg) !important;
            box-shadow: var(--shadow-card) !important;
        }
        .modal-header {
            border-bottom: 1px solid var(--border-subtle) !important;
            padding: 20px 25px !important;
        }
        .modal-title { font-size: 20px !important; font-weight: 700; }
        #cancelOrderModal .modal-title { color: #e74c3c !important; }
        #reorderModal .modal-title { color: var(--text-primary) !important; }
        .btn-close { filter: invert(1) !important; opacity: 0.5 !important; }
        .modal-body p { font-size: 15px; color: var(--text-secondary); }
        .modal-body label { font-size: 12px; letter-spacing: 0.5px; text-transform: uppercase; font-weight: 700; color: var(--text-secondary); }
        .form-select {
            background: var(--bg-elevated) !important;
            border: 1.5px solid var(--border-subtle) !important;
            border-radius: var(--radius-sm) !important;
            padding: 10px 14px !important;
            color: var(--text-primary) !important;
        }
        .form-select:focus {
            border-color: var(--border-gold-strong) !important;
            box-shadow: 0 0 0 3px rgba(212,175,55,0.06) !important;
        }
        .form-select option {
            background: var(--bg-surface);
            color: var(--text-primary);
        }
        .modal-footer {
            border-top: 1px solid var(--border-subtle) !important;
            padding: 15px 25px 20px !important;
            gap: 10px;
        }
        .btn-keep {
            padding: 10px 22px;
            background: transparent;
            border: 1.5px solid var(--border-subtle);
            color: var(--text-secondary);
            border-radius: 25px; font-size: 13px;
            cursor: pointer; transition: var(--transition-fast);
            font-weight: 500;
        }
        .btn-keep:hover { border-color: var(--gold); color: var(--gold); }
        .btn-confirm-cancel {
            padding: 10px 24px;
            background: rgba(231,76,60,0.12);
            border: 1.5px solid rgba(231,76,60,0.3);
            color: #e74c3c;
            border-radius: 25px; font-size: 13px;
            font-weight: 600; cursor: pointer; transition: var(--transition-fast);
        }
        .btn-confirm-cancel:hover { background: rgba(231,76,60,0.2); transform: translateY(-1px); }

        /* ================= OVERRIDES ================= */
        .main-content { flex: 1; padding: 30px 40px; background: var(--bg-primary); }
        .content-header h1 { font-family: 'Playfair Display', serif; }
        .btn-success {
            background: rgba(34,197,94,0.12) !important;
            border: 1px solid rgba(34,197,94,0.2) !important;
            color: #22c55e !important;
            border-radius: 20px !important;
            padding: 6px 16px !important;
            font-weight: 600 !important;
            font-size: 12px !important;
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

    <%-- SIDEBAR --%>
    <!-- Sidebar chung -->
    <%@ include file="/common/user-sidebar.jsp" %>


    <%-- MAIN CONTENT --%>
    <div class="main-content">
        <div class="content-header">
            <h1>Lịch sử đơn hàng</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">

                        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                        <i class="bi bi-chevron-right"></i>
                    </li>
                    <li class="breadcrumb-item">

                        <a href="${pageContext.request.contextPath}/profile">Tài khoản</a>
                        <i class="bi bi-chevron-right"></i>
                    </li>
                    <li class="breadcrumb-item active">Đơn hàng của tôi</li>
                </ol>

             </nav>
        </div>

        <%-- STATUS TABS --%>
        <div class="order-tabs">
            <div class="order-tab active" onclick="filterOrders('all', this)">Tất cả</div>
            <div class="order-tab" onclick="filterOrders('pending', this)">Đang xử lý</div>
            <div class="order-tab" onclick="filterOrders('confirmed', this)">Đã xác nhận</div>
            <div class="order-tab" onclick="filterOrders('shipping', this)">Đang vận chuyển</div>
            <div class="order-tab" onclick="filterOrders('completed', this)">Đã Giao</div>
            <div class="order-tab" onclick="filterOrders('cancelled', this)">Đã huỷ</div>

        </div>

        <%-- ORDER LIST --%>
        <c:forEach var="order" items="${orders}">

            <c:set var="statusCategory" value="pending" />

            <c:if test="${order.orderStatus == 'CONFIRMED' || fn:contains(order.orderStatus, 'Đã xác nhận')}">
                <c:set var="statusCategory" value="confirmed" />
            </c:if>

            <c:if test="${fn:contains(order.orderStatus, 'Đã huỷ') ||
 fn:contains(order.orderStatus, 'Đã hủy') || order.orderStatus == 'CANCELLED'}">
                <c:set var="statusCategory" value="cancelled" />
            </c:if>

            <c:if test="${fn:contains(order.orderStatus, 'SHIPPING') ||
 fn:contains(order.orderStatus, 'Đang vận chuyển')}">
                <c:set var="statusCategory" value="shipping" />
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
                            <i class="bi bi-clock"></i>

                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>

                    <div class="order-header-right">

                        <c:choose>
                            <%-- HUỶ --%>
                            <c:when test="${statusCategory == 'cancelled'}">

                                <span class="order-status status-cancelled">
                                    <i class="bi bi-x-circle"></i> ${order.orderStatus}
                                </span>

                                <button type="button" class="btn-reorder" onclick="reOrder('${order.id}')">
                                    <i class="bi bi-arrow-repeat"></i> Mua lại đơn này
                                </button>

                             </c:when>

                            <%-- ĐÃ GIAO --%>
                            <c:when test="${statusCategory == 'completed'}">

                                <span class="order-status status-completed">
                                    <i class="bi bi-check-circle-fill"></i> ${order.orderStatus}
                                </span>

                                <button type="button" class="btn-reorder" onclick="reOrder('${order.id}')">
                                    <i class="bi bi-arrow-repeat"></i> Mua lại lần nữa
                                </button>

                             </c:when>

                            <%-- ĐANG VẬN CHUYỂN --%>
                            <c:when test="${statusCategory == 'shipping'}">
                                <span class="order-status status-shipping">
                                    <i class="bi bi-truck"></i> ${order.orderStatus}
                                </span>
                                <form action="${pageContext.request.contextPath}/confirm-received" method="POST" style="display:inline; margin-top: 6px;">
                                    <input type="hidden" name="id" value="${order.id}">
                                    <button type="submit" class="btn btn-success btn-sm"
                                            style="border-radius:20px; padding:6px 16px; font-weight:600;
                                                   background:#22c55e; border-color:#22c55e; font-size:12px;"
                                            onclick="return confirm('Bạn xác nhận đã nhận được hàng?')">
                                        <i class="bi bi-check-circle-fill"></i> Đã nhận được hàng
                                    </button>
                                </form>
                            </c:when>

                            <%-- XÁC NHẬN --%>
                            <c:when test="${order.orderStatus == 'CONFIRMED' ||
 fn:contains(order.orderStatus, 'Đã xác nhận')}">
                                <span class="order-status status-confirmed">
                                    <i class="bi bi-check2-all"></i> ${order.orderStatus}

                                </span>
                            </c:when>

                            <%-- ĐANG XỬ LÝ --%>
                            <c:otherwise>

                                <span class="order-status status-processing">
                                    <i class="bi bi-arrow-repeat"></i> ${order.orderStatus}

                                </span>
                                <c:if test="${order.orderStatus == 'Đang xử lý' ||
 order.orderStatus == 'PENDING'}">
                                    <button type="button" class="btn-cancel-order" onclick="openCancelModal('${order.id}')">
                                        <i class="bi bi-x-lg"></i> Huỷ đơn hàng

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
                        <p><i class="bi bi-geo-alt"></i> ${order.shippingAddress}</p>
                    </div>
                    <div class="info-block">

                        <h4>Phương thức thanh toán</h4>
                        <p><i class="bi bi-credit-card"></i> ${order.paymentMethod}</p>
                    </div>
                    <div class="info-block">
                        <h4>Vận chuyển &amp; Dự kiến</h4>
                        <p><i class="bi bi-truck"></i> Phí ship:
                            <c:choose>
                                <c:when test="${order.shippingFee > 0}">
                                    <fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true"/> ₫
                                </c:when>
                                <c:otherwise>
                                    Miễn phí
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${not empty order.shippingMethod}">
                        <p><i class="bi bi-truck"></i> Phương thức giao: <strong>${order.shippingMethod}</strong></p>
                        </c:if>
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
                        <p><i class="bi bi-clock"></i> Nhận hàng:
                            <strong>
                                <fmt:formatDate value="${estFrom}" pattern="dd/MM"/> – <fmt:formatDate value="${estTo}" pattern="dd/MM/yyyy"/>
                            </strong>
                        </p>
                        </c:if>
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
                        <i class="bi bi-info-circle"></i> Xem chi tiết

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
                <i class="bi bi-box-seam"></i>
                <h4>Bạn chưa có đơn hàng nào</h4>
                <a href="${pageContext.request.contextPath}/home" class="btn-shop">
                    <i class="bi bi-arrow-right"></i> Tiếp tục
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
                        <i class="bi bi-exclamation-triangle me-2" style="color: #dc3545;"></i>Xác nhận hủy đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                 </div>

                <div class="modal-body">
                    <p>Bạn có chắc muốn hủy đơn hàng <strong>#<span id="displayOrderId"></span></strong>?</p>
                    <input type="hidden" name="orderId" id="cancelOrderId" value="">
                    <div class="mt-4">
                        <label class="form-label fw-bold d-block">Vui lòng chọn lý do hủy:</label>
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

<%-- REORDER MODAL --%>
<div class="modal fade" id="reorderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-arrow-repeat me-2" style="color: var(--gold);"></i>Xác nhận mua lại
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>
                    Bạn có muốn thêm sản phẩm từ đơn hàng <strong>#<span id="reorderDisplayId"></span></strong> vào giỏ hàng không?
                </p>
                <input type="hidden" id="reorderId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-keep" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>Để sau
                </button>
                <button type="button" class="btn-reorder" id="confirmReorderBtn">
                    <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ hàng
                </button>
            </div>
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
        document.getElementById('reorderDisplayId').innerText = orderId;
        document.getElementById('reorderId').value = orderId;
        var reorderModal = new bootstrap.Modal(document.getElementById('reorderModal'));
        reorderModal.show();
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('confirmReorderBtn').addEventListener('click', function() {
            var orderId = document.getElementById('reorderId').value;
            if (orderId) {
                window.location.href = '${pageContext.request.contextPath}/reorder?id=' + orderId;
            }
        });
    });
</script>

</body>
</html>