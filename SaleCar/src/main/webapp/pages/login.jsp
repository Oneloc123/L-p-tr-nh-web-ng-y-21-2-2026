<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <!-- Style riêng cho trang đăng nhập -->
    <style>
        .social-login {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .btn-social {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            border-radius: 4px;
            font-weight: 600;
            text-decoration: none;
            color: #ffffff;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .btn-social i {
            margin-right: 8px;
            font-size: 18px;
        }

        /* Google */
        .btn-google {
            background-color: #db4437;
            border-color: #db4437;
        }

        .btn-google:hover {
            background-color: #ffffff;
            color: #db4437;
        }

        /* Facebook */
        .btn-facebook {
            background-color: #1877f2;
            border-color: #1877f2;
        }

        .btn-facebook:hover {
            background-color: #ffffff;
            color: #1877f2;
        }
        body {
            background-color: #000000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            margin-bottom: 0;
        }

        .login-container {
            background-color: #ffffff;
            width: 100%;
            max-width: 450px;
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
            margin-bottom: 25px;
        }

        label {
            display: block;
            color: #000000;
            margin-bottom: 8px;
            font-weight: 500;
            font-size: 15px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #000000;
            background-color: #ffffff;
            color: #000000;
            font-size: 15px;
            border-radius: 4px;
            outline: none;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            background-color: #f5f5f5;
            border-color: #333333;
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #000000;
            color: #ffffff;
            border: 2px solid #000000;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            border-radius: 4px;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-login:hover {
            background-color: #ffffff;
            color: #000000;
        }

        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }

        .forgot-password a {
            color: #666666;
            text-decoration: none;
            font-size: 13px;
            border-bottom: 1px solid #666666;
        }

        .forgot-password a:hover {
            color: #000000;
            border-bottom-color: #000000;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 2px solid #000000;
            color: #333333;
            font-size: 14px;
        }

        .register-link a {
            color: #000000;
            text-decoration: none;
            font-weight: 600;
            border-bottom: 1px solid #000000;
            padding-bottom: 2px;
        }

        .register-link a:hover {
            color: #333333;
            border-bottom-color: #333333;
        }

        .car-icon {
            text-align: center;
            margin-bottom: 15px;
            font-size: 48px;
            color: #000000;
        }

        .footer-text {
            text-align: center;
            color: #666666;
            font-size: 12px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="car-icon">
        <!-- LOGO -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            LUXCAR
        </a>
    </div>
    <div class="subtitle">ĐĂNG NHẬP HỆ THỐNG</div>

    <form method="post" action="/login">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            </div>
        </c:if>
        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username" value="${param.username}"
                   placeholder="Nhập tên đăng nhập">
            <c:if test="${not empty usernameError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${usernameError}
            </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" value="${param.password}"
                   placeholder="Nhập mật khẩu">
            <c:if test="${not empty passwordError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${passwordError}
            </span>
            </c:if>
        </div>

        <div class="forgot-password">
            <a href="forgot-password.jsp">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
        <!-- Divider -->
        <div style="text-align:center; margin:20px 0; color:#666;">
            -------- Hoặc đăng nhập với --------
        </div>

        <!-- Social Login -->
        <div class="social-login">
            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:8080/login/GoogleLoginServlet&response_type=code&client_id=CODEODAYNE&approval_prompt=force" class="btn-social btn-google">
                <i class="bi bi-google"></i> Đăng nhập với Google
            </a>

            <a href="/login-facebook" class="btn-social btn-facebook">
                <i class="bi bi-facebook"></i> Đăng nhập với Facebook
            </a>
        </div>
    </form>

    <div class="register-link">
        Chưa có tài khoản? <a href="/register">ĐĂNG KÝ NGAY</a>
    </div>

    <div class="footer-text">
        © 2024 - LUXCAR | Mô hình xe cao cấp
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/common/footer.jsp" %>

</body>
</html>