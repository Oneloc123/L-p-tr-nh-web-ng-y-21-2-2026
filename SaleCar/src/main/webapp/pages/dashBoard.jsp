<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bảng điều khiển - LUXCAR</title>
    <%@ include file="/common/header.jsp" %>
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar */
        .dashboard-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
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

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            border: 1px solid #e9ecef;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .stat-info h3 {
            font-size: 28px;
            font-weight: 700;
            color: #000000;
            margin-bottom: 5px;
        }
        .stat-info p {
            font-size: 14px;
            color: #6c757d;
            margin: 0;
        }
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        .stat-icon.orders { background: #fff3e0; color: #ff9800; }
        .stat-icon.spending { background: #e8f5e9; color: #4caf50; }
        .stat-icon.favorites { background: #fee8e8; color: #f44336; }
        .stat-icon.cart { background: #e3f2fd; color: #2196f3; }

        /* Chart and Recent Orders Section */
        .dashboard-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }
        .chart-card, .recent-card, .quick-actions-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .card-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .card-header h3 i {
            color: #000000;
        }
        .view-all {
            color: #000000;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
        }
        .view-all:hover {
            text-decoration: underline;
        }

        /* Recent Orders Table */
        .orders-table {
            width: 100%;
        }
        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .order-info {
            flex: 1;
        }
        .order-id {
            font-weight: 600;
            color: #000000;
            margin-bottom: 4px;
        }
        .order-date {
            font-size: 12px;
            color: #6c757d;
        }
        .order-amount {
            font-weight: 600;
            color: #000000;
            margin-right: 15px;
        }
        .order-status {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .status-delivered { background: #e8f5e9; color: #2e7d32; }
        .status-shipping { background: #fff3e0; color: #ed6c02; }
        .status-pending { background: #ffebee; color: #c62828; }
        .status-processing { background: #e3f2fd; color: #1976d2; }

        /* Quick Actions */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s;
            border: 1px solid #e9ecef;
        }
        .action-btn:hover {
            background: #000000;
            transform: translateY(-3px);
        }
        .action-btn i {
            font-size: 28px;
            color: #000000;
            margin-bottom: 10px;
            transition: color 0.3s;
        }
        .action-btn span {
            font-size: 14px;
            font-weight: 500;
            color: #495057;
            transition: color 0.3s;
        }
        .action-btn:hover i,
        .action-btn:hover span {
            color: #ffffff;
        }

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #000000 0%, #333333 100%);
            border-radius: 16px;
            padding: 25px 30px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .welcome-text h2 {
            color: white;
            font-size: 24px;
            margin-bottom: 8px;
        }
        .welcome-text p {
            color: rgba(255,255,255,0.8);
            margin: 0;
        }
        .welcome-stats {
            display: flex;
            gap: 30px;
        }
        .welcome-stat {
            text-align: center;
        }
        .welcome-stat .number {
            color: white;
            font-size: 28px;
            font-weight: 700;
        }
        .welcome-stat .label {
            color: rgba(255,255,255,0.7);
            font-size: 12px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .dashboard-row {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .sidebar-menu {
                width: 0;
                display: none;
            }
            .welcome-banner {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            .actions-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
    <!-- Sidebar Menu -->
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item active">
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

            <a href="${pageContext.request.contextPath}/order" class="menu-item">
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

<%--            <div class="menu-divider"></div>--%>

<%--            <a href="${pageContext.request.contextPath}/address-list" class="menu-item">--%>
<%--                <i class="fas fa-map-marker-alt"></i>--%>
<%--                <span>Sổ địa chỉ</span>--%>
<%--            </a>--%>

<%--            <a href="${pageContext.request.contextPath}/notifications" class="menu-item">--%>
<%--                <i class="fas fa-bell"></i>--%>
<%--                <span>Thông báo</span>--%>
<%--            </a>--%>

<%--            <a href="${pageContext.request.contextPath}/settings" class="menu-item">--%>
<%--                <i class="fas fa-cog"></i>--%>
<%--                <span>Cài đặt</span>--%>
<%--            </a>--%>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="content-header">
            <h1>Bảng điều khiển</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Dashboard</li>
                </ol>
            </nav>
        </div>

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Chào mừng trở lại, ${user.getFullname()}!</h2>
                <p>Dưới đây là tổng quan hoạt động của bạn tại LUXCAR</p>
            </div>
            <div class="welcome-stats">
                <div class="welcome-stat">
                    <div class="number">${totalOrders}</div>
                    <div class="label">Đơn hàng</div>
                </div>
                <div class="welcome-stat">
                    <div class="number"><fmt:formatNumber value="${totalSpending}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></div>
                    <div class="label">Tổng chi tiêu</div>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>${totalOrders}</h3>
                    <p>Tổng đơn hàng</p>
                </div>
                <div class="stat-icon orders">
                    <i class="fas fa-shopping-bag"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3><fmt:formatNumber value="${totalSpending}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></h3>
                    <p>Tổng chi tiêu</p>
                </div>
                <div class="stat-icon spending">
                    <i class="fas fa-chart-line"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>${totalFavorites}</h3>
                    <p>Sản phẩm yêu thích</p>
                </div>
                <div class="stat-icon favorites">
                    <i class="fas fa-heart"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>${cartItemCount}</h3>
                    <p>Sản phẩm trong giỏ</p>
                </div>
                <div class="stat-icon cart">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
        </div>

        <!-- Dashboard Row: Chart & Recent Orders -->
        <div class="dashboard-row">
            <!-- Spending Chart -->
<%--            <div class="chart-card">--%>
<%--                <div class="card-header">--%>
<%--                    <h3><i class="fas fa-chart-bar"></i> Thống kê chi tiêu 6 tháng gần nhất</h3>--%>
<%--                </div>--%>
<%--                <canvas id="spendingChart" style="max-height: 300px;"></canvas>--%>
<%--            </div>--%>

            <!-- Recent Orders -->
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-clock"></i> Đơn hàng gần đây</h3>
                    <a href="${pageContext.request.contextPath}/order" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
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
                                    <i class="fas fa-check-circle"></i> ${order.orderStatus}
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 40px;">
                                <i class="fas fa-shopping-bag" style="font-size: 48px; color: #ddd;"></i>
                                <p style="margin-top: 15px; color: #6c757d;">Chưa có đơn hàng nào</p>
                                <a href="${pageContext.request.contextPath}/shop" class="btn-add-address" style="display: inline-block; margin-top: 10px;">Mua sắm ngay</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions-card">
            <div class="card-header">
                <h3><i class="fas fa-bolt"></i> Thao tác nhanh</h3>
            </div>
            <div class="actions-grid">
                <a href="${pageContext.request.contextPath}/shop" class="action-btn">
                    <i class="fas fa-store"></i>
                    <span>Tiếp tục mua sắm</span>
                </a>
                <a href="${pageContext.request.contextPath}/cart" class="action-btn">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Xem giỏ hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/order" class="action-btn">
                    <i class="fas fa-truck"></i>
                    <span>Theo dõi đơn hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/favorites" class="action-btn">
                    <i class="fas fa-heart"></i>
                    <span>Sản phẩm yêu thích</span>
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>