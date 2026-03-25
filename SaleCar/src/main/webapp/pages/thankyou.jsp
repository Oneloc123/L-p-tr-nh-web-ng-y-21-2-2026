<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cảm ơn bạn - LUXCAR</title>
    <%@ include file="/common/header.jsp" %>
    <style>
        .thankyou-wrapper {
            min-height: 60vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            background-color: #f8f9fa;
            padding: 50px 20px;
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