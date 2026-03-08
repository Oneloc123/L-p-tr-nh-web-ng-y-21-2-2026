<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <style>
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
        input[type="email"] {
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
        input[type="email"]:focus {
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
    <div class="car-icon">🚗</div>
    <h1>ĐĂNG KÝ</h1>
    <div class="subtitle">TRỞ THÀNH THÀNH VIÊN LUXCAR</div>

    <div class="message">
        <strong>Lưu ý:</strong> Các trường đánh dấu * là bắt buộc
    </div>

    <form method="post" action="/register">
        <div class="form-group">
            <label for="fullname">Họ và tên *</label>
            <input type="text" id="fullname" name="fullname"
                   placeholder="Nhập họ và tên">
        </div>

        <div class="form-group">
            <label for="username">Tên đăng nhập *</label>
            <input type="text" id="username" name="username"
                   placeholder="Nhập tên đăng nhập">
        </div>

        <div class="form-group">
            <label for="email">Email *</label>
            <input type="email" id="email" name="email"
                   placeholder="Nhập địa chỉ email">
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu *</label>
            <input type="password" id="password" name="password"
                   placeholder="Nhập mật khẩu">
        </div>

        <div class="form-group">
            <label for="confirm-password">Xác nhận mật khẩu *</label>
            <input type="password" id="confirm-password" name="confirm-password"
                   placeholder="Nhập lại mật khẩu">
        </div>

        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phonenumber"
                   placeholder="Nhập số điện thoại">
        </div>

        <button type="submit" class="btn-register">ĐĂNG KÝ</button>
    </form>

    <div class="terms">
        Bằng việc đăng ký, bạn đồng ý với
        <a href="#">Điều khoản dịch vụ</a> và
        <a href="#">Chính sách bảo mật</a>
    </div>

    <div class="login-link">
        Đã có tài khoản? <a href="/login">ĐĂNG NHẬP</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>