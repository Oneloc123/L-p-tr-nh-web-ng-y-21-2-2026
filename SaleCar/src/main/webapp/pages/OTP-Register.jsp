<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Xác nhận OTP - Đăng ký | LUXCAR</title>
  <%@ include file="/common/header-for-login-ex.jsp" %>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    /* Copy toàn bộ CSS từ OTPforChangePassword (giống hệt) */
    :root { --black: #0a0a0a; --gold: #D4AF37; --dark-gold: #B8960C; --white: #ffffff; }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { background: var(--black); min-height: 100vh; display: flex; flex-direction: column; font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif; }
    .split-layout { display: grid; grid-template-columns: 1fr 1fr; flex: 1; max-width: 1280px; width: 92%; margin: 40px auto; border-radius: 20px; overflow: hidden; box-shadow: 0 40px 80px rgba(0,0,0,0.6); min-height: 580px; }
    .split-left { background: var(--black); padding: 52px 48px; display: flex; flex-direction: column; justify-content: center; position: relative; overflow: hidden; }
    .split-left::before { content: ''; position: absolute; top: -140px; right: -100px; width: 420px; height: 420px; border-radius: 50%; background: rgba(212,175,55,0.07); pointer-events: none; }
    .split-left::after { content: ''; position: absolute; bottom: -100px; left: -80px; width: 300px; height: 300px; border-radius: 50%; background: rgba(212,175,55,0.04); pointer-events: none; }
    .left-brand a { font-size: 44px; font-weight: 900; letter-spacing: 6px; font-family: 'Arial Black', Impact, sans-serif; color: #fff; text-decoration: none; display: inline-block; margin-bottom: 44px; transition: opacity .2s; }
    .left-brand a:hover { opacity: .85; }
    .left-brand .highlight { color: var(--gold); }
    .left-title { margin-bottom: 40px; }
    .left-title h1 { font-size: 32px; font-weight: 800; color: #fff; line-height: 1.25; letter-spacing: -.5px; }
    .left-title .badge { display: inline-flex; align-items: center; gap: 7px; margin-top: 16px; padding: 8px 16px; border-radius: 40px; background: rgba(212,175,55,0.12); border: 1px solid rgba(212,175,55,0.35); color: var(--gold); font-size: 13px; font-weight: 500; }
    .feature-list { list-style: none; }
    .feature-list li { display: flex; align-items: center; gap: 14px; padding: 16px 0; border-bottom: 1px solid rgba(255,255,255,.06); }
    .feature-list li:last-child { border-bottom: none; }
    .feat-icon { width: 40px; height: 40px; border-radius: 10px; background: rgba(212,175,55,0.12); border: 1px solid rgba(212,175,55,0.25); display: flex; align-items: center; justify-content: center; }
    .feat-icon i { font-size: 17px; color: var(--gold); }
    .feat-text strong { display: block; color: #fff; font-size: 14px; font-weight: 600; }
    .feat-text span { font-size: 12px; color: rgba(255,255,255,.45); }
    .split-right { background: #fff; display: flex; align-items: center; justify-content: center; }
    .form-box { width: 100%; max-width: 420px; padding: 52px 44px; }
    .form-header { text-align: center; margin-bottom: 32px; }
    .form-header h1 { font-size: 26px; font-weight: 800; color: var(--black); letter-spacing: 1.5px; }
    .form-header .subtitle { font-size: 13px; color: #888; margin-top: 6px; }
    .form-header .sep { width: 40px; height: 3px; background: var(--gold); border-radius: 2px; margin: 12px auto 0; }
    .steps { display: flex; align-items: center; justify-content: center; gap: 0; margin-bottom: 28px; }
    .step { display: flex; flex-direction: column; align-items: center; gap: 4px; }
    .step-circle { width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: 700; }
    .step.active .step-circle { background: var(--black); color: #fff; }
    .step.inactive .step-circle { background: #f0f0f0; color: #aaa; border: 1.5px solid #e0e0e0; }
    .step-label { font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: .5px; }
    .step.active .step-label { color: var(--black); }
    .step.inactive .step-label { color: #bbb; }
    .step-line { flex: 1; height: 2px; background: #e8e8e8; margin: 0 8px; margin-bottom: 18px; max-width: 50px; }
    .info-box { background: #fafcfd; border: 1px solid #eef2f6; border-radius: 16px; padding: 20px; margin-bottom: 28px; text-align: center; }
    .info-box p { margin: 8px 0; color: #1e293b; font-size: 14px; }
    .info-box strong { color: var(--gold); }
    .code-display { font-size: 28px; font-weight: 700; letter-spacing: 6px; color: var(--black); background: #fff8e8; padding: 12px; border-radius: 12px; margin: 15px 0; border: 1px dashed var(--gold); }
    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .6px; color: #333; margin-bottom: 6px; }
    input[type="text"] { width: 100%; padding: 12px 14px; border: 1.5px solid #e0e0e0; background: #fff; color: #111; font-size: 18px; text-align: center; letter-spacing: 4px; border-radius: 10px; outline: none; transition: all 0.2s; }
    input[type="text"]:focus { border-color: var(--gold); box-shadow: 0 0 0 3px rgba(212,175,55,0.2); }
    .error-message { display: block; font-size: 11px; color: #e67e22; margin-top: 5px; font-weight: 500; }
    .alert-gold { margin-bottom: 20px; padding: 10px 14px; background: #fffaf0; border-left: 3px solid var(--gold); border-radius: 0 8px 8px 0; font-size: 13px; color: #b8860b; }
    .btn-verify { width: 100%; padding: 14px; background: var(--black); color: #fff; border: none; font-size: 15px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; border-radius: 12px; cursor: pointer; transition: background .2s, transform .1s; margin-top: 8px; }
    .btn-verify:hover { background: var(--gold); }
    .btn-verify:active { transform: scale(.99); }
    .btn-secondary { display: block; width: 100%; padding: 12px; background: #fff; color: var(--black); border: 1.5px solid #e0e0e0; font-size: 13px; font-weight: 600; text-transform: uppercase; border-radius: 10px; text-align: center; text-decoration: none; transition: all 0.2s; margin-top: 15px; }
    .btn-secondary:hover { border-color: var(--gold); color: var(--gold); background: #fffaf0; }
    .timer { font-size: 12px; color: #888; text-align: center; margin: 16px 0 8px; }
    .back-link { text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid #f0f0f0; font-size: 13px; color: #666; }
    .back-link a { color: var(--black); font-weight: 700; text-decoration: none; border-bottom: 2px solid var(--gold); padding-bottom: 1px; }
    .back-link a:hover { color: var(--gold); }
    .footer-text { text-align: center; font-size: 11px; color: #bbb; margin-top: 20px; }
    @media (max-width: 900px) { .split-layout { grid-template-columns: 1fr; } .split-left { display: none; } .split-right { align-items: flex-start; } .form-box { padding: 40px 28px; } }
  </style>
</head>
<body>
<div class="split-layout">
  <div class="split-left">
    <div class="left-brand"><a href="${pageContext.request.contextPath}/home">LUX<span class="highlight">CAR</span></a></div>
    <div class="left-title"><h1>Xác nhận đăng ký tài khoản</h1><div class="badge"><i class="bi bi-envelope-check"></i> Kích hoạt email</div></div>
    <ul class="feature-list">
      <li><div class="feat-icon"><i class="bi bi-envelope-paper-fill"></i></div><div class="feat-text"><strong>Mã OTP qua Email</strong><span>Chúng tôi đã gửi mã 6 số đến email của bạn</span></div></li>
      <li><div class="feat-icon"><i class="bi bi-clock-history"></i></div><div class="feat-text"><strong>Hiệu lực 5 phút</strong><span>Nhập mã trước khi hết hạn</span></div></li>
      <li><div class="feat-icon"><i class="bi bi-person-badge"></i></div><div class="feat-text"><strong>Hoàn tất đăng ký</strong><span>Xác nhận để kích hoạt tài khoản LuxCar</span></div></li>
    </ul>
  </div>
  <div class="split-right">
    <div class="form-box">
      <div class="form-header"><h1>NHẬP MÃ OTP</h1><div class="subtitle">Xác nhận email để kích hoạt tài khoản</div><div class="sep"></div></div>
      <div class="steps"><div class="step active"><div class="step-circle">1</div><div class="step-label">Xác thực OTP</div></div><div class="step-line"></div><div class="step inactive"><div class="step-circle">2</div><div class="step-label">Hoàn tất</div></div></div>
      <div class="info-box"><p><strong>Tài khoản:</strong> ${user.fullname}</p><p><strong>Email:</strong> ${user.email}</p><div class="code-display">123456</div><p style="font-size: 12px;">(Mã xác nhận mẫu: 123456)</p></div>
      <c:if test="${not empty OTPError}"><div class="alert-gold"><i class="bi bi-exclamation-triangle-fill"></i> ${OTPError}</div></c:if>
      <form method="post" action="${pageContext.request.contextPath}/OTPforRegister">
        <div class="form-group"><label for="code">Mã xác nhận (6 số)</label><input type="text" id="code" name="otp" maxlength="6" placeholder="••••••" autocomplete="off"></div>
        <button type="submit" class="btn-verify">XÁC NHẬN →</button>
      </form>
      <div class="timer"><i class="bi bi-clock"></i> Mã có hiệu lực trong 5 phút</div>
      <a href="${pageContext.request.contextPath}/OTPforRegister" class="btn-secondary">GỬI LẠI MÃ</a>
      <div class="back-link"><a href="${pageContext.request.contextPath}/register">← Quay lại</a></div>
      <div class="footer-text">© 2024 LUXCAR · Mô hình xe cao cấp</div>
    </div>
  </div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>