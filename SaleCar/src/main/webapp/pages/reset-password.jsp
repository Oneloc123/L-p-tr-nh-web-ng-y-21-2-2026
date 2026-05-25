<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Tạo mật khẩu mới - LUXCAR</title>
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

    /* LEFT PANEL */
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
    }
    .feat-icon i { font-size: 17px; color: var(--gold); }
    .feat-text strong { display: block; color: #fff; font-size: 14px; font-weight: 600; }
    .feat-text span { font-size: 12px; color: rgba(255,255,255,.45); }

    /* RIGHT PANEL */
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

    /* Steps indicator - 3 bước, bước 3 active */
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

    .info-box {
      background: #fafcfd;
      border: 1px solid #eef2f6;
      border-radius: 16px;
      padding: 16px;
      margin-bottom: 28px;
      text-align: center;
    }
    .info-box p {
      margin: 6px 0;
      color: #1e293b;
      font-size: 14px;
    }
    .info-box strong {
      color: var(--gold);
    }

    .form-group { margin-bottom: 22px; }
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
      transition: all 0.2s;
    }
    input[type="password"]:focus {
      border-color: var(--gold);
      box-shadow: 0 0 0 3px rgba(212,175,55,0.2);
    }
    .form-text {
      font-size: 11px;
      color: #888;
      margin-top: 4px;
      display: block;
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
    .btn-reset {
      width: 100%; padding: 14px;
      background: var(--black);
      color: #fff; border: none;
      font-size: 15px; font-weight: 700;
      text-transform: uppercase; letter-spacing: 1px;
      border-radius: 12px; cursor: pointer;
      transition: background .2s, transform .1s;
      margin-top: 8px;
    }
    .btn-reset:hover { background: var(--gold); }
    .btn-reset:active { transform: scale(.99); }

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

  <!-- LEFT PANEL (giống forgotPassword) -->
  <div class="split-left">
    <div class="left-brand">
      <a href="${pageContext.request.contextPath}/home">LUX<span class="highlight">CAR</span></a>
    </div>
    <div class="left-title">
      <h1>Đặt lại mật khẩu thành công</h1>
      <div class="badge"><i class="bi bi-shield-check"></i> Bảo mật tài khoản</div>
    </div>
    <ul class="feature-list">
      <li>
        <div class="feat-icon"><i class="bi bi-key-fill"></i></div>
        <div class="feat-text">
          <strong>Mật khẩu mới mạnh</strong>
          <span>Kết hợp chữ hoa, thường, số và ký tự đặc biệt</span>
        </div>
      </li>
      <li>
        <div class="feat-icon"><i class="bi bi-check-circle"></i></div>
        <div class="feat-text">
          <strong>Cập nhật an toàn</strong>
          <span>Mật khẩu đã được mã hóa và lưu trữ bảo mật</span>
        </div>
      </li>
      <li>
        <div class="feat-icon"><i class="bi bi-arrow-repeat"></i></div>
        <div class="feat-text">
          <strong>Đăng nhập lại</strong>
          <span>Sử dụng mật khẩu mới để đăng nhập ngay</span>
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

  <!-- RIGHT PANEL: FORM ĐẶT LẠI MẬT KHẨU -->
  <div class="split-right">
    <div class="form-box">
      <div class="form-header">
        <h1>TẠO MẬT KHẨU MỚI</h1>
        <div class="subtitle">Đặt lại mật khẩu cho tài khoản LuxCar</div>
        <div class="sep"></div>
      </div>

      <!-- Steps indicator - bước 3 active -->
      <div class="steps">
        <div class="step inactive">
          <div class="step-circle">1</div>
          <div class="step-label">Xác thực</div>
        </div>
        <div class="step-line"></div>
        <div class="step inactive">
          <div class="step-circle">2</div>
          <div class="step-label">Mã OTP</div>
        </div>
        <div class="step-line"></div>
        <div class="step active">
          <div class="step-circle">3</div>
          <div class="step-label">Mật khẩu mới</div>
        </div>
      </div>

      <div class="info-box">
        <p><strong>Tài khoản:</strong> ${user.fullname}</p>
        <p><strong>Email:</strong> ${user.email}</p>
      </div>

      <c:if test="${not empty globalError}">
        <div class="alert-gold"><i class="bi bi-exclamation-triangle-fill"></i> ${globalError}</div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/resetPassword">
        <div class="form-group">
          <label for="password">Mật khẩu mới *</label>
          <input type="password" id="password" name="newPassword" value="${param.newPassword}"
                 placeholder="Nhập mật khẩu mới">
          <small class="form-text">Mật khẩu tối thiểu 6 ký tự, nên bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt</small>
          <c:if test="${not empty newPasswordError}">
            <span class="error-message"><i class="bi bi-x-circle"></i> ${newPasswordError}</span>
          </c:if>
        </div>

        <div class="form-group">
          <label for="confirm-password">Xác nhận mật khẩu *</label>
          <input type="password" id="confirm-password" name="confirmPassword" value="${param.confirmPassword}"
                 placeholder="Nhập lại mật khẩu">
          <small class="form-text">Nhập lại chính xác mật khẩu đã nhập ở trên</small>
          <c:if test="${not empty confirmPasswordError}">
            <span class="error-message"><i class="bi bi-x-circle"></i> ${confirmPasswordError}</span>
          </c:if>
        </div>

        <button type="submit" class="btn-reset">CẬP NHẬT MẬT KHẨU →</button>
      </form>

      <div class="back-link">
        <a href="${pageContext.request.contextPath}/login">← Quay lại đăng nhập</a>
      </div>
      <div class="footer-text">© 2024 LUXCAR · Mô hình xe cao cấp</div>
    </div>
  </div>
</div>

<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>