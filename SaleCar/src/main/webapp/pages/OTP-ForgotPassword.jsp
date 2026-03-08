<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận - LUXCAR</title>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <style>
        body {
            background-color: #000000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .verify-container {
            background-color: #ffffff;
            width: 100%;
            max-width: 400px;
            margin: 50px auto;
            padding: 40px 35px;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(255, 255, 255, 0.1);
        }

        h1 {
            color: #000000;
            text-align: center;
            margin-bottom: 10px;
            font-size: 26px;
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
            text-transform: uppercase;
            font-size: 14px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #000000;
            background-color: #ffffff;
            color: #000000;
            font-size: 18px;
            text-align: center;
            letter-spacing: 5px;
            border-radius: 4px;
            outline: none;
        }

        input[type="text"]:focus {
            background-color: #f5f5f5;
        }

        .btn-verify {
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
        }

        .btn-verify:hover {
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

        .info-box {
            background-color: #f5f5f5;
            padding: 20px;
            margin-bottom: 25px;
            border: 2px solid #000000;
            text-align: center;
            border-radius: 4px;
        }

        .info-box p {
            margin: 5px 0;
            color: #333333;
        }

        .code-display {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 5px;
            color: #000000;
            margin: 15px 0;
            padding: 10px;
            background-color: #ffffff;
            border: 2px dashed #000000;
            border-radius: 4px;
        }

        .car-icon {
            text-align: center;
            margin-bottom: 15px;
            font-size: 48px;
            color: #000000;
        }

        .timer {
            font-size: 12px;
            color: #666666;
            text-align: center;
            margin: 15px 0;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #666666;
            text-decoration: none;
            font-size: 13px;
        }

        .back-link:hover {
            color: #000000;
        }
    </style>
</head>
<body>
<div class="verify-container">
    <div class="car-icon">✉️</div>
    <h1>XÁC NHẬN</h1>
    <div class="subtitle">NHẬP MÃ XÁC NHẬN</div>

    <div class="info-box">
        <p><strong>Tài khoản:</strong> luxcar_user</p>
        <p><strong>Email:</strong> user@luxcar.com</p>
        <div class="code-display">123456</div>
        <p style="font-size: 12px;">(Mã xác nhận mẫu: 123456)</p>
    </div>

    <form method="post" action="#">
        <div class="form-group">
            <label for="code">Mã xác nhận (6 số)</label>
            <input type="text" id="code" name="code" maxlength="6"
                   placeholder="------">
        </div>

        <button type="submit" class="btn-verify">XÁC NHẬN</button>
    </form>

    <div class="timer">
        Mã có hiệu lực trong 5 phút
    </div>

    <a href="forgot-password.jsp" class="btn-secondary">GỬI LẠI MÃ</a>
    <a href="login.jsp" class="back-link">Quay lại đăng nhập</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>