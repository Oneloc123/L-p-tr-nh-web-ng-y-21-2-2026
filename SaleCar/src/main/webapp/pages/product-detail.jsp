<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/common/header.jsp" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Chi tiết sản phẩm - LUXCAR</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font luxury -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Inter:wght@300;400;500;600&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
        }

        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }

        .main-image {
            height: 450px;
            overflow: hidden;
        }

        .main-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .sub-image {
            height: 120px;
            overflow: hidden;
            cursor: pointer;
        }

        .sub-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .badge-hot {
            background: #000;
        }

        .price-box {
            background: #fff;
            padding: 30px;
            border: 1px solid #eee;
        }

        .price-current {
            font-size: 28px;
            font-weight: 600;
        }

        .price-old {
            text-decoration: line-through;
            color: #888;
        }

        .star-btn {
            border: 1px solid #000;
        }

        .star-btn:hover {
            background: #000;
            color: #fff;
        }

        .btn-buy {
            background: #000;
            color: #fff;
        }

        .btn-buy:hover {
            background: #333;
            color: #fff;
        }

        .product-card {
            border: none;
            height: 100%;
        }

        .product-card img {
            height: 220px;
            object-fit: cover;
        }
    </style>
</head>

<body>

<div class="container py-5">
<%--        =============== Back ===============--%>
        <div class="mb-4">
            <c:choose>
<%--                <c:when test="${not empty param.returnUrl}">--%>
<%--                    <a href="${param.returnUrl}" class="btn btn-outline-dark btn-sm">--%>
<%--                        ← Quay lại--%>
<%--                    </a>--%>
<%--                </c:when>--%>
                <c:otherwise>
                    <a href="/home" class="btn btn-outline-dark btn-sm">
                        ← Quay lại
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

    <br>

    <!-- ================= TOP SECTION ================= -->
    <div class="row g-5">

        <!-- HÌNH ẢNH -->
        <div class="col-lg-6">

            <div class="main-image mb-3">
                <img src="car-main.jpg" alt="">
            </div>

            <div class="row g-3">
                <div class="col-4">
                    <div class="sub-image">
                        <img src="car1.jpg" alt="">
                    </div>
                </div>
                <div class="col-4">
                    <div class="sub-image">
                        <img src="car2.jpg" alt="">
                    </div>
                </div>
                <div class="col-4">
                    <div class="sub-image">
                        <img src="car3.jpg" alt="">
                    </div>
                </div>
            </div>

        </div>


        <!-- THÔNG TIN + KHU MUA -->
        <div class="col-lg-6">

            <h1>${product.name} Model 1:18</h1>

            <div class="mb-3">
                <span class="badge bg-danger">Giảm 20%</span>
                <span class="badge badge-hot">HOT</span>
            </div>

            <!-- Rating -->
            <div class="mb-3">
                ★★★★☆ (4.5 / 5 - 124 đánh giá)
            </div>

            <p>
                ${product.description}
            </p>

            <hr>

            <div class="price-box">

                <div class="mb-2">
                    <span class="price-current">
                     <p><fmt:formatNumber value="${product.price}"
                                          type="number"
                                          groupingUsed="true"/> ₫
                    </p>
                    </span>
                    <span class="price-old ms-2">
                    <p><fmt:formatNumber value="${product.price}"
                                         type="number"
                                         groupingUsed="true"/> ₫
                    </p>
                    </span>
                </div>

                <!-- Voucher -->
                <div class="mb-3">
                    <button class="btn btn-outline-dark w-100">
                        Chọn Voucher
                    </button>
                </div>

                <!-- Số lượng -->
                <div class="mb-3">
                    <label class="form-label">Số lượng</label>
                    <input type="number" class="form-control" value="1" min="1">
                </div>

                <!-- Nút hành động -->
                <div class="d-grid gap-2">
                    <button class="btn btn-buy">Mua ngay</button>
                    <button class="btn btn-outline-dark">Thêm vào giỏ hàng</button>
                    <button class="btn star-btn">★ Thêm vào yêu thích</button>
                </div>

            </div>

        </div>
    </div>


    <!-- ================= THÔNG SỐ ================= -->
    <div class="mt-5">
        <h2>Thông Số Kỹ Thuật</h2>
        <table class="table mt-3">
            <tr>
                <th>Tỉ lệ</th>
                <td>${product.ratio}</td>
            </tr>
            <tr>
                <th>Chất liệu</th>
                <td>${product.meterial}</td>
            </tr>
            <tr>
                <th>Hãng</th>
                <td>${product.brandName}</td>
            </tr>
            <tr>
                <th>Xuất xứ</th>
                <td>${product.orign}</td>
            </tr>
        </table>
    </div>


    <!-- ================= ĐÁNH GIÁ ================= -->
    <div class="mt-5">
        <h2>Đánh Giá & Bình Luận</h2>

        <div class="mb-4">
            <strong>Nguyễn Văn A</strong>
            <div>★★★★★</div>
            <p>Chi tiết rất sắc nét, đóng gói cẩn thận.</p>
        </div>

        <hr>

        <!-- Form bình luận -->
        <form>
            <div class="mb-3">
                <label class="form-label">Viết bình luận</label>
                <textarea class="form-control" rows="3"></textarea>
            </div>
            <button class="btn btn-dark">Gửi đánh giá</button>
        </form>
    </div>


    <!-- ================= SẢN PHẨM LIÊN QUAN ================= -->
    <div class="mt-5">
        <h2 class="mb-4">Sản Phẩm Liên Quan</h2>

        <div class="row g-4">

            <div class="col-lg-3 col-md-6">
                <div class="card product-card">
                    <img src="car2.jpg" class="card-img-top" alt="">
                    <div class="card-body text-center">
                        <h6>Lamborghini Aventador</h6>
                        <p>3.200.000</p>
                        <button class="btn btn-sm btn-outline-dark">Xem</button>
                    </div>
                </div>
            </div>

            <!-- copy thêm -->

        </div>
    </div>

</div>

</body>
</html>
