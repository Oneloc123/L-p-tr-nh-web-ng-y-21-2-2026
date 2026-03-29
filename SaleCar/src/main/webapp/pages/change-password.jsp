<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <style>
        body {
            background-color: #000000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .change-password-container {
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

        input[type="password"]:focus {
            background-color: #f5f5f5;
            border-color: #333333;
        }

        .password-requirements {
            margin-top: 10px;
            padding: 10px;
            background-color: #f5f5f5;
            border-left: 4px solid #000000;
            font-size: 13px;
            border-radius: 4px;
        }

        .password-requirements p {
            margin: 5px 0;
            color: #333333;
        }

        .btn-change {
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

        .btn-change:hover {
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

        .user-info {
            background-color: #f5f5f5;
            padding: 15px;
            margin-bottom: 25px;
            border: 2px solid #000000;
            text-align: center;
            border-radius: 4px;
        }

        .car-icon {
            text-align: center;
            margin-bottom: 15px;
            font-size: 48px;
            color: #000000;
        }

        .mode-indicator {
            font-size: 12px;
            color: #666666;
            text-align: center;
            margin-bottom: 15px;
        }

        .message {
            background-color: #f5f5f5;
            padding: 15px;
            margin-bottom: 25px;
            border-left: 5px solid #000000;
            font-size: 14px;
            color: #333333;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="change-password-container">
    <div class="car-icon">🔑</div>
    <h1>ĐỔI MẬT KHẨU</h1>
    <div class="subtitle">THAY ĐỔI MẬT KHẨU ĐĂNG NHẬP</div>

    <div class="mode-indicator">
        Chế độ: <strong>Đã đăng nhập</strong>
    </div>

    <div class="user-info">
        <strong>Tài khoản:</strong> luxcar_user
    </div>

    <div class="message">
        <strong>Lưu ý:</strong> Mật khẩu phải có ít nhất 6 ký tự
    </div>

    <form method="post" action="/changePassword">
        <div class="form-group">
            <label for="current_password">Mật khẩu hiện tại</label>
            <input type="password" id="current_password" name="current_password"
                   placeholder="Nhập mật khẩu hiện tại" value="${param.current_password}">
            <c:if test="${not empty currPasswordError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${currPasswordError}
            </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="new_password">Mật khẩu mới</label>
            <input type="password" id="new_password" name="new_password"
                   placeholder="Nhập mật khẩu mới" value="${param.new_password}">
            <small class="form-text text-muted">
                Mật khẩu tối thiểu 6 ký tự, nên bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt để tăng bảo mật
            </small>
            <c:if test="${not empty newPasswordError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${newPasswordError}
            </span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="confirm_password">Xác nhận mật khẩu mới</label>
            <input type="password" id="confirm_password" name="confirm_password" value="${param.confirm_password}"  placeholder="Nhập lại mật khẩu mới">

            <c:if test="${not empty confirmPasswordError}">
            <span class="error-message" style="color: red;">
                <i class="bi bi-x-circle"></i> ${confirmPasswordError}
            </span>
            </c:if>
        </div>

        <button type="submit" class="btn-change">CẬP NHẬT</button>
    </form>

    <a href="/home" class="btn-secondary">QUAY LẠI TRANG CHỦ</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>