<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/20/2026
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- FOOTER SECTION -->
<footer class="footer">

<%--    <div id="alertContainer"></div>--%>
    <script src="${pageContext.request.contextPath}/common/assets/alert.js"></script>

    <%--    Login success--%>
    <c:if test="${not empty sessionScope.toastMessage}">
        <script>

            showAlert(
                "${sessionScope.toastMessage}",
                "${sessionScope.toastType}"
            );

        </script>

        <c:remove var="toastMessage" scope="session"/>
        <c:remove var="toastType" scope="session"/>

    </c:if>
    <div class="container">
        <!-- Main Footer Content -->
        <div class="row g-4">
            <!-- Column 1: Brand Info -->
            <div class="col-lg-4 col-md-6">
                <div class="footer-brand">
                    <i class="bi bi-gem me-2"></i>LUXCAR
                </div>
                <p class="footer-description">
                    Nơi hội tụ những dòng xe sang trọng bậc nhất thế giới.
                    Chúng tôi mang đến trải nghiệm mua sắm đẳng cấp và dịch vụ hoàn hảo nhất.
                </p>
                <div class="footer-social">
                    <a href="#" class="social-link"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-link"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-link"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="social-link"><i class="bi bi-tiktok"></i></a>
                </div>
            </div>

            <!-- Column 2: Quick Links -->
            <div class="col-lg-2 col-md-6">
                <h4 class="footer-title">Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home"><i class="bi bi-chevron-right"></i>Trang
                        chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products"><i class="bi bi-chevron-right"></i>Sản
                        phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/favorites"><i class="bi bi-chevron-right"></i>Yêu
                        thích</a></li>
                    <li><a href="${pageContext.request.contextPath}/about"><i class="bi bi-chevron-right"></i>Giới thiệu</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/contact"><i class="bi bi-chevron-right"></i>Liên hệ</a>
                    </li>
                </ul>
            </div>

            <!-- Column 3: Support -->
            <div class="col-lg-2 col-md-6">
                <h4 class="footer-title">Hỗ trợ</h4>
                <ul class="footer-links">
                    <li><a href="#"><i class="bi bi-chevron-right"></i>Chính sách bảo hành</a></li>
                    <li><a href="#"><i class="bi bi-chevron-right"></i>Chính sách đổi trả</a></li>
                    <li><a href="#"><i class="bi bi-chevron-right"></i>Vận chuyển & giao nhận</a></li>
                    <li><a href="#"><i class="bi bi-chevron-right"></i>Thanh toán</a></li>
                    <li><a href="#"><i class="bi bi-chevron-right"></i>FAQ</a></li>
                </ul>
            </div>

            <!-- Column 4: Contact Info -->
            <div class="col-lg-4 col-md-6">
                <h4 class="footer-title">Thông tin liên hệ</h4>
                <ul class="footer-contact">
                    <li>
                        <i class="bi bi-geo-alt"></i>
                        <span>123 Đường Lê Duẩn, Quận 1, TP. Hồ Chí Minh</span>
                    </li>
                    <li>
                        <i class="bi bi-telephone"></i>
                        <span>Hotline: <a href="tel:19001000">1900 1000</a></span>
                    </li>
                    <li>
                        <i class="bi bi-envelope"></i>
                        <span>Email: <a href="mailto:info@luxcar.vn">info@luxcar.vn</a></span>
                    </li>
                    <li>
                        <i class="bi bi-clock"></i>
                        <span>Thời gian làm việc: 8:00 - 21:00 (T2-CN)</span>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Newsletter Section -->
        <div class="row mt-5 pt-3">
            <div class="col-12">
                <div class="newsletter-wrapper">
                    <div class="newsletter-content">
                        <i class="bi bi-envelope-paper"></i>
                        <h4>Đăng ký nhận tin</h4>
                        <p>Nhận thông tin ưu đãi và sản phẩm mới nhất</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/subscribe" method="POST" class="newsletter-form">
                        <div class="input-group">
                            <input type="email"
                                   class="newsletter-input"
                                   placeholder="Email của bạn"
                                   required>
                            <button type="submit" class="newsletter-btn">
                                Đăng ký <i class="bi bi-send ms-2"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Payment Methods & Copyright -->
        <div class="row footer-bottom">
            <div class="col-md-6">
                <div class="payment-methods">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/visa/visa-original.svg" alt="Visa">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mastercard/mastercard-original.svg"
                         alt="Mastercard">
                    <i class="bi bi-credit-card"></i>
                    <i class="bi bi-bank"></i>
                    <i class="bi bi-cash"></i>
                </div>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="copyright">
                    © 2024 LUXCAR. All rights reserved.
                    <br class="d-md-none">
                    Design by <span class="text-gold">LUXCAR Team</span>
                </p>
            </div>
        </div>
    </div>
</footer>

<style>
    /* FOOTER STYLES */
    .footer {
        background: var(--black);
        border-top: 3px solid var(--gold);
        padding: 60px 0 20px;
        margin-top: 50px;
        position: relative;
    }

    /* Brand Section */
    .footer-brand {
        font-size: 28px;
        font-weight: 700;
        background: linear-gradient(135deg, var(--white) 0%, var(--gold) 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 20px;
        display: inline-block;
    }

    .footer-brand i {
        background: none;
        -webkit-text-fill-color: var(--gold);
        color: var(--gold);
    }

    .footer-description {
        color: rgba(255, 255, 255, 0.7);
        line-height: 1.6;
        margin-bottom: 20px;
        font-size: 14px;
    }

    /* Social Links */
    .footer-social {
        display: flex;
        gap: 15px;
    }

    .social-link {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background: rgba(212, 175, 55, 0.1);
        border: 1px solid rgba(212, 175, 55, 0.3);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--gold);
        font-size: 18px;
        transition: all 0.3s ease;
        text-decoration: none;
    }

    .social-link:hover {
        background: var(--gold);
        color: var(--black);
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }

    /* Footer Titles */
    .footer-title {
        color: var(--gold);
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        position: relative;
        padding-bottom: 10px;
    }

    .footer-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 40px;
        height: 2px;
        background: var(--gold);
    }

    /* Footer Links */
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-links li {
        margin-bottom: 12px;
    }

    .footer-links a {
        color: rgba(255, 255, 255, 0.7);
        text-decoration: none;
        font-size: 14px;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .footer-links a i {
        font-size: 10px;
        transition: transform 0.3s ease;
    }

    .footer-links a:hover {
        color: var(--gold);
        transform: translateX(5px);
    }

    .footer-links a:hover i {
        transform: translateX(3px);
    }

    /* Contact Info */
    .footer-contact {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-contact li {
        display: flex;
        align-items: flex-start;
        gap: 12px;
        margin-bottom: 15px;
        color: rgba(255, 255, 255, 0.7);
        font-size: 14px;
    }

    .footer-contact li i {
        color: var(--gold);
        font-size: 18px;
        margin-top: 2px;
        min-width: 20px;
    }

    .footer-contact li a {
        color: rgba(255, 255, 255, 0.7);
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-contact li a:hover {
        color: var(--gold);
    }

    /* Newsletter Section */
    .newsletter-wrapper {
        background: rgba(212, 175, 55, 0.05);
        border-radius: 15px;
        padding: 30px;
        border: 1px solid rgba(212, 175, 55, 0.2);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }

    .newsletter-content {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .newsletter-content i {
        font-size: 40px;
        color: var(--gold);
    }

    .newsletter-content h4 {
        color: var(--white);
        margin: 0;
        font-size: 20px;
        font-weight: 600;
    }

    .newsletter-content p {
        color: rgba(255, 255, 255, 0.7);
        margin: 5px 0 0;
        font-size: 13px;
    }

    .newsletter-form {
        flex: 1;
        min-width: 280px;
    }

    .newsletter-input {
        width: 100%;
        padding: 12px 20px;
        border: 2px solid rgba(212, 175, 55, 0.3);
        border-radius: 50px;
        background: rgba(255, 255, 255, 0.05);
        color: var(--white);
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .newsletter-input:focus {
        outline: none;
        border-color: var(--gold);
        background: rgba(255, 255, 255, 0.1);
        box-shadow: 0 0 15px rgba(212, 175, 55, 0.2);
    }

    .newsletter-input::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }

    .newsletter-btn {
        position: absolute;
        right: 5px;
        top: 50%;
        transform: translateY(-50%);
        background: var(--gold);
        color: var(--black);
        border: none;
        padding: 8px 25px;
        border-radius: 50px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .newsletter-btn:hover {
        background: var(--dark-gold);
        transform: translateY(-50%) scale(1.02);
    }

    .input-group {
        position: relative;
        display: flex;
        align-items: center;
    }

    /* Footer Bottom */
    .footer-bottom {
        margin-top: 50px;
        padding-top: 20px;
        border-top: 1px solid rgba(212, 175, 55, 0.2);
    }

    .payment-methods {
        display: flex;
        gap: 15px;
        align-items: center;
    }

    .payment-methods img,
    .payment-methods i {
        width: 40px;
        height: 30px;
        object-fit: contain;
        font-size: 28px;
        color: rgba(255, 255, 255, 0.7);
        transition: all 0.3s ease;
    }

    .payment-methods i {
        font-size: 28px;
    }

    .payment-methods img:hover,
    .payment-methods i:hover {
        color: var(--gold);
        transform: translateY(-2px);
    }

    .copyright {
        color: rgba(255, 255, 255, 0.6);
        font-size: 13px;
        margin: 0;
    }

    .text-gold {
        color: var(--gold);
        font-weight: 600;
    }

    /* Responsive */
    @media (max-width: 991px) {
        .footer {
            padding: 40px 0 20px;
        }

        .newsletter-wrapper {
            flex-direction: column;
            text-align: center;
        }

        .newsletter-content {
            flex-direction: column;
            text-align: center;
        }

        .footer-bottom {
            text-align: center;
        }

        .payment-methods {
            justify-content: center;
            margin-bottom: 15px;
        }
    }

    @media (max-width: 768px) {
        .footer-title {
            margin-top: 20px;
        }

        .newsletter-form {
            width: 100%;
        }
    }

    /* Back to Top Button */
    .back-to-top {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 45px;
        height: 45px;
        background: var(--gold);
        color: var(--black);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        font-size: 20px;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
        z-index: 999;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }

    .back-to-top.show {
        opacity: 1;
        visibility: visible;
    }

    .back-to-top:hover {
        background: var(--dark-gold);
        transform: translateY(-3px);
        color: var(--black);
    }
</style>

<!-- Back to Top Button -->
<a href="#" class="back-to-top" id="backToTop">
    <i class="bi bi-arrow-up"></i>
</a>

<script>
    // Back to Top Button
    const backToTopButton = document.getElementById('backToTop');

    window.addEventListener('scroll', () => {
        if (window.pageYOffset > 300) {
            backToTopButton.classList.add('show');
        } else {
            backToTopButton.classList.remove('show');
        }
    });

    backToTopButton.addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({top: 0, behavior: 'smooth'});
    });
</script>
</body>
</html>
