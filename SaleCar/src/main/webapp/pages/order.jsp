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
        .main-content { flex: 1; padding: 30px; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 600; color: #000000; margin-bottom: 10px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; align-items: center; gap: 6px; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #666666; text-decoration: none; font-size: 13px; }
        .breadcrumb-item.active { color: #000000; font-weight: 500; font-size: 13px; }
        .breadcrumb-item i { color: #ccc; font-size: 9px; }

        /* ===== ORDER TABS ===== */
        .order-tabs {
            display: flex;
            background: #ffffff;
            border-radius: 8px;
            margin-bottom: 28px;
            border: 1px solid #eeeeee;
            box-shadow: 0 5px 20px rgba(0,0,0,0.03);
            overflow: hidden;
        }
        .order-tab {
            flex: 1;
            text-align: center;
            padding: 15px 0;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            color: #666666;
            border-bottom: 2px solid transparent;
            transition: all 0.25s ease;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .order-tab:hover { color: #000; background: #fafafa; }
        .order-tab.active { color: #000000; border-bottom-color: #000000; background: #fff; font-weight: 600; }

        /* ===== ORDER CARD (giống profile-card) ===== */
        .order-card {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #eeeeee;
            overflow: hidden;
            margin-bottom: 24px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .order-card:hover { border-color: #000; box-shadow: 0 8px 30px rgba(0,0,0,0.08); }

        .order-header {
            background: #fafafa;
            padding: 18px 28px;
            border-bottom: 1px solid #eeeeee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }
        .order-id-date .id { font-size: 18px; font-weight: 700; color: #000; display: block; margin-bottom: 4px; }
        .order-id-date .date { font-size: 12px; color: #666; }
        .order-id-date .date i { margin-right: 5px; }
        .order-header-right { display: flex; flex-direction: column; align-items: flex-end; gap: 8px; }

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
        .status-shipping { background: #e0f2fe; color: #0284c7; border: 1px solid #bae6fd; }

        .btn-reorder {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 14px; border: 1px solid #000; color: #000;
            background: transparent; border-radius: 5px; font-size: 12px;
            font-weight: 500; cursor: pointer; transition: all 0.25s;
        }
        .btn-reorder:hover { background: #000; color: #fff; }

        .btn-cancel-order {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 14px; border: 1px solid #dc3545; color: #dc3545;
            background: transparent; border-radius: 5px; font-size: 12px;
            font-weight: 500; cursor: pointer; transition: all 0.25s;
        }
        .btn-cancel-order:hover { background: #dc3545; color: #fff; }

        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0;
            padding: 20px 28px;
            border-bottom: 1px solid #eeeeee;
            background: #fff;
        }
        .info-block h4 { font-size: 11px; text-transform: uppercase; color: #000; margin-bottom: 8px; font-weight: 600; letter-spacing: 1px; }
        .info-block p { font-size: 13px; color: #666; line-height: 1.6; margin: 0; }
        .info-block i { margin-right: 6px; color: #000; }

        .order-items-wrapper { padding: 0 28px 20px; }
        .order-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .order-table th { padding: 10px 0; border-bottom: 2px solid #000; text-align: left; font-size: 11px; color: #000; text-transform: uppercase; letter-spacing: 1px; font-weight: 600; }
        .order-table td { padding: 16px 0; border-bottom: 1px dashed #eee; vertical-align: middle; font-size: 14px; }
        .item-name { font-weight: 500; color: #111; }
        .item-price { color: #111; font-weight: 500; }
        .item-total { font-weight: 700; color: #d9534f; text-align: right; }
        .col-right { text-align: right; }
        .col-center { text-align: center; }

        .order-footer {
            padding: 18px 28px;
            background: #fafafa;
            border-top: 1px solid #eeeeee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-detail {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 9px 20px; border: 1px solid #000; color: #000;
            border-radius: 6px; text-decoration: none; font-weight: 500;
            font-size: 13px; transition: all 0.25s;
        }
        .btn-detail:hover { background: #000; color: #fff; }
        .total-amount-label { font-size: 13px; color: #666; margin-right: 12px; }
        .total-amount-value { font-size: 22px; font-weight: 700; color: #d9534f; }

        /* Empty state */
        .empty-state { text-align: center; padding: 70px 30px; color: #666; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 20px; display: block; }
        .empty-state h4 { font-size: 22px; color: #000; margin-bottom: 20px; }
        .btn-shop { display: inline-flex; align-items: center; gap: 8px; padding: 12px 28px; background: #000; color: #fff; border-radius: 6px; text-decoration: none; font-weight: 600; font-size: 14px; transition: all 0.25s; }
        .btn-shop:hover { background: #333; }

        /* ===== MODAL ===== */
        .modal-content { background: #fff !important; border: none !important; border-radius: 10px !important; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .modal-header { border-bottom: 1px solid #eee !important; padding: 20px 25px !important; }
        .modal-title { color: #dc3545 !important; font-size: 20px !important; font-weight: 600; }
        .btn-close { filter: none !important; opacity: 0.5 !important; }
        .modal-body p { font-size: 15px; }
        .modal-body label { font-size: 13px; letter-spacing: 0.5px; text-transform: uppercase; font-weight: 600; }
        .form-select { background: #fff !important; border: 1px solid #ccc !important; border-radius: 6px !important; }
        .form-select:focus { border-color: #000 !important; box-shadow: 0 0 0 3px rgba(0,0,0,0.1) !important; }
        .modal-footer { border-top: none !important; padding: 15px 25px 20px !important; gap: 10px; }
        .btn-keep { padding: 9px 20px; background: transparent; border: 1px solid #ccc; color: #666; border-radius: 6px; font-size: 13px; cursor: pointer; transition: 0.25s; font-weight: 500; }
        .btn-keep:hover { border-color: #000; color: #000; }
        .btn-confirm-cancel { padding: 9px 22px; background: #dc3545; border: 1px solid #dc3545; color: #fff; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; transition: 0.25s; }
        .btn-confirm-cancel:hover { background: #c82333; }

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
            <a href="${pageContext.request.contextPath}/notifications" class="menu-item">
                <i class="fas fa-bell"></i>
                <span>Thông báo</span>
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

                            <%-- ĐANG VẬN CHUYỂN --%>
                            <c:when test="${statusCategory == 'shipping'}">
                                <span class="order-status status-shipping">
                                    <i class="fas fa-truck"></i> ${order.orderStatus}
                                </span>
                                <form action="${pageContext.request.contextPath}/confirm-received" method="POST" style="display:inline; margin-top: 6px;">
                                    <input type="hidden" name="id" value="${order.id}">
                                    <button type="submit" class="btn btn-success btn-sm"
                                            style="border-radius:20px; padding:6px 16px; font-weight:600;
                                                   background:#22c55e; border-color:#22c55e; font-size:12px;"
                                            onclick="return confirm('Bạn xác nhận đã nhận được hàng?')">
                                        <i class="fas fa-check-circle"></i> Đã nhận được hàng
                                    </button>
                                </form>
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
                    <div class="info-block">
                        <h4>Vận chuyển &amp; Dự kiến</h4>
                        <p><i class="fas fa-truck"></i> Phí ship:
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
                        <p><i class="fas fa-shipping-fast"></i> Phương thức giao: <strong>${order.shippingMethod}</strong></p>
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
                        <p><i class="fas fa-clock"></i> Nhận hàng:
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