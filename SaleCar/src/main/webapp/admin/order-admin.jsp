<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - LUXCAR Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --admin-primary: #1e81b0;
            --admin-bg: #f5f7f9;
            --admin-sidebar: #ffffff;
            --admin-text: #333333;
            --admin-border: #eaedf1;
            --admin-gold: #d4a017;
            --admin-red: #ef4444;
            --admin-green: #22c55e;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--admin-bg);
            color: var(--admin-text);
            margin: 0;
            overflow-x: hidden;
        }

        .admin-layout {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }

        .sidebar {
            width: 260px;
            flex-shrink: 0;
            background-color: var(--admin-sidebar);
            border-right: 1px solid var(--admin-border);
            height: 100vh;
            position: sticky;
            top: 0;
            padding: 20px 15px;
            overflow-y: auto;
        }

        .logo {
            font-size: 1.4rem;
            font-weight: 700;
            color: #1a365d;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            padding-left: 10px;
        }

        .logo i {
            color: var(--admin-primary);
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar nav ul li {
            margin-bottom: 5px;
        }

        .sidebar nav ul li a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 15px;
            border-radius: 50px;
            color: #64748b;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            font-size: 0.95rem;
        }

        .sidebar nav ul li a i {
            font-size: 1.2rem;
        }

        .sidebar nav ul li a:hover {
            background-color: #f8fafc;
            color: var(--admin-primary);
        }

        .sidebar nav ul li a.active {
            background-color: #eff6ff;
            color: var(--admin-primary);
        }

        .main-content {
            flex: 1;
            padding: 30px;
            max-width: calc(100% - 260px);
        }

        /* ═══ ADMIN CARD ═══ */
        .admin-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
            border: 1px solid var(--admin-border);
            overflow: hidden;
        }
        .admin-card-body {
            padding: 25px;
        }

        .page-header-block {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: var(--admin-primary);
        }

        .search-input, .custom-select, .btn-pill {
            border-radius: 50px !important;
            padding: 10px 20px !important;
            box-shadow: none !important;
            border-color: #cbd5e1;
        }

        .search-input:focus, .custom-select:focus {
            border-color: var(--admin-primary);
        }

        .btn-pill {
            background-color: var(--admin-primary);
            color: white;
            border: none;
            font-weight: 500;
        }

        .btn-pill:hover {
            background-color: #15658e;
            color: white;
        }

        /* ═══ ADMIN TABLE ═══ */
        .admin-table {
            width: 100%;
            border-collapse: collapse;
        }
        .admin-table thead tr {
            background: #f8fafc;
        }
        .admin-table th {
            text-transform: uppercase;
            font-size: 11px;
            color: #64748b;
            font-weight: 700;
            padding: 14px 16px;
            border-bottom: 2px solid var(--admin-border);
            white-space: nowrap;
            letter-spacing: 0.5px;
            text-align: left;
        }
        .admin-table td {
            vertical-align: middle;
            font-size: 14px;
            padding: 14px 16px;
            color: #334155;
            border-bottom: 1px solid var(--admin-border);
        }
        .admin-table tbody tr:hover {
            background-color: #f8fafc;
        }
        .admin-table-hover tbody tr {
            transition: background-color 0.15s;
        }
        .admin-table-hover tbody tr:hover {
            background-color: #f1f5f9;
        }

        .col-nowrap {
            white-space: nowrap;
        }

        /* ═══ BADGE-STATUS (dạng viên thuốc) ═══ */
        .badge-status {
            padding: 5px 14px;
            border-radius: 50px;
            font-size: 11px;
            font-weight: 600;
            border: 1px solid transparent;
            display: inline-block;
            white-space: nowrap;
            letter-spacing: 0.3px;
        }
        .badge-pending { background: #fffbeb; color: #b45309; border-color: #fde68a; }
        .badge-confirmed { background: #eff6ff; color: #1d4ed8; border-color: #bfdbfe; }
        .badge-shipping { background: #e0f2fe; color: #0284c7; border-color: #bae6fd; }
        .badge-delivered { background: #f0fdf4; color: #15803d; border-color: #bbf7d0; }
        .badge-cancelled { background: #fef2f2; color: #b91c1c; border-color: #fecaca; }

        /* ═══ ADMIN ACTION BUTTONS ═══ */
        .admin-action-btn {
            border-radius: 50px;
            padding: 6px 14px;
            font-size: 12px;
            font-weight: 500;
            background: transparent;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid;
            transition: all 0.2s;
            white-space: nowrap;
            cursor: pointer;
        }
        .admin-action-btn i {
            font-size: 13px;
        }
        .admin-action-edit {
            border-color: var(--admin-gold);
            color: var(--admin-gold);
        }
        .admin-action-edit:hover {
            background: var(--admin-gold);
            color: white;
        }
        .admin-action-delete {
            border-color: var(--admin-red);
            color: var(--admin-red);
        }
        .admin-action-delete:hover {
            background: var(--admin-red);
            color: white;
        }
        .admin-action-view {
            border-color: #64748b;
            color: #64748b;
        }
        .admin-action-view:hover {
            background: #64748b;
            color: white;
        }
        .admin-action-confirm {
            border-color: #0ea5e9;
            color: #0ea5e9;
        }
        .admin-action-confirm:hover {
            background: #0ea5e9;
            color: white;
        }
        .admin-action-shipping {
            border-color: #8b5cf6;
            color: #8b5cf6;
        }
        .admin-action-shipping:hover {
            background: #8b5cf6;
            color: white;
        }
        .admin-action-deliver {
            border-color: var(--admin-green);
            color: var(--admin-green);
        }
        .admin-action-deliver:hover {
            background: var(--admin-green);
            color: white;
        }

        /* Giữ lại action-view cũ cho nút Xem (dùng trong JS) */
        .action-view {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            border-radius: 50px;
            padding: 6px 14px;
            transition: 0.2s;
        }
        .action-view:hover {
            background: #64748b;
            color: white;
        }

        /* ═══ MODAL FORM ═══ */
        .form-card { padding: 25px; }
        .form-section {
            background: #fefefe;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .form-section-title {
            font-size: 14px;
            font-weight: 600;
            color: #2c7da0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        .btn-cancel-modal {
            border: 1px solid #e2e8f0;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            text-decoration: none;
            background: transparent;
        }
        .btn-cancel-modal:hover {
            border-color: #2c7da0;
            color: #2c7da0;
        }
        .form-control:read-only {
            background-color: #f8fafc;
            color: #475569;
        }
    </style>
</head>
<body>

<div class="admin-layout">

    <%@ include file="sidebar/sidebar.jsp"%>                    <main class="main-content">
                        <div class="admin-card">
                            <div class="admin-card-body">
            <div class="page-header-block">
                <h2 class="page-title"><i class="bi bi-receipt"></i> Quản lý đơn hàng</h2>
                <button class="btn btn-pill"><i class="bi bi-download me-1"></i> Xuất dữ liệu</button>
            </div>



                <section class="filters mt-2 mb-4">
                   <!-- FORM TÌM KIẾM VÀ LỌC DỮ LIỆU -->
                   <form action="${pageContext.request.contextPath}/order-admin" method="GET" class="row g-3 mb-4 align-items-center">

                   <!-- Ô tìm kiếm theo Mã -->
                      <div class="col-md-5">
                        <div class="input-group">
                           <span class="input-group-text bg-transparent border-end-0" style="border-radius: 50px 0 0 50px; border-color: #cbd5e1; padding-left: 20px;">
                              <i class="bi bi-search text-muted"></i>
                           </span>
                           <input type="text" name="search" value="${currentSearch}" class="form-control search-input border-start-0 ps-0" style="border-radius: 0 50px 50px 0 !important;" placeholder="Tìm kiếm mã đơn...">
                        </div>
                      </div>

                      <!-- Dropdown status -->
                      <div class="col-md-4">
                        <select name="status" class="form-select custom-select">
                           <option value="" ${empty currentStatus ? 'selected' : ''}>Tất cả trạng thái</option>
                           <option value="PENDING" ${currentStatus == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                           <option value="CONFIRMED" ${currentStatus == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                           <option value="SHIPPING" ${currentStatus == 'SHIPPING' ? 'selected' : ''}>Đang vận chuyển</option>
                           <option value="DELIVERED" ${currentStatus == 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                           <option value="CANCELLED" ${currentStatus == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                      </div>


                       <div class="col-md-3">
                          <button type="submit" class="btn btn-pill w-100"><i class="bi bi-funnel me-1"></i> Lọc dữ liệu</button>
                       </div>

                   </form>
                </section>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="alert alert-info text-center mt-4">Không tìm thấy đơn hàng nào.</div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="admin-table admin-table-hover">
                            <thead>
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th style="width: 15%;">Địa chỉ</th>
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
                                            <div class="fw-semibold" style="color: #334155;">${customerNameMap[ord.userId]}</div>
                                            <small class="text-muted">UID: ${ord.userId}</small>
                                        </td>

                                        <td class="col-nowrap">${ord.orderDate}</td>

                                        <td>
                                            <div class="text-truncate" style="max-width: 150px;" title="${ord.shippingAddress}">
                                                ${ord.shippingAddress}
                                            </div>
                                        </td>

                                        <td>
                                           <c:forEach var="item" items="${ord.items}">
                                              <div class="d-flex align-items-center gap-2 mb-1">
                                                  <img src="${not empty item.imageUrl ? pageContext.request.contextPath.concat('/uploads/').concat(item.imageUrl) : 'https://placehold.co/40?text=LUX'}"
                                                       alt="${item.product.name}"
                                                       style="width: 36px; height: 36px; object-fit: cover; border-radius: 6px; border: 1px solid #e2e8f0; flex-shrink: 0;"
                                                       onerror="this.src='https://placehold.co/40?text=LUX'">
                                                  <span class="fw-semibold text-dark" style="font-size:13px;">${item.product.name}</span>
                                                  <span class="text-danger fw-bold ms-1">x${item.quantity}</span>
                                              </div>
                                           </c:forEach>
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

                                        <td class="col-nowrap">
                                            <div id="action-buttons-${ord.id}" class="d-flex justify-content-center gap-2 flex-nowrap">

                                                <button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal${ord.id}">
                                                    <i class="bi bi-eye"></i>
                                                </button>

                                                <c:choose>
                                                    <c:when test="${ord.orderStatus == 'PENDING' || ord.orderStatus == 'Đang xử lý'}">
                                                        <button type="button" class="admin-action-btn admin-action-confirm" onclick="updateStatusOrder(event, ${ord.id}, 'CONFIRMED')">
                                                            <i class="bi bi-check2-circle"></i> Xác nhận
                                                        </button>
                                                        <button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ${ord.id}, 'CANCELLED')">
                                                            <i class="bi bi-x-circle"></i> Hủy
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${ord.orderStatus == 'CONFIRMED' || ord.orderStatus == 'Đã xác nhận'}">
                                                        <button type="button" class="admin-action-btn admin-action-shipping" onclick="updateStatusOrder(event, ${ord.id}, 'SHIPPING')">
                                                            <i class="bi bi-truck"></i> Giao ĐVVC
                                                        </button>
                                                        <button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ${ord.id}, 'CANCELLED')">
                                                            <i class="bi bi-x-circle"></i> Hủy
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${ord.orderStatus == 'SHIPPING' || ord.orderStatus == 'Đang vận chuyển'}">
                                                        <span class="text-muted small" style="font-size:11px;">Đã giao cho ĐVVC</span>
                                                        <button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ${ord.id}, 'CANCELLED')">
                                                            <i class="bi bi-x-circle"></i> Hủy
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
    <i class="fas fa-check-circle"></i> <span id="toastMessage"> Đơn hàng đã được xác nhận!</span>
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
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>' +
                            '<button type="button" class="admin-action-btn admin-action-shipping" onclick="updateStatusOrder(event, ' + orderId + ', \'SHIPPING\')">' +
                                '<i class="bi bi-truck"></i> Giao ĐVVC' +
                            '</button>' +
                            '<button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ' + orderId + ', \'CANCELLED\')">' +
                                '<i class="bi bi-x-circle"></i> Hủy' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-confirmed">Đã xác nhận</span>';

                    } else if("SHIPPING" === newStatus){
                        document.getElementById("toastMessage").innerText = "Đã bàn giao cho đơn vị vận chuyển!";

                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>' +
                            '<span class="text-muted small" style="font-size:11px;">Đã giao cho ĐVVC</span>' +
                            '<button type="button" class="admin-action-btn admin-action-delete" onclick="updateStatusOrder(event, ' + orderId + ', \'CANCELLED\')">' +
                                '<i class="bi bi-x-circle"></i> Hủy' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-shipping">Đang vận chuyển</span>';

                    } else if("DELIVERED" === newStatus){
                        document.getElementById("toastMessage").innerText = "Đơn hàng #ORD-"+ orderId + " đã được giao!";

                        // giu lai nut xem
                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '">' +
                                '<i class="bi bi-eye"></i>' +
                            '</button>';

                        trangThai.innerHTML = '<span class="badge-status badge-delivered">Đã giao</span>';

                    } else {
                        document.getElementById("toastMessage").innerText = "Đã huỷ đơn hàng: #ORD-"+ orderId + "!";


                        actionGroup.innerHTML =
                            '<button class="admin-action-btn admin-action-view" data-bs-toggle="modal" data-bs-target="#viewOrderModal' + orderId + '">' +
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