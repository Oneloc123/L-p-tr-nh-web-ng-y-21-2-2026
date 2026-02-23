<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <!-- Style riêng cho trang đăng nhập -->
    <style>
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
    <div class="car-icon">🚗</div>
    <h1>LUXCAR</h1>
    <div class="subtitle">ĐĂNG NHẬP HỆ THỐNG</div>

    <form method="post" action="#">
        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username"
                   placeholder="Nhập tên đăng nhập">
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password"
                   placeholder="Nhập mật khẩu">
        </div>

        <div class="forgot-password">
            <a href="forgot-password.jsp">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
    </form>

    <div class="register-link">
        Chưa có tài khoản? <a href="register.jsp">ĐĂNG KÝ NGAY</a>
    </div>

    <div class="footer-text">
        © 2024 - LUXCAR | Mô hình xe cao cấp
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>