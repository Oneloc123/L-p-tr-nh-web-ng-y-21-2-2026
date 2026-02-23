<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 1:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ taglib prefix="c" uri="jakarta.tags.core" %>--%>
<%--<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>--%>
<%@ include file="/common/header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm yêu thích - SaleCar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <!-- Font Luxury -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        h1, h2 {
            font-family: 'Cormorant Garamond', serif;
        }

        .sidebar {
            background: #fff;
            padding: 25px;
            border-right: 1px solid #eee;
        }

        .filter-title {
            font-weight: 600;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .product-card {
            border: none;
            transition: 0.3s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-img {
            height: 220px;
            overflow: hidden;
        }

        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .price-current {
            font-weight: 600;
        }

        .price-old {
            text-decoration: line-through;
            color: #888;
            font-size: 14px;
        }

        .rating i {
            color: #f5b301;
            font-size: 14px;
        }

        .voucher-box {
            background: #fff;
            padding: 20px;
            border: 1px solid #eee;
            margin-top: 20px;
        }

        .empty-state {
            text-align: center;
            padding: 80px 0;
        }

        .empty-state i {
            font-size: 60px;
            color: #ccc;
        }
    </style>
</head>

<body>

<div class="container-fluid py-5">
    <div class="row">

        <!-- SIDEBAR FILTER -->
        <div class="col-lg-3 sidebar">

            <form method="get" action="favorites">

                <input type="text" name="keyword" class="form-control mb-3" placeholder="Tìm kiếm yêu thích...">

                <div class="filter-title">Loại xe</div>
                <select name="type" class="form-select mb-3">
                    <option value="">Tất cả</option>
                    <option value="sedan">Sedan</option>
                    <option value="suv">SUV</option>
                    <option value="sport">Sport</option>
                </select>

                <div class="filter-title">Hãng</div>
                <select name="brand" class="form-select mb-3">
                    <option value="">Tất cả</option>
                    <option value="toyota">Toyota</option>
                    <option value="mercedes">Mercedes</option>
                    <option value="bmw">BMW</option>
                </select>

                <div class="filter-title">Khoảng giá</div>
                <select name="price" class="form-select mb-3">
                    <option value="">Tất cả</option>
                    <option value="low">Dưới 1 tỷ</option>
                    <option value="mid">1 - 3 tỷ</option>
                    <option value="high">Trên 3 tỷ</option>
                </select>

                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="discount">
                    <label class="form-check-label">Đang giảm giá</label>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="hot">
                    <label class="form-check-label">Hàng HOT</label>
                </div>

                <button class="btn btn-dark w-100">Lọc</button>

            </form>

            <!-- VOUCHER TOGGLE -->
            <div class="voucher-box">
                <button class="btn btn-outline-dark w-100" data-bs-toggle="collapse" data-bs-target="#voucherArea">
                    Xem Voucher của bạn
                </button>

                <div class="collapse mt-3" id="voucherArea">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="border p-2 mb-2">
                            <strong>${v.code}</strong><br>
                            Giảm
                            <fmt:formatNumber value="${v.discount}" type="number"/> đ
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div>

        <!-- PRODUCT GRID -->
        <div class="col-lg-9 px-5">

            <h1 class="mb-4">Xe bạn đã yêu thích</h1>

            <c:choose>

                <c:when test="${not empty favorites}">

                    <div class="row g-4">

                        <c:forEach var="p" items="${favorites}">

                            <div class="col-lg-3 col-md-6">
                                <div class="card product-card">

                                    <div class="product-img">
                                        <img src="${p.imageUrl}" alt="${p.name}">
                                    </div>

                                    <div class="card-body">

                                        <div>
                                            <h6>${p.name}</h6>

                                            <div class="mb-2">
                                                <span class="price-current">
                                                    <fmt:formatNumber value="${p.price}" type="number"/> đ
                                                </span>

                                                <c:if test="${p.oldPrice > 0}">
                                                    <span class="price-old ms-2">
                                                        <fmt:formatNumber value="${p.oldPrice}" type="number"/> đ
                                                    </span>
                                                </c:if>
                                            </div>

                                            <div class="rating mb-2">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <c:choose>
                                                        <c:when test="${i <= p.rating}">
                                                            <i class="fa-solid fa-star"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa-regular fa-star"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>

                                            <div class="mb-2">
                                                <c:choose>
                                                    <c:when test="${p.stock > 0}">
                                                        <span class="badge bg-success">Còn hàng</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Hết hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <c:if test="${p.hot}">
                                                <span class="badge bg-dark">HOT</span>
                                            </c:if>

                                        </div>

                                        <div class="d-grid gap-2 mt-3">
                                            <a href="cart?action=add&id=${p.id}" class="btn btn-dark btn-sm">
                                                Thêm vào giỏ
                                            </a>

                                            <a href="favorites?action=remove&id=${p.id}" class="btn btn-outline-danger btn-sm">
                                                <i class="fa-solid fa-star"></i> Bỏ yêu thích
                                            </a>
                                        </div>

                                    </div>
                                </div>
                            </div>

                        </c:forEach>

                    </div>

                </c:when>

                <c:otherwise>

                    <div class="empty-state">
                        <i class="fa-regular fa-star"></i>
                        <h4 class="mt-4">Bạn chưa có sản phẩm yêu thích nào</h4>
                        <a href="products" class="btn btn-dark mt-3">
                            Khám phá xe ngay
                        </a>
                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>