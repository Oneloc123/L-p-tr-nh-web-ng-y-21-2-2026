<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --black: #0a0a0a;
            --gold: #D4AF37;
            --dark-gold: #B8960C;
            --white: #ffffff;
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
            min-height: 580px;
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

        /* Steps indicator */
        .steps {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0;
            margin-bottom: 28px;
        }
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 4px;
        }
        .step-circle {
            width: 30px; height: 30px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 12px; font-weight: 700;
        }
        .step.active .step-circle { background: var(--black); color: #fff; }
        .step.inactive .step-circle {
            background: #f0f0f0; color: #aaa;
            border: 1.5px solid #e0e0e0;
        }
        .step-label { font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: .5px; }
        .step.active .step-label { color: var(--black); }
        .step.inactive .step-label { color: #bbb; }
        .step-line {
            flex: 1;
            height: 2px;
            background: #e8e8e8;
            margin: 0 8px;
            margin-bottom: 18px;
            max-width: 50px;
        }

        /* Info box */
        .info-box {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            padding: 12px 14px;
            background: #f8f8f8;
            border-left: 3px solid var(--gold);
            border-radius: 0 10px 10px 0;
            margin-bottom: 24px;
            font-size: 12px;
            color: #555;
            line-height: 1.5;
        }
        .info-box i { font-size: 15px; color: var(--gold); margin-top: 1px; flex-shrink: 0; }

        /* ── FORM ── */
        .form-group { margin-bottom: 20px; }
        label {
            display: block;
            font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: .6px;
            color: #333; margin-bottom: 6px;
        }
        input[type="text"],
        input[type="email"] {
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

        .error-message {
            display: block; font-size: 11px;
            color: #e67e22; margin-top: 5px; font-weight: 500;
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

        .btn-submit {
            width: 100%; padding: 14px;
            background: var(--black);
            color: #fff; border: none;
            font-size: 15px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 1px;
            border-radius: 12px; cursor: pointer;
            transition: background .2s, transform .1s;
        }
        .btn-submit:hover { background: var(--gold); }
        .btn-submit:active { transform: scale(.99); }

        .back-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
            font-size: 13px;
            color: #666;
        }
        .back-link a {
            color: var(--black); font-weight: 700;
            text-decoration: none;
            border-bottom: 2px solid var(--gold);
            padding-bottom: 1px;
        }
        .back-link a:hover { color: var(--gold); }

        .note {
            text-align: center;
            font-size: 11px;
            color: #bbb;
            margin-top: 14px;
        }
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
            <h1>Khôi phục tài khoản của bạn</h1>
            <div class="badge"><i class="bi bi-envelope-check"></i> Xác nhận qua email</div>
        </div>
        <ul class="feature-list">
            <li>
                <div class="feat-icon"><i class="bi bi-person-check"></i></div>
                <div class="feat-text">
                    <strong>Xác thực danh tính</strong>
                    <span>Nhập tên đăng nhập & email đã đăng ký</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-envelope"></i></div>
                <div class="feat-text">
                    <strong>Nhận mã xác nhận</strong>
                    <span>Mã OTP sẽ được gửi đến email của bạn</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-lock"></i></div>
                <div class="feat-text">
                    <strong>Đặt lại mật khẩu</strong>
                    <span>Tạo mật khẩu mới an toàn cho tài khoản</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-headset"></i></div>
                <div class="feat-text">
                    <strong>Hỗ trợ 24/7</strong>
                    <span>Đội ngũ chuyên nghiệp luôn sẵn sàng hỗ trợ</span>
                </div>
            </li>
        </ul>
    </div>

    <!-- ── CỘT PHẢI : FORM ── -->
    <div class="split-right">
        <div class="form-box">
            <div class="form-header">
                <h1>QUÊN MẬT KHẨU</h1>
                <div class="subtitle">Khôi phục quyền truy cập tài khoản LuxCar</div>
                <div class="sep"></div>
            </div>

            <!-- Steps indicator -->
            <div class="steps">
                <div class="step active">
                    <div class="step-circle">1</div>
                    <div class="step-label">Xác thực</div>
                </div>
                <div class="step-line"></div>
                <div class="step inactive">
                    <div class="step-circle">2</div>
                    <div class="step-label">Mã OTP</div>
                </div>
                <div class="step-line"></div>
                <div class="step inactive">
                    <div class="step-circle">3</div>
                    <div class="step-label">Mật khẩu mới</div>
                </div>
            </div>

            <div class="info-box">
                <i class="bi bi-info-circle"></i>
                <span>Nhập đúng tên đăng nhập và email đã đăng ký để nhận mã xác nhận.</span>
            </div>

            <c:if test="${not empty globalError}">
                <div class="alert-gold"><i class="bi bi-exclamation-triangle-fill"></i> ${globalError}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/forgotPassword">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" value="${param.username}"
                           placeholder="Nhập tên đăng nhập">
                    <c:if test="${not empty usernameError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${usernameError}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${param.email}"
                           placeholder="Nhập email đã đăng ký">
                    <c:if test="${not empty emailError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${emailError}</span>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">Gửi yêu cầu →</button>
            </form>

            <div class="note">Mã xác nhận sẽ được gửi đến email của bạn</div>

            <div class="back-link">
                Nhớ mật khẩu? <a href="${pageContext.request.contextPath}/login">← Quay lại đăng nhập</a>
            </div>
            <div class="footer-text">© 2024 LUXCAR · Mô hình xe cao cấp</div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>