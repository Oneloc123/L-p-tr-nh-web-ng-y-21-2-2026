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
            font-size: 28px;
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

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

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
            padding: 0 1rem;
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

            .stat-card {
                margin-bottom: 0;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 3rem;
        }

        .empty-state i {
            font-size: 48px;
            color: #cbd5e1;
        }

        .empty-state p {
            margin-top: 1rem;
            color: #64748b;
        }

        .btn-add-address {
            background: #2c7da0;
            color: white;
            padding: 8px 20px;
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            display: inline-block;
            margin-top: 0.5rem;
        }

        .btn-add-address:hover {
            background: #1e5a7a;
            color: white;
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

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="header d-flex justify-content-between align-items-center flex-wrap gap-2">
            <h3 class="fw-bold m-0">
                <i class="bi bi-speedometer2 me-2" style="color:#2c7da0;"></i>
                Tổng quan hệ thống
            </h3>
            <div class="d-flex align-items-center gap-3">
                <span class="text-muted small">
                    <i class="bi bi-calendar3"></i>
                    <script>document.write(new Date().toLocaleDateString('vi-VN'));</script>
                </span>
                <button class="btn btn-primary btn-sm px-3" onclick="window.location.reload()" style="border-radius: 30px; background: #2c7da0; border: none;">
                    <i class="bi bi-arrow-repeat"></i> Làm mới
                </button>
            </div>
        </header>

        <!-- Statistics Cards Row 1 -->
        <div class="row g-4 mb-4">
            <div class="col-md-3 col-sm-6">
                <div class="stat-card" onclick="window.location.href='/userAdmin'">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="stat-info">
                            <h3>${totalUser}</h3>
                            <p>Tổng người dùng</p>
                        </div>
                        <div class="stat-icon primary">
                            <i class="bi bi-people-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="stat-info">
                            <h3>${activeUsers}</h3>
                            <p>Đang hoạt động</p>
                        </div>
                        <div class="stat-icon success">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="stat-info">
                            <h3>${inactiveUsers}</h3>
                            <p>Đã khóa</p>
                        </div>
                        <div class="stat-icon warning">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="stat-info">
                            <h3>${totalAdmins}</h3>
                            <p>Quản trị viên</p>
                        </div>
                        <div class="stat-icon danger">
                            <i class="bi bi-shield-lock-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Cards Row 2 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="stat-info">
                        <h3>${totalOrders}</h3>
                        <p>Tổng đơn hàng</p>
                    </div>
                    <div class="stat-icon orders">
                        <i class="bi bi-bag-check-fill"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="stat-info">
                        <h3><fmt:formatNumber value="${totalSpending}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></h3>
                        <p>Tổng chi tiêu</p>
                    </div>
                    <div class="stat-icon spending">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="dashboard-row">
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="bi bi-clock-history"></i> Đơn hàng gần đây</h3>
                    <a href="${pageContext.request.contextPath}/orderAdmin" class="view-all">Xem tất cả <i class="bi bi-arrow-right-short"></i></a>
                </div>
                <div class="orders-table">
                    <c:choose>
                        <c:when test="${not empty listOrder}">
                            <c:forEach var="order" items="${listOrder}">
                                <div class="order-item">
                                    <div class="order-info">
                                        <div class="order-id">#${order.id}</div>
                                        <div class="order-date">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </div>
                                    </div>
                                    <div class="order-amount">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                    <span class="order-status status-${order.orderStatus}">
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'DELIVERED'}">Đã giao</c:when>
                                            <c:when test="${order.orderStatus == 'SHIPPING'}">Đang giao</c:when>
                                            <c:when test="${order.orderStatus == 'PENDING'}">Chờ xử lý</c:when>
                                            <c:when test="${order.orderStatus == 'PROCESSING'}">Đang xử lý</c:when>
                                            <c:when test="${order.orderStatus == 'COMPLETED'}">Hoàn thành</c:when>
                                            <c:otherwise>${order.orderStatus}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="bi bi-bag-x"></i>
                                <p>Chưa có đơn hàng nào</p>
                                <a href="${pageContext.request.contextPath}/shop" class="btn-add-address">Mua sắm ngay</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="/userAdmin" class="quick-action-btn">
                <i class="bi bi-people-fill"></i>
                <span>Quản lý người dùng</span>
            </a>
            <a href="/admin/products" class="quick-action-btn">
                <i class="bi bi-box-seam-fill"></i>
                <span>Quản lý sản phẩm</span>
            </a>
            <a href="/orderAdmin" class="quick-action-btn">
                <i class="bi bi-cart-fill"></i>
                <span>Quản lý đơn hàng</span>
            </a>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="/common/footer.jsp" %>

</body>
</html>