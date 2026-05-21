<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --black: #0a0a0a;
            --white: #ffffff;
            --gold: #D4AF37;
            --dark-gold: #B8960C;
            --light-gold: #f5e2b0;
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
            min-height: 620px;
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
            background: rgba(212,175,55,0.07);
            pointer-events: none;
        }
        .split-left::after {
            content: '';
            position: absolute;
            bottom: -100px; left: -80px;
            width: 300px; height: 300px;
            border-radius: 50%;
            background: rgba(212,175,55,0.04);
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
            margin-bottom: 44px;
            transition: opacity .2s;
        }
        .left-brand a:hover { opacity: .85; }
        .left-brand .highlight { color: var(--gold); }

        .left-title { margin-bottom: 40px; }
        .left-title h1 {
            font-size: 32px;
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
            background: rgba(212,175,55,0.12);
            border: 1px solid rgba(212,175,55,0.35);
            color: var(--gold);
            font-size: 13px;
            font-weight: 500;
        }

        .feature-list { list-style: none; }
        .feature-list li {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 16px 0;
            border-bottom: 1px solid rgba(255,255,255,.06);
        }
        .feature-list li:last-child { border-bottom: none; }
        .feat-icon {
            width: 40px; height: 40px;
            border-radius: 10px;
            background: rgba(212,175,55,0.12);
            border: 1px solid rgba(212,175,55,0.25);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .feat-icon i { font-size: 17px; color: var(--gold); }
        .feat-text strong {
            display: block; color: #fff;
            font-size: 14px; font-weight: 600;
        }
        .feat-text span { font-size: 12px; color: rgba(255,255,255,.45); }

        /* ── RIGHT PANEL ── */
        .split-right {
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .form-box {
            width: 100%;
            max-width: 420px;
            padding: 52px 44px;
        }

        .form-header { text-align: center; margin-bottom: 32px; }
        .form-header h1 {
            font-size: 26px; font-weight: 800;
            color: var(--black); letter-spacing: 1.5px;
        }
        .form-header .subtitle {
            font-size: 13px; color: #888; margin-top: 6px;
        }
        .form-header .sep {
            width: 40px; height: 3px;
            background: var(--gold); border-radius: 2px;
            margin: 12px auto 0;
        }

        /* ── FORM ── */
        .form-group { margin-bottom: 20px; }
        label {
            display: block;
            font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: .6px;
            color: #333; margin-bottom: 6px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
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
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(212,175,55,0.2);
        }
        .password-wrapper { position: relative; }
        .password-wrapper input { padding-right: 44px; }
        .toggle-password {
            position: absolute; right: 14px; top: 50%;
            transform: translateY(-50%);
            cursor: pointer; color: #aaa; font-size: 17px;
            transition: color .2s;
        }
        .toggle-password:hover { color: var(--gold); }

        .error-message {
            display: block; font-size: 11px;
            color: var(--gold); margin-top: 5px; font-weight: 500;
        }
        .alert-gold {
            margin-bottom: 20px;
            padding: 10px 14px;
            background: #fffaf0;
            border-left: 3px solid var(--gold);
            border-radius: 0 8px 8px 0;
            font-size: 13px;
            color: #b8860b;
        }
        .alert-gold i {
            margin-right: 6px;
            color: var(--gold);
        }

        .forgot-password {
            text-align: right;
            margin-top: -8px;
            margin-bottom: 16px;
        }
        .forgot-password a {
            font-size: 12px; color: #888;
            text-decoration: none;
            border-bottom: 1px solid #ddd;
            padding-bottom: 1px;
            transition: color .2s, border-color .2s;
        }
        .forgot-password a:hover {
            color: var(--gold); border-color: var(--gold);
        }

        .btn-login {
            width: 100%; padding: 14px;
            background: var(--black);
            color: #fff; border: none;
            font-size: 15px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 1px;
            border-radius: 12px; cursor: pointer;
            transition: background .2s, transform .1s;
        }
        .btn-login:hover { background: var(--gold); }
        .btn-login:active { transform: scale(.99); }

        .divider {
            display: flex; align-items: center;
            gap: 12px; margin: 22px 0 16px;
            color: #bbb; font-size: 11px;
            font-weight: 600; letter-spacing: 1px;
        }
        .divider::before, .divider::after {
            content: ''; flex: 1; height: 1px; background: #eee;
        }

        .social-login { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 24px; }
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
        .btn-social:hover { background: var(--black); color: #fff; border-color: var(--gold); }

        .register-link {
            text-align: center; font-size: 13px;
            color: #666; padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }
        .register-link a {
            color: var(--black); font-weight: 700;
            text-decoration: none;
            border-bottom: 2px solid var(--gold);
            padding-bottom: 1px;
        }
        .register-link a:hover { color: var(--gold); }

        .footer-text {
            text-align: center; font-size: 11px;
            color: #bbb; margin-top: 20px;
        }

        @media (max-width: 900px) {
            .split-layout { grid-template-columns: 1fr; }
            .split-left { display: none; }
            .split-right { align-items: flex-start; }
            .form-box { padding: 40px 28px; }
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
            <h1>Chào mừng trở lại với LuxCar</h1>
            <div class="badge"><i class="bi bi-shield-check"></i> Đăng nhập an toàn & bảo mật</div>
        </div>
        <ul class="feature-list">
            <li>
                <div class="feat-icon"><i class="bi bi-person-check"></i></div>
                <div class="feat-text">
                    <strong>Tài khoản cá nhân</strong>
                    <span>Quản lý đơn hàng & lịch sử mua sắm</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-gem"></i></div>
                <div class="feat-text">
                    <strong>Ưu đãi thành viên VIP</strong>
                    <span>Voucher & tích điểm độc quyền</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-truck"></i></div>
                <div class="feat-text">
                    <strong>Theo dõi đơn hàng</strong>
                    <span>Cập nhật trạng thái giao hàng realtime</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-headset"></i></div>
                <div class="feat-text">
                    <strong>Hỗ trợ 24/7</strong>
                    <span>Đội ngũ chuyên nghiệp luôn sẵn sàng</span>
                </div>
            </li>
        </ul>
    </div>

    <!-- ── CỘT PHẢI : FORM (backend không đổi) ── -->
    <div class="split-right">
        <div class="form-box">
            <div class="form-header">
                <h1>ĐĂNG NHẬP</h1>
                <div class="subtitle">Đăng nhập vào tài khoản LuxCar của bạn</div>
                <div class="sep"></div>
            </div>

            <form method="post" action="/login">
                <c:if test="${not empty errorMessage}">
                    <div class="alert-gold">
                        <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
                    </div>
                </c:if>

                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" value="${param.username}"
                           placeholder="Nhập tên đăng nhập">
                    <c:if test="${not empty usernameError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${usernameError}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="password-wrapper">
                        <input type="password" id="password" name="password" value="${param.password}"
                               placeholder="••••••••">
                        <i class="bi bi-eye-slash toggle-password" onclick="togglePassword(this)"></i>
                    </div>
                    <c:if test="${not empty passwordError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${passwordError}</span>
                    </c:if>
                </div>

                <div class="forgot-password">
                    <a href="forgot-password.jsp">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-login">Đăng nhập →</button>

                <div class="divider"><span>HOẶC ĐĂNG NHẬP BẰNG</span></div>

                <div class="social-login">
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:8080/login/GoogleLoginServlet&response_type=code&client_id=CODEODAYNE&approval_prompt=force"
                       class="btn-social">
                        <i class="bi bi-google"></i> Google
                    </a>
                    <a href="https://www.facebook.com/v18.0/dialog/oauth?client_id=AAAAAAAAAAAAAAAAA&redirect_uri=https://localhost:8080/login/loginFacebook&scope=email"
                       class="btn-social">
                        <i class="bi bi-facebook"></i> Facebook
                    </a>
                </div>
            </form>

            <div class="register-link">
                Chưa có tài khoản? <a href="/register">Đăng ký ngay</a>
            </div>
            <div class="footer-text">© 2024 LUXCAR · Mô hình xe cao cấp</div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/common/footer.jsp" %>

<script>
    function togglePassword(iconElement) {
        const input = document.getElementById('password');
        if (input.type === 'password') {
            input.type = 'text';
            iconElement.classList.remove('bi-eye-slash');
            iconElement.classList.add('bi-eye');
        } else {
            input.type = 'password';
            iconElement.classList.remove('bi-eye');
            iconElement.classList.add('bi-eye-slash');
        }
    }
</script>
</body>
</html>