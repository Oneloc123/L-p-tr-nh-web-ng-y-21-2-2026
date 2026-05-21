<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --black: #0a0a0a;
            --gold: #D4AF37;
            --dark-gold: #B8960C;
            --light-gold: #f5e2b0;
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
            min-height: 620px;
        }

        /* ── LEFT PANEL (màu đen + vàng) ── */
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

        /* ── RIGHT PANEL (trắng + vàng) ── */
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
        small.form-text {
            display: block;
            font-size: 11px;
            color: #999;
            margin-top: 5px;
            line-height: 1.4;
        }

        /* User info card */
        .user-info-card {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 14px;
            background: #f8f8f8;
            border: 1.5px solid #e8e8e8;
            border-radius: 10px;
            margin-bottom: 24px;
        }
        .user-avatar {
            width: 36px; height: 36px;
            border-radius: 50%;
            background: var(--black);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .user-avatar i { color: var(--gold); font-size: 16px; }
        .user-info-text strong {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: var(--black);
        }
        .user-info-text span {
            font-size: 11px;
            color: #888;
        }

        /* Password strength hint */
        .password-hint {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            padding: 10px 12px;
            background: #f8f8f8;
            border-left: 3px solid var(--gold);
            border-radius: 0 8px 8px 0;
            margin-bottom: 22px;
            font-size: 12px;
            color: #555;
            line-height: 1.5;
        }
        .password-hint i { font-size: 14px; color: var(--gold); margin-top: 1px; flex-shrink: 0; }

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

    <!-- ── CỘT TRÁI (vàng) ── -->
    <div class="split-left">
        <div class="left-brand">
            <a href="${pageContext.request.contextPath}/home">LUX<span class="highlight">CAR</span></a>
        </div>
        <div class="left-title">
            <h1>Bảo mật tài khoản của bạn</h1>
            <div class="badge"><i class="bi bi-shield-lock"></i> Cập nhật mật khẩu định kỳ</div>
        </div>
        <ul class="feature-list">
            <li>
                <div class="feat-icon"><i class="bi bi-lock"></i></div>
                <div class="feat-text">
                    <strong>Mật khẩu mạnh</strong>
                    <span>Kết hợp chữ hoa, chữ thường, số & ký tự đặc biệt</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-shield-check"></i></div>
                <div class="feat-text">
                    <strong>Bảo vệ tài khoản</strong>
                    <span>Thay đổi mật khẩu thường xuyên để tăng bảo mật</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-eye-slash"></i></div>
                <div class="feat-text">
                    <strong>Không chia sẻ</strong>
                    <span>Tuyệt đối không chia sẻ mật khẩu với người khác</span>
                </div>
            </li>
            <li>
                <div class="feat-icon"><i class="bi bi-headset"></i></div>
                <div class="feat-text">
                    <strong>Hỗ trợ 24/7</strong>
                    <span>Liên hệ ngay nếu bạn nghi ngờ tài khoản bị xâm phạm</span>
                </div>
            </li>
        </ul>
    </div>

    <!-- ── CỘT PHẢI : FORM ── -->
    <div class="split-right">
        <div class="form-box">
            <div class="form-header">
                <h1>ĐỔI MẬT KHẨU</h1>
                <div class="subtitle">Thay đổi mật khẩu đăng nhập của bạn</div>
                <div class="sep"></div>
            </div>

            <%-- User info display --%>
            <div class="user-info-card">
                <div class="user-avatar"><i class="bi bi-person"></i></div>
                <div class="user-info-text">
                    <strong>luxcar_user</strong>
                    <span>Chế độ: Đã đăng nhập</span>
                </div>
            </div>

            <div class="password-hint">
                <i class="bi bi-info-circle"></i>
                <span>Mật khẩu tối thiểu 6 ký tự, nên bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.</span>
            </div>

            <form method="post" action="/changePassword">
                <div class="form-group">
                    <label for="current_password">Mật khẩu hiện tại</label>
                    <div class="password-wrapper">
                        <input type="password" id="current_password" name="current_password"
                               placeholder="Nhập mật khẩu hiện tại" value="${param.current_password}">
                        <i class="bi bi-eye-slash toggle-password" onclick="togglePw('current_password', this)"></i>
                    </div>
                    <c:if test="${not empty currPasswordError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${currPasswordError}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="new_password">Mật khẩu mới</label>
                    <div class="password-wrapper">
                        <input type="password" id="new_password" name="new_password"
                               placeholder="Nhập mật khẩu mới" value="${param.new_password}">
                        <i class="bi bi-eye-slash toggle-password" onclick="togglePw('new_password', this)"></i>
                    </div>
                    <small class="form-text">
                        Tối thiểu 6 ký tự, nên bao gồm chữ hoa, số và ký tự đặc biệt
                    </small>
                    <c:if test="${not empty newPasswordError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${newPasswordError}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="confirm_password">Xác nhận mật khẩu mới</label>
                    <div class="password-wrapper">
                        <input type="password" id="confirm_password" name="confirm_password"
                               value="${param.confirm_password}" placeholder="Nhập lại mật khẩu mới">
                        <i class="bi bi-eye-slash toggle-password" onclick="togglePw('confirm_password', this)"></i>
                    </div>
                    <c:if test="${not empty confirmPasswordError}">
                        <span class="error-message"><i class="bi bi-x-circle"></i> ${confirmPasswordError}</span>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">Cập nhật mật khẩu →</button>
            </form>

            <div class="back-link">
                <a href="/home">← Quay lại trang chủ</a>
            </div>
            <div class="footer-text">© 2024 LUXCAR · Mô hình xe cao cấp</div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function togglePw(inputId, iconEl) {
        const input = document.getElementById(inputId);
        if (input.type === 'password') {
            input.type = 'text';
            iconEl.classList.remove('bi-eye-slash');
            iconEl.classList.add('bi-eye');
        } else {
            input.type = 'password';
            iconEl.classList.remove('bi-eye');
            iconEl.classList.add('bi-eye-slash');
        }
    }
</script>
</body>
</html>