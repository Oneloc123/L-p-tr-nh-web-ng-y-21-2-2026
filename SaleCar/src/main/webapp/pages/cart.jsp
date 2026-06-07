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

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>
        /* ================= CART CARD ================= */
        .profile-card {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
            overflow: hidden;
            margin-bottom: 30px;
            transition: all var(--transition-base);
        }

        /* ================= TABLE ================= */
        .lux-table { width: 100%; border-collapse: collapse; }
        .lux-table thead tr { background: #0a0a0a; }
        .lux-table th {
            color: var(--text-primary);
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border-bottom: 1px solid var(--border-subtle);
        }
        .lux-table td {
            padding: 20px;
            border-bottom: 1px solid var(--border-subtle);
            vertical-align: middle;
            background: var(--bg-surface);
            color: var(--text-secondary);
        }
        .lux-table tbody tr { transition: background-color var(--transition-fast); }
        .lux-table tbody tr:hover td { background-color: var(--bg-elevated); }
        .lux-table tbody tr:last-child td { border-bottom: none; }

        .product-col { display: flex; align-items: center; gap: 15px; }
        .product-img {
            width: 60px; height: 60px; border-radius: var(--radius-sm);
            overflow: hidden; flex-shrink: 0;
            background: var(--bg-elevated);
            display: flex; align-items: center; justify-content: center;
            border: 1px solid var(--border-subtle);
        }
        .product-img img { width: 100%; height: 100%; object-fit: cover; }
        .product-name { font-weight: 600; color: var(--text-primary); margin-bottom: 4px; font-size: 15px; }
        .product-id { font-size: 12px; color: var(--text-muted); }

        .price-text { font-weight: 600; color: var(--text-primary); }
        .total-text { font-weight: 700; color: #e74c3c; }

        .btn-remove {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            transition: all var(--transition-fast);
        }
        .btn-remove:hover {
            color: #e74c3c;
            background: rgba(231,76,60,0.12);
            transform: scale(1.1);
        }

        /* ================= CART SUMMARY ================= */
        .cart-summary {
            padding: 30px;
            background: var(--bg-elevated);
            border-top: 1px solid var(--border-subtle);
            text-align: right;
            animation: fadeInUp 0.4s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .summary-row { margin-bottom: 15px; font-size: 16px; color: var(--text-secondary); }
        .summary-total {
            font-size: 24px;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
        }
        .btn-checkout {
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
            padding: 14px 35px;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 700;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all var(--transition-base);
            border: none;
        }
        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(212,175,55,0.3);
            color: #101010;
        }

        /* ================= QTY CONTROLS ================= */
        .qty-controls {
            display: inline-flex;
            align-items: center;
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-sm);
            overflow: hidden;
        }
        .qty-controls .qty-btn {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            background: var(--bg-surface);
            color: var(--text-secondary);
            font-size: 14px;
            transition: all var(--transition-fast);
            text-decoration: none;
        }
        .qty-controls .qty-btn:hover {
            background: rgba(212,175,55,0.12);
            color: var(--gold);
        }
        .qty-controls .qty-input {
            width: 45px;
            height: 36px;
            text-align: center;
            border: none;
            border-left: 1px solid var(--border-subtle);
            border-right: 1px solid var(--border-subtle);
            font-weight: 600;
            font-size: 14px;
            outline: none;
            background: var(--bg-surface);
            color: var(--text-primary);
        }

        /* ================= EMPTY STATE ================= */
        .empty-state { text-align: center; padding: 80px 30px; }
        .empty-state i { font-size: 64px; color: rgba(255,255,255,0.08); margin-bottom: 16px; display: block; }
        .empty-state h4 { font-size: 22px; color: var(--text-primary); margin-bottom: 12px; }
        .empty-state p { color: var(--text-muted); margin-bottom: 20px; }

        /* ================= OVERRIDES ================= */
        .main-content { flex: 1; padding: 30px 40px; background: var(--bg-primary); }
        .content-header h1 { font-family: 'Playfair Display', serif; }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <!-- Sidebar chung -->
    <%@ include file="/common/user-sidebar.jsp" %>

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