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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card {
            background: var(--bg-surface);
            border-radius: var(--radius-md);
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--shadow-card);
            border: 1px solid var(--border-subtle);
        }
        .stat-info h3 { font-size: 24px; font-weight: 700; color: var(--text-primary); margin-bottom: 5px; }
        .stat-info p { font-size: 13px; color: var(--text-muted); margin: 0; }
        .stat-icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .stat-icon.orders   { background: rgba(255, 152, 0, 0.12); color: #ff9800; }
        .stat-icon.spending { background: rgba(76, 175, 80, 0.12); color: #4caf50; }
        .stat-icon.favorites{ background: rgba(244, 67, 54, 0.12); color: #f44336; }
        .stat-icon.vouchers { background: rgba(0, 172, 193, 0.12); color: #00acc1; }

        .dashboard-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px; margin-bottom: 30px; }
        .recent-card {
            background: var(--bg-surface);
            border-radius: var(--radius-md);
            padding: 22px;
            box-shadow: var(--shadow-card);
            border: 1px solid var(--border-subtle);
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border-subtle);
        }
        .card-header h3 { font-size: 16px; font-weight: 600; color: var(--text-primary); margin: 0; display: flex; align-items: center; gap: 8px; }
        .card-header h3 i { color: var(--gold); }
        .view-all { color: var(--text-muted); text-decoration: none; font-size: 13px; font-weight: 500; transition: color var(--transition-fast); }
        .view-all:hover { color: var(--gold); text-decoration: none; }

        .order-item { display: flex; align-items: center; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--border-subtle); gap: 10px; }
        .order-item:last-child { border-bottom: none; }
        .order-info { flex: 1; min-width: 0; }
        .order-id { font-weight: 600; color: var(--text-primary); margin-bottom: 4px; font-size: 14px; }
        .order-meta { font-size: 12px; color: var(--text-muted); display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
        .order-meta .payment-method { background: var(--bg-elevated); padding: 2px 6px; border-radius: 4px; font-size: 11px; color: var(--text-secondary); }
        .order-amount { font-weight: 700; color: var(--gold); font-size: 14px; }
        .order-status { padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 600; text-transform: uppercase; }
        .status-processing{ background: rgba(21, 101, 192, 0.12); color: #42a5f5; }
        .status-pending   { background: rgba(245, 127, 23, 0.12); color: #ffb74d; }
        .status-delivered { background: rgba(0, 105, 92, 0.12); color: #4db6ac; }
        .payment-paid   { color: #2ecc71; }
        .payment-unpaid { color: #e74c3c; }

        .wishlist-item { display: flex; align-items: center; gap: 12px; padding: 12px 0; border-bottom: 1px solid var(--border-subtle); }
        .wishlist-item:last-child { border-bottom: none; }
        .wishlist-img { width: 44px; height: 44px; border-radius: 8px; object-fit: cover; background: var(--bg-elevated); }
        .wishlist-info { flex: 1; min-width: 0; }
        .wishlist-name { font-size: 13px; font-weight: 600; color: var(--text-primary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .wishlist-price { font-size: 12px; }
        .wishlist-price .final { color: var(--text-primary); font-weight: 600; }
        .wishlist-price .original { text-decoration: line-through; color: var(--text-muted); margin-left: 5px; font-size: 11px; }
        .wishlist-price .badge-disc { background: rgba(244, 67, 54, 0.12); color: #f44336; font-size: 10px; padding: 1px 4px; border-radius: 4px; margin-left: 5px; }

        .noti-item { display: flex; gap: 12px; padding: 12px 0; border-bottom: 1px solid var(--border-subtle); align-items: flex-start; }
        .noti-item:last-child { border-bottom: none; }
        .noti-icon { width: 32px; height: 32px; border-radius: 50%; background: var(--bg-elevated); display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .noti-icon.success { background: rgba(76, 175, 80, 0.12); color: #4caf50; }
        .noti-icon.info { background: rgba(33, 150, 243, 0.12); color: #2196f3; }
        .noti-content { flex: 1; }
        .noti-text { font-size: 13px; color: var(--text-secondary); line-height: 1.4; margin: 0 0 3px 0; }
        .noti-time { font-size: 11px; color: var(--text-muted); }

        .voucher-item { display: flex; border: 1px dashed var(--border-subtle); border-radius: var(--radius-sm); margin-bottom: 12px; background: var(--bg-elevated); overflow: hidden; }
        .voucher-item:last-child { margin-bottom: 0; }
        .voucher-left {
            background: #0a0a0a;
            color: var(--gold);
            padding: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 85px;
            text-align: center;
            border-right: 1px solid var(--border-subtle);
        }
        .voucher-left i { font-size: 18px; margin-bottom: 4px; }
        .voucher-left span { font-size: 11px; text-transform: uppercase; font-weight: bold; }
        .voucher-right { flex: 1; padding: 12px 15px; display: flex; flex-direction: column; justify-content: center; }
        .voucher-expiry { font-size: 11px; color: var(--text-muted); }

        .address-box {
            padding: 15px;
            border: 1px solid var(--border-subtle);
            border-radius: 10px;
            background: var(--bg-elevated);
            position: relative;
            margin-bottom: 12px;
        }
        .address-box:last-child { margin-bottom: 0; }
        .address-box.default { border-color: var(--border-gold); background: var(--bg-elevated); }
        .address-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
            font-size: 10px;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 700;
        }
        .address-name { font-weight: 600; font-size: 14px; color: var(--text-primary); margin-bottom: 6px; }
        .address-phone { font-size: 13px; color: var(--text-secondary); margin-bottom: 4px; }
        .address-text { font-size: 13px; color: var(--text-muted); line-height: 1.4; }

        .security-list { display: flex; flex-direction: column; gap: 15px; }
        .security-item { display: flex; align-items: center; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--border-subtle); }
        .security-item:last-child { border-bottom: none; }
        .security-info { display: flex; align-items: center; gap: 12px; }
        .security-info i { font-size: 18px; color: var(--gold); width: 20px; }
        .security-label { font-size: 13px; font-weight: 500; color: var(--text-primary); }
        .security-value { font-size: 13px; color: var(--text-muted); margin-left: 10px; }
        .security-status { font-size: 12px; padding: 2px 8px; border-radius: 4px; font-weight: 500; }
        .status-verified { background: rgba(46, 204, 113, 0.12); color: #2ecc71; }
        .status-warning { background: rgba(230, 81, 0, 0.12); color: #ff7043; }
        .status-success { background: rgba(46, 204, 113, 0.12); color: #2ecc71; }

        .welcome-banner {
            background: linear-gradient(135deg, #0a0a0a 0%, #1f1f1f 100%);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-md);
            padding: 25px 30px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-card);
        }
        .welcome-text h2 { color: #fff; font-size: 22px; margin-bottom: 8px; font-family: 'Playfair Display', serif; }
        .welcome-text p { color: var(--text-muted); margin: 0; font-size: 14px; }
        .welcome-stats { display: flex; gap: 30px; }
        .welcome-stat { text-align: center; }
        .welcome-stat .number { color: var(--gold); font-size: 24px; font-weight: 700; }
        .welcome-stat .label { color: var(--text-muted); font-size: 12px; margin-top: 2px; }

        .status-summary { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 25px; }
        .status-pill {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            color: var(--text-secondary);
        }
        .status-pill .dot { width: 8px; height: 8px; border-radius: 50%; }
        .dot-pending { background: #f57f17; }
        .dot-processing { background: #1565c0; }
        .dot-shipping { background: #2e7d32; }
        .dot-delivered { background: #00695c; }
        .dot-cancelled { background: #b71c1c; }

        .noti-empty { padding: 20px 0; text-align: center; }
        .noti-empty p { color: var(--text-muted); font-size: 13px; }

        .quick-actions-card { margin-top: 30px; }

        @media (max-width: 1024px) { .dashboard-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .sidebar-menu { display: none; } .actions-grid { grid-template-columns: repeat(2, 1fr); } }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
    <!-- Sidebar chung -->
    <%@ include file="/common/user-sidebar.jsp" %>

    <div class="main-content">
        <div class="content-header">
            <h1>Bảng điều khiển</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Dashboard</li>
                </ol>
            </nav>
        </div>

        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Chào mừng trở lại, ${sessionScope.user.username}!</h2>
                <p>Hệ thống giám sát hành trình mua sắm và ưu đãi dành riêng cho bạn tại LUXCAR.</p>
            </div>
            <div class="welcome-stats">
                <div class="welcome-stat">
                    <div class="number">${totalOrders}</div>
                    <div class="label">Đơn hàng</div>
                </div>
                <div class="welcome-stat">
                    <div class="number"><fmt:formatNumber
                            value="${totalSpending}"
                            type="number"
                            groupingUsed="true"/>
                        ₫</div>
                    <div class="label">Đã chi tiêu</div>
                </div>
                <div class="welcome-stat">
                    <div class="number">${totalVoucher}</div>
                    <div class="label"> Mã giảm giá</div>
                </div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info"><h3>${totalOrders}</h3><p>Tổng đơn đặt hàng</p></div>
                <div class="stat-icon orders"><i class="fas fa-shopping-bag"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3><fmt:formatNumber
                        value="${totalSpending}"
                        type="number"
                        groupingUsed="true"/>
                    ₫</h3><p>Tổng chi tiêu tích lũy</p></div>
                <div class="stat-icon spending"><i class="fas fa-wallet"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>${totalFavorites}</h3><p> Sản phẩm yêu thích</p></div>
                <div class="stat-icon favorites"><i class="fas fa-heart"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>${totalVoucher} mã áp dụng</h3><p>Kho Voucher khả dụng</p></div>
                <div class="stat-icon vouchers"><i class="fas fa-ticket-alt"></i></div>
            </div>
        </div>

        <div class="status-summary">
            <div class="status-pill">
                <span class="dot dot-pending"></span>
                Chờ xác nhận: <strong>${pendingCount}</strong>
            </div>

            <div class="status-pill">
                <span class="dot dot-processing"></span>
                Đang xử lý: <strong>${processingCount}</strong>
            </div>

            <div class="status-pill">
                <span class="dot dot-shipping"></span>
                Đang giao: <strong>${shippingCount}</strong>
            </div>

            <div class="status-pill">
                <span class="dot dot-delivered"></span>
                Đã giao: <strong>${deliveredCount}</strong>
            </div>

            <div class="status-pill">
                <span class="dot dot-cancelled"></span>
                Đã hủy: <strong>${cancelledCount}</strong>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-history"></i> Đơn hàng gần đây</h3>
                    <a href="/order" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
                </div>
                <c:forEach items="${listOrder}" var="order" begin="0" end="4">


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
                            <div class="order-id">#LC-${order.id}</div>

                            <div class="order-meta">
                <span>
                    <fmt:formatDate value="${order.orderDate}"
                                    pattern="dd/MM/yyyy HH:mm"/>
                </span>

                                <span class="payment-method">
                                        ${order.paymentMethod}
                                </span>

                            </div>
                        </div>

                        <div class="order-amount">
                            <fmt:formatNumber value="${order.totalAmount}"
                                              type="number"
                                              groupingUsed="true"/> ₫
                        </div>
                    </div>

                </c:forEach>
            </div>

            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-heart"></i> Yêu thích gần đây</h3>
                    <a href="/favorites" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="wishlist-item">
                    <img src="https://images.unsplash.com/photo-1542282088-72c9c27ed0cd?w=100" class="wishlist-img" alt="Product">
                    <div class="wishlist-info">
                        <div class="wishlist-name">Vô lăng thể thao bọc da Alcantara</div>
                        <div class="wishlist-price"><span class="final">12.800.000 ₫</span><span class="original">15.000.000 ₫</span><span class="badge-disc">-15%</span></div>
                    </div>
                </div>
                <div class="wishlist-item">
                    <img src="https://images.unsplash.com/photo-1617814076367-b759c7d7e738?w=100" class="wishlist-img" alt="Product">
                    <div class="wishlist-info">
                        <div class="wishlist-name">Thảm lót sàn Carbon cao cấp LUXCAR</div>
                        <div class="wishlist-price"><span class="final">2.500.000 ₫</span></div>
                    </div>
                </div>
                <div class="wishlist-item">
                    <img src="https://images.unsplash.com/photo-1563720223185-11003d516935?w=100" class="wishlist-img" alt="Product">
                    <div class="wishlist-info">
                        <div class="wishlist-name">Camera hành trình 4K Ultra-S</div>
                        <div class="wishlist-price"><span class="final">4.200.000 ₫</span><span class="original">4.900.000 ₫</span><span class="badge-disc">-14%</span></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-ticket-alt"></i>  Voucher </h3>
                </div>
                <c:forEach items="${vouchers}" var="voucher" begin="0" end="1">

                    <div class="voucher-item">
                        <div class="voucher-left ${voucher.code eq 'FREESHIP' ? '' : ''}"
                                <c:if test="${voucher.code ne 'FREESHIP'}">
                                    style="background:#d32f2f;"
                                </c:if>>
                            <i class="fas ${voucher.code eq 'FREESHIP' ? 'fa-shipping-fast' : 'fa-percentage'}"></i>
                            <span>${voucher.code}</span>
                        </div>
                        <div class="voucher-right">
                            <div class="voucher-expiry">
                                Hạn dùng:
                                <fmt:formatDate value="${voucher.endAtDate}"
                                                pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-map-marker-alt"></i> Sổ địa chỉ mặc định</h3>
                    <a href="/profileEdit" class="view-all">Quản lý địa chỉ <i class="fas fa-arrow-right"></i></a>
                </div>
                <c:choose>
                    <c:when test="${not empty address}">
                        <div class="address-box default">
                            <span class="address-badge">Mặc định</span>
                            <div class="address-name">${address.nameAddress}</div>
                            <div class="address-phone"><i class="fas fa-phone-alt"></i> ${sessionScope.user.phonenumber}</div>
                            <div class="address-text"><i class="fas fa-home"></i> ${address.fullAddress}</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="address-box default">
                            <span class="address-badge">Mặc định</span>
                            <div class="address-text"><i class="fas fa-home"></i> Chưa có địa chỉ mặc định.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-bell"></i> Thông báo mới nhất</h3>
                    <a href="/notifications" class="view-all">Đọc tất cả <i class="fas fa-arrow-right"></i></a>
                </div>
                <c:choose>
                    <%-- 1. KIỂM TRA CÒN THÔNG BÁO HAY KHÔNG --%>
                    <c:when test="${empty notificationList}">
                        <div class="noti-empty">
                            <p>Bạn không có thông báo nào mới.</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <%-- 2. HIỂN THỊ DANH SÁCH KHOẢNG 3 CÁI (Sử dụng thuộc tính end="2" vì index chạy từ 0) --%>
                        <c:forEach items="${notificationList}" var="noti" end="2">
                            <div class="noti-item">
                                <div class="noti-content">
                                        <%-- Hiển thị nội dung thông báo (cho phép chứa thẻ HTML như <strong> nếu có) --%>
                                    <div class="noti-text">${noti.message}</div>
                                        <%-- Hiển thị thời gian thông báo --%>
                                    <div class="noti-time">${noti.createdAt}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-shield-alt"></i> An toàn & Bảo mật tài khoản</h3>
                    <a href="/profileEdit" class="view-all">Thiết lập <i class="fas fa-cog"></i></a>
                </div>
                <div class="security-list">
                    <div class="security-item">
                        <div class="security-info">
                            <i class="fas fa-envelope"></i>
                            <span class="sidebar-header-label">Email đăng nhập</span>
                            <span class="security-value">${user.email}</span>
                        </div>
                    </div>
                    <div class="security-item">
                        <div class="security-info">
                            <i class="fas fa-mobile-alt"></i>
                            <span class="sidebar-header-label">Số điện thoại</span>
                            <span class="security-value">${user.phonenumber}</span>
                        </div>
                    </div>
                    <%-- 1. LẤY THỜI GIAN HIỆN TẠI VÀ THỜI GIAN ĐỔI MẬT KHẨU (Tính bằng mili-giây) --%>
                    <jsp:useBean id="now" class="java.util.Date" />
                    <c:set var="currentTime" value="${now.time}" />
                    <c:set var="lastUpdateTime" value="${user.updatePassword.time}" />

                    <%-- 2. TÍNH KHOẢNG CÁCH THỜI GIAN --%>
                    <c:set var="diffTime" value="${currentTime - lastUpdateTime}" />

                    <%-- Quy đổi mili-giây:
                         1 ngày = 24 * 60 * 60 * 1000 = 86,400,000 ms
                         1 tháng (tạm tính 30 ngày) = 30 * 86,400,000 = 2,592,000,000 ms
                    --%>
                    <c:set var="diffDays" value="${diffTime / 86400000}" />
                    <c:set var="diffMonths" value="${diffTime / 2592000000}" />

                    <%-- Làm tròn số để hiển thị đẹp mắt --%>
                    <fmt:formatNumber var="roundedMonths" value="${diffMonths}" maxFractionDigits="0" pattern="#" />
                    <fmt:formatNumber var="roundedDays" value="${diffDays}" maxFractionDigits="0" pattern="#" />

                    <%-- 3. ĐỊNH DẠNG TEXT HIỂN THỊ THỜI GIAN --%>
                    <c:choose>
                        <c:when test="${roundedMonths >= 1}">
                            <c:set var="timeLabel" value="Thay đổi ${roundedMonths} tháng trước" />
                        </c:when>
                        <c:when test="${roundedDays >= 1}">
                            <c:set var="timeLabel" value="Thay đổi ${roundedDays} ngày trước" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="timeLabel" value="Vừa thay đổi gần đây" />
                        </c:otherwise>
                    </c:choose>

                    <%-- 4. KIỂM TRA ĐIỀU KIỆN 3 THÁNG ĐỂ HIỂN THỊ TRẠNG THÁI --%>
                    <c:choose>
                        <%-- Nếu thời gian vượt quá hoặc bằng 3 tháng --%>
                        <c:when test="${diffMonths >= 3}">
                            <c:set var="statusClass" value="status-warning" />
                            <c:set var="statusText" value="Cần cập nhật" />
                        </c:when>
                        <%-- Mật khẩu vẫn còn an toàn (< 3 tháng) --%>
                        <c:otherwise>
                            <c:set var="statusClass" value="status-success" />
                            <c:set var="statusText" value="An toàn" />
                        </c:otherwise>
                    </c:choose>
                    ---
                    <%-- 5. ĐỔ DỮ LIỆU VÀO GIAO DIỆN HTML --%>
                    <div class="security-item">
                        <div class="security-info">
                            <i class="fas fa-key"></i>
                            <span class="sidebar-header-label">Mật khẩu tài khoản</span>
                            <%-- Hiển thị số tháng/ngày động --%>
                            <span class="security-value">${timeLabel}</span>
                        </div>
                        <%-- Thay đổi class và text dựa theo logic kiểm tra bên trên --%>
                        <span class="security-status ${statusClass}">${statusText}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="quick-actions-card">
            <div class="card-header">
                <h3><i class="fas fa-bolt"></i> Thao tác nhanh</h3>
            </div>
            <div class="actions-grid">
                <a href="/products" class="action-btn"><i class="fas fa-store"></i><span>Mua sắm xe</span></a>
                <a href="/cart" class="action-btn"><i class="fas fa-shopping-cart"></i><span>Xem giỏ hàng</span></a>
                <a href="/order" class="action-btn"><i class="fas fa-truck"></i><span>Theo dõi vận đơn</span></a>
                <a href="/favorites" class="action-btn"><i class="fas fa-heart"></i><span>Mục đã lưu</span></a>
            </div>
        </div>
    </div></div><%@ include file="/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>