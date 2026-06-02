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
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
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
            border: 1px solid #e9ecef;
        }
        .stat-info h3 { font-size: 24px; font-weight: 700; color: #000000; margin-bottom: 5px; }
        .stat-info p { font-size: 13px; color: #6c757d; margin: 0; }
        .stat-icon { width: 46px; height: 46px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; }
        .stat-icon.orders   { background: #fff3e0; color: #ff9800; }
        .stat-icon.spending { background: #e8f5e9; color: #4caf50; }
        .stat-icon.favorites{ background: #fee8e8; color: #f44336; }
        .stat-icon.vouchers { background: #e0f7fa; color: #00acc1; }

        /* Dashboard Layout Rows */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }
        .recent-card {
            background: white;
            border-radius: 16px;
            padding: 22px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f0f0f0;
        }
        .card-header h3 { font-size: 16px; font-weight: 600; color: #000000; margin: 0; display: flex; align-items: center; gap: 8px; }
        .view-all { color: #000000; text-decoration: none; font-size: 13px; font-weight: 500; }
        .view-all:hover { text-decoration: underline; }

        /* Recent Orders Items */
        .order-item { display: flex; align-items: center; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid #f8f9fa; gap: 10px; }
        .order-item:last-child { border-bottom: none; }
        .order-info { flex: 1; min-width: 0; }
        .order-id { font-weight: 600; color: #000000; margin-bottom: 4px; font-size: 14px; }
        .order-meta { font-size: 12px; color: #6c757d; display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
        .order-meta .payment-method { background: #f0f0f0; padding: 2px 6px; border-radius: 4px; font-size: 11px; }
        .order-amount { font-weight: 700; color: #000000; font-size: 14px; }
        .order-status { padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 600; text-transform: uppercase; }
        .status-processing{ background: #e3f2fd; color: #1565c0; }
        .status-pending   { background: #fff8e1; color: #f57f17; }
        .status-delivered { background: #e0f2f1; color: #00695c; }
        .payment-paid   { color: #2e7d32; }
        .payment-unpaid { color: #c62828; }

        /* Wishlist Items */
        .wishlist-item { display: flex; align-items: center; gap: 12px; padding: 12px 0; border-bottom: 1px solid #f8f9fa; }
        .wishlist-item:last-child { border-bottom: none; }
        .wishlist-img { width: 44px; height: 44px; border-radius: 8px; object-fit: cover; background: #f0f0f0; }
        .wishlist-info { flex: 1; min-width: 0; }
        .wishlist-name { font-size: 13px; font-weight: 600; color: #000; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .wishlist-price { font-size: 12px; }
        .wishlist-price .final { color: #000; font-weight: 600; }
        .wishlist-price .original { text-decoration: line-through; color: #999; margin-left: 5px; font-size: 11px; }
        .wishlist-price .badge-disc { background: #fee8e8; color: #f44336; font-size: 10px; padding: 1px 4px; border-radius: 4px; margin-left: 5px; }

        /* Notifications Items */
        .noti-item { display: flex; gap: 12px; padding: 12px 0; border-bottom: 1px solid #f8f9fa; align-items: flex-start; }
        .noti-item:last-child { border-bottom: none; }
        .noti-icon { width: 32px; height: 32px; border-radius: 50%; background: #f1f3f5; display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .noti-icon.success { background: #e8f5e9; color: #4caf50; }
        .noti-icon.info { background: #e3f2fd; color: #2196f3; }
        .noti-content { flex: 1; }
        .noti-text { font-size: 13px; color: #333; margin-bottom: 30px; line-height: 1.4; margin: 0 0 3px 0; }
        .noti-time { font-size: 11px; color: #999; }

        /* Voucher Items */
        .voucher-item { display: flex; border: 1px dashed #e0e0e0; border-radius: 8px; margin-bottom: 12px; background: #fff; overflow: hidden; }
        .voucher-item:last-child { margin-bottom: 0; }
        .voucher-left { background: #000; color: #fff; padding: 15px; display: flex; flex-direction: column; align-items: center; justify-content: center; min-width: 85px; text-align: center; }
        .voucher-left i { font-size: 18px; margin-bottom: 4px; }
        .voucher-left span { font-size: 11px; text-transform: uppercase; font-weight: bold; }
        .voucher-right { flex: 1; padding: 12px 15px; display: flex; flex-direction: column; justify-content: center; }
        .voucher-title { font-size: 14px; font-weight: 600; color: #000; margin-bottom: 4px; }
        .voucher-expiry { font-size: 11px; color: #777; }

        /* Address Book Box */
        .address-box { padding: 15px; border: 1px solid #e9ecef; border-radius: 10px; background: #f8f9fa; position: relative; margin-bottom: 12px; }
        .address-box:last-child { margin-bottom: 0; }
        .address-box.default { border-color: #000; background: #fff; }
        .address-badge { position: absolute; top: 15px; right: 15px; background: #000; color: #fff; font-size: 10px; padding: 2px 8px; border-radius: 4px; font-weight: 500; }
        .address-name { font-weight: 600; font-size: 14px; color: #000; margin-bottom: 6px; }
        .address-phone { font-size: 13px; color: #555; margin-bottom: 4px; }
        .address-text { font-size: 13px; color: #777; line-height: 1.4; }

        /* Account & Security Layout */
        .security-list { display: flex; flex-direction: column; gap: 15px; }
        .security-item { display: flex; align-items: center; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #f8f9fa; }
        .security-item:last-child { border-bottom: none; }
        .security-info { display: flex; align-items: center; gap: 12px; }
        .security-info i { font-size: 18px; color: #555; width: 20px; }
        .security-label { font-size: 13px; font-weight: 500; color: #333; }
        .security-value { font-size: 13px; color: #777; margin-left: 10px; }
        .security-status { font-size: 12px; padding: 2px 8px; border-radius: 4px; font-weight: 500; }
        .status-verified { background: #e8f5e9; color: #2e7d32; }
        .status-warning { background: #fff3e0; color: #e65100; }

        /* Quick Actions & Welcome Banner */
        .welcome-banner { background: linear-gradient(135deg, #000000 0%, #333333 100%); border-radius: 16px; padding: 25px 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; }
        .welcome-text h2 { color: white; font-size: 22px; margin-bottom: 8px; }
        .welcome-text p { color: rgba(255,255,255,0.75); margin: 0; font-size: 14px; }
        .welcome-stats { display: flex; gap: 30px; }
        .welcome-stat { text-align: center; }
        .welcome-stat .number { color: white; font-size: 24px; font-weight: 700; }
        .welcome-stat .label { color: rgba(255,255,255,0.65); font-size: 12px; margin-top: 2px; }

        .status-summary { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 25px; }
        .status-pill { display: flex; align-items: center; gap: 6px; padding: 8px 14px; border-radius: 20px; font-size: 13px; font-weight: 500; background: #fff; border: 1px solid #e9ecef; box-shadow: 0 1px 4px rgba(0,0,0,0.04); }
        .status-pill .dot { width: 8px; height: 8px; border-radius: 50%; }
        .dot-pending { background: #f57f17; }
        .dot-processing { background: #1565c0; }
        .dot-shipping { background: #2e7d32; }
        .dot-delivered { background: #00695c; }
        .dot-cancelled { background: #b71c1c; }

        .actions-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; }
        .action-btn { display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 15px; background: #f8f9fa; border-radius: 12px; text-decoration: none; transition: all 0.3s; border: 1px solid #e9ecef; }
        .action-btn:hover { background: #000000; transform: translateY(-3px); }
        .action-btn i { font-size: 22px; color: #000000; margin-bottom: 8px; transition: color 0.3s; }
        .action-btn span { font-size: 13px; font-weight: 500; color: #495057; transition: color 0.3s; text-align: center; }
        .action-btn:hover i, .action-btn:hover span { color: #ffffff; }

        @media (max-width: 1024px) { .dashboard-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .sidebar-menu { display: none; } .actions-grid { grid-template-columns: repeat(2, 1fr); } }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
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
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>

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
                <h2>Chào mừng trở lại, Nguyễn Hoàng Long!</h2>
                <p>Hệ thống giám sát hành trình mua sắm và ưu đãi dành riêng cho bạn tại LUXCAR.</p>
            </div>
            <div class="welcome-stats">
                <div class="welcome-stat">
                    <div class="number">12</div>
                    <div class="label">Đơn hàng</div>
                </div>
                <div class="welcome-stat">
                    <div class="number">68.200.000 ₫</div>
                    <div class="label">Đã chi tiêu</div>
                </div>
                <div class="welcome-stat">
                    <div class="number">3</div>
                    <div class="label">Mã giảm giá</div>
                </div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info"><h3>12</h3><p>Tổng đơn đặt hàng</p></div>
                <div class="stat-icon orders"><i class="fas fa-shopping-bag"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>68.200.000 ₫</h3><p>Tổng chi tiêu tích lũy</p></div>
                <div class="stat-icon spending"><i class="fas fa-wallet"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>5</h3><p>Sản phẩm yêu thích</p></div>
                <div class="stat-icon favorites"><i class="fas fa-heart"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>3 mã áp dụng</h3><p>Kho Voucher khả dụng</p></div>
                <div class="stat-icon vouchers"><i class="fas fa-ticket-alt"></i></div>
            </div>
        </div>

        <div class="status-summary">
            <div class="status-pill"><span class="dot dot-pending"></span>Chờ xác nhận: <strong>1</strong></div>
            <div class="status-pill"><span class="dot dot-processing"></span>Đang xử lý: <strong>1</strong></div>
            <div class="status-pill"><span class="dot dot-shipping"></span>Đang giao: <strong>0</strong></div>
            <div class="status-pill"><span class="dot dot-delivered"></span>Đã giao: <strong>9</strong></div>
            <div class="status-pill"><span class="dot dot-cancelled"></span>Đã hủy: <strong>1</strong></div>
        </div>

        <div class="dashboard-grid">
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-history"></i> Đơn hàng gần đây</h3>
                    <a href="#" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="order-item">
                    <div class="order-info">
                        <div class="order-id">#LC-8954</div>
                        <div class="order-meta"><span>Hôm nay, 10:25</span><span class="payment-method">MoMo</span><span class="payment-status payment-paid">Đã thanh toán</span></div>
                    </div>
                    <div class="order-amount">24.500.000 ₫</div>
                    <div><span class="order-status status-processing">Đang xử lý</span></div>
                </div>
                <div class="order-item">
                    <div class="order-info">
                        <div class="order-id">#LC-8812</div>
                        <div class="order-meta"><span>28/05/2026</span><span class="payment-method">COD</span><span class="payment-status payment-unpaid">Chưa thanh toán</span></div>
                    </div>
                    <div class="order-amount">3.200.000 ₫</div>
                    <div><span class="order-status status-pending">Chờ xác nhận</span></div>
                </div>
                <div class="order-item">
                    <div class="order-info">
                        <div class="order-id">#LC-8240</div>
                        <div class="order-meta"><span>15/04/2026</span><span class="payment-method">Chuyển khoản</span><span class="payment-status payment-paid">Đã thanh toán</span></div>
                    </div>
                    <div class="order-amount">40.500.000 ₫</div>
                    <div><span class="order-status status-delivered">Đã giao</span></div>
                </div>
            </div>

            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-heart"></i> Yêu thích gần đây</h3>
                    <a href="#" class="view-all">Xem tất cả <i class="fas fa-arrow-right"></i></a>
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
                    <h3><i class="fas fa-ticket-alt"></i> Kho Voucher / Ưu đãi của tôi</h3>
                    <a href="#" class="view-all">Xem tủ voucher <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="voucher-item">
                    <div class="voucher-left"><i class="fas fa-shipping-fast"></i><span>FREESHIP</span></div>
                    <div class="voucher-right">
                        <div class="voucher-title">Miễn phí vận chuyển toàn quốc</div>
                        <div class="voucher-expiry">Hạn dùng: Hết hạn trong 3 ngày tới</div>
                    </div>
                </div>
                <div class="voucher-item">
                    <div class="voucher-left" style="background:#d32f2f;"><i class="fas fa-percentage"></i><span>LUXCAR10</span></div>
                    <div class="voucher-right">
                        <div class="voucher-title">Giảm 10% cho đơn phụ kiện xe từ 2TR</div>
                        <div class="voucher-expiry">Hạn dùng: Đến hết ngày 30/06/2026</div>
                    </div>
                </div>
            </div>

            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-map-marker-alt"></i> Sổ địa chỉ mặc định</h3>
                    <a href="#" class="view-all">Quản lý địa chỉ <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="address-box default">
                    <span class="address-badge">Mặc định</span>
                    <div class="address-name">Nguyễn Hoàng Long (Nhà riêng)</div>
                    <div class="address-phone"><i class="fas fa-phone-alt"></i> 0901.234.567</div>
                    <div class="address-text"><i class="fas fa-home"></i> Lầu 5, Tòa nhà Landmark 81, Phường 22, Quận Bình Thạnh, TP. Hồ Chí Minh</div>
                </div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-bell"></i> Thông báo mới nhất</h3>
                    <a href="#" class="view-all">Đọc tất cả <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="noti-item">
                    <div class="noti-icon success"><i class="fas fa-check"></i></div>
                    <div class="noti-content">
                        <div class="noti-text">Đơn hàng <strong>#LC-8240</strong> của bạn đã được giao thành công. Đánh giá ngay để nhận ưu đãi!</div>
                        <div class="noti-time">1 giờ trước</div>
                    </div>
                </div>
                <div class="noti-item">
                    <div class="noti-icon info"><i class="fas fa-truck"></i></div>
                    <div class="noti-content">
                        <div class="noti-text">Đơn hàng <strong>#LC-8954</strong> đã được đóng gói và bàn giao cho ĐVVC Giao Hàng Nhanh.</div>
                        <div class="noti-time">5 giờ trước</div>
                    </div>
                </div>
            </div>

            <div class="recent-card">
                <div class="card-header">
                    <h3><i class="fas fa-shield-alt"></i> An toàn & Bảo mật tài khoản</h3>
                    <a href="#" class="view-all">Thiết lập <i class="fas fa-cog"></i></a>
                </div>
                <div class="security-list">
                    <div class="security-item">
                        <div class="security-info">
                            <i class="fas fa-envelope"></i>
                            <span class="sidebar-header-label">Email đăng nhập</span>
                            <span class="security-value">longnh****@gmail.com</span>
                        </div>
                        <span class="security-status status-verified">Đã xác minh</span>
                    </div>
                    <div class="security-item">
                        <div class="security-info">
                            <i class="fas fa-mobile-alt"></i>
                            <span class="sidebar-header-label">Số điện thoại</span>
                            <span class="security-value">******567</span>
                        </div>
                        <span class="security-status status-verified">Đã liên kết</span>
                    </div>
                    <div class="security-item">
                        <div class="security-info">
                            <i class="fas fa-key"></i>
                            <span class="sidebar-header-label">Mật khẩu tài khoản</span>
                            <span class="security-value">Thay đổi 3 tháng trước</span>
                        </div>
                        <span class="security-status status-warning">Cần cập nhật</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="quick-actions-card">
            <div class="card-header">
                <h3><i class="fas fa-bolt"></i> Thao tác nhanh</h3>
            </div>
            <div class="actions-grid">
                <a href="#" class="action-btn"><i class="fas fa-store"></i><span>Mua sắm xe</span></a>
                <a href="#" class="action-btn"><i class="fas fa-shopping-cart"></i><span>Xem giỏ hàng</span></a>
                <a href="#" class="action-btn"><i class="fas fa-truck"></i><span>Theo dõi vận đơn</span></a>
                <a href="#" class="action-btn"><i class="fas fa-heart"></i><span>Mục đã lưu</span></a>
            </div>
        </div>
    </div></div><%@ include file="/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>