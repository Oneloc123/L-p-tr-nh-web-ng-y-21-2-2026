<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - LUXCAR Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* ========== RESET & GLOBAL ========== */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }

        /* ========== SIDEBAR ========== */
        .sidebar {
            width: 280px;
            background-color: #ffffff;
            border-right: 1px solid #e9edf2;
            height: 100vh;
            position: sticky;
            top: 0;
            padding: 2rem 1.2rem;
            transition: all 0.3s;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1e2a3a, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 2.5rem;
            letter-spacing: -0.5px;
        }

        .logo i {
            background: none;
            color: #2c7da0;
        }

        .sidebar nav ul { list-style: none; padding: 0; }
        .sidebar nav ul li { margin-bottom: 0.6rem; }
        .sidebar nav ul li a {
            display: flex; align-items: center; gap: 14px; padding: 12px 18px;
            border-radius: 14px; color: #5a6e7c; font-weight: 500; text-decoration: none;
            transition: all 0.2s ease; font-size: 0.95rem;
        }
        .sidebar nav ul li a i { font-size: 1.3rem; width: 24px; }
        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #f0f9ff; color: #2c7da0;
            box-shadow: 0 2px 4px rgba(44,125,160,0.08);
            border-left: 2px solid #2c7da0;
        }

        /* ========== MAIN CONTENT ========== */
        .main-content {
            flex: 1; padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9; overflow-y: auto;
        }

        /* ========== ADMIN HEADER ========== */
        .admin-header {
            background: #ffffff; padding: 1rem 1.8rem;
            border-radius: 24px; margin-bottom: 2rem;
            border: 1px solid #e9edf2; box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }
        .admin-header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text; background-clip: text; color: transparent;
        }

        .breadcrumb { background: transparent; padding: 0; margin: 0; font-size: 0.85rem; }
        .breadcrumb-item a { color: #5a6e7c; text-decoration: none; }
        .breadcrumb-item.active { color: #2c7da0; font-weight: 500; }

        /* ========== BUTTONS ========== */
        .admin-btn-primary {
            background-color: #2c7da0; border: none;
            padding: 8px 20px; font-weight: 600;
            border-radius: 40px; color: #ffffff; transition: 0.2s; cursor: pointer;
            display: inline-flex; align-items: center; gap: 8px;
        }
        .admin-btn-primary:hover {
            background-color: #1f5e7a; transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2); color: #fff;
        }

        /* ========== FORM CONTROLS ========== */
        .admin-input, .admin-select {
            background-color: #ffffff; border: 1px solid #e2e8f0;
            color: #1e293b; border-radius: 14px; padding: 10px 16px; width: 100%;
        }
        .admin-input:focus, .admin-select:focus {
            background-color: #ffffff; border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1); color: #1e293b; outline: none;
        }

        /* ========== ADMIN CARD ========== */
        .admin-card {
            background: #ffffff; border: 1px solid #e9edf2;
            border-radius: 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }
        .admin-card-body { padding: 1.2rem; }

        /* ========== ADMIN TABLE ========== */
        .admin-table { color: #1e293b; border-color: #e9edf2; width: 100%; table-layout: fixed; }
        .admin-table thead { background-color: #f8fafc; }
        .admin-table th {
            font-weight: 600; font-size: 11px;
            text-transform: uppercase; letter-spacing: 0.3px;
        }
        .admin-table td { font-size: 13px; vertical-align: middle; overflow: hidden; }
        .admin-table-hover tbody tr:hover { background-color: #f8fafc; }

        .col-nowrap { white-space: nowrap; }
        .text-truncate-cell { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }

        /* ========== BADGES ========== */
        .badge-status {
            padding: 5px 14px; border-radius: 50px;
            font-size: 11px; font-weight: 600;
            border: 1px solid transparent; display: inline-block; 
            white-space: nowrap; letter-spacing: 0.3px;
        }
        .badge-pending { background: #fffbeb; color: #b45309; border-color: #fde68a; }
        .badge-confirmed { background: #eff6ff; color: #1d4ed8; border-color: #bfdbfe; }
        .badge-shipping { background: #e0f2fe; color: #0284c7; border-color: #bae6fd; }
        .badge-delivered { background: #f0fdf4; color: #15803d; border-color: #bbf7d0; }
        .badge-cancelled { background: #fef2f2; color: #b91c1c; border-color: #fecaca; }

        /* ========== ACTION BUTTONS ========== */
        .admin-action-btn {
            padding: 6px 14px; border-radius: 40px;
            font-size: 12px; font-weight: 500;
            transition: all 0.2s; border: none;
            display: inline-flex; align-items: center;
            gap: 5px; cursor: pointer;
        }
        .admin-action-view {
            background-color: #eef2ff; color: #2c7da0;
        }
        .admin-action-view:hover { background-color: #e0e8f5; color: #1f5e7a; }
        .admin-action-confirm {
            background-color: #e6f7ec; color: #2e7d5e;
        }
        .admin-action-confirm:hover { background-color: #d1f0d6; color: #1f6b45; }
        .admin-action-shipping {
            background-color: #e0f2fe; color: #0284c7;
        }
        .admin-action-shipping:hover { background-color: #bae6fd; color: #0369a1; }
        .admin-action-delete {
            background-color: #fff0f0; color: #c75c5c;
        }
        .admin-action-delete:hover { background-color: #ffe0e0; color: #b84c4c; }

        /* ========== MODAL ========== */
        .form-card { padding: 25px; }
        .form-section {
            background: #fefefe; border: 1px solid #eef2f6;
            border-radius: 20px; padding: 20px; margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .form-section-title {
            font-size: 14px; font-weight: 600;
            color: #2c7da0; margin-bottom: 15px;
            display: flex; align-items: center; gap: 8px;
        }
        .form-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-cancel-modal {
            border: 1px solid #e2e8f0; padding: 8px 18px;
            border-radius: 30px; color: #64748b;
            text-decoration: none; background: transparent; transition: 0.2s;
        }
        .btn-cancel-modal:hover { border-color: #2c7da0; color: #2c7da0; }
        .form-control:read-only { background-color: #f8fafc; color: #475569; }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 992px) {
            .sidebar { width: 80px; padding: 1rem 0.5rem; }
            .sidebar .logo span { display: none; }
            .sidebar nav ul li a span { display: none; }
            .sidebar nav ul li a i { font-size: 1.5rem; }
            .main-content { padding: 1rem; }
        }
    </style>
</head>
<body>

<div class="d-flex">

    <%@ include file="sidebar/sidebar.jsp"%>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center">
            <div>
                <h3 class="fw-bold m-0"><i class="bi bi-receipt me-2" style="color:#2c7da0;"></i> Quản lý đơn hàng</h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Orders</li>
                    </ol>
                </nav>
            </div>
        </header>

        <div class="admin-card">
            <div class="admin-card-body">

                <!-- Filter by Status -->
                <form action="${pageContext.request.contextPath}/order-admin" method="GET" class="row g-3 align-items-end mb-4">
                    <div class="col-md-8">
                        <select name="status" class="admin-select">
                            <option value="" ${empty currentStatus ? 'selected' : ''}>Tất cả trạng thái</option>
                            <option value="PENDING" ${currentStatus == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="CONFIRMED" ${currentStatus == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="SHIPPING" ${currentStatus == 'SHIPPING' ? 'selected' : ''}>Đang vận chuyển</option>
                            <option value="DELIVERED" ${currentStatus == 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                            <option value="CANCELLED" ${currentStatus == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="admin-btn-primary w-100"><i class="bi bi-funnel me-1"></i> Lọc dữ liệu</button>
                    </div>
                </form>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="alert alert-info text-center mt-4">Không tìm thấy đơn hàng nào.</div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="admin-table table table-hover align-middle mb-0">
                            <colgroup>
                                <col style="width: 105px;">
                                <col style="width: 120px;">
                                <col style="width: 100px;">
                                <col>
                                <col>
                                <col style="width: 110px;">
                                <col style="width: 60px;">
                                <col style="width: 140px;">
                                <col style="width: 120px;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Địa chỉ</th>
                                    <th>Sản phẩm</th>
                                    <th>Tổng tiền</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>

                                <c:forEach var="ord" items="${orders}">
                                    <tr>
                                        <td class="fw-bold col-nowrap" style="color: #0f172a;">#ORD-${ord.id}</td>

                                        <td>
                                            <div class="text-truncate-cell fw-semibold" style="color: #334155;" title="${customerNameMap[ord.userId]}">${customerNameMap[ord.userId]}</div>
                                            <small class="text-muted" style="font-size: 10px;">UID: ${ord.userId}</small>
                                        </td>

                                        <td class="col-nowrap">${ord.orderDate}</td>

                                        <td>
                                            <div class="text-truncate-cell" title="${ord.shippingAddress}">
                                                ${ord.shippingAddress}
                                            </div>
                                        </td>

                                        <td style="overflow: hidden; text-overflow: ellipsis;">
                                            <c:set var="itemCount" value="0"/>
                                            <c:set var="totalItems" value="${fn:length(ord.items)}"/>
                                            <c:forEach var="item" items="${ord.items}" varStatus="stat">
                                                <c:if test="${stat.index < 2}">
                                                    <div class="text-truncate-cell" style="max-width: 100%;">
                                                        <span class="fw-semibold text-dark" style="font-size: 12px;">${item.product.name}</span>
                                                        <span class="text-danger fw-bold ms-1" style="font-size: 11px;">x${item.quantity}</span>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${totalItems > 2}">
                                                <span class="badge bg-secondary" style="font-size: 10px; border-radius: 10px; padding: 2px 8px;">+${totalItems - 2} cái</span>
                                            </c:if>
                                            <c:if test="${totalItems <= 2 && totalItems == 0}">
                                                <span class="text-muted" style="font-size: 11px;">(trống)</span>
                                            </c:if>
                                        </td>

                                        <td class="col-nowrap fw-bold text-danger">
                                            <fmt:formatNumber value="${ord.totalAmount}" type="number" groupingUsed="true"/> ₫
                                        </td>

                                        <td><span class="badge bg-secondary">COD</span></td>

                                        <td class="col-nowrap" id="status-cell-${ord.id}">
                                            <c:choose>
                                                <c:when test="${ord.orderStatus == 'PENDING' || ord.orderStatus == 'Đang xử lý'}">
                                                    <span class="badge-status badge-pending">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${ord.orderStatus == 'CONFIRMED' || ord.orderStatus == 'Đã xác nhận'}">
                                                    <span class="badge-status badge-confirmed">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${ord.orderStatus == 'SHIPPING' || ord.orderStatus == 'Đang vận chuyển'}">
                                                    <span class="badge-status badge-shipping">Đang vận chuyển</span>
                                                </c:when>
                                                <c:when test="${ord.orderStatus == 'DELIVERED' || ord.orderStatus == 'Đã giao'}">
                                                    <span class="badge-status badge-delivered">Đã giao</span>
                                                </c:when>
                                                <c:when test="${ord.orderStatus == 'CANCELLED' || ord.orderStatus == 'Đã hủy'}">
                                                    <span class="badge-status badge-cancelled">Đã hủy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-status badge-pending">${ord.orderStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="col-nowrap" style="text-align: center;">
                                            <div id="action-buttons-${ord.id}" class="d-flex justify-content-center gap-1 flex-nowrap">

                                                <button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal${ord.id}" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </button>

                                                <c:choose>
                                                    <c:when test="${ord.orderStatus == 'PENDING' || ord.orderStatus == 'Đang xử lý'}">
                                                        <button type="button" class="admin-action-btn admin-action-confirm" onclick="updateStatusOrder(event, ${ord.id}, 'CONFIRMED')" title="Xác nhận">
                                                            <i class="bi bi-check2-circle"></i>
                                                        </button>
                                                        <button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ${ord.id}, 'CANCELLED')" title="Hủy đơn">
                                                            <i class="bi bi-x-circle"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${ord.orderStatus == 'CONFIRMED' || ord.orderStatus == 'Đã xác nhận'}">
                                                        <button type="button" class="admin-action-btn admin-action-shipping" onclick="updateStatusOrder(event, ${ord.id}, 'SHIPPING')" title="Giao ĐVVC">
                                                            <i class="bi bi-truck"></i>
                                                        </button>
                                                        <button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ${ord.id}, 'CANCELLED')" title="Hủy đơn">
                                                            <i class="bi bi-x-circle"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${ord.orderStatus == 'SHIPPING' || ord.orderStatus == 'Đang vận chuyển'}">
                                                        <span class="badge bg-info text-white" style="font-size: 10px; border-radius: 10px;">Đang giao</span>
                                                        <button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ${ord.id}, 'CANCELLED')" title="Hủy đơn">
                                                            <i class="bi bi-x-circle"></i>
                                                        </button>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
            </div>
        </div>

        <c:forEach var="ord" items="${orders}">
            <div class="modal fade" id="viewOrderModal${ord.id}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="form-card">

                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="bi bi-cart-check-fill"></i> Thông tin Đơn hàng #ORD-${ord.id}
                                </h3>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label text-muted small">Ngày đặt</label>
                                        <input type="text" class="form-control" value="${ord.orderDate}" readonly>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label text-muted small">Tên khách hàng</label>
                                        <input type="text" class="form-control fw-semibold" value="${customerNameMap[ord.userId]}" readonly>
                                    </div>

                                    <div class="col-md-4 mb-3">
                                        <label class="form-label text-muted small">Trạng thái</label>
                                        <input type="text" class="form-control text-primary fw-bold" value="${ord.orderStatus}" readonly>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label text-muted small">Phương thức thanh toán</label>
                                        <input type="text" class="form-control" value="COD (Mặc định)" readonly>
                                    </div>
                                    <c:if test="${not empty ord.shippingMethod}">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label text-muted small">Phương thức giao hàng</label>
                                        <input type="text" class="form-control" value="${ord.shippingMethod}" readonly>
                                    </div>
                                    </c:if>
                                </div>
                            </div>

                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="bi bi-person-lines-fill"></i> Thông tin Khách hàng & Giao hàng
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label text-muted small">ID Người mua</label>
                                        <input type="text" class="form-control" value="${ord.userId}" readonly>
                                    </div>


                                    <div class="col-12 mb-3">
                                        <label class="form-label text-muted small">Địa chỉ giao hàng</label>
                                        <input type="text" class="form-control" value="${ord.shippingAddress}" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="bi bi-box-seam"></i> Chi tiết Sản phẩm
                                </h3>

                                  <div class="row">
                                    <div class="col-12 mb-3">
                                       <%-- Vòng lặp in từng sản phẩm có kèm ảnh --%>
                                       <c:forEach items="${ord.items}" var="item">
                                          <div class="d-flex justify-content-between align-items-center border-bottom py-3">

                                              <%-- Phần bên trái: Ảnh + Tên + Số lượng --%>
                                              <div class="d-flex align-items-center gap-3">
                                                  <%-- Khối hình ảnh giống order-detail.jsp --%>
                                                  <div style="width: 65px; height: 65px; background: #f8f9fa; border-radius: 8px; overflow: hidden; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                                     <img src="${not empty item.imageUrl ? pageContext.request.contextPath.concat('/uploads/').concat(item.imageUrl) : 'https://placehold.co/100?text=LUXCAR'}" alt="${item.product.name}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.src='https://placehold.co/100?text=LUXCAR'">
                                                  </div>

                                                  <%-- Thông tin tên xe --%>
                                                  <div>
                                                     <div class="fw-bold" style="color: #1e293b; font-size: 15px;">${item.product.name}</div>
                                                        <div class="text-muted small mt-1">
                                                           Mã SP: LUX-${item.productId} | <span class="text-danger fw-bold">Số lượng: x${item.quantity}</span>
                                                        </div>
                                                     </div>
                                                  </div>

                                                  <%-- Phần bên phải: Đơn giá --%>
                                                  <div class="fw-bold" style="color: #475569; font-size: 14px;">
                                                      <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> ₫
                                                  </div>

                                          </div>
                                       </c:forEach>
                                    </div>

                                    <div class="col-12 mt-2 text-end">
                                        <h4 class="text-danger fw-bold m-0" style="font-size: 18px;">
                                           Tổng tiền: <fmt:formatNumber value="${ord.totalAmount}" type="number" groupingUsed="true"/> ₫
                                        </h4>
                                </div>
                              </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="btn-cancel-modal" data-bs-dismiss="modal">
                                    <i class="bi bi-x-lg"></i> Đóng
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </main>
</div>

<div id="customToast"
     style="visibility: hidden; min-width: 250px; background-color: #28a745; color: white; text-align: center; border-radius: 5px; padding: 16px; position: fixed; z-index: 9999; right: 30px; top: 30px; font-weight: bold; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); transition: opacity 1s;">
    <i class="bi bi-check-circle-fill"></i> <span id="toastMessage"> Đơn hàng đã được xác nhận!</span>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function updateStatusOrder(event, orderId, newStatus){
        event.preventDefault()

        if(newStatus === 'CANCELLED'){
            let xacnhan = confirm("Bạn có chắc chắn muốn huỷ đơn hàng này không?");
            if(xacnhan === false){
                return;
            }
        }

        let formData = new URLSearchParams({orderId: orderId, status: newStatus});

        fetch('update-order-status' ,{method: 'POST', body: formData})
            .then(function(response) {
                return response.text();
            })
            .then(function(data){
                if(data.trim() === 'success'){

                    let toast = document.getElementById("customToast");
                    toast.style.visibility = "visible";
                    toast.style.opacity = "1";

                    let trangThai = document.getElementById("status-cell-" + orderId);
                    let actionGroup = document.getElementById("action-buttons-" + orderId);

                    if("CONFIRMED" === newStatus){
                        document.getElementById("toastMessage").innerText = "Đơn hàng #ORD-"+ orderId + " đã được duyệt!";


                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '" title="Xem chi tiết">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>' +
                            '<button type="button" class="admin-action-btn admin-action-shipping" onclick="updateStatusOrder(event, ' + orderId + ', \'SHIPPING\')" title="Giao ĐVVC">' +
                                '<i class="bi bi-truck"></i>' +
                            '</button>' +
                            '<button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ' + orderId + ', \'CANCELLED\')" title="Hủy đơn">' +
                                '<i class="bi bi-x-circle"></i>' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-confirmed">Đã xác nhận</span>';

                    } else if("SHIPPING" === newStatus){
                        document.getElementById("toastMessage").innerText = "Đã bàn giao cho đơn vị vận chuyển!";

                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '" title="Xem chi tiết">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>' +
                            '<span class="badge bg-info text-white" style="font-size: 10px; border-radius: 10px;">Đang giao</span>' +
                            '<button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ' + orderId + ', \'CANCELLED\')" title="Hủy đơn">' +
                                '<i class="bi bi-x-circle"></i>' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-shipping">Đang vận chuyển</span>';

                    } else if("DELIVERED" === newStatus){
                        document.getElementById("toastMessage").innerText = "Đơn hàng #ORD-"+ orderId + " đã được giao!";

                        // giu lai nut xem
                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '" title="Xem chi tiết">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-delivered">Đã giao</span>';

                    } else {
                        document.getElementById("toastMessage").innerText = "Đã huỷ đơn hàng: #ORD-"+ orderId + "!";


                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '" title="Xem chi tiết">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-cancelled">Đã huỷ đơn</span>';
                    }

                    setTimeout(function(){
                        toast.style.opacity = "0";
                        setTimeout(function(){
                            toast.style.visibility ="hidden";
                        }, 300);
                    }, 3000);

                } else {
                    alert("Máy chủ từ chối cập nhật! lý do: " + data);
                }
            })
            .catch(function(error) {
                console.log("Lỗi hệ thống:", error);
            });
    }
</script>

</body>
</html>