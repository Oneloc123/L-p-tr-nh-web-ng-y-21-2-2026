<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">

    <style>

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background-color: #cfe2ff;
            color: #084298;
        }

        .status-shipping {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }

        /* SIDEBAR STYLE - GIỮ NGUYÊN */
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
            -webkit-background-clip: unset;
            background-clip: unset;
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
        }

        .sidebar nav ul li {
            margin-bottom: 0.6rem;
        }

        .sidebar nav ul li a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 18px;
            border-radius: 14px;
            color: #5a6e7c;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 0.95rem;
        }

        .sidebar nav ul li a i {
            font-size: 1.3rem;
            width: 24px;
        }

        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #f0f9ff;
            color: #2c7da0;
            box-shadow: 0 2px 4px rgba(44,125,160,0.08);
            border-left: 2px solid #2c7da0;
        }

        /* MAIN CONTENT */
        .main-content {
            flex: 1;
            padding: 1.5rem 2rem 2rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }

        /* HEADER */
        .header {
            background: #ffffff;
            padding: 1rem 1.8rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            border: 1px solid #e9edf2;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        /* Stat Cards */
        .stat-card {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 20px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -8px rgba(44,125,160,0.12);
            border-color: #2c7da0;
        }

        .stat-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-icon.primary {
            background: linear-gradient(135deg, #e0f2fe, #bae6fd);
            color: #2c7da0;
        }

        .stat-icon.success {
            background: linear-gradient(135deg, #dcfce7, #bbf7d0);
            color: #22c55e;
        }

        .stat-icon.warning {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #f59e0b;
        }

        .stat-icon.danger {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: #ef4444;
        }

        .stat-icon.orders {
            background: linear-gradient(135deg, #f3e8ff, #e9d5ff);
            color: #a855f7;
        }

        .stat-icon.spending {
            background: linear-gradient(135deg, #fefce8, #fef08a);
            color: #eab308;
        }

        .stat-info h3 {
            font-size: 26px;
            font-weight: 700;
            margin: 0;
            color: #1e293b;
        }

        .stat-info p {
            margin: 4px 0 0;
            color: #64748b;
            font-size: 13px;
            font-weight: 500;
        }

        .stat-trend {
            font-size: 12px;
            font-weight: 600;
            margin-top: 8px;
        }
        .trend-up { color: #22c55e; }
        .trend-down { color: #ef4444; }

        /* Alert Notification Styles */
        .alert-box {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e9edf2;
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .alert-box.border-danger-light { border-left: 4px solid #ef4444; }
        .alert-box.border-warning-light { border-left: 4px solid #f59e0b; }
        .alert-box.border-info-light { border-left: 4px solid #3b82f6; }

        /* Dashboard Row */
        .dashboard-row {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        /* Recent Card */
        .recent-card {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 20px;
            overflow: hidden;
            height: 100%;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e9edf2;
            background: #ffffff;
        }

        .card-header h3 {
            font-size: 1rem;
            font-weight: 600;
            margin: 0;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .view-all {
            font-size: 13px;
            color: #2c7da0;
            text-decoration: none;
            font-weight: 500;
        }

        .view-all:hover {
            text-decoration: underline;
        }

        .orders-table {
            padding: 0 1.5rem;
        }

        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-info {
            flex: 1;
        }

        .order-id {
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 4px;
            font-size: 14px;
        }

        .order-date {
            font-size: 11px;
            color: #94a3b8;
        }

        .order-amount {
            font-weight: 700;
            color: #1e293b;
            margin-right: 1rem;
            font-size: 14px;
        }

        .order-status {
            padding: 4px 12px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-align: center;
            min-width: 100px;
        }

        .status-delivered { background: #d1fae5; color: #065f46; }
        .status-shipping { background: #fed7aa; color: #9a3412; }
        .status-pending { background: #fee2e2; color: #b91c1c; }
        .status-processing { background: #dbeafe; color: #1e40af; }
        .status-completed { background: #d1fae5; color: #065f46; }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 0.5rem;
        }

        .quick-action-btn {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 16px;
            padding: 1rem;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .quick-action-btn:hover {
            background: #f0f9ff;
            border-color: #2c7da0;
            transform: translateY(-2px);
        }

        .quick-action-btn i {
            font-size: 22px;
            color: #2c7da0;
        }

        .quick-action-btn span {
            font-size: 14px;
            font-weight: 600;
            color: #1e293b;
        }

        /* Product Best Seller Style */
        .product-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0.85rem 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .product-item:last-child { border-bottom: none; }
        .product-img-box {
            width: 45px;
            height: 45px;
            background: #f8fafc;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 1rem 0.5rem;
            }

            .sidebar .logo span {
                display: none;
            }

            .sidebar nav ul li a span {
                display: none;
            }

            .sidebar nav ul li a i {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        footer {
            margin-top: 2rem;
            text-align: center;
            color: #94a3b8;
            font-size: 12px;
            border-top: 1px solid #e9edf2;
            padding-top: 1.5rem;
        }
    </style>
</head>

<body>
<div class="d-flex">

    <%@ include file="sidebar/sidebar.jsp"%>
    <main class="main-content">
        <header class="header d-flex justify-content-between align-items-center flex-wrap gap-2">
            <h3 class="fw-bold m-0">
                <i class="bi bi-speedometer2 me-2" style="color:#2c7da0;"></i>
                Bảng điều khiển kinh doanh
            </h3>
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <select class="form-select form-select-sm border-secondary-subtle"
                        style="border-radius: 30px; width: 150px; font-size: 13px;"
                        onchange="window.location.href='${pageContext.request.contextPath}/admin/dashboard?days=' + this.value">
                    <option value="1" ${selectedDays == 1 ? 'selected' : ''}>Hôm nay</option>
                    <option value="7" ${selectedDays == 7 || selectedDays == null ? 'selected' : ''}>7 ngày qua</option>
                    <option value="30" ${selectedDays == 30 ? 'selected' : ''}>Tháng này (30 ngày)</option>
                    <option value="365" ${selectedDays == 365 ? 'selected' : ''}>Năm nay (365 ngày)</option>
                </select>
                <span class="text-muted small px-2">
                    <i class="bi bi-calendar3"></i>
                    <script>document.write(new Date().toLocaleDateString('vi-VN'));</script>
                </span>
                <button class="btn btn-primary btn-sm px-3" onclick="window.location.reload()" style="border-radius: 30px; background: #2c7da0; border: none;">
                    <i class="bi bi-arrow-repeat"></i> Làm mới
                </button>
            </div>
        </header>

        <div class="row g-4 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div class="stat-info">
                            <h3><fmt:formatNumber
                                    value="${totalPriceOrder}"
                                    type="number"
                                    groupingUsed="true"/>
                                ₫</h3>
                            <p>Doanh thu thuần</p>
                            <span class="stat-trend trend-up"><i class="bi bi-arrow-up-short"></i> ${growPriceOder}% </span>
                        </div>
                        <div class="stat-icon success">
                            <i class="bi bi-currency-dollar"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="stat-card" onclick="window.location.href='/orderAdmin'">
                    <div class="d-flex justify-content-between align-items-start">
                        <div class="stat-info">
                            <h3>${totalOrder} đơn</h3>
                            <p>Tổng đơn hàng</p>
                            <span class="stat-trend trend-up"><i class="bi bi-arrow-up-short"></i> ${growTotalOrder}%</span>
                        </div>
                        <div class="stat-icon orders">
                            <i class="bi bi-bag-check-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div class="stat-info">
                            <h3><fmt:formatNumber
                                    value="${averagePriceOrder}"
                                    type="number"
                                    groupingUsed="true"/>
                                ₫</h3>
                            <p>Giá trị TB đơn (AOV)</p>
                            <span class="stat-trend trend-down"><i class="bi bi-arrow-down-short"></i> ${growAverage}%</span>
                        </div>
                        <div class="stat-icon spending">
                            <i class="bi bi-graph-up-arrow"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="alert-box border-danger-light">
                    <i class="bi bi-exclamation-triangle-fill text-danger fs-4"></i>
                    <div>
                        <div class="fw-bold text-dark mb-0">${inProcess} đơn hàng đang chờ xử lý</div>
                        <small class="text-muted">Đang chờ quản trị viên phê duyệt</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="alert-box border-warning-light">
                    <i class="bi bi-clock-fill text-warning fs-4"></i>
                    <div>
                        <div class="fw-bold text-dark mb-0">${cancelled} Đơn hàng đã huỷ</div>
                        <small class="text-muted">Xem lý do huỷ đơn hàng</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="alert-box border-info-light">
                    <i class="bi bi-arrow-counterclockwise text-info fs-4"></i>
                    <div>
                        <div class="fw-bold text-dark mb-0">${delivered} đơn hàng đã giao</div>
                        <small class="text-muted">Theo dõi thanh toán đơn hàng</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-lg-8">
                <div class="recent-card">
                    <div class="card-header">
                        <h3><i class="bi bi-bar-chart-line"></i> Doanh thu & Đơn hàng (${selectedDays != null ? selectedDays : 7} ngày qua)</h3>
                    </div>
                    <div class="p-3">
                        <canvas id="revenueChart" style="max-height: 320px; width: 100%;"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="recent-card">
                    <div class="card-header">
                        <h3><i class="bi bi-pie-chart"></i> Phương thức thanh toán</h3>
                    </div>
                    <div class="p-3 d-flex align-items-center justify-content-center">
                        <canvas id="paymentChart" style="max-height: 320px; max-width: 320px;"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-lg-7">
                <div class="recent-card">
                    <div class="card-header">
                        <h3><i class="bi bi-clock-history"></i> Đơn hàng vừa đặt</h3>
                        <a href="/order-admin" class="view-all">Xem tất cả <i class="bi bi-arrow-right-short"></i></a>
                    </div>
                    <div class="orders-table">
                        <c:forEach items="${listOrder}" var="order" begin="0" end="4">

                            <c:set var="statusClass" value="status-pending"/>

                            <c:choose>
                                <c:when test="${order.orderStatus eq 'PENDING'}">
                                    <c:set var="statusClass" value="status-pending"/>
                                    <c:set var="statusText" value="Chờ xử lý"/>
                                </c:when>

                                <c:when test="${order.orderStatus eq 'Đang xử lý'}">
                                    <c:set var="statusClass" value="status-processing"/>
                                    <c:set var="statusText" value="Đang xử lý"/>
                                </c:when>

                                <c:when test="${order.orderStatus eq 'SHIPPING'}">
                                    <c:set var="statusClass" value="status-shipping"/>
                                    <c:set var="statusText" value="Đang giao"/>
                                </c:when>

                                <c:when test="${order.orderStatus eq 'CONFIRMED'}">
                                    <c:set var="statusClass" value="status-completed"/>
                                    <c:set var="statusText" value="Đã hoàn thành"/>
                                </c:when>

                                <c:when test="${order.orderStatus eq 'CANCELLED'}">
                                    <c:set var="statusClass" value="status-cancelled"/>
                                    <c:set var="statusText" value="Đã hủy"/>
                                </c:when>
                            </c:choose>
                            <div class="order-item">
                                <div class="order-info">
                                    <div class="order-id">
                                        #ORD-${order.id}
                                        <span class="fw-normal text-muted" style="font-size:13px;">
                    - mã khách hàng ${order.userId}
                </span>
                                    </div>

                                    <div class="order-date">
                                        <fmt:formatDate
                                                value="${order.orderDate}"
                                                pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </div>

                                <div class="order-amount">
                                    <fmt:formatNumber
                                            value="${order.totalAmount}"
                                            type="number"
                                            groupingUsed="true"/>
                                    ₫
                                </div>

                            </div>

                        </c:forEach>

                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="recent-card">
                    <div class="card-header">
                        <h3><i class="bi bi-fire text-danger"></i> Sản phẩm bán chạy nhất</h3>
                        <a href="/admin/products" class="view-all">Xem kho kho <i class="bi bi-arrow-right-short"></i></a>
                    </div>
                    <div class="px-4">
                        <div class="product-item">
                            <div class="product-img-box"><i class="bi bi-car-front-fill"></i></div>
                            <div class="flex-grow-1">
                                <div class="fw-bold style-14 text-dark">Thảm lót sàn da Nappa cao cấp</div>
                                <small class="text-muted">Đã bán: 124 bộ</small>
                            </div>
                            <div class="fw-bold text-end text-primary" style="font-size:14px;">347M ₫</div>
                        </div>
                        <div class="product-item">
                            <div class="product-img-box"><i class="bi bi-camera-video-fill"></i></div>
                            <div class="flex-grow-1">
                                <div class="fw-bold style-14 text-dark">Camera hành trình 4K UltraHD</div>
                                <small class="text-muted">Đã bán: 98 cái</small>
                            </div>
                            <div class="fw-bold text-end text-primary" style="font-size:14px;">411M ₫</div>
                        </div>
                        <div class="product-item">
                            <div class="product-img-box"><i class="bi bi-shield-shaded"></i></div>
                            <div class="flex-grow-1">
                                <div class="fw-bold style-14 text-dark">Phim cách nhiệt 3M Crystalline</div>
                                <small class="text-muted">Đã bán: 86 gói</small>
                            </div>
                            <div class="fw-bold text-end text-primary" style="font-size:14px;">602M ₫</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h5 class="fw-bold mb-3 mt-4" style="font-size:15px; color:#64748b;">Thao tác nhanh hệ thống</h5>
        <div class="quick-actions">
            <a href="/admin/products" class="quick-action-btn">
                <i class="bi bi-box-seam-fill"></i>
                <span>Thêm sản phẩm mới</span>
            </a>
            <a href="/order-admin" class="quick-action-btn">
                <i class="bi bi-cart-fill"></i>
                <span>Xử lý đơn hàng</span>
            </a>
            <a href="/userAdmin" class="quick-action-btn">
                <i class="bi bi-people-fill"></i>
                <span>Phân nhóm khách hàng</span>
            </a>
            <a href="/admin/vouchers" class="quick-action-btn">
                <i class="bi bi-ticket-perforated-fill text-warning"></i>
                <span>Tạo mã giảm giá</span>
            </a>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 1. Khởi tạo Biểu đồ Doanh thu 7 ngày qua (Line Chart)
    const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctxRevenue, {
        type: 'line',
        data: {
            // Duyệt danh sách ngày từ Backend gửi qua (Ví dụ: '27/05', '28/05'...)
            labels: [
                <c:forEach var="label" items="${revenueLabels}" varStatus="status">
                '${label}'${!status.last ? ',' : ''}
                </c:forEach>
            ],
            datasets: [{
                label: 'Doanh thu (₫)',
                // Duyệt danh sách số tiền tương ứng của từng ngày
                data: [
                    <c:forEach var="value" items="${revenueData}" varStatus="status">
                    ${value}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                borderColor: '#2c7da0',
                backgroundColor: 'rgba(44, 125, 160, 0.1)',
                borderWidth: 3,
                fill: true,
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        // Định dạng hiển thị tiền tệ VNĐ trên trục Y cho chuyên nghiệp
                        callback: function(value) {
                            return value.toLocaleString('vi-VN') + ' ₫';
                        }
                    }
                }
            }
        }
    });

    // 2. Khởi tạo Biểu đồ Phương thức thanh toán (Doughnut Chart)
    const ctxPayment = document.getElementById('paymentChart').getContext('2d');
    new Chart(ctxPayment, {
        type: 'doughnut',
        data: {
            // Duyệt danh sách các phương thức thanh toán xuất hiện (Ví dụ: 'COD', 'Momo'...)
            labels: [
                <c:forEach var="label" items="${paymentLabels}" varStatus="status">
                '${label}'${!status.last ? ',' : ''}
                </c:forEach>
            ],
            datasets: [{
                // Duyệt số lượng đơn hàng hoặc tỷ lệ tương ứng
                data: [
                    <c:forEach var="value" items="${paymentData}" varStatus="status">
                    ${value}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                backgroundColor: ['#2c7da0', '#22c55e', '#f59e0b', '#ef4444', '#a855f7'],
                borderWidth: 2,
                borderColor: '#ffffff'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom', labels: { boxWidth: 12, font: { size: 12 } } }
            }
        }
    });
</script>


</body>
</html>