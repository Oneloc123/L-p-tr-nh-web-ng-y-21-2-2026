<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 8:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Sản phẩm - LUXCAR</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font luxury đề xuất -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Inter:wght@300;400;500;600&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        h1, h2, h3, h4 {
            font-family: 'Cormorant Garamond', serif;
        }

        .sidebar {
            background: #fff;
            padding: 30px;
            border-right: 1px solid #eee;
        }

        .filter-title {
            font-weight: 600;
            margin-top: 25px;
            margin-bottom: 15px;
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

        .product-image-wrapper {
            height: 250px; /* cố định chiều cao ảnh */
            overflow: hidden;
        }

        .product-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* quan trọng */
        }

        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .product-price {
            font-weight: 500;
        }

        .btn-buy {
            background: #000;
            color: #fff;
        }

        .btn-buy:hover {
            background: #333;
            color: #fff;
        }

        .star-btn {
            border: 1px solid #000;
        }

        .star-btn:hover {
            background: #000;
            color: #fff;
        }

        .product-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>

<%@ include file="/common/header.jsp" %>
<body>

<div class="container-fluid">
    <div class="row">

        <!-- ================= SIDEBAR FILTER ================= -->
        <div class="col-lg-3 col-md-4 sidebar">

            <!-- Tìm kiếm -->
            <div>
                <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm...">
            </div>

            <!-- Phân loại -->
            <div>
                <div class="filter-title">Theo Loại</div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Siêu Xe</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Xe Thể Thao</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Xe Cổ Điển</label>
                </div>
            </div>

            <!-- Theo hãng -->
            <div>
                <div class="filter-title">Theo Hãng</div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Ferrari</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Lamborghini</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Porsche</label>
                </div>
            </div>

            <!-- Giá -->
            <div>
                <div class="filter-title">Khoảng Giá</div>
                <input type="range" class="form-range">
                <small>0 - 10.000.000</small>
            </div>

            <!-- Sản phẩm nổi bật -->
            <div>
                <div class="filter-title">Tùy chọn khác</div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Sản phẩm nổi bật</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox">
                    <label class="form-check-label">Sản phẩm mới</label>
                </div>
            </div>

            <button class="btn btn-dark w-100 mt-4">Lọc sản phẩm</button>

        </div>


        <!-- ================= PRODUCT LIST ================= -->
        <div class="col-lg-9 col-md-8 p-5">

            <h2 class="mb-4">Tất Cả Sản Phẩm</h2>

            <div class="row g-4">

                <!-- CARD 1 -->
                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>


                <!-- CARD 2 -->
                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card product-card">

                        <a href="product-detail.html" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLET_lWcDmg0bCLG53BM9CgOk4Hxyjqenz8w&s"
                                     class="card-img-top" alt="">
                            </div>
                        </a>

                        <div class="card-body text-center">

                            <div>
                                <h6>Ferrari 488 Pista</h6>
                                <p class="product-price">2500000</p>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3">
                                <button class="btn btn-buy btn-sm">Mua</button>
                                <button class="btn star-btn btn-sm">★</button>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Copy thêm sản phẩm -->

            </div>

        </div>

    </div>
</div>

</body>
</html>
