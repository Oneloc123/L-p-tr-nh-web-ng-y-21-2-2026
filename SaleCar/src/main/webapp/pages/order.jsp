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

        /* ================= ORDER TABS ================= */
        .order-tabs {
            display: flex;
            background: #fff;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid #eee;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
            overflow: hidden;
        }
        .order-tab {
            flex: 1;
            text-align: center;
            padding: 16px 0;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            color: #666;
            border-bottom: 3px solid transparent;
            transition: all 0.3s;
        }
        .order-tab:hover {
            background: #fafafa;
            color: #000;
        }
        .order-tab.active {
            color: var(--gold, #C5A028); /* Hoặc dùng màu đen #000 tùy style của bạn */
            border-bottom-color: var(--gold, #C5A028);
            background: #fffcf5;
            font-weight: 600;
        }


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

    <!-- trang thais don hang -->
    <div class="order-tabs">
        <div class="order-tab active" onclick="filterOrders('all', this)">Tât cả</div>
        <div class="order-tab" onclick="filterOrders('pending',this)">Đang xử lý</div>
        <div class="order-tab" onclick="filterOrders('completed', this)">Đã Giao</div>
        <div class="order-tab" onclick="filterOrders('cancelled',this)">Đã huỷ</div>
    </div>



<c:forEach var="order" items="${orders}">

    <c:set var="statusCategory" value="pending" />

    <!-- check gtri val PENDING -->
    <c:if test="${fn:contains(order.orderStatus, 'Đã huỷ') || fn:contains(order.orderStatus, 'Đã hủy')}">
        <c:set var="statusCategory" value="cancelled" />
    </c:if>

    <c:if test="${fn:contains(order.orderStatus, 'Đã giao') || fn:contains(order.orderStatus, 'Thành công')}">
        <c:set var="statusCategory" value="completed" />
    </c:if>

    <div class="order-card order-item-card" data-status="${statusCategory}">

        <div class="order-header">
            <div class="order-id-date">
                <span class="id">Đơn hàng #${order.id}</span>
                <span class="date"><i class="far fa-clock"></i>
                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>

            <c:choose>
                <%-- NẾU LÀ ĐƠN ĐÃ HỦY --%>
                <c:when test="${statusCategory == 'cancelled'}">
                    <div class="order-status" style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
                        <i class="bi bi-x-circle-fill"></i> ${order.orderStatus}
                    </div>
                    <div class="mt-2">
                        <button type="button" class="btn btn-outline-dark btn-sm" onclick="reOrder('${order.id}')">
                            <i class="bi bi-arrow-repeat"></i> Mua lại đơn này
                        </button>
                    </div>
                </c:when>

                <%-- NẾU LÀ ĐƠN BÌNH THƯỜNG --%>
                <c:otherwise>
                    <div class="order-status status-processing">
                        <i class="fas fa-spinner fa-spin"></i> ${order.orderStatus}
                    </div>
                    <c:if test="${order.orderStatus == 'Đang xử lý' || order.orderStatus == 'Pending'}">
                        <div class="mt-2">
                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="openCancelModal('${order.id}')">
                                <i class="bi bi-x-circle"></i> Huỷ đơn hàng
                            </button>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="order-info-grid">
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

<!-- xac nhan huy hang, ly do huy hang -->
<div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 12px; border: none;">
            <form action="cancel-order" method="POST">
                <div class="modal-header" style="border-bottom: 1px solid #eee;">
                    <h5 class="modal-title text-danger" style="font-weight: 600;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>Xác nhận hủy đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body" style="padding: 25px;">
                    <p style="font-size: 16px; color: #333;">Bạn có chắc chắn muốn hủy đơn hàng <strong>#<span id="displayOrderId"></span></strong> không?</p>

                    <input type="hidden" name="orderId" id="cancelOrderId" value="">

                    <div class="form-group mt-3">
                        <label class="fw-bold mb-2" style="font-size: 14px;">Vui lòng chọn lý do hủy:</label>
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

                <div class="modal-footer" style="border-top: none;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">Không hủy nữa</button>
                    <button type="submit" class="btn btn-danger" style="border-radius: 8px;">Đồng ý hủy đơn</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>

    function openCancelModal(orderId){

        document.getElementById('displayOrderId').innerText = orderId;

        document.getElementById('cancelOrderId').value = orderId;

        let cancelModal = new bootstrap.Modal(document.getElementById('cancelOrderModal'));
        cancelModal.show();
    }

    function filterOrders(statusTarget, clickedTab) {

        let tabs = document.querySelectorAll('.order-tab');
        tabs.forEach(tab => tab.classList.remove('active'));
        clickedTab.classList.add('active');

        let allOrders = document.querySelectorAll('.order-item-card');
        allOrders.forEach(order => {
            let orderStatus = order.getAttribute('data-status');

            if (statusTarget === 'all' || orderStatus === statusTarget){
                order.style.display = 'block';
            } else {

                order.style.display = 'none';
            }
        });
    }

</script>

</body>
</html>