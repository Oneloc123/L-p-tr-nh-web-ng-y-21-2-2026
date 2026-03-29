<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <style>
        body {
            background-color: #000000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .forgot-container {
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
        input[type="email"] {
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
        input[type="email"]:focus {
            background-color: #f5f5f5;
            border-color: #333333;
        }

        .btn-submit {
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
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background-color: #ffffff;
            color: #000000;
        }

        .btn-secondary {
            width: 100%;
            padding: 12px;
            background-color: #ffffff;
            color: #000000;
            border: 2px solid #000000;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            margin-top: 15px;
        }

        .btn-secondary:hover {
            background-color: #000000;
            color: #ffffff;
        }

        .info-text {
            background-color: #f5f5f5;
            padding: 15px;
            margin-bottom: 25px;
            border-left: 5px solid #000000;
            font-size: 14px;
            color: #333333;
            border-radius: 4px;
        }

        .car-icon {
            text-align: center;
            margin-bottom: 15px;
            font-size: 48px;
            color: #000000;
        }

        .note {
            font-size: 12px;
            color: #666666;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="forgot-container">
    <div class="car-icon">🔐</div>
    <h1>QUÊN MẬT KHẨU</h1>
    <div class="subtitle">KHÔI PHỤC TÀI KHOẢN</div>

    <div class="info-text">
        <strong>Hướng dẫn:</strong> Nhập email và tên đăng nhập để nhận mã xác nhận.
    </div>

    <form method="post" action="/forgotPassword">
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
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${param.email}"
                   placeholder="Nhập email đã đăng ký">
            <c:if test="${not empty emailError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${emailError}
            </span>
            </c:if>
        </div>

        <button type="submit" class="btn-submit">GỬI YÊU CẦU</button>
    </form>

    <a href="/login" class="btn-secondary">QUAY LẠI ĐĂNG NHẬP</a>

    <div class="note">
        Mã xác nhận sẽ được gửi đến email của bạn
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>