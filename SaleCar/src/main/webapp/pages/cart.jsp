<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header.jsp" %>

    <style>
        :root {
            --black: #000000;
            --gold: #D4AF37;
            --white: #FFFFFF;
            --dark-gold: #b8960f;
            --gray-dark: #2c2c2c;
            --gray-medium: #666666;
            --gray-light: #f5f5f5;
            --border-light: #e5e5e5;
            --danger: #dc3545;
            --success: #28a745;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f4f6fa; }

        /* Main layout & Sidebar */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: var(--black); color: var(--white); padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 0 20px 20px; border-bottom: 1px solid #333; text-align: center; }
        .sidebar-header h3 { color: var(--white); font-size: 24px; font-weight: 600; margin: 0; }
        .sidebar-header p { color: #999; font-size: 14px; margin-top: 5px; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: var(--white); text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333; color: var(--white); transform: translateX(4px); }
        .menu-item.active { background-color: var(--white); color: var(--black); }
        .menu-item.active i { color: var(--black); }
        .menu-divider { height: 1px; background-color: #333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; background: #f4f6fa; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 700; color: var(--black); margin-bottom: 10px; letter-spacing: -0.3px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; flex-wrap: wrap; font-size: 13px; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #5a6874; text-decoration: none; transition: color 0.2s; }
        .breadcrumb-item a:hover { color: var(--gold); }
        .breadcrumb-item.active { color: var(--black); font-weight: 600; }

        /* Cart Specific Styles */
        .profile-card {
            background: var(--white);
            border-radius: 28px;
            box-shadow: 0 20px 35px -12px rgba(0,0,0,0.08);
            overflow: hidden;
            margin-bottom: 30px;
            transition: all 0.2s;
        }
        .cart-info-bar { background-color: #f8f9fa; padding: 15px 30px; border-bottom: 1px solid var(--border-light); display: flex; justify-content: space-between; font-size: 14px; color: var(--gray-medium); }

        .lux-table { width: 100%; border-collapse: collapse; }
        .lux-table thead tr { background: var(--black); }
        .lux-table th {
            color: var(--white);
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .lux-table td { padding: 20px; border-bottom: 1px solid var(--border-light); vertical-align: middle; }
        .lux-table tbody tr { transition: background-color 0.2s; }
        .lux-table tbody tr:hover { background-color: #f8f9fa; }
        .lux-table tbody tr:last-child td { border-bottom: none; }

        .product-col { display: flex; align-items: center; gap: 15px; }
        .product-img { width: 60px; height: 60px; border-radius: 8px; overflow: hidden; flex-shrink: 0; background: var(--gray-light); display: flex; align-items: center; justify-content: center; border: 1px solid var(--border-light); }
        .product-img img { width: 100%; height: 100%; object-fit: cover; }
        .product-name { font-weight: 600; color: var(--black); margin-bottom: 4px; font-size: 15px; }
        .product-id { font-size: 12px; color: var(--gray-medium); }

        .price-text { font-weight: 600; color: var(--black); }
        .total-text { font-weight: 700; color: var(--danger); }
        .btn-remove {
            color: var(--danger);
            text-decoration: none;
            font-size: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            transition: all 0.25s;
        }
        .btn-remove:hover {
            color: var(--white);
            background: var(--danger);
            transform: scale(1.1);
        }

        .cart-summary {
            padding: 30px;
            background: linear-gradient(135deg, #fafafa 0%, #f5f5f5 100%);
            border-top: 2px solid var(--black);
            text-align: right;
            animation: fadeInUp 0.4s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .summary-row { margin-bottom: 15px; font-size: 16px; color: var(--gray-medium); }
        .summary-total { font-size: 24px; font-weight: 700; color: var(--black); margin-bottom: 20px; }
        .btn-checkout {
            background-color: var(--black);
            color: var(--white);
            padding: 14px 35px;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 600;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        .btn-checkout:hover {
            background-color: var(--gold);
            border-color: var(--black);
            color: var(--black);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(212,175,55,0.3);
        }

        /* Qty controls */
        .qty-controls {
            display: inline-flex;
            align-items: center;
            border: 1px solid var(--border-light);
            border-radius: 8px;
            overflow: hidden;
        }
        .qty-controls .qty-btn {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            background: var(--white);
            color: var(--black);
            font-size: 14px;
            transition: all 0.2s;
            text-decoration: none;
        }
        .qty-controls .qty-btn:hover {
            background: var(--gold);
            color: var(--black);
        }
        .qty-controls .qty-input {
            width: 45px;
            height: 36px;
            text-align: center;
            border: none;
            border-left: 1px solid var(--border-light);
            border-right: 1px solid var(--border-light);
            font-weight: 600;
            font-size: 14px;
            outline: none;
        }

        /* Empty state */
        .empty-state { text-align: center; padding: 80px 30px; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 16px; display: block; }
        .empty-state h4 { font-size: 22px; color: var(--black); margin-bottom: 12px; }
        .empty-state p { color: var(--gray-medium); margin-bottom: 20px; }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">
                <i class="bi bi-speedometer2"></i>
                <span>Bảng điều khiển</span>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                <i class="bi bi-person-circle"></i>
                <span>Thông tin cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item">
                <i class="bi bi-person-gear"></i>
                <span>Chỉnh sửa thông tin</span>
            </a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item">
                <i class="bi bi-lock"></i>
                <span>Đổi mật khẩu</span>
            </a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item">
                <i class="bi bi-bag"></i>
                <span>Đơn hàng của tôi</span>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item active">
                <i class="bi bi-cart3"></i>
                <span>Giỏ hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item">
                <i class="bi bi-heart"></i>
                <span>Sản phẩm yêu thích</span>
            </a>
            <a href="${pageContext.request.contextPath}/notifications" class="menu-item">
                <i class="bi bi-bell"></i>
                <span>Thông báo</span>
            </a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item">
                <i class="bi bi-box-arrow-right"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <!-- gio hang -->
    <div class="main-content">
        <div class="content-header">
            <h1>Giỏ hàng của bạn</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> <i class="bi bi-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item active">Giỏ hàng</li>
                </ol>
            </nav>
        </div>

        <div class="profile-card">

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

                    <!-- hien thi san pham -->
                    <tbody>

                    <!-- san pham -->
                    <c:forEach var="item" items="${sessionScope.cart.items}">
                    <tr>
                    <td>
                       <div class="product-col">
                            <div class="product-img">
                                                    <%-- Đồng nhất gọi productDetail và bọc chống rỗng ảnh --%>
                                 <img src="${not empty item.productDetail.images ? pageContext.request.contextPath.concat('/uploads/').concat(item.productDetail.images[0]) : 'https://placehold.co/50'}" style="width: 50px; height: 50px; object-fit: cover;" alt="${item.productDetail.productName}" />
                            </div>

                            <div>
                                                    <%-- Đồng nhất lấy tên qua productDetail --%>
                                <div class="product-name">${item.productDetail.productName}</div>
                                <div class="product-id">ID: ${item.productId}</div>
                            </div>
                        </div>
                    </td>

                    <td class="price-text">
                        <fmt:formatNumber value="${item.variantFinalPrice}" type="number" groupingUsed="true"/> ₫
                    </td>



                    <!-- cap nhat so luong -->
                    <td>
                        <div class="d-flex align-items-center justify-content-center">


                            <div class="qty-controls">
                                <a href="/update-cart?value=-1&id=${item.productId}" class="qty-btn">
                                    <i class="bi bi-dash"></i>
                                </a>
                                <input type="text" class="qty-input" value="${item.quantity}" readonly>
                                <a href="/update-cart?value=1&id=${item.productId}" class="qty-btn">
                                    <i class="bi bi-plus"></i>
                                </a>
                            </div>
                        </div>
                    </td>



                    <td class="total-text">
                       <fmt:formatNumber value="${item.variantFinalPrice * item.quantity}" type="number" groupingUsed="true"/> ₫
                    </td>

                    <!-- xoa san pham -->
                    <td>
                        <a href="cart-remove?id=${item.productId}" class="btn-remove">
                            <i class="bi bi-trash"></i>
                        </a>
                    </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="cart-summary">
                <div class="summary-row">
                    Tổng số lượng: <strong>${sessionScope.cart.totalQuantity} sản phẩm</strong>
                </div>
                <div class="summary-total">Tổng tiền: <fmt:formatNumber value="${sessionScope.cart.total}" type="number" groupingUsed="true"/> ₫</div>
                <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">Tiến hành thanh toán <i class="bi bi-arrow-right"></i></a>
            </div>
        </div>
    </div>
</div>
</body>

</html>