<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Tạo mật khẩu mới - LUXCAR</title>
  <%@ include file="/common/header-for-login-ex.jsp" %>

  <style>
    body {
      background-color: #000000;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .reset-container {
      background-color: #ffffff;
      width: 100%;
      max-width: 400px;
      margin: 50px auto;
      padding: 40px 35px;
      border-radius: 8px;
      box-shadow: 0 10px 30px rgba(255,255,255,0.1);
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
      margin-bottom: 20px;
    }

    label {
      display: block;
      color: #000000;
      margin-bottom: 8px;
      font-weight: 500;
      text-transform: uppercase;
      font-size: 14px;
    }

    input[type="password"] {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #000000;
      background-color: #ffffff;
      color: #000000;
      font-size: 14px;
      border-radius: 4px;
      outline: none;
    }

    input[type="password"]:focus {
      background-color: #f5f5f5;
    }

    .btn-reset {
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

    .btn-reset:hover {
      background-color: #ffffff;
      color: #000000;
    }

    .info-box {
      background-color: #f5f5f5;
      padding: 15px;
      margin-bottom: 25px;
      border: 2px solid #000000;
      text-align: center;
      border-radius: 4px;
    }

    .info-box p {
      margin: 5px 0;
      color: #333333;
    }

    .icon {
      text-align: center;
      margin-bottom: 15px;
      font-size: 45px;
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

<div class="reset-container">

  <div class="icon">🔑</div>

  <h1>TẠO MẬT KHẨU MỚI</h1>
  <div class="subtitle">ĐẶT LẠI MẬT KHẨU CHO TÀI KHOẢN</div>

  <div class="info-box">
    <p><strong>Tài khoản:</strong> ${user.fullname}</p>
    <p><strong>Email:</strong> ${user.email}</p>
  </div>

  <form method="post" action="${pageContext.request.contextPath}/resetPassword">

    <div class="form-group">
      <label>Mật khẩu mới</label>
      <input type="password" name="newPassword"
             placeholder="Nhập mật khẩu mới" required>
    </div>

    <div class="form-group">
      <label>Xác nhận mật khẩu</label>
      <input type="password" name="confirmPassword"
             placeholder="Nhập lại mật khẩu" required>
    </div>

    <button type="submit" class="btn-reset">
      CẬP NHẬT MẬT KHẨU
    </button>

  </form>

  <a href="/login" class="back-link">Quay lại đăng nhập</a>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>