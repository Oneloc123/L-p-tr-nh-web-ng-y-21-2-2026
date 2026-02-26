<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar (Dùng chung từ profile.jsp) */
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

        /* Cart Specific Styles */
        .profile-card { background: #ffffff; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow: hidden; margin-bottom: 30px; }
        .cart-info-bar { background-color: #f0f0f0; padding: 15px 30px; border-bottom: 1px solid #eeeeee; display: flex; justify-content: space-between; font-size: 14px; color: #666; }

        .lux-table { width: 100%; border-collapse: collapse; }
        .lux-table th { background: #000000; color: #ffffff; padding: 15px 20px; text-align: left; font-weight: 500; }
        .lux-table td { padding: 20px; border-bottom: 1px solid #eeeeee; vertical-align: middle; }

        .product-col { display: flex; align-items: center; gap: 15px; }
        .product-img { width: 80px; height: 60px; background-color: #e9ecef; border-radius: 6px; display: flex; align-items: center; justify-content: center; color: #adb5bd; }
        .product-name { font-weight: 600; color: #000; margin-bottom: 5px; }
        .product-id { font-size: 12px; color: #666; }

        .qty-box { width: 60px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; text-align: center; }
        .price-text { font-weight: 600; color: #000; }
        .total-text { font-weight: 700; color: #d9534f; }
        .btn-remove { color: #dc3545; text-decoration: none; font-size: 18px; }
        .btn-remove:hover { color: #a71d2a; }

        .cart-summary { padding: 30px; background-color: #fafafa; border-top: 2px solid #000; text-align: right; }
        .summary-row { margin-bottom: 15px; font-size: 16px; }
        .summary-total { font-size: 24px; font-weight: 700; color: #000; margin-bottom: 20px; }
        .btn-checkout { background-color: #000; color: #fff; padding: 12px 30px; text-decoration: none; border-radius: 8px; font-weight: 600; font-size: 16px; display: inline-block; transition: 0.3s; }
        .btn-checkout:hover { background-color: #333; }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <div class="sidebar-menu">
        <div class="sidebar-header">
            <h3>LUXCAR</h3>
            <p>Mô hình xe cao cấp</p>
        </div>
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">
                <i class="fas fa-chart-pie"></i><span>Bảng điều khiển</span>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                <i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item active">
                <i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item">
                <i class="fas fa-shopping-bag"></i><span>Đơn hàng của tôi</span>
            </a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="content-header">
            <h1>Giỏ hàng của bạn</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> <i class="fas fa-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item active">Giỏ hàng</li>
                </ol>
            </nav>
        </div>

        <div class="profile-card">
            <div class="cart-info-bar">
                <span><strong>Mã Giỏ Hàng (Cart ID):</strong> CRT-001</span>
                <span><strong>Cập nhật lần cuối:</strong> 24/02/2026 08:30</span>
            </div>

            <div style="overflow-x: auto;">
                <table class="lux-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="product-col">
                                    <div class="product-img"><i class="fas fa-car fa-2x"></i></div>
                                    <div>
                                        <div class="product-name">Lamborghini Aventador 1:18</div>
                                        <div class="product-id">Product ID: PRD045</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="price-text">2,500,000 ₫</span></td>
                            <td><input type="number" class="qty-box" value="1" min="1"></td>
                            <td><span class="total-text">2,500,000 ₫</span></td>
                            <td><a href="#" class="btn-remove"><i class="fas fa-trash-alt"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="product-col">
                                    <div class="product-img"><i class="fas fa-car fa-2x"></i></div>
                                    <div>
                                        <div class="product-name">Porsche 911 GT3 RS 1:24</div>
                                        <div class="product-id">Product ID: PRD088</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="price-text">1,200,000 ₫</span></td>
                            <td><input type="number" class="qty-box" value="2" min="1"></td>
                            <td><span class="total-text">2,400,000 ₫</span></td>
                            <td><a href="#" class="btn-remove"><i class="fas fa-trash-alt"></i></a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="cart-summary">
                <div class="summary-row">Tổng số lượng: <strong>3 sản phẩm</strong></div>
                <div class="summary-total">Tổng tiền: 4,900,000 ₫</div>
                <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">Tiến hành thanh toán <i class="fas fa-arrow-right" style="margin-left: 8px;"></i></a>
            </div>
        </div>
    </div>
</div>
</body>
</html>