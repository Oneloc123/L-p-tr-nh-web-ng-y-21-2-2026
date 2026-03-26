<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<h1>TEST JSP WORKING</h1>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/common/header.jsp" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Chi tiết sản phẩm - LUXCAR</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Font luxury -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Inter:wght@300;400;500;600&display=swap"
          rel="stylesheet">

    <style>

        /* =================================================
           1. CÀI ĐẶT CHUNG CHO TRANG
           ================================================= */

        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
        }

        /* Font tiêu đề */
        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }


        /* =================================================
           2. HÌNH ẢNH SẢN PHẨM (TRANG CHI TIẾT)
           ================================================= */

        /* Ảnh chính */
        .main-image {
            height: 450px;
            overflow: hidden;
        }

        .main-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Ảnh phụ */
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


        /* =================================================
           3. GIÁ SẢN PHẨM
           ================================================= */

        .badge-hot {
            background: #000;
        }

        /* Box hiển thị giá */
        .price-box {
            background: #fff;
            padding: 30px;
            border: 1px solid #eee;
        }

        /* Giá sau giảm */
        .price-total {
            font-size: 50px;
            font-weight: 600;
        }

        /* Giá gốc */
        .price-old-bar {
            text-decoration: line-through;
            font-size: 30px;
            color: #888;
        }


        /* =================================================
           4. BUTTON
           ================================================= */

        /* Button đánh giá sao */
        .star-btn {
            border: 1px solid #000;
            background: #fff;
            transition: all 0.25s ease;
        }

        .star-btn i {
            color: #000000;
        }

        .star-btn:hover {
            background: #000;
            color: #fff;
            transform: translateY(-2px);
        }

        .star-btn:hover i {
            color: #ffc107;
        }

        /* Button mua hàng */
        .btn-buy {
            background: #000;
            color: #fff;
        }

        .btn-buy:hover {
            background: #333;
            color: #fff;
        }


        /* =================================================
           5. RATING (HIỂN THỊ SAO)
           ================================================= */

        /* Container rating */
        .rating-box {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 18px;
        }

        /* Các icon sao */
        .stars {
            display: flex;
            gap: 3px;
            color: #ffc107;
            font-size: 20px;
        }

        /* Hiệu ứng hover sao */
        .stars i {
            transition: transform 0.2s ease;
        }

        .stars i:hover {
            transform: scale(1.2);
        }

        /* Điểm rating */
        .rating-score {
            font-weight: 600;
            color: #000;
        }

        /* dấu "/" giữa điểm và max */
        .rating-divider {
            color: #888;
        }

        /* max rating */
        .rating-max {
            color: #888;
        }

        /* số lượng review */
        .rating-reviews {
            margin-left: 6px;
            color: #777;
            font-size: 15px;
        }


        /* =================================================
           6. REVIEW SECTION
           ================================================= */

        /* Tiêu đề review */
        .review-title {
            margin-bottom: 30px;
        }

        /* Khi chưa có review */
        .no-review {
            color: #777;
        }

        /* Card hiển thị review */
        .review-card {
            display: flex;
            gap: 15px;
            padding: 20px;
            background: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        /* Avatar người review */
        .review-avatar img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
        }

        /* Nội dung review */
        .review-content {
            flex: 1;
        }

        /* Header review */
        .review-header {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Tên người review */
        .review-name {
            font-size: 16px;
        }

        /* Ngày review */
        .review-date {
            font-size: 13px;
            color: #888;
            margin-bottom: 8px;
        }

        /* Nội dung bình luận */
        .review-comment {
            font-size: 15px;
            line-height: 1.6;
        }

        /* Form viết review */
        .review-form {
            margin-top: 30px;
        }


        /* =================================================
           7. RATING SUMMARY (TỔNG QUAN ĐÁNH GIÁ)
           ================================================= */

        .rating-summary {
            display: flex;
            align-items: center;
            gap: 40px;
            margin-bottom: 30px;
            padding: 20px;
            background: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
        }

        /* Điểm rating lớn */
        .rating-big {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .rating-big i {
            font-size: 36px;
            color: #ffc107;
        }

        .rating-big-number {
            font-size: 28px;
            font-weight: 600;
        }

        /* Tổng số review */
        .rating-total {
            color: #777;
            font-size: 14px;
        }

        /* Các mức rating */
        .rating-levels {
            display: flex;
            gap: 15px;
        }

        .rating-level {
            font-size: 14px;
            color: #ffc107;
            padding: 6px 10px;
            border: 1px solid #eee;
            border-radius: 6px;
            background: #eeeeee;
        }


        /* =================================================
           8. RELATED PRODUCT (SẢN PHẨM LIÊN QUAN)
           ================================================= */

        /* Card sản phẩm */
        .product-card {
            border: none;
            height: 100%;
            background: #fff;
            transition: all 0.25s ease;
        }

        /* Hover card */
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        }

        /* Container ảnh */
        .product-image {
            position: relative;
            overflow: hidden;
        }

        /* Ảnh sản phẩm */
        .product-image img {
            height: 220px;
            width: 100%;
            object-fit: cover;
        }

        /* Badge giảm giá */
        .badge-discount {
            position: absolute;
            top: 10px;
            left: 10px;
            background: #000;
            color: #fff;
            font-size: 13px;
            padding: 4px 8px;
            border-radius: 4px;
        }

        /* Brand sản phẩm */
        .product-brand {
            font-size: 12px;
            color: #777;
            margin-bottom: 4px;
        }

        /* Tên sản phẩm */
        .product-name {
            font-size: 15px;
            font-weight: 500;
            min-height: 40px;
        }

        /* Box giá */
        .product-price {
            margin-top: 6px;
        }

        /* Giá hiện tại */
        .price-current {
            font-weight: 600;
            font-size: 16px;
        }

        /* Giá cũ */
        .price-old {
            text-decoration: line-through;
            color: #888;
            font-size: 13px;
            margin-left: 6px;
        }

        /* Rating sản phẩm */
        .product-rating {
            margin-top: 6px;
            font-size: 14px;
            color: #ffc107;
        }

        /* Text trong rating */
        .product-rating span {
            color: #000;
            margin-left: 4px;
        }

        /* Số lượng review */
        .review-count {
            color: #777;
            margin-left: 4px;
        }

        form {
            margin: 0;
            padding: 0;
        }

    </style>
</head>

<body>

<div class="container py-5">
    <%--        =============== Back ===============--%>
    <div class="mb-4">
        <c:if test="${returnUrl ne null}">
            <a href="${returnUrl}" class="btn btn-outline-dark btn-sm">
                ← Quay lại
            </a>
        </c:if>

        <c:if test="${returnUrl eq null}">
            <a href="/products" class="btn btn-outline-dark btn-sm">
                ← Quay lại
            </a>
        </c:if>
    </div>

    <br>

    <!-- ================= TOP SECTION ================= -->
    <div class="row g-5">

        <!-- HÌNH ẢNH -->
        <div class="col-lg-6">

            <div class="main-image mb-3">
                <img src="" alt="">
            </div>

            <div class="row g-3">
                <div class="col-4">
                    <div class="sub-image">
                        <img src="" alt="">
                    </div>
                </div>
                <div class="col-4">
                    <div class="sub-image">
                        <img src="" alt="">
                    </div>
                </div>
                <div class="col-4">
                    <div class="sub-image">
                        <img src="" alt="">
                    </div>
                </div>
            </div>

        </div>


        <!-- THÔNG TIN + KHU MUA -->
        <div class="col-lg-6">

            <h1>${product.name} Model ${product.ratio}</h1>


            <c:if test="${productDetail.ratePrice ne null && productDetail.ratePrice gt 1}">
                <div class="mb-3">
                    <span class="badge bg-danger">Giảm ${productDetail.ratePrice}%</span>

                    <c:if test="${productDetail.ratePrice ge 20}">
                        <span class="badge badge-hot">HOT</span>
                    </c:if>
                </div>
            </c:if>


            <!-- Rating -->
            <div class="rating-box mb-3">

                <div class="stars">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i le productDetail.avgRating}">
                                <i class="bi bi-star-fill"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>

                <span class="rating-score">
                   <fmt:formatNumber
                           value="${productDetail.avgRating}"
                           maxFractionDigits="1"/>
                </span>

                <span class="rating-divider">/</span>

                <span class="rating-max">5</span>

                <span class="rating-reviews">
        (${productDetail.totalReviews} đánh giá)
    </span>

            </div>
            <p>
                ${product.description}
            </p>

            <hr>

            <div class="price-box">

                <div class="mb-2">
                    <span class="price-total">
                     <p><fmt:formatNumber value="${product.finalPrice}"
                                          type="number"
                                          groupingUsed="true"/> ₫
                    </p>
                    </span>
                    <span class="price-old-bar ms-2">
                    <p><fmt:formatNumber value="${product.price}"
                                         type="number"
                                         groupingUsed="true"/> ₫
                    </p>
                    </span>
                </div>


                <!-- Số lượng -->
                <div class="mb-3">
                    <label class="form-label">Số lượng</label>
                    <input type="number" name="quantity" class="form-control" value="1" min="1" form="add-to-cart">
                </div>

                <!-- Nút hành động -->
                <div class="d-grid gap-2">



                    <!-- them sp vao cart -->
                    <form id="add-to-cart" action="cart-add" method="get" class="w-100">
                        <input type="hidden" name="productId" value="${product.id}">



                        <button type="button" class="btn btn-outline-dark w-100"
                        onclick="addToCartAjax(event,'${product.id}', '${product.name}', false)">Thêm vào giỏ hàng
                        </button>
                    </form>

                    <form id="buy-now" action="buy-now" method="get" class="w-100">
                        <input type="hidden" name="productId" value="${product.id}">

                        <button type="button" class="btn btn-buy w-100"
                        onclick="addToCartAjax(event,'${product.id}', '${product.name}', true)" >Mua ngay</button>
                    </form>

                    <form method="post" action="/favorites" class="w-100">
                        <button type="submit"
                                class="btn star-btn w-100"
                                name="productid"
                                value="${product.id}">
                            <i class="bi bi-star me-2"></i>
                            Thêm vào yêu thích
                        </button>
                    </form>
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
                <th>Kích thước</th>
                <td>${product.size}</td>
            </tr>
            <tr>
                <th>Chất liệu</th>
                <td>${product.material}</td>
            </tr>
            <tr>
                <th>Hãng</th>
                <td><a href="${productDetail.brandLink}" target="_blank">${productDetail.brandName}</a></td>
            </tr>
            <tr>
                <th>Xuất xứ</th>
                <td>${product.origin}</td>
            </tr>
        </table>
    </div>


    <!-- ================= ĐÁNH GIÁ ================= -->
    <div class="mt-5 review-section">

        <h2 class="review-title">Đánh Giá & Bình Luận</h2>

        <c:if test="${productDetail.totalReviews lt 1}">
            <p class="no-review">Chưa có đánh giá nào</p>
        </c:if>

        <div class="rating-summary">

            <!-- AVG RATING -->
            <div class="rating-big">

                <i class="bi bi-star-fill"></i>

                <div class="rating-big-number">
                    <fmt:formatNumber value="${productDetail.avgRating}" maxFractionDigits="1"/>
                </div>

                <div class="rating-total">
                    (${productDetail.totalReviews} đánh giá)
                </div>

            </div>

            <!-- RATING LEVELS -->
            <div class="rating-levels">

                <div class="rating-level">5 <i class="bi bi-star-fill"></i> (${rating.fiveStar})</div>
                <div class="rating-level">4 <i class="bi bi-star-fill"></i> (${rating.fourStar})</div>
                <div class="rating-level">3 <i class="bi bi-star-fill"></i> (${rating.threeStar})</div>
                <div class="rating-level">2 <i class="bi bi-star-fill"></i> (${rating.twoStar})</div>
                <div class="rating-level">1 <i class="bi bi-star-fill"></i> (${rating.oneStar})</div>

            </div>

        </div>

        <c:forEach var="r" items="${productDetail.reviews}">

            <div class="review-card">

                <!-- Avatar -->
                <div class="review-avatar">
                    <div class="review-avatar">

                        <c:choose>
                            <c:when test="${r.avatar ne null}">
                                <img src="${r.avatar}" alt="avatar">
                            </c:when>

                            <c:otherwise>
                                <img src="https://avatarfiles.alphacoders.com/369/thumb-1920-369714.jpeg" alt="avatar">
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

                <div class="review-content">

                    <div class="review-header">
                        <strong class="review-name">${r.userName}</strong>

                        <div class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i le r.rating}">
                                        <i class="bi bi-star-fill"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-star"></i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>

                    <p class="review-date">${r.createAt}</p>

                    <p class="review-comment">${r.comment}</p>

                </div>

            </div>

        </c:forEach>

        <hr>

        <!-- Form bình luận -->
        <form action="/reviews" method="post" class="review-form">

            <input type="hidden" name="productId" value="${product.id}">

            <select name="rating" class="form-select w-25">
                <option value="5">5 ⭐</option>
                <option value="4">4 ⭐</option>
                <option value="3">3 ⭐</option>
                <option value="2">2 ⭐</option>
                <option value="1">1 ⭐</option>
            </select>

            <div class="mb-3 mt-3">
                <label class="form-label">Viết bình luận</label>
                <textarea class="form-control" rows="3" name="comment"></textarea>
            </div>

            <button class="btn btn-dark" type="submit">Gửi đánh giá</button>

        </form>

    </div>

    <!-- ================= SẢN PHẨM LIÊN QUAN ================= -->
    <div class="mt-5">
        <h2 class="mb-4">Sản Phẩm Liên Quan</h2>


        <div class="row g-4 mt-2">

            <c:forEach items="${related}" var="rl">
                <div class="col-lg-3 col-md-6">

                    <div class="card product-card shadow-sm">

                        <!-- IMAGE -->
                        <div class="product-image">
                            <img src="" class="card-img-top" alt="${rl.name}">

                            <!-- DISCOUNT BADGE -->
                            <c:if test="${rl.ratePrice gt 0}">
                        <span class="badge-discount">
                            -${rl.ratePrice}%
                        </span>
                            </c:if>
                        </div>

                        <div class="card-body text-center">

                            <!-- BRAND -->
                            <div class="product-brand">
                                    ${rl.brandName}
                            </div>

                            <!-- NAME -->
                            <h6 class="product-name">
                                    ${rl.name}
                            </h6>

                            <!-- PRICE -->
                            <div class="product-price">

                        <span class="price-current">
                            <fmt:formatNumber value="${rl.finalPrice}"
                                              type="number"
                                              groupingUsed="true"/> ₫
                        </span>

                                <c:if test="${rl.ratePrice gt 0}">
                            <span class="price-old">
                                <fmt:formatNumber value="${rl.price}"
                                                  type="number"
                                                  groupingUsed="true"/> ₫
                            </span>
                                </c:if>

                            </div>

                            <!-- RATING -->
                            <div class="product-rating">

                                <i class="bi bi-star-fill"></i>
                                <span>${rl.avgRating}</span>

                                <span class="review-count">
                            (${rl.reviews.size()})
                        </span>

                            </div>

                            <!-- BUTTON -->
                            <a href="/products?id=${rl.id}"
                               class="btn btn-sm btn-outline-dark mt-2">
                                Xem chi tiết
                            </a>

                        </div>

                    </div>

                </div>
            </c:forEach>

        </div>
    </div>

</div>

<!-- khai bao TOAST -->
<div id="customToast" style="visibility: hidden; min-width: 250px; background-color: #28a745; color: white; text-align: center; border-radius: 5px; padding: 16px; position: fixed; z-index: 9999; right: 30px; top: 30px; font-weight: bold; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); transition: opacity 1s;">
    <i class="fas fa-check-circle"></i> <span id="toastMessage"> Đã thêm vào giỏ!</span>
</div>

<!-- thong bao dang nhap -->
<div class="modal fade" id="requireLoginModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
            <div class="modal-header" style="border-bottom: 1px solid #eee;">
                <h5 class="modal-title" style="color: var(--gold); font-weight: 600;">
                    <i class="bi bi-shield-lock me-2"></i>Yêu cầu đăng nhập
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body text-center" style="padding: 30px 20px;">
                <i class="bi bi-person-circle" style="font-size: 50px; color: #ddd; margin-bottom: 15px; display: block;"></i>
                <h6 style="font-size: 16px; color: #333; line-height: 1.5;">Vui lòng đăng nhập để thêm mặt hàng này vào giỏ nhé!</h6>
            </div>

            <div class="modal-footer justify-content-center" style="border-top: none; padding-bottom: 25px;">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" style="border-radius: 30px; padding: 8px 24px; font-weight: 500;">
                    Tiếp tục lướt
                </button>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark" style="border-radius: 30px; padding: 8px 24px; background-color: var(--black); font-weight: 500;">
                    Đi đến đăng nhập
                </a>
            </div>
        </div>
    </div>
</div>



<script>
    function addToCartAjax(event, productId, productName, isBuyNow){
        event.preventDefault();

        let quantityInput = document.querySelector('input[name="quantity"]');
        let quantity;

        if (quantityInput != null){
            quantity = quantityInput.value
        } else{
            quantity = 1;
        }

        let apiUrl;
        if (isBuyNow == true){
            apiUrl = 'buy-now';
        } else{
            apiUrl = 'cart-add';
        }

        fetch(apiUrl + '?productId=' + productId + '&quantity=' + quantity + '&ajax=true')
            .then(function(response) {
                return response.text();
            })
            .then(function(data) {
                if (data.trim() === 'success'){

                    if(isBuyNow === true){
                        window.location.href = "checkout?type=buynow";
            } else {

            // hien thi thong bao(TOAST)
            let toast = document.getElementById("toastMessage");
            document.getElementById("toastMessage").innerText = "Đã thêm "+ quantity + " chiếc [" + productName + "] vào giỏ!";

            toast.style.visibility = "visible";
            toast.style.opacity = "1";

            setTimeout( function(){
                toast.style.opacity = "0";

                setTimeout(function(){ toast.style.visibility = "hidden"; }, 500);
            }, 3000);

            // CỘNG SỐ GIỎ HÀNG
            let count = document.getElementById("cart-count");

            if (count != null){
                let crrNumber = parseInt(count.innerText);

                if (isNaN(crrNumber)){
                    crrNumber = 0; }
                count.innerText = crrNumber + parseInt(quantity);
            }
            }


            } else if (data.trim() === 'need_login'){
                let loginModal = new bootstrap.Modal(document.getElementById("requireLoginModal"));
                loginModal.show();
            }
    })
    .catch(function(error) {
        console.error("Lỗi khi thêm giỏ hàng:", error);
        alert("có lỗi xãy ra, vui lòng thử lại!");
    });
}
</script>

</body>
</html>
