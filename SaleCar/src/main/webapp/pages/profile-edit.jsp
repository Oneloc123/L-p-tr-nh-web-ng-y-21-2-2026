<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa thông tin - LUXCAR</title>

    <%@ include file="/common/header.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6fa;
        }

        /* ── Layout chính ── */
        .profile-wrapper {
            display: flex;
            align-items: flex-start;
            min-height: 100vh;
        }

        /* ── Sidebar (giữ nguyên gốc) ── */
        .sidebar-menu {
            width: 280px;
            background-color: #000;
            color: #fff;
            padding: 30px 0;
            position: sticky;
            top: 0;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .menu-items {
            padding: 20px 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 25px;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s;
            margin: 5px 10px;
            border-radius: 8px;
        }

        .menu-item i {
            width: 25px;
            margin-right: 12px;
            font-size: 18px;
        }

        .menu-item span {
            font-size: 15px;
            font-weight: 500;
        }

        .menu-item:hover {
            background-color: #333;
            color: #fff;
        }

        .menu-item.active {
            background-color: #fff;
            color: #000;
        }

        .menu-item.active i {
            color: #000;
        }

        .menu-divider {
            height: 1px;
            background-color: #333;
            margin: 15px 20px;
        }

        /* ───────────────────────────────────────────── */
        /* KHU VỰC NỘI DUNG CHÍNH (ĐÃ NÂNG CẤP)           */
        /* ───────────────────────────────────────────── */
        .main-content {
            flex: 1;
            padding: 32px 40px;
            background: #f4f6fa;
        }

        /* Breadcrumb & tiêu đề */
        .content-header {
            margin-bottom: 28px;
        }

        .content-header h1 {
            font-size: 28px;
            font-weight: 700;
            color: #0a0a0a;
            margin-bottom: 8px;
            letter-spacing: -0.3px;
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
            list-style: none;
            display: flex;
            flex-wrap: wrap;
            font-size: 13px;
        }

        .breadcrumb-item + .breadcrumb-item::before {
            content: "›";
            margin: 0 8px;
            color: #aaa;
            font-size: 16px;
        }

        .breadcrumb-item a {
            color: #5a6874;
            text-decoration: none;
            transition: color 0.2s;
        }

        .breadcrumb-item a:hover {
            color: #000;
        }

        .breadcrumb-item.active {
            color: #000;
            font-weight: 600;
        }

        /* Card chính */
        .form-card {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: all 0.2s;
        }

        /* Phần avatar */
        .avatar-upload-section {
            background: linear-gradient(135deg, #fafbfc 0%, #ffffff 100%);
            border-bottom: 1px solid #edf2f7;
            padding: 32px 40px;
            display: flex;
            align-items: center;
            gap: 32px;
            flex-wrap: wrap;
        }

        .current-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #eef2f6;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            flex-shrink: 0;
        }

        .current-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-controls {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .btn-upload {
            background: #000;
            color: #fff;
            border: none;
            padding: 10px 24px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.25s;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .btn-upload i {
            font-size: 14px;
        }

        .btn-upload:hover {
            background: #2c2c2c;
            transform: translateY(-1px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.1);
        }

        .upload-hint {
            font-size: 12px;
            color: #6c7a8a;
        }

        /* Form section */
        .form-section {
            padding: 32px 40px;
            border-bottom: 1px solid #edf2f7;
        }

        .form-section:last-of-type {
            border-bottom: none;
        }

        .form-section-title {
            font-size: 20px;
            font-weight: 700;
            color: #111;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 28px;
        }

        .form-section-title i {
            color: #000;
            font-size: 20px;
        }

        .form-label {
            font-weight: 600;
            color: #1e2a3e;
            margin-bottom: 8px;
            font-size: 13px;
            letter-spacing: 0.3px;
        }

        .form-control, .form-select {
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 10px 14px;
            font-size: 14px;
            transition: all 0.2s;
            background-color: #fff;
        }

        .form-control:focus, .form-select:focus {
            border-color: #000;
            box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.05);
            outline: none;
        }

        .form-control.is-invalid {
            border-color: #e53e3e;
            background-image: none;
        }

        .invalid-feedback {
            font-size: 12px;
            color: #e53e3e;
            margin-top: 6px;
        }

        textarea.form-control {
            min-height: 90px;
            resize: vertical;
        }

        .form-text {
            font-size: 11px;
            color: #6c7a8a;
            margin-top: 6px;
        }

        /* Trạng thái radio */
        .status-options {
            display: flex;
            gap: 28px;
            align-items: center;
            margin-top: 8px;
        }

        .status-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            color: #2d3a48;
        }

        .status-option input {
            width: 16px;
            height: 16px;
            accent-color: #000;
            margin: 0;
        }

        /* Địa chỉ card */
        .address-grid {
            display: flex;
            flex-direction: column;
            gap: 24px;
            margin-bottom: 24px;
        }

        .address-box {
            background: #fff;
            border: 1px solid #e9edf2;
            border-radius: 20px;
            padding: 24px;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.02);
        }

        .address-box:hover {
            border-color: #cbd5e0;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.04);
        }

        .address-box.main-address {
            border-left: 4px solid #000;
            background: #fefefe;
        }

        .address-box-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }

        .address-box-header h4 {
            font-size: 16px;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #0a0a0a;
        }

        .badge-main {
            background: #000;
            color: #fff;
            font-size: 10px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 30px;
            letter-spacing: 0.3px;
        }

        .address-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-set-main {
            background: #f1f5f9;
            border: none;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            color: #1e293b;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-set-main:hover {
            background: #e2e8f0;
            color: #000;
        }

        .btn-remove-address {
            background: transparent;
            border: none;
            color: #a0aec0;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s;
            width: 32px;
            height: 32px;
            border-radius: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-remove-address:hover {
            background: #fff0f0;
            color: #e53e3e;
        }

        .btn-add-address {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            background: #fff;
            border: 1.5px dashed #cbd5e0;
            border-radius: 14px;
            padding: 12px 20px;
            font-weight: 600;
            font-size: 14px;
            color: #1e293b;
            width: 100%;
            transition: all 0.2s;
            cursor: pointer;
        }

        .btn-add-address:hover {
            border-color: #000;
            background: #fafcff;
            color: #000;
        }

        /* Form actions */
        .form-actions {
            padding: 24px 40px;
            background: #fff;
            border-top: 1px solid #edf2f7;
            display: flex;
            justify-content: flex-end;
            gap: 16px;
        }

        .btn-save {
            background: #000;
            color: #fff;
            border: none;
            padding: 12px 32px;
            border-radius: 40px;
            font-weight: 700;
            font-size: 14px;
            transition: all 0.25s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-save:hover {
            background: #2c2c2c;
            transform: translateY(-1px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.08);
        }

        .btn-cancel {
            background: #fff;
            color: #4a5568;
            border: 1.5px solid #e2e8f0;
            padding: 12px 28px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-cancel:hover {
            background: #f8fafc;
            border-color: #cbd5e0;
            color: #000;
        }

        /* Modal styles (làm đẹp modal có sẵn) */
        .modal-content {
            border-radius: 24px;
            border: none;
            box-shadow: 0 30px 40px rgba(0, 0, 0, 0.15);
        }

        .modal-header {
            padding: 20px 24px;
            border-bottom: 1px solid #edf2f7;
        }

        .modal-footer {
            padding: 16px 24px;
            border-top: 1px solid #edf2f7;
        }

        .modal-title {
            font-weight: 700;
            font-size: 18px;
        }

        /* Avatar modal riêng (giữ nguyên cấu trúc, chỉ bổ sung style) */
        .avatar-modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.25s ease;
        }

        .avatar-modal-overlay.open {
            opacity: 1;
        }

        .avatar-modal {
            background: #fff;
            border-radius: 32px;
            width: 500px;
            max-width: calc(100vw - 32px);
            overflow: hidden;
            transform: translateY(20px);
            transition: transform 0.25s ease;
        }

        .avatar-modal-overlay.open .avatar-modal {
            transform: translateY(0);
        }

        .avatar-modal-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 24px;
            border-bottom: 1px solid #edf2f7;
        }

        .avatar-modal-close {
            background: none;
            border: none;
            font-size: 26px;
            cursor: pointer;
            color: #718096;
        }

        .avatar-modal-body {
            padding: 24px;
        }

        .avatar-modal-foot {
            padding: 16px 24px;
            border-top: 1px solid #edf2f7;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }

        .am-preview-wrap {
            text-align: center;
            margin-bottom: 20px;
        }

        .am-preview-ring {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            border: 3px solid #000;
            overflow: hidden;
            margin: 0 auto;
            background: #f1f5f9;
        }

        .am-preview-ring img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .am-dropzone {
            border: 2px dashed #cbd5e0;
            border-radius: 20px;
            padding: 24px;
            text-align: center;
            cursor: pointer;
            background: #fafcff;
            transition: 0.2s;
            position: relative;
        }

        .am-dropzone:hover {
            border-color: #000;
            background: #f8fafc;
        }

        .am-dz-icon {
            font-size: 36px;
            color: #718096;
            margin-bottom: 8px;
        }

        .am-dz-title {
            font-weight: 600;
            font-size: 14px;
        }

        .am-dz-hint {
            font-size: 12px;
            color: #718096;
        }

        .am-dropzone input {
            position: absolute;
            inset: 0;
            opacity: 0;
            cursor: pointer;
        }

        .am-file-row {
            display: none;
            align-items: center;
            gap: 12px;
            background: #f1f5f9;
            border-radius: 14px;
            padding: 10px 16px;
            margin-top: 16px;
        }

        .am-file-row.show {
            display: flex;
        }

        .am-btn-cancel, .am-btn-save {
            padding: 10px 24px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 13px;
            border: none;
        }

        .am-btn-cancel {
            background: #fff;
            border: 1px solid #e2e8f0;
        }

        .am-btn-save {
            background: #000;
            color: #fff;
        }

        .am-btn-save:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar-menu {
                display: none;
            }
            .main-content {
                padding: 20px;
            }
            .form-section, .avatar-upload-section, .form-actions {
                padding: 20px;
            }
            .address-box-header {
                flex-direction: column;
                align-items: flex-start;
            }
            .address-actions {
                width: 100%;
                justify-content: flex-start;
            }
            .form-actions {
                flex-direction: column;
            }
            .btn-save, .btn-cancel {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <!-- Sidebar (giữ nguyên) -->
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item"><i class="fas fa-chart-pie"></i><span>Bảng điều khiển</span></a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item"><i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span></a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item active"><i class="fas fa-user-edit"></i><span>Chỉnh sửa thông tin</span></a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item"><i class="fas fa-lock"></i><span>Đổi mật khẩu</span></a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item"><i class="fas fa-shopping-bag"></i><span>Đơn hàng của tôi</span></a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item"><i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span></a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item"><i class="fas fa-heart"></i><span>Sản phẩm yêu thích</span></a>
            <a href="${pageContext.request.contextPath}/notifications" class="menu-item"><i class="fas fa-bell"></i><span>Thông báo</span></a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item"><i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span></a>
        </div>
    </div>

    <!-- Nội dung chính đã nâng cấp -->
    <div class="main-content">
        <div class="content-header">
            <h1>Chỉnh sửa thông tin</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Tài khoản</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a></li>
                    <li class="breadcrumb-item active">Chỉnh sửa</li>
                </ol>
            </nav>
        </div>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/profileEdit" method="post">

                <!-- Khu vực Avatar -->
                <div class="avatar-upload-section">
                    <div class="current-avatar">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.imgURL}">
                                <img src="${sessionScope.user.imgURL != null ? sessionScope.user.imgURL : pageContext.request.contextPath.concat('/assets/img/default-product.png')}" alt="Avatar" />
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png" alt="Avatar" id="profileAvatarImg">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="avatar-controls">
                        <button type="button" class="btn-upload" onclick="openAvatarModal()">
                            <i class="fas fa-camera"></i> Thay đổi ảnh đại diện
                        </button>
                        <div class="upload-hint">Hỗ trợ JPG, PNG, jpeg, webp. Dung lượng tối đa 2MB.</div>
                    </div>
                </div>

                <!-- Thông tin cơ bản -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="fas fa-user-circle"></i>
                        Thông tin cơ bản
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">ID người dùng</label>
                            <input type="text" class="form-control" value="${user.getId()}" readonly disabled>
                            <div class="form-text">ID cố định, không thể thay đổi</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" value="${user.getUsername()}" readonly disabled>
                            <div class="form-text">Tên đăng nhập không thể thay đổi</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control ${not empty fullnameError ? 'is-invalid' : ''}"
                                   name="fullname" value="${fn:escapeXml(param.fullname != null ? param.fullname : user.fullname)}" required>
                            <c:if test="${not empty fullnameError}"><div class="invalid-feedback">${fullnameError}</div></c:if>
                            <div class="form-text">Ví dụ: Nguyễn Văn A (không dùng ký tự đặc biệt)</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control ${not empty emailError ? 'is-invalid' : ''}"
                                   name="email" value="${fn:escapeXml(param.email != null ? param.email : user.email)}" required>
                            <c:if test="${not empty emailError}"><div class="invalid-feedback">${emailError}</div></c:if>
                            <div class="form-text">Địa chỉ email hợp lệ, dùng để nhận thông báo</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control ${not empty phonenumberError ? 'is-invalid' : ''}"
                                   name="phoneNumber" value="${fn:escapeXml(param.phoneNumber != null ? param.phoneNumber : user.phonenumber)}">
                            <c:if test="${not empty phonenumberError}"><div class="invalid-feedback">${phonenumberError}</div></c:if>
                            <div class="form-text">Số điện thoại liên lạc (không bắt buộc)</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Vai trò</label>
                            <select class="form-select" name="role" disabled>
                                <option value="ROLE_USER" ${(param.role != null ? param.role : user.role) == 'ROLE_USER' ? 'selected' : ''}>Khách hàng (ROLE_USER)</option>
                                <option value="ROLE_ADMIN" ${(param.role != null ? param.role : user.role) == 'ROLE_ADMIN' ? 'selected' : ''}>Quản trị viên (ROLE_ADMIN)</option>
                            </select>
                            <div class="form-text">Chỉ Admin mới có thể thay đổi vai trò</div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Mô tả bản thân / Ghi chú</label>
                            <textarea class="form-control" name="description" placeholder="Thông tin thêm về bạn...">${fn:escapeXml(param.description != null ? param.description : user.description)}</textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Trạng thái tài khoản</label>
                            <div class="status-options">
                                <label class="status-option">
                                    <input type="radio" name="status" value="true"
                                    ${ (param.status != null ? param.status : user.status) == true || (param.status == 'true') ? 'checked' : '' }>
                                    <span>Hoạt động</span>
                                </label>

                                <label class="status-option">
                                    <input type="radio" name="status" value="false"
                                    ${ (param.status != null ? param.status : user.status) == false || (param.status == 'false') ? 'checked' : '' }>
                                    <span>Tạm khóa</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sổ địa chỉ -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="fas fa-map-marked-alt"></i>
                        Sổ địa chỉ nhận hàng
                    </div>

                    <div class="address-grid">
                        <c:choose>
                            <c:when test="${not empty listAddress}">
                                <%-- Địa chỉ chính --%>
                                <c:forEach var="a" items="${listAddress}">
                                    <c:if test="${a.type == 'main'}">
                                        <div class="address-box main-address">
                                            <div class="address-box-header">
                                                <h4><i class="fas fa-home"></i> ${fn:escapeXml(a.nameAddress)} <span class="badge-main"><i class="fas fa-check-circle"></i> Mặc định</span></h4>
                                                <div class="address-actions">
                                                    <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal${a.id}" title="Xóa địa chỉ">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="row g-3">
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Số nhà, tên đường</label>
                                                    <input type="text" class="form-control" name="street${a.id}" value="${fn:escapeXml(a.addressLine)}">
                                                </div>
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Xã / Phường</label>
                                                    <input type="text" class="form-control" name="commune${a.id}" value="${fn:escapeXml(a.wardName)}">
                                                </div>
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Quận / Huyện</label>
                                                    <input type="text" class="form-control" name="district${a.id}" value="${fn:escapeXml(a.districName)}">
                                                </div>
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Tỉnh / Thành phố</label>
                                                    <input type="text" class="form-control" name="province${a.id}" value="${fn:escapeXml(a.provinceName)}">
                                                </div>
                                            </div>
                                            <input type="hidden" name="addressId" value="${a.id}">
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <%-- Địa chỉ phụ --%>
                                <c:forEach var="a" items="${listAddress}">
                                    <c:if test="${a.type != 'main'}">
                                        <div class="address-box">
                                            <div class="address-box-header">
                                                <h4><i class="fas fa-location-dot"></i> ${fn:escapeXml(a.nameAddress)}</h4>
                                                <div class="address-actions">
                                                    <a href="${pageContext.request.contextPath}/setMainAddress?id=${a.id}" class="btn-set-main"><i class="fas fa-star"></i> Đặt mặc định</a>
                                                    <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal${a.id}" title="Xóa địa chỉ">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="row g-3">
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Số nhà, tên đường</label>
                                                    <input type="text" class="form-control" name="street${a.id}" value="${fn:escapeXml(a.addressLine)}">
                                                </div>
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Xã / Phường</label>
                                                    <input type="text" class="form-control" name="commune${a.id}" value="${fn:escapeXml(a.wardName)}">
                                                </div>
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Quận / Huyện</label>
                                                    <input type="text" class="form-control" name="district${a.id}" value="${fn:escapeXml(a.districName)}">
                                                </div>
                                                <div class="col-md-6 col-lg-3">
                                                    <label class="form-label text-muted small">Tỉnh / Thành phố</label>
                                                    <input type="text" class="form-control" name="province${a.id}" value="${fn:escapeXml(a.provinceName)}">
                                                </div>
                                            </div>
                                            <input type="hidden" name="addressId" value="${a.id}">
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <!-- Modal xác nhận xóa cho từng địa chỉ (giữ nguyên) -->
                                <c:forEach var="a" items="${listAddress}">
                                    <div class="modal fade" id="confirmDeleteModal${a.id}" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Xác nhận xóa địa chỉ</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Bạn có chắc chắn muốn xóa địa chỉ <strong>${fn:escapeXml(a.nameAddress)}</strong>? Hành động này không thể hoàn tác.
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Hủy bỏ</button>
                                                    <a href="${pageContext.request.contextPath}/removeAddress?id=${a.id}" class="btn btn-dark">Xóa địa chỉ</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5 bg-light rounded-3">
                                    <i class="fas fa-map-marker-alt fa-3x text-muted mb-3"></i>
                                    <p class="mb-0 text-secondary">Bạn chưa có địa chỉ nào. Hãy thêm địa chỉ đầu tiên.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <button type="button" class="btn-add-address" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                        <i class="fas fa-plus-circle"></i> Thêm địa chỉ mới
                    </button>
                </div>

                <!-- Nút hành động -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/profile" class="btn-cancel"><i class="fas fa-times"></i> Hủy bỏ</a>
                    <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu thay đổi</button>
                </div>
            </form>

            <!-- Modal thêm địa chỉ (giữ nguyên logic JS hiện tại) -->
            <div class="modal fade" id="addAddressModal" tabindex="-1" aria-labelledby="addAddressModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addAddressModalLabel"><i class="fas fa-plus-circle me-2"></i>Thêm địa chỉ mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div id="addressModalError" class="alert alert-danger d-none" role="alert"></div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên địa chỉ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="addressName" placeholder="VD: Nhà riêng, Văn phòng, Công ty...">
                                <div class="form-text">Đặt tên để dễ phân biệt các địa chỉ</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Tỉnh / Thành phố <span class="text-danger">*</span></label>
                                <select class="form-select" id="provinceSelect" required>
                                    <option value="" selected disabled>-- Chọn Tỉnh / Thành phố --</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Quận / Huyện</label>
                                <select class="form-select" id="districtSelect" disabled>
                                    <option value="" selected>-- Chọn Quận / Huyện --</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Phường / Xã <span class="text-danger">*</span></label>
                                <select class="form-select" id="wardSelect" required disabled>
                                    <option value="" selected disabled>-- Chọn Phường / Xã --</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Số nhà, tên đường <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="streetAddress" placeholder="VD: 123 Đường Lê Lợi">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Hủy bỏ</button>
                            <button type="button" class="btn btn-dark" id="saveAddressBtn"><i class="fas fa-save me-1"></i> Lưu địa chỉ</button>
                        </div>
                    </div>
                </div>
            </div>

        </div> <!-- end form-card -->
    </div> <!-- end main-content -->
</div> <!-- end profile-wrapper -->

<!-- Modal thay đổi avatar (giữ nguyên HTML & logic) -->
<div class="avatar-modal-overlay" id="avatarModalOverlay">
    <div class="avatar-modal">
        <div class="avatar-modal-head">
            <h5><i class="fas fa-camera me-2"></i> Thay đổi ảnh đại diện</h5>
            <button type="button" class="avatar-modal-close" onclick="closeAvatarModal()">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/avatarEdit" method="post" enctype="multipart/form-data">
            <div class="avatar-modal-body">
                <c:if test="${not empty avatarError}">
                    <div class="am-err show"><i class="fas fa-exclamation-circle"></i> <span>${fn:escapeXml(avatarError)}</span></div>
                </c:if>
                <div class="am-preview-wrap">
                    <div class="am-preview-ring">
                        <img id="amPreviewImg" src="${not empty user.imgURL ? pageContext.request.contextPath.concat('/').concat(user.imgURL) : pageContext.request.contextPath.concat('/assets/img/default-avatar.png')}" alt="Xem trước">
                    </div>
                </div>
                <div class="am-dropzone">
                    <i class="fas fa-cloud-upload-alt am-dz-icon"></i>
                    <div class="am-dz-title">Nhấn để chọn ảnh</div>
                    <div class="am-dz-hint">Hỗ trợ JPG, PNG, jpeg, webp. Dung lượng tối đa 2MB.</div>
                    <input type="file" name="avatar" id="amFileInput" accept="image/jpeg,image/png,image/gif,image/webp">
                </div>
                <div class="am-file-row" id="amFileRow">
                    <i class="fas fa-file-image"></i>
                    <div class="am-file-meta"><div class="am-file-name" id="amFileName">—</div><div class="am-file-size" id="amFileSize">—</div></div>
                </div>
            </div>
            <div class="avatar-modal-foot">
                <button type="button" class="am-btn-cancel" onclick="closeAvatarModal()">Hủy bỏ</button>
                <button type="submit" class="am-btn-save" id="amSaveBtn" disabled><i class="fas fa-save"></i> Lưu ảnh đại diện</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // ======================= AVATAR MODAL =======================
    function openAvatarModal() {
        var overlay = document.getElementById('avatarModalOverlay');
        overlay.style.display = 'flex';
        requestAnimationFrame(function() { requestAnimationFrame(function() { overlay.classList.add('open'); }); });
    }
    function closeAvatarModal() {
        var overlay = document.getElementById('avatarModalOverlay');
        overlay.classList.remove('open');
        setTimeout(function() { overlay.style.display = 'none'; }, 250);
    }
    document.getElementById('avatarModalOverlay').addEventListener('click', function(e) {
        if (e.target === this) closeAvatarModal();
    });
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeAvatarModal();
    });
    document.getElementById('amFileInput').addEventListener('change', function() {
        var file = this.files[0];
        if (!file) return;
        document.getElementById('amFileName').textContent = file.name;
        document.getElementById('amFileSize').textContent = file.size < 1048576 ? (file.size / 1024).toFixed(1) + ' KB' : (file.size / 1048576).toFixed(2) + ' MB';
        document.getElementById('amFileRow').classList.add('show');
        document.getElementById('amSaveBtn').disabled = false;
        var reader = new FileReader();
        reader.onload = function(e) { document.getElementById('amPreviewImg').src = e.target.result; };
        reader.readAsDataURL(file);
    });
    <c:if test="${not empty avatarError}"> openAvatarModal(); </c:if>

    // ======================= THÊM ĐỊA CHỈ (GIỮ NGUYÊN LOGIC CŨ) =======================
    const contextPath = "${pageContext.request.contextPath}";
    let addressData = [];
    const provinceSelect = document.getElementById("provinceSelect");
    const districtSelect = document.getElementById("districtSelect");
    const wardSelect = document.getElementById("wardSelect");
    const saveAddressBtn = document.getElementById("saveAddressBtn");
    const addressModalError = document.getElementById("addressModalError");
    const addressNameInput = document.getElementById("addressName");
    const streetInput = document.getElementById("streetAddress");

    function showModalError(message) {
        addressModalError.textContent = message;
        addressModalError.classList.remove("d-none");
        setTimeout(() => { addressModalError.classList.add("d-none"); }, 4000);
    }

    const addAddressModalEl = document.getElementById("addAddressModal");
    addAddressModalEl.addEventListener("show.bs.modal", function () {
        addressNameInput.value = "";
        streetInput.value = "";
        provinceSelect.innerHTML = '<option value="" selected disabled>-- Chọn Tỉnh / Thành phố --</option>';
        districtSelect.innerHTML = '<option value="" selected disabled>-- Chọn Quận / Huyện --</option>';
        wardSelect.innerHTML = '<option value="" selected disabled>-- Chọn Phường / Xã --</option>';
        districtSelect.disabled = true;
        wardSelect.disabled = true;
        addressModalError.classList.add("d-none");
        if (addressData.length === 0) loadAddressData();
        else renderProvinces();
    });

    async function loadAddressData() {
        try {
            const response = await fetch('https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json');
            if (!response.ok) throw new Error("Không thể tải dữ liệu");
            addressData = await response.json();
            renderProvinces();
        } catch (error) {
            console.error(error);
            showModalError("Không thể tải danh sách tỉnh/thành phố.");
        }
    }

    function renderProvinces() {
        provinceSelect.innerHTML = '<option value="" selected disabled>-- Chọn Tỉnh / Thành phố --</option>';
        addressData.forEach(province => {
            let option = document.createElement('option');
            option.value = province.Name;
            option.text = province.Name;
            option.dataset.id = province.Id;
            provinceSelect.appendChild(option);
        });
    }

    provinceSelect.addEventListener('change', function() {
        districtSelect.innerHTML = '<option value="" selected disabled>-- Chọn Quận / Huyện --</option>';
        wardSelect.innerHTML = '<option value="" selected disabled>-- Chọn Phường / Xã --</option>';
        wardSelect.disabled = true;
        districtSelect.disabled = false;
        const selectedOption = this.options[this.selectedIndex];
        if (!selectedOption.dataset.id) return;
        const province = addressData.find(p => p.Id === selectedOption.dataset.id);
        if (province && province.Districts) {
            province.Districts.forEach(district => {
                let option = document.createElement('option');
                option.value = district.Name;
                option.text = district.Name;
                option.dataset.id = district.Id;
                districtSelect.appendChild(option);
            });
        }
    });

    districtSelect.addEventListener('change', function() {
        wardSelect.innerHTML = '<option value="" selected disabled>-- Chọn Phường / Xã --</option>';
        wardSelect.disabled = false;
        const provinceId = provinceSelect.options[provinceSelect.selectedIndex].dataset.id;
        const province = addressData.find(p => p.Id === provinceId);
        if (!province) return;
        const districtId = this.options[this.selectedIndex].dataset.id;
        const district = province.Districts.find(d => d.Id === districtId);
        if (district && district.Wards) {
            district.Wards.forEach(ward => {
                let option = document.createElement('option');
                option.value = ward.Name;
                option.text = ward.Name;
                wardSelect.appendChild(option);
            });
        }
    });

    saveAddressBtn.addEventListener("click", async function () {
        const name = addressNameInput.value.trim();
        const provinceText = provinceSelect.value;
        const districtText = districtSelect.value;
        const wardText = wardSelect.value;
        const street = streetInput.value.trim();

        if (!name) { showModalError("Vui lòng nhập tên địa chỉ"); return; }
        if (!provinceText || provinceText === "-- Chọn Tỉnh / Thành phố --") { showModalError("Vui lòng chọn Tỉnh / Thành phố"); return; }
        if (!districtText || districtText === "-- Chọn Quận / Huyện --") { showModalError("Vui lòng chọn Quận / Huyện"); return; }
        if (!wardText || wardText === "-- Chọn Phường / Xã --") { showModalError("Vui lòng chọn Phường / Xã"); return; }
        if (!street) { showModalError("Vui lòng nhập số nhà và tên đường"); return; }

        saveAddressBtn.disabled = true;
        saveAddressBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';

        try {
            const response = await fetch(contextPath + "/addAddress", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({
                    name: name,
                    street: street,
                    commune: wardText,
                    district: districtText,
                    province: provinceText
                })
            });
            if (response.ok) {
                window.location.reload();
            } else {
                const errorText = await response.text();
                console.error(errorText);
                showModalError("Lưu địa chỉ thất bại. Vui lòng thử lại.");
                saveAddressBtn.disabled = false;
                saveAddressBtn.innerHTML = '<i class="fas fa-save me-1"></i> Lưu địa chỉ';
            }
        } catch (error) {
            console.error(error);
            showModalError("Lỗi kết nối đến máy chủ.");
            saveAddressBtn.disabled = false;
            saveAddressBtn.innerHTML = '<i class="fas fa-save me-1"></i> Lưu địa chỉ';
        }
    });

    if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", loadAddressData);
    else loadAddressData();
</script>
</body>
</html>