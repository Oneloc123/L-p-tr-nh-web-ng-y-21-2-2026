<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --black: #0a0a0a;
            --red: #e60000;
            --red-dark: #b50000;
            --white: #ffffff;
            --gold: #D4AF37;
            --dark-gold: #B8960C;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            background: var(--black);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
        }

        /* ── SPLIT LAYOUT ── */
        .split-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            flex: 1;
            max-width: 1280px;
            width: 92%;
            margin: 40px auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 40px 80px rgba(0,0,0,0.6);
        }

        /* ── LEFT PANEL ── */
        .split-left {
            background: var(--black);
            padding: 52px 48px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        .split-left::before {
            content: '';
            position: absolute;
            top: -140px; right: -100px;
            width: 420px; height: 420px;
            border-radius: 50%;
            background: rgba(230,0,0,0.07);
            pointer-events: none;
        }
        .split-left::after {
            content: '';
            position: absolute;
            bottom: -100px; left: -80px;
            width: 300px; height: 300px;
            border-radius: 50%;
            background: rgba(230,0,0,0.04);
            pointer-events: none;
        }

        .left-brand a {
            font-size: 44px;
            font-weight: 900;
            letter-spacing: 6px;
            font-family: 'Arial Black', Impact, sans-serif;
            color: #fff;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 40px;
            transition: opacity .2s;
        }
        .left-brand a:hover { opacity: .85; }
        .left-brand .highlight { color: var(--red); }

        .left-title { margin-bottom: 36px; }
        .left-title h1 {
            font-size: 30px;
            font-weight: 800;
            color: #fff;
            line-height: 1.25;
            letter-spacing: -.5px;
        }
        .left-title .badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            margin-top: 16px;
            padding: 8px 16px;
            border-radius: 40px;
            background: rgba(230,0,0,0.12);
            border: 1px solid rgba(230,0,0,0.25);
            color: #ff4444;
            font-size: 13px;
            font-weight: 500;
        }

        .banner-area {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 18px;
            padding: 22px 20px;
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 32px;
        }
        .banner-icon {
            width: 64px; height: 64px;
            border-radius: 14px;
            background: rgba(230,0,0,0.12);
            border: 1px solid rgba(230,0,0,0.2);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .banner-icon i { font-size: 28px; color: var(--red); }
        .banner-text strong {
            font-size: 15px; font-weight: 600;
            color: #fff; display: block; margin-bottom: 4px;
        }
        .banner-text p { font-size: 12px; color: rgba(255,255,255,.5); line-height: 1.5; }

        .benefits-list { list-style: none; }
        .benefits-list li {
            display: flex; align-items: center; gap: 14px;
            padding: 13px 0;
            border-bottom: 1px solid rgba(255,255,255,.06);
            font-size: 14px; color: rgba(255,255,255,.75);
        }
        .benefits-list li:last-child { border-bottom: none; }
        .benefit-icon {
            width: 36px; height: 36px;
            border-radius: 10px;
            background: rgba(230,0,0,0.10);
            border: 1px solid rgba(230,0,0,0.15);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .benefit-icon i { font-size: 16px; color: var(--red); }

        /* ── RIGHT PANEL ── */
        .split-right {
            background: #fff;
            padding: 48px 44px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header { text-align: center; margin-bottom: 28px; }
        .form-header h1 {
            font-size: 26px; font-weight: 800;
            color: var(--black); letter-spacing: 1.5px;
        }
        .form-header .subtitle {
            font-size: 13px; color: #888; margin-top: 6px;
        }
        .form-header .sep {
            width: 40px; height: 3px;
            background: var(--red); border-radius: 2px;
            margin: 12px auto 0;
        }

        .message {
            background: #fafafa;
            border-left: 3px solid var(--black);
            border-radius: 0 8px 8px 0;
            padding: 10px 14px;
            margin-bottom: 24px;
            font-size: 12px; color: #555;
        }

        /* ── FORM ── */
        .row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

        .form-group { margin-bottom: 18px; }
        label {
            display: block;
            font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: .6px;
            color: #333; margin-bottom: 6px;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"] {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #e0e0e0;
            background: #fff;
            color: #111;
            font-size: 14px;
            border-radius: 10px;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }
        input::placeholder { color: #bbb; }
        input:focus {
            border-color: var(--red);
            box-shadow: 0 0 0 3px rgba(230,0,0,0.08);
        }
        .password-wrapper { position: relative; }
        .password-wrapper input { padding-right: 44px; }
        .toggle-password {
            position: absolute; right: 14px; top: 50%;
            transform: translateY(-50%);
            cursor: pointer; color: #aaa; font-size: 17px;
            transition: color .2s;
        }
        .toggle-password:hover { color: #333; }

        .error-message {
            display: block; font-size: 11px;
            color: var(--red); margin-top: 5px; font-weight: 500;
        }
        .form-group small { display: none; }

        .btn-register {
            width: 100%; padding: 14px;
            background: var(--black);
            color: #fff; border: none;
            font-size: 15px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 1px;
            border-radius: 12px; cursor: pointer;
            margin-top: 6px;
            transition: background .2s, transform .1s;
        }
        .btn-register:hover { background: var(--red); }
        .btn-register:active { transform: scale(.99); }

        .divider {
            display: flex; align-items: center;
            gap: 12px; margin: 20px 0 16px;
            color: #bbb; font-size: 11px;
            font-weight: 600; letter-spacing: 1px;
        }
        .divider::before, .divider::after {
            content: ''; flex: 1; height: 1px; background: #eee;
        }

        .social-login { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 20px; }
        .btn-social {
            display: flex; align-items: center;
            justify-content: center; gap: 8px;
            padding: 11px;
            border: 1.5px solid #e0e0e0;
            border-radius: 10px;
            text-decoration: none; color: #333;
            font-size: 13px; font-weight: 600;
            transition: all .2s;
        }
        .btn-social i { font-size: 17px; }
        .btn-social:hover { background: var(--black); color: #fff; border-color: var(--black); }

        .terms {
            text-align: center; font-size: 11px;
            color: #aaa; margin-top: 14px; margin-bottom: 0;
        }
        .terms a {
            color: #333; font-weight: 700;
            text-decoration: underline;
            text-underline-offset: 2px;
        }

        .login-link {
            text-align: center; font-size: 13px;
            color: #666; padding-top: 16px;
            border-top: 1px solid #f0f0f0; margin-top: 20px;
        }
        .login-link a {
            color: var(--black); font-weight: 700;
            text-decoration: none;
            border-bottom: 2px solid var(--red);
            padding-bottom: 1px;
        }
        .login-link a:hover { color: var(--red); }

        @media (max-width: 900px) {
            .split-layout { grid-template-columns: 1fr; }
            .split-left { display: none; }
            .split-right { padding: 40px 28px; }
            .row-2 { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="split-layout">

    <!-- ── CỘT TRÁI ── -->
    <div class="split-left">
        <div class="left-brand">
            <a href="${pageContext.request.contextPath}/home">LUX<span class="highlight">CAR</span></a>
        </div>
        <div class="left-title">
            <h1>Trải nghiệm mua sắm đẳng cấp cùng LuxCar</h1>
            <div class="badge"><i class="bi bi-star-fill"></i> Ưu đãi độc quyền thành viên</div>
        </div>
        <div class="banner-area">
            <div class="banner-icon"><i class="bi bi-car-front-fill"></i></div>
            <div class="banner-text">
                <strong>Thế giới xe sang & phụ kiện chính hãng</strong>
                <p>Giao hàng miễn phí toàn quốc · Bảo hành ưu đãi thành viên VIP</p>
            </div>
        </div>
        <ul class="benefits-list">
            <li><div class="benefit-icon"><i class="bi bi-gem"></i></div> Tích điểm đổi quà & voucher độc quyền</li>
            <li><div class="benefit-icon"><i class="bi bi-truck"></i></div> Miễn phí vận chuyển cho đơn hàng từ 2 triệu</li>
            <li><div class="benefit-icon"><i class="bi bi-shield-lock"></i></div> Bảo mật thông tin tuyệt đối</li>
            <li><div class="benefit-icon"><i class="bi bi-headset"></i></div> Hỗ trợ 24/7 từ đội ngũ chuyên nghiệp</li>
        </ul>
    </div>

    <!-- ── CỘT PHẢI : FORM (backend không đổi) ── -->
    <div class="split-right">
        <div class="form-header">
            <h1>ĐĂNG KÝ</h1>
            <div class="subtitle">TRỞ THÀNH THÀNH VIÊN LUXCAR</div>
            <div class="sep"></div>
        </div>
        <div class="message">
            <strong>Lưu ý:</strong> Các trường đánh dấu * là bắt buộc
        </div>

        <form method="post" action="/register">

            <div class="row-2">
                <div class="form-group">
                    <label for="fullname">Họ và tên *</label>
                    <input type="text" id="fullname" name="fullname" value="${param.fullname}" placeholder="Nguyễn Văn A">
                    <c:if test="${not empty fullnameError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${fullnameError}</span>
                    </c:if>
                </div>
                <div class="form-group">
                    <label for="username">Tên đăng nhập *</label>
                    <input type="text" id="username" name="username" value="${param.username}" placeholder="username123">
                    <c:if test="${not empty usernameError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${usernameError}</span>
                    </c:if>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" value="${param.email}" placeholder="email@example.com">
                <c:if test="${not empty emailError}">
                    <span class="error-message"><i class="bi bi-x-circle"></i> ${emailError}</span>
                </c:if>
            </div>

            <div class="row-2">
                <div class="form-group">
                    <label for="password">Mật khẩu *</label>
                    <div class="password-wrapper">
                        <input type="password" id="password" name="password" value="${param.password}" placeholder="••••••••">
                        <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('password', this)"></i>
                    </div>
                    <c:if test="${not empty passwordError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${passwordError}</span>
                    </c:if>
                </div>
                <div class="form-group">
                    <label for="confirm-password">Xác nhận mật khẩu *</label>
                    <div class="password-wrapper">
                        <input type="password" id="confirm-password" name="confirm-password" value="${param.confirmPassword}" placeholder="••••••••">
                        <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('confirm-password', this)"></i>
                    </div>
                    <c:if test="${not empty confirmPasswordError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${confirmPasswordError}</span>
                    </c:if>
                </div>
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="tel" id="phone" name="phonenumber"
                       value="${phonenumber != null ? phonenumber : param.phonenumber}"
                       placeholder="0912 345 678"
                       pattern="^(0|\+84)[0-9]{9}$" maxlength="11">
                <c:if test="${not empty phonenumberError}">
                    <span class="error-message"><i class="bi bi-x-circle"></i> ${phonenumberError}</span>
                </c:if>
            </div>

            <button type="submit" class="btn-register">Đăng ký ngay →</button>
        </form>

        <div class="terms">
            Bằng việc đăng ký, bạn đồng ý với
            <a href="#">Điều khoản dịch vụ</a> và
            <a href="#">Chính sách bảo mật</a>
        </div>

        <div class="divider"><span>HOẶC ĐĂNG KÝ BẰNG</span></div>

        <div class="social-login">
            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:8080/login/GoogleLoginServlet&response_type=code&client_id=CODEODAYNE&approval_prompt=force" class="btn-social">
                <i class="bi bi-google"></i> Google
            </a>
            <a href="https://www.facebook.com/v18.0/dialog/oauth?client_id=AAAAAAAAAAAAAAAA&redirect_uri=https://localhost:8080/login/loginFacebook&scope=email" class="btn-social">
                <i class="bi bi-facebook"></i> Facebook
            </a>
        </div>

        <div class="login-link">
            Đã có tài khoản? <a href="/login">Đăng nhập ngay</a>
        </div>
    </div>
</div>


<!-- ═══════════════ FOOTER (giữ nguyên) ═══════════════ -->
<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="footer-brand"><i class="bi bi-gem me-2"></i>LUXCAR</div>
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
            <div class="col-lg-2 col-md-6">
                <h4 class="footer-title">Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home"><i class="bi bi-chevron-right"></i>Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products"><i class="bi bi-chevron-right"></i>Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/favorites"><i class="bi bi-chevron-right"></i>Yêu thích</a></li>
                    <li><a href="${pageContext.request.contextPath}/about"><i class="bi bi-chevron-right"></i>Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact"><i class="bi bi-chevron-right"></i>Liên hệ</a></li>
                </ul>
            </div>
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
            <div class="col-lg-4 col-md-6">
                <h4 class="footer-title">Thông tin liên hệ</h4>
                <ul class="footer-contact">
                    <li><i class="bi bi-geo-alt"></i><span>123 Đường Lê Duẩn, Quận 1, TP. Hồ Chí Minh</span></li>
                    <li><i class="bi bi-telephone"></i><span>Hotline: <a href="tel:19001000">1900 1000</a></span></li>
                    <li><i class="bi bi-envelope"></i><span>Email: <a href="mailto:info@luxcar.vn">info@luxcar.vn</a></span></li>
                    <li><i class="bi bi-clock"></i><span>Thời gian làm việc: 8:00 - 21:00 (T2-CN)</span></li>
                </ul>
            </div>
        </div>
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
                            <input type="email" class="newsletter-input" placeholder="Email của bạn" required>
                            <button type="submit" class="newsletter-btn">Đăng ký <i class="bi bi-send ms-2"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="row footer-bottom">
            <div class="col-md-6">
                <div class="payment-methods">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/visa/visa-original.svg" alt="Visa">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mastercard/mastercard-original.svg" alt="Mastercard">
                    <i class="bi bi-credit-card"></i>
                    <i class="bi bi-bank"></i>
                    <i class="bi bi-cash"></i>
                </div>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="copyright">© 2024 LUXCAR. All rights reserved.<br class="d-md-none"> Design by <span class="text-gold">LUXCAR Team</span></p>
            </div>
        </div>
    </div>
</footer>

<style>
    .footer { background: var(--black); border-top: 3px solid var(--gold); padding: 60px 0 20px; margin-top: 0; }
    .footer-brand { font-size: 28px; font-weight: 700; background: linear-gradient(135deg, var(--white) 0%, var(--gold) 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 20px; display: inline-block; }
    .footer-brand i { background: none; -webkit-text-fill-color: var(--gold); color: var(--gold); }
    .footer-description { color: rgba(255,255,255,.7); line-height: 1.6; margin-bottom: 20px; font-size: 14px; }
    .footer-social { display: flex; gap: 15px; }
    .social-link { width: 38px; height: 38px; border-radius: 50%; background: rgba(212,175,55,.1); border: 1px solid rgba(212,175,55,.3); display: flex; align-items: center; justify-content: center; color: var(--gold); font-size: 18px; transition: all .3s; text-decoration: none; }
    .social-link:hover { background: var(--gold); color: var(--black); transform: translateY(-3px); box-shadow: 0 5px 15px rgba(212,175,55,.3); }
    .footer-title { color: var(--gold); font-size: 18px; font-weight: 600; margin-bottom: 20px; position: relative; padding-bottom: 10px; }
    .footer-title::after { content: ''; position: absolute; bottom: 0; left: 0; width: 40px; height: 2px; background: var(--gold); }
    .footer-links { list-style: none; padding: 0; margin: 0; }
    .footer-links li { margin-bottom: 12px; }
    .footer-links a { color: rgba(255,255,255,.7); text-decoration: none; font-size: 14px; transition: all .3s; display: inline-flex; align-items: center; gap: 8px; }
    .footer-links a i { font-size: 10px; transition: transform .3s; }
    .footer-links a:hover { color: var(--gold); transform: translateX(5px); }
    .footer-links a:hover i { transform: translateX(3px); }
    .footer-contact { list-style: none; padding: 0; margin: 0; }
    .footer-contact li { display: flex; align-items: flex-start; gap: 12px; margin-bottom: 15px; color: rgba(255,255,255,.7); font-size: 14px; }
    .footer-contact li i { color: var(--gold); font-size: 18px; margin-top: 2px; min-width: 20px; }
    .footer-contact li a { color: rgba(255,255,255,.7); text-decoration: none; transition: color .3s; }
    .footer-contact li a:hover { color: var(--gold); }
    .newsletter-wrapper { background: rgba(212,175,55,.05); border-radius: 15px; padding: 30px; border: 1px solid rgba(212,175,55,.2); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px; }
    .newsletter-content { display: flex; align-items: center; gap: 15px; }
    .newsletter-content i { font-size: 40px; color: var(--gold); }
    .newsletter-content h4 { color: var(--white); margin: 0; font-size: 20px; font-weight: 600; }
    .newsletter-content p { color: rgba(255,255,255,.7); margin: 5px 0 0; font-size: 13px; }
    .newsletter-form { flex: 1; min-width: 280px; }
    .newsletter-input { width: 100%; padding: 12px 20px; border: 2px solid rgba(212,175,55,.3); border-radius: 50px; background: rgba(255,255,255,.05); color: var(--white); font-size: 14px; transition: all .3s; }
    .newsletter-input:focus { outline: none; border-color: var(--gold); background: rgba(255,255,255,.1); box-shadow: 0 0 15px rgba(212,175,55,.2); }
    .newsletter-input::placeholder { color: rgba(255,255,255,.5); }
    .newsletter-btn { position: absolute; right: 5px; top: 50%; transform: translateY(-50%); background: var(--gold); color: var(--black); border: none; padding: 8px 25px; border-radius: 50px; font-weight: 600; font-size: 14px; transition: all .3s; cursor: pointer; }
    .newsletter-btn:hover { background: var(--dark-gold); transform: translateY(-50%) scale(1.02); }
    .input-group { position: relative; display: flex; align-items: center; }
    .footer-bottom { margin-top: 50px; padding-top: 20px; border-top: 1px solid rgba(212,175,55,.2); }
    .payment-methods { display: flex; gap: 15px; align-items: center; }
    .payment-methods img { width: 40px; height: 30px; object-fit: contain; }
    .payment-methods i { font-size: 28px; color: rgba(255,255,255,.7); transition: all .3s; }
    .payment-methods img:hover, .payment-methods i:hover { color: var(--gold); transform: translateY(-2px); }
    .copyright { color: rgba(255,255,255,.6); font-size: 13px; margin: 0; }
    .text-gold { color: var(--gold); font-weight: 600; }
    @media (max-width: 991px) { .footer { padding: 40px 0 20px; } .newsletter-wrapper { flex-direction: column; text-align: center; } .newsletter-content { flex-direction: column; text-align: center; } .footer-bottom { text-align: center; } .payment-methods { justify-content: center; margin-bottom: 15px; } }
    @media (max-width: 768px) { .footer-title { margin-top: 20px; } .newsletter-form { width: 100%; } }
    .back-to-top { position: fixed; bottom: 30px; right: 30px; width: 45px; height: 45px; background: var(--gold); color: var(--black); border-radius: 50%; display: flex; align-items: center; justify-content: center; text-decoration: none; font-size: 20px; opacity: 0; visibility: hidden; transition: all .3s; z-index: 999; box-shadow: 0 2px 10px rgba(0,0,0,.2); }
    .back-to-top.show { opacity: 1; visibility: visible; }
    .back-to-top:hover { background: var(--dark-gold); transform: translateY(-3px); color: var(--black); }
</style>

<a href="#" class="back-to-top" id="backToTop"><i class="bi bi-arrow-up"></i></a>

<script>
    function togglePassword(inputId, iconElement) {
        const input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            iconElement.classList.remove("bi-eye-slash");
            iconElement.classList.add("bi-eye");
        } else {
            input.type = "password";
            iconElement.classList.remove("bi-eye");
            iconElement.classList.add("bi-eye-slash");
        }
    }
    const backToTopButton = document.getElementById('backToTop');
    window.addEventListener('scroll', () => {
        backToTopButton.classList.toggle('show', window.pageYOffset > 300);
    });
    backToTopButton.addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
</script>
</body>
</html>
