<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <style>
        /* --- CSS CHO LOGO --- */
        .logo-container {
            text-align: center;
            margin-bottom: 25px;
        }

        .navbar-brand {
            display: inline-block;
            font-size: 40px;
            font-weight: 900;
            color: #000000;
            text-decoration: none;
            letter-spacing: 6px;
            font-family: 'Arial Black', Impact, sans-serif;
            position: relative;
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover {
            color: #000000;
            transform: scale(1.05);
        }

        .navbar-brand .highlight {
            color: #e60000;
        }

        .navbar-brand::after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background-color: #000000;
            bottom: -8px;
            left: 25%;
            border-radius: 2px;
        }
        /* CSS cho đường kẻ "HOẶC" */
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 25px 0 20px 0;
            color: #666666;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #cccccc;
        }
        .divider::before {
            margin-right: 15px;
        }
        .divider::after {
            margin-left: 15px;
        }
        /* CSS cho 2 nút Google và Facebook */
        .social-login {
            display: flex;
            gap: 15px; /
        margin-bottom: 10px;
        }
        .btn-social {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            padding: 12px;
            background-color: #ffffff;
            color: #000000;
            border: 2px solid #000000;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-social i {
            font-size: 18px;
        }
        .btn-social:hover {
            background-color: #000000;
            color: #ffffff;
        }
        /* CSS cho tính năng Ẩn/Hiện mật khẩu */
        .password-wrapper {
            position: relative;
            width: 100%;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666666;
            font-size: 18px;
            transition: color 0.3s;
        }

        .toggle-password:hover {
            color: #000000;
        }

        .password-wrapper input {
            padding-right: 45px !important;
        }

        body {
            background-color: #000000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .register-container {
            background-color: #ffffff;
            width: 100%;
            max-width: 500px;
            margin: 50px auto;
            padding: 40px 35px;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(255, 255, 255, 0.1);
        }

        h1 {
            color: #000000;
            text-align: center;
            margin-bottom: 10px;
            font-size: 28px;
            font-weight: 600;
        }

        .subtitle {
            color: #333333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 14px;
            border-bottom: 2px solid #000000;
            padding-bottom: 15px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: #000000;
            margin-bottom: 5px;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"]{
            width: 100%;
            padding: 12px;
            border: 2px solid #000000;
            background-color: #ffffff;
            color: #000000;
            font-size: 15px;
            border-radius: 4px;
            outline: none;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="tel"]{
            background-color: #f5f5f5;
        }


        .btn-register {
            width: 100%;
            padding: 14px;
            background-color: #000000;
            color: #ffffff;
            border: 2px solid #000000;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s;
        }

        .btn-register:hover {
            background-color: #ffffff;
            color: #000000;
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 2px solid #000000;
        }

        .login-link a {
            color: #000000;
            text-decoration: none;
            font-weight: 600;
            border-bottom: 1px solid #000000;
        }

        .login-link a:hover {
            color: #333333;
            border-bottom-color: #333333;
        }

        .car-icon {
            text-align: center;
            margin-bottom: 15px;
            font-size: 48px;
            color: #000000;
        }

        .terms {
            margin-top: 15px;
            font-size: 12px;
            color: #666666;
            text-align: center;
        }

        .terms a {
            color: #000000;
            text-decoration: none;
            font-weight: 600;
        }

        .message {
            background-color: #f5f5f5;
            padding: 15px;
            margin-bottom: 20px;
            border-left: 5px solid #000000;
            font-size: 14px;
            color: #333333;
            border-radius: 4px;
        }

    </style>
</head>
<body>
<div class="register-container">
    <div class="logo-container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            LUX<span class="highlight">CAR</span>
        </a>
    </div>
    <h1>ĐĂNG KÝ</h1>
    <div class="subtitle">TRỞ THÀNH THÀNH VIÊN LUXCAR</div>

    <div class="message">
        <strong>Lưu ý:</strong> Các trường đánh dấu * là bắt buộc
    </div>

    <form method="post" action="/register">
        <div class="form-group">
            <label for="fullname">Họ và tên *</label>
            <input type="text" id="fullname" name="fullname" value="${param.fullname}"
                   placeholder="Nhập họ và tên">
            <small class="form-text text-muted">
                Nhập họ và tên đầy đủ (không dùng ký tự đặc biệt, tối thiểu 2 từ)
            </small>
            <c:if test="${not empty fullnameError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${fullnameError}
            </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="username">Tên đăng nhập *</label>
            <input type="text" id="username" name="username" value="${param.username}"
                   placeholder="Nhập tên đăng nhập">
            <!-- USERNAME -->
            <small class="form-text text-muted">
                Tên đăng nhập từ 4–20 ký tự, chỉ gồm chữ cái và số, không chứa khoảng trắng
            </small>
            <c:if test="${not empty usernameError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${usernameError}
            </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="email">Email *</label>
            <input type="email" id="email" name="email" value="${param.email}"
                   placeholder="Nhập địa chỉ email">
            <small class="form-text text-muted">
                Nhập email hợp lệ (VD: tenban@gmail.com), dùng để nhận thông báo và khôi phục mật khẩu
            </small>
            <c:if test="${not empty emailError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${emailError}
            </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu *</label>
            <div class="password-wrapper">
                <input type="password" id="password" name="password" value="${param.password}" placeholder="Nhập mật khẩu" required>
                <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('password', this)"></i>
            </div>

            <small class="form-text text-muted">
                Mật khẩu tối thiểu 6 ký tự, nên bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt
            </small>
            <c:if test="${not empty passwordError}">
                <span class="error-message" style="color: red;">
                    <i class="bi bi-x-circle"></i> ${passwordError}
                </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="confirm-password">Mật khẩu *</label>
            <div class="password-wrapper">
                <input type="password" id="confirm-password" name="confirm-password" value="${param.password}" placeholder="Nhập lại mật khẩu" required>
                <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('confirm-password', this)"></i>
            </div>

            <small class="form-text text-muted">
                Nhập lại chính xác mật khẩu đã nhập ở trên
            </small>
            <c:if test="${not empty confirmPasswordError}">
                <span class="error-message" style="color: red;">
                    <i class="bi bi-x-circle"></i> ${confirmPasswordError}
                </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="tel" id="phone" name="phonenumber"
                   value="${phonenumber != null ? phonenumber : param.phonenumber}"
                   placeholder="VD: 0912345678"
                   pattern="^(0|\+84)[0-9]{9}$"
                   maxlength="11">
            <small class="form-text text-muted">
                Số điện thoại gồm 10–11 số, bắt đầu bằng 0 hoặc +84 (VD: 0912345678 hoặc +84912345678)
            </small>
            <c:if test="${not empty phonenumberError}">
                <span class="error-message" style="color: red;">
                    <i class="bi bi-x-circle"></i> ${phonenumberError}
                </span>
            </c:if>
        </div>

        <button type="submit" class="btn-register">ĐĂNG KÝ</button>
    </form>

    <div class="terms">
        Bằng việc đăng ký, bạn đồng ý với
        <a href="#">Điều khoản dịch vụ</a> và
        <a href="#">Chính sách bảo mật</a>
    </div>

    <div class="divider">
        <span>HOẶC ĐĂNG KÝ BẰNG</span>
    </div>

    <div class="social-login">
        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:8080/login/GoogleLoginServlet&response_type=code&client_id=CODEODAYNE&approval_prompt=force" class="btn-social">
            <i class="bi bi-google"></i> Google
        </a>
        <a href="https://www.facebook.com/v18.0/dialog/oauth?client_id=AAAAAAAAAAAAAAAA&redirect_uri=https://localhost:8080/login/loginFacebook&scope=email" class="btn-social">
            <i class="bi bi-facebook"></i> Facebook
        </a>
    </div>
    <div class="login-link">
        Đã có tài khoản? <a href="/login">ĐĂNG NHẬP</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/common/footer.jsp" %>
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
</script>
</body>
</html>