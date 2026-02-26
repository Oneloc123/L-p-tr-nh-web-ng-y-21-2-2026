<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/common/header.jsp" %>

    <title>Luxury Car Model</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600&family=Poppins:wght@300;400;500&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }


        .hero {
            background: #111;
            color: white;
            padding: 120px 0;
        }

        .section-title {
            margin-bottom: 40px;
            text-align: center;
        }

        .product-card {
            border: none;
            transition: 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-price {
            font-weight: 500;
            color: #000;
        }

        .category-card {
            background: #fff;
            padding: 40px 20px;
            text-align: center;
            border: 1px solid #eee;
        }

        .badge-gif {
            height: 1.9em;
            vertical-align: middle;
        }

        .footer {
            background: #000;
            color: #aaa;
            padding: 40px 0;
        }

    </style>
</head>


<body>


<!-- ================= HERO ================= -->
<section class="hero text-center">
    <div class="container">
        <h1 class="display-4">Mô Hình Xe Sang Trọng</h1>
        <p class="lead mt-3">Tinh tế – Đẳng cấp – Chuẩn sưu tầm</p>
        <a href="/products" class="btn btn-outline-light mt-4 px-4">Khám phá ngay</a>
    </div>
</section>


<!-- ================= DANH MỤC ================= -->
<section class="py-5">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Theo Loại</h2>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="category-card">
                    <h5>Xe Thể Thao</h5>
                </div>
            </div>

            <div class="col-md-4">
                <div class="category-card">
                    <h5>Siêu Xe</h5>
                </div>
            </div>

            <div class="col-md-4">
                <div class="category-card">
                    <h5>Xe Cổ Điển</h5>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- ================= SẢN PHẨM NỔI BẬT ================= -->
<section class="py-5 bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Nổi Bật</h2>

        <div class="row g-4">

            <c:forEach var="p" items="${productHot}">
                <div class="col-md-3">
                    <div class="card product-card h-100 shadow-sm">

                        <img
                            <%--                                src="${p.image}"--%>
                                src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"

                                class="card-img-top"
                                style="height:220px; object-fit:cover;"
                                alt="${p.name}">

                        <div class="card-body text-center d-flex flex-column">

                            <div class="d-flex align-items-center gap-2">
                                <img
                                        src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYzh6dWZldmNoczNrdW1laGhtdjBnejVsbnN2NWRocGI3cTIwMDNveCZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9dHM/hvdEcuSP8Ue7ZnUjhM/giphy.gif"
                                class="badge-gif">
                                <h6 class="mb-2">${p.name}</h6>
                            </div>
                                <%--                            <p> ${p.updateat}</p>--%>

                            <p class="product-price mt-auto">
                                <fmt:formatNumber value="${p.price}"
                                                  type="number"
                                                  groupingUsed="true"/> ₫
                            </p>

                            <a href="/product-detail?id=${p.id}"
                               class="btn btn-outline-dark btn-sm ">
                                Chi tiết
                            </a>

                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Copy thêm sản phẩm tương tự -->

        </div>
    </div>
</section>


<!-- ================= SẢN PHẨM MỚI ================= -->
<section class="py-5">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Mới</h2>

        <div class="row g-4">

            <c:forEach var="p" items="${productNew}">
                <div class="col-md-3">
                    <div class="card product-card h-100 shadow-sm">

                        <img
                            <%--                                src="${p.image}"--%>
                                src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"

                                class="card-img-top"
                                style="height:220px; object-fit:cover;"
                                alt="${p.name}">

                        <div class="card-body text-center d-flex flex-column">

                            <div class="d-flex align-items-center gap-2">
                                <img
                                        src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExa2w5czN5bW1ncjRqNHU0bzRsdDV2aWg5aHQ5Nzdzbnd2aXRrb21xaSZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9dHM/oM5kD4MuSqXjhdCiSh/giphy.gif"
                                class="badge-gif">
                                <h6 class="mb-2">${p.name}</h6>
                            </div>
                                <%--                            <p> ${p.updateat}</p>--%>

                            <p class="product-price mt-auto">
                                <fmt:formatNumber value="${p.price}"
                                                  type="number"
                                                  groupingUsed="true"/> ₫
                            </p>

                            <a href="/product-detail?id=${p.id}"
                               class="btn btn-outline-dark btn-sm ">
                                Chi tiết
                            </a>

                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</section>


<!-- ================= SẢN PHẨM YÊU THÍCH ================= -->
<section class="py-5 bg-white">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Được Yêu Thích</h2>

        <div class="row g-4">

            <div class="col-md-3">
                <div class="card product-card">
                    <img src="https://media.playmobil.com/i/playmobil/71020_product_detail?w=540&sm=aspect&aspect=10:7&locale=el-GR,el,en,*&fmt=auto&strip=true&qlt=80&unsharp=0,1,0.9,1&fmt.jpeg.interlaced=true"
                         class="card-img-top" alt="">
                    <div class="card-body text-center">
                        <h6>Ferrari 488</h6>
                        <p class="product-price">2500000</p>
                        <a href="#" class="btn btn-outline-dark btn-sm">Chi tiết</a>
                    </div>
                </div>
            </div>

            <!-- Card sản phẩm giống phía trên -->

        </div>
    </div>
</section>


<!-- ================= BANNER ================= -->
<section class="py-5 text-center bg-dark text-white">
    <div class="container">
        <h3>Bộ Sưu Tập Giới Hạn 2026</h3>
        <p class="mt-3">Chỉ dành cho người thực sự đam mê</p>
        <a href="#" class="btn btn-outline-light">Xem ngay</a>
    </div>
</section>


<!-- ================= FOOTER ================= -->
<footer class="footer text-center">
    <div class="container">
        <h5 class="text-white">LUXCAR</h5>
        <p class="mt-3">© 2026 Luxury Car Model Store</p>
    </div>
</footer>

</body>
</html>