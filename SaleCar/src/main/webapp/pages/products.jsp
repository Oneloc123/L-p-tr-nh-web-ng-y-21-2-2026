<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 8:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/common/header.jsp" %>

    <title>Sản phẩm - LUXCAR</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Font luxury đề xuất -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Inter:wght@300;400;500;600&display=swap"
          rel="stylesheet">

    <style>
        /* ================= GLOBAL ================= */

        html, body {
            height: 100%;
            /*overflow: hidden;!* khóa scroll toàn trang *!*/
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        h1, h2, h3, h4 {
            font-family: 'Cormorant Garamond', serif;
        }

        /* Full height layout */
        .container-fluid {
            height: 100vh;
        }

        .row {
            height: 100%;
            align-items: flex-start;
        }


        /* ================= SIDEBAR ================= */

        .sidebar {
            background: #fff;
            padding: 30px;
            border-right: 1px solid #eee;

            height: 100%; /* full column height */
            overflow-y: auto; /* enable scroll */
        }

        /* Scrollbar style */
        .sidebar::-webkit-scrollbar,
        .product-wrapper::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-thumb,
        .product-wrapper::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 10px;
        }

        /* Sticky apply button inside sidebar */
        .sidebar-footer {
            position: sticky;
            bottom: 0;
            background: #fff;
            padding-top: 15px;
            margin-top: 20px;
            border-top: 1px solid #eee;
        }


        /* ================= PRODUCT LIST ================= */

        .product-wrapper {
            height: 100%;
            overflow-y: auto;
            padding: 3rem;
        }


        /* ================= FILTER STYLE ================= */

        .filter-title {
            font-weight: 600;
            margin-top: 25px;
            margin-bottom: 15px;
            letter-spacing: 0.5px;
            transition: 0.3s;
        }

        .filter-title:hover {
            color: #000;
        }

        /* Collapse icon */
        .toggle-icon {
            transition: transform 0.3s ease;
        }

        .filter-title[aria-expanded="true"] .toggle-icon {
            transform: rotate(180deg);
        }

        /* Limit filter height */
        .filter-scroll {
            max-height: 180px;
            overflow-y: auto;
        }


        /* ================= PRODUCT CARD ================= */

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
            height: 250px;
            overflow: hidden;
        }

        .product-image-wrapper img {
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

        .product-price {
            font-weight: 500;
        }

        .product-price-old {
            text-decoration: line-through;
            font-weight: 400;
            color: #888;

        }


        /* ================= BUTTON STYLE ================= */

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


        /* ================= PAGINATION ================= */

        .pagination .page-link {
            color: #000;
            border: 1px solid #ddd;
            transition: 0.3s;
        }

        .pagination .page-link:hover {
            background: #000;
            color: #fff;
            border-color: #000;
        }

        .pagination .page-item.active .page-link {
            background: #000;
            border-color: #000;
            color: #fff;
        }

        .pagination .page-item.disabled .page-link {
            color: #aaa;
        }

        .voucher-box {
            background: #fff;
            padding: 20px;
            border: 1px solid #eee;
            margin-top: 20px;
        }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row align-items-start">

        <!-- ================= SIDEBAR FILTER ================= -->
        <div class="col-lg-3 col-md-4 sidebar">
            <form action="products" method="get">

                <!-- Tìm kiếm -->
                <div>
                    <input name="find" value="${find}" type="text" class="form-control"
                           placeholder="Tìm kiếm sản phẩm...">
                </div>

                <%--            Giảm giá--%>
                <div>
                    <div class="filter-title">Giảm giá</div>
                    <div class="form-check">
                        <input name="discount" value="newest" class="form-check-input" type="checkbox">
                        <label class="form-check-label">Giảm giá mới nhất <img
                                src="https://nettruyen.work/assets/images/icon-hot.gif"> </label>
                    </div>
                    <div class="form-check">
                        <input name="discount" value="highest" class="form-check-input" type="checkbox">
                        <label class="form-check-label">Giảm giá nhiều nhất <img
                                src="https://nettruyen.work/assets/images/icon-hot.gif"></label>
                    </div>
                </div>

                <!-- Phân loại -->
                <div>
                    <div class="filter-title d-flex justify-content-between align-items-center"
                         data-bs-toggle="collapse"
                         data-bs-target="#categoryCollapse"
                         style="cursor:pointer;">
                        <span>Theo Loại (${totalCategory})</span>
                        <i class="toggle-icon bi bi-chevron-down"></i>
                    </div>

                    <div class="collapse " id="categoryCollapse">
                        <div class="filter-scroll">

                            <c:forEach var="cn" items="${categoryName}">
                                <div class="form-check">
                                    <input name="category" value="${cn}" class="form-check-input" type="checkbox">
                                    <label class="form-check-label">${cn}</label>
                                </div>
                            </c:forEach>

                        </div>
                    </div>

                </div>


                <!-- Theo hãng -->
                <div>
                    <div class="filter-title d-flex justify-content-between align-items-center"
                         data-bs-toggle="collapse"
                         data-bs-target="#brandCollapse"
                         style="cursor:pointer;">
                        <span>Theo Hãng (${totalBrand})</span>
                        <i class="toggle-icon bi bi-chevron-down"></i>
                    </div>

                    <div class="collapse " id="brandCollapse">
                        <div class="filter-scroll">

                            <c:forEach var="bn" items="${brandName}">
                                <div class="form-check">
                                    <input name="brand" value="${bn}" class="form-check-input" type="checkbox">
                                    <label class="form-check-label">${bn}</label>
                                </div>
                            </c:forEach>

                        </div>
                    </div>

                </div>

                <!-- Giá -->
                <div>
                    <div class="filter-title d-flex justify-content-between align-items-center"
                         data-bs-toggle="collapse"
                         data-bs-target="#priceCollapse"
                         style="cursor:pointer;">
                        <span>Theo Giá </span>
                        <i class="toggle-icon bi bi-chevron-down"></i>
                    </div>

                    <div class="collapse " id="priceCollapse">
                        <div class="filter-scroll">

                            <div class="form-check">
                                <input name="price" value="10000000" class="form-check-input" type="radio">
                                <label class="form-check-label"> < 10.000.000</label>
                            </div>

                            <div class="form-check">
                                <input name="price" value="50000000" class="form-check-input" type="radio">
                                <label class="form-check-label"> < 50.000.000</label>
                            </div>

                            <div class="form-check">
                                <input name="price" value="100000000" class="form-check-input" type="radio">
                                <label class="form-check-label"> < 100.000.000</label>
                            </div>

                            <div class="form-check">
                                <input name="price" value="500000000" class="form-check-input" type="radio">
                                <label class="form-check-label"> < 500.000.000</label>
                            </div>

                            <div class="form-check">
                                <input name="price" value="1000000000" class="form-check-input" type="radio">
                                <label class="form-check-label"> < 1.000.000.000</label>
                            </div>


                        </div>
                    </div>
                </div>

                <%--            <!-- Sản phẩm nổi bật -->--%>
                <%--            <div>--%>
                <%--                <div class="filter-title">Tùy chọn khác</div>--%>
                <%--                <div class="form-check">--%>
                <%--                    <input class="form-check-input" type="checkbox">--%>
                <%--                    <label class="form-check-label">Sản phẩm nổi bật</label>--%>
                <%--                </div>--%>
                <%--                <div class="form-check">--%>
                <%--                    <input class="form-check-input" type="checkbox">--%>
                <%--                    <label class="form-check-label">Sản phẩm mới</label>--%>
                <%--                </div>--%>
                <%--            </div>--%>

                <div class="sidebar-footer">
                    <button type="submit" class="btn btn-dark w-100">Áp dụng bộ lọc</button>
                </div>

            </form>

            <div class="voucher-box">
                <button class="btn btn-outline-dark w-100" data-bs-toggle="collapse" data-bs-target="#voucherArea">
                    Xem Voucher của bạn
                </button>

                <div class="collapse mt-3" id="voucherArea">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="border p-2 mb-2">
                            <strong>${v.code}</strong><br>
                            Giảm ${v.discount}
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>


        <!-- ================= PRODUCT LIST ================= -->
        <div class="col-lg-9 col-md-8 p-5 product-wrapper">
            <%--        Loại đang lọc--%>
            <%--            <div class="mb-3">--%>
            <%--                <span class="badge bg-dark">Ferrari ×</span>--%>
            <%--                <span class="badge bg-dark">Xe Thể Thao ×</span>--%>
            <%--            </div>--%>

            <h2 class="mb-4">Tất Cả Sản Phẩm (${totalProduct})</h2>

            <div class="row g-4">

                <!-- CARD 1 -->
                <c:forEach var="p" items="${products}">
                    <div class="col-lg-4 col-md-6">
                        <div class="card product-card">

                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="product-link">
                                <div class="product-image-wrapper">
                                    <img src="https://product.hstatic.net/1000328919/product/mo-hinh-xe-ferrari-296-gtb-assetto-fiorano-1-18-bburago-red__1__5f3c41eeffdf431b984bd7b18153072f_grande.jpg"
                                         class="card-img-top" alt="">
                                </div>
                            </a>

                            <div class="card-body text-center">

                                <div>
                                    <h6>${p.name} </h6>
                                    <h6>Model ${p.ratio}</h6>
                                    <p class="product-price-old mt-auto">
                                        <fmt:formatNumber value="${p.price}"
                                                          type="number"
                                                          groupingUsed="true"/> ₫
                                    </p>
                                    <h6 class="product-price mt-auto">
                                        <fmt:formatNumber value="${p.finalPrice}"
                                                          type="number"
                                                          groupingUsed="true"/> ₫
                                    </h6>

                                </div>

                                <!-- Mua ngay va them vao gio hang -->
                                <div class="d-flex justify-content-center gap-2 mt-3">

                                    <form id="add-to-cart" action="cart-add" method="get" class="">
                                        <input type= "hidden" name = "productId" value="${p.id}">
                                        <input type="hidden" name="quantity" value="1" min="1" form="add-to-cart">
                                        <button type="submit" name="action" value="buyNow" class="bi btn btn-buy btn-sm"><i>Mua ngay</i></button>
                                        <button type="submit" name="action" value="addCart" class="btn star-btn btn-sm "><i class="bi bi-cart-plus"></i></button>

                                    </form>
                                    <form method="post" action="/favorites">
                                        <button class="btn star-btn btn-sm" name="productid" value="${p.id}"><i
                                                class="bi bi-star"></i>
                                        </button>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${totalPage > 1}">
                    <div class="d-flex justify-content-center mt-5">
                        <nav>
                            <ul class="pagination">

                                <!-- Previous -->
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link"
                                       href="products?page=${currentPage - 1}<c:forEach var="cn" items="${selectedCategories}">&category=${cn}</c:forEach>
                                        <c:forEach var="bn" items="${selectedBrands}">&brand=${bn}</c:forEach>">
                                        <<
                                    </a>
                                </li>

                                <!-- Trang 1 -->
                                <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                                    <a class="page-link"
                                       href="products?page=1<c:forEach var="cn" items="${selectedCategories}">&category=${cn}</c:forEach>
                                        <c:forEach var="bn" items="${selectedBrands}">&brand=${bn}</c:forEach>">1</a>
                                </li>

                                <!-- Dấu ... đầu -->
                                <c:if test="${currentPage > 3}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>

                                <!-- Các trang giữa -->
                                <c:forEach begin="${currentPage - 1}"
                                           end="${currentPage + 1}"
                                           var="i">
                                    <c:if test="${i > 1 && i < totalPage}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="products?page=${i}<c:forEach var="cn" items="${selectedCategories}">&category=${cn}</c:forEach>
                                        <c:forEach var="bn" items="${selectedBrands}">&brand=${bn}</c:forEach>">
                                                    ${i}
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>

                                <!-- Dấu ... cuối -->
                                <c:if test="${currentPage < totalPage - 2}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>

                                <!-- Trang cuối -->
                                <li class="page-item ${currentPage == totalPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="products?page=${totalPage}<c:forEach var="cn" items="${selectedCategories}">&category=${cn}</c:forEach>
                                        <c:forEach var="bn" items="${selectedBrands}">&brand=${bn}</c:forEach>">
                                            ${totalPage}
                                    </a>
                                </li>

                                <!-- Next -->
                                <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
                                    <a class="page-link"
                                       href="products?page=${currentPage + 1}<c:forEach var="cn" items="${selectedCategories}">&category=${cn}</c:forEach>
                                        <c:forEach var="bn" items="${selectedBrands}">&brand=${bn}</c:forEach>">
                                        >>
                                    </a>
                                </li>

                            </ul>
                        </nav>
                    </div>
                </c:if>

                <!-- Copy thêm sản phẩm -->

            </div>

        </div>


    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
