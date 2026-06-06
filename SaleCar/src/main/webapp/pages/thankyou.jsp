<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cảm ơn bạn - LUXCAR</title>
    <%@ include file="/common/header.jsp" %>
    <style>
        :root {
            --black: #000000;
            --gold: #D4AF37;
            --white: #FFFFFF;
            --gray-medium: #666666;
            --gray-light: #f5f5f5;
            --border-light: #e5e5e5;
        }

        .thankyou-wrapper {
            min-height: 50vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            background: linear-gradient(135deg, #f8f9fa 0%, #fff 100%);
            padding: 60px 20px 40px;
        }
        .thankyou-icon {
            font-size: 80px;
            color: var(--gold, #C5A028);
            margin-bottom: 20px;
            animation: popIn 0.5s ease-out forwards;
        }
        @keyframes popIn {
            0% { transform: scale(0); opacity: 0; }
            80% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); opacity: 1; }
        }

        /* Suggested Products Section */
        .suggested-section {
            max-width: 1100px;
            margin: 0 auto 60px;
            padding: 0 20px;
        }
        .suggested-section h2 {
            font-size: 24px;
            font-weight: 700;
            color: var(--black);
            text-align: center;
            margin-bottom: 8px;
        }
        .suggested-section .subtitle {
            text-align: center;
            color: var(--gray-medium);
            font-size: 14px;
            margin-bottom: 30px;
        }
        .suggested-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 20px;
        }
        .suggested-card {
            background: var(--white);
            border-radius: 16px;
            border: 1px solid var(--border-light);
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.04);
        }
        .suggested-card:hover {
            border-color: var(--black);
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
        }
        .suggested-card-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-bottom: 1px solid var(--border-light);
        }
        .suggested-card-body {
            padding: 16px;
        }
        .suggested-card-body h4 {
            font-size: 15px;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 6px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .suggested-price {
            font-size: 16px;
            font-weight: 700;
            color: var(--danger, #dc3545);
        }
        .suggested-price-original {
            font-size: 12px;
            color: var(--gray-medium);
            text-decoration: line-through;
            margin-left: 8px;
        }
        .suggested-card .btn-add-cart {
            width: 100%;
            padding: 10px;
            background: var(--black);
            color: var(--white);
            border: none;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s;
            margin-top: 8px;
            text-decoration: none;
            display: block;
            text-align: center;
        }
        .suggested-card .btn-add-cart:hover {
            background: var(--gold);
            color: var(--black);
        }
        .suggested-card .discount-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--danger, #dc3545);
            color: white;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }
        .img-wrapper {
            position: relative;
        }
    </style>
</head>
<body>

<div class="thankyou-wrapper">
    <i class="bi bi-envelope-paper-heart thankyou-icon"></i>
    <h1 style="font-family: 'Cormorant Garamond', serif; font-weight: 700;">Cảm ơn bạn đã mua hàng!</h1>
    <p class="text-muted mt-2 mb-4" style="font-size: 16px; max-width: 500px;">
        Đơn hàng của bạn đã được hệ thống ghi nhận và đang trong quá trình xử lý. Chúng tôi sẽ sớm liên hệ để giao những chiếc mô hình tuyệt đẹp đến tay bạn.
    </p>
    <div>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark" style="border-radius: 30px; padding: 10px 25px; margin-right: 10px;">
            <i class="bi bi-arrow-left"></i> Tiếp tục mua sắm
        </a>
        <a href="${pageContext.request.contextPath}/order" class="btn btn-dark" style="background-color: var(--black); border-radius: 30px; padding: 10px 25px;">
            Xem lịch sử đơn hàng <i class="bi bi-arrow-right"></i>
        </a>
    </div>
</div>

<%-- SUGGESTED PRODUCTS --%>
<c:if test="${not empty sessionScope.suggestedProducts}">
<section class="suggested-section">
    <h2>Gợi ý sản phẩm cho bạn</h2>
    <p class="subtitle">Có thể bạn sẽ thích những sản phẩm này</p>
    <div class="suggested-grid">
        <c:forEach var="product" items="${sessionScope.suggestedProducts}">
            <div class="suggested-card">
                <div class="img-wrapper">
                    <c:if test="${product.discountPercent > 0}">
                        <span class="discount-badge">-<fmt:formatNumber value="${product.discountPercent}" pattern="#"/>%</span>
                    </c:if>
                    <img src="${not empty product.image ? pageContext.request.contextPath.concat('/uploads/').concat(product.image) : 'https://placehold.co/400x300?text=LUXCAR'}"
                         alt="${product.name}" class="suggested-card-img"
                         onerror="this.src='https://placehold.co/400x300?text=LUXCAR'">
                </div>
                <div class="suggested-card-body">
                    <h4>${product.name}</h4>
                    <div>
                        <span class="suggested-price">
                            <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/> ₫
                        </span>
                        <c:if test="${product.finalPrice < product.price}">
                            <span class="suggested-price-original">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                            </span>
                        </c:if>
                    </div>
                    <a href="${pageContext.request.contextPath}/cart-add?productId=${product.id}&quantity=1" class="btn-add-cart">
                        <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <div style="text-align: center; margin-top: 30px;">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark" style="border-radius: 30px; padding: 10px 28px;">
            <i class="bi bi-grid"></i> Xem tất cả sản phẩm
        </a>
    </div>
</section>

<script>
    // Xoá suggestedProducts khỏi session sau khi người dùng rời trang
    // (chỉ hiển thị 1 lần, tránh hiển thị lại nếu reload)
    window.addEventListener('beforeunload', function() {
        navigator.sendBeacon('${pageContext.request.contextPath}/clear-suggested', '');
    });
    // Backup: xoá sau 30 giây nếu người dùng ở lại trang
    setTimeout(function() {
        fetch('${pageContext.request.contextPath}/clear-suggested', {method: 'POST'});
    }, 30000);
</script>
</c:if>

<div class="modal fade" id="orderSuccessModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 16px; border: none; box-shadow: 0 10px 40px rgba(0,0,0,0.15);">
            <div class="modal-body text-center" style="padding: 40px 30px;">
                <i class="bi bi-check-circle-fill" style="font-size: 65px; color: #28a745; display: block; margin-bottom: 15px;"></i>
                <h4 style="font-weight: 700; color: #333; margin-bottom: 10px;">Đặt hàng thành công!</h4>
                <p style="color: #666; font-size: 15px; margin-bottom: 25px;">
                    Thông báo này sẽ tự động tắt sau <strong id="countdown" style="color: #dc3545; font-size: 18px;">5</strong> giây...
                </p>

                <a href="${pageContext.request.contextPath}/order" class="btn w-100" style="background-color: var(--gold, #C5A028); color: white; border-radius: 30px; padding: 12px; font-weight: 600; font-size: 15px;">
                    <i class="bi bi-box-seam me-2"></i>Xem đơn hàng của bạn
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function(){

        let successModal = new bootstrap.Modal(document.getElementById('orderSuccessModal'));
        successModal.show();

        let timeLeft = 5;
        let countdownElement = document.getElementById('countdown');

        let timer = setInterval( function() {
            timeLeft--;
            countdownElement.innerText = timeLeft;

        if (timeLeft <= 0){
            clearInterval(timer);
            successModal.hide();
            }
        }, 1000);
    });

</script>
</body>
</html>