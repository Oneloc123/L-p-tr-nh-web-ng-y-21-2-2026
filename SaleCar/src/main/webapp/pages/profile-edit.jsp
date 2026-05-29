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
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* ── Layout ── */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }

        /* ── Sidebar ── */
        .sidebar-menu { width: 280px; background-color: #000; color: #fff; padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: #fff; text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333; color: #fff; }
        .menu-item.active { background-color: #fff; color: #000; }
        .menu-item.active i { color: #000; }
        .menu-divider { height: 1px; background-color: #333; margin: 15px 20px; }

        /* ── Main content ── */
        .main-content { flex: 1; padding: 30px; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 600; color: #000; margin-bottom: 10px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #666; text-decoration: none; }
        .breadcrumb-item.active { color: #000; font-weight: 500; }

        /* ── Form card ── */
        .form-card { background: #fff; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow: hidden; }
        .form-section { margin-bottom: 40px; padding: 0 30px; }
        .form-section:first-of-type { padding-top: 30px; }
        .form-section-title { font-size: 18px; font-weight: 600; color: #000; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #000; }
        .form-label { font-weight: 500; color: #000; margin-bottom: 8px; }
        .form-control, .form-select { border: 2px solid #e0e0e0; border-radius: 8px; padding: 10px 15px; font-size: 15px; transition: all 0.3s; }
        .form-control:focus, .form-select:focus { border-color: #000; box-shadow: none; }
        .form-control.is-invalid { border-color: #dc3545; }
        .invalid-feedback { font-size: 13px; }
        textarea.form-control { min-height: 100px; resize: vertical; }

        /* ── Avatar section ── */
        .avatar-upload-section { background-color: #f8f9fa; border: 2px dashed #000; border-radius: 12px; padding: 30px; text-align: center; margin: 30px 30px 0; }
        .current-avatar { width: 120px; height: 120px; border-radius: 50%; margin: 0 auto 20px; background-color: #000; display: flex; align-items: center; justify-content: center; border: 4px solid #fff; box-shadow: 0 5px 15px rgba(0,0,0,0.1); overflow: hidden; }
        .current-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .btn-upload { padding: 10px 25px; background-color: #000; color: #fff; border: 2px solid #000; border-radius: 8px; font-weight: 500; cursor: pointer; transition: all 0.3s; display: inline-block; }
        .btn-upload:hover { background-color: #fff; color: #000; }
        .upload-hint { font-size: 12px; color: #666; margin-top: 10px; }

        /* ── Address box ── */
        .address-box { background-color: #f8f9fa; border: 2px solid #e0e0e0; border-radius: 8px; padding: 20px; margin-top: 20px; }
        .address-box-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .address-box-header h4 { font-size: 16px; font-weight: 600; margin: 0; }
        .address-actions { display: flex; align-items: center; gap: 15px; }
        .btn-remove-address { color: #dc3545; background: none; border: none; cursor: pointer; font-size: 16px; }
        .btn-set-main { color: #0d6efd; border: 1px solid #0d6efd; background-color: transparent; padding: 5px 12px; border-radius: 6px; font-size: 13px; font-weight: 500; text-decoration: none; transition: all 0.3s; }
        .btn-set-main:hover { background-color: #0d6efd; color: #fff; }

        /* ── Status ── */
        .status-options { display: flex; gap: 20px; margin-top: 10px; }
        .status-option { display: flex; align-items: center; gap: 8px; }
        .status-option input[type="radio"] { width: 18px; height: 18px; }

        /* ── Form actions ── */
        .form-actions { padding: 30px; background-color: #f8f9fa; border-top: 1px solid #eee; display: flex; gap: 15px; justify-content: flex-end; }
        .btn-save { padding: 12px 30px; background-color: #000; color: #fff; border: 2px solid #000; border-radius: 8px; font-weight: 600; text-decoration: none; transition: all 0.3s; cursor: pointer; }
        .btn-save:hover { background-color: #fff; color: #000; }
        .btn-cancel { padding: 12px 30px; background-color: #fff; color: #000; border: 2px solid #000; border-radius: 8px; font-weight: 600; text-decoration: none; }
        .btn-cancel:hover { background-color: #f0f0f0; }

        /* ── Avatar Modal ── */
        .avatar-modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.55);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.25s ease;
        }
        .avatar-modal-overlay.open { opacity: 1; }
        .avatar-modal {
            background: #fff;
            border-radius: 16px;
            width: 480px;
            max-width: calc(100vw - 32px);
            overflow: hidden;
            transform: translateY(20px);
            transition: transform 0.25s ease;
        }
        .avatar-modal-overlay.open .avatar-modal { transform: translateY(0); }
        .avatar-modal-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 24px;
            border-bottom: 1px solid #eee;
        }
        .avatar-modal-head h5 { margin: 0; font-size: 16px; font-weight: 600; color: #000; }
        .avatar-modal-close {
            background: none;
            border: none;
            font-size: 24px;
            line-height: 1;
            cursor: pointer;
            color: #666;
            padding: 0 6px;
            border-radius: 6px;
        }
        .avatar-modal-close:hover { background: #f0f0f0; }
        .avatar-modal-body { padding: 24px; }
        .avatar-modal-foot {
            padding: 16px 24px;
            border-top: 1px solid #eee;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        .am-preview-wrap { text-align: center; margin-bottom: 20px; }
        .am-preview-ring {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            border: 3px solid #000;
            overflow: hidden;
            margin: 0 auto;
            background: #e9ecef;
        }
        .am-preview-ring img { width: 100%; height: 100%; object-fit: cover; }
        .am-dropzone {
            border: 2px dashed #ccc;
            border-radius: 12px;
            padding: 30px 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
            background: #fafafa;
            position: relative;
        }
        .am-dropzone:hover { border-color: #000; background: #f0f0f0; }
        .am-dz-icon { font-size: 32px; color: #aaa; display: block; margin-bottom: 10px; }
        .am-dz-title { font-size: 14px; font-weight: 500; color: #333; margin-bottom: 5px; }
        .am-dz-hint { font-size: 12px; color: #999; }
        .am-dropzone input[type="file"] {
            position: absolute;
            inset: 0;
            opacity: 0;
            cursor: pointer;
            width: 100%;
            height: 100%;
        }
        .am-file-row {
            display: none;
            align-items: center;
            gap: 10px;
            background: #f4f4f4;
            border-radius: 8px;
            padding: 10px 14px;
            margin-top: 12px;
        }
        .am-file-row.show { display: flex; }
        .am-file-row > i { font-size: 20px; color: #000; flex-shrink: 0; }
        .am-file-meta { flex: 1; min-width: 0; }
        .am-file-name { font-size: 13px; font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #000; }
        .am-file-size { font-size: 12px; color: #666; }
        .am-err {
            display: none;
            align-items: center;
            gap: 8px;
            background: #fff3f3;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 16px;
            font-size: 13px;
            color: #842029;
        }
        .am-err.show { display: flex; }
        .am-btn-cancel {
            padding: 10px 22px;
            background: #fff;
            color: #000;
            border: 2px solid #000;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
        }
        .am-btn-cancel:hover { background: #f0f0f0; }
        .am-btn-save {
            padding: 10px 22px;
            background: #000;
            color: #fff;
            border: 2px solid #000;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }
        .am-btn-save:hover:not(:disabled) { background: #333; }
        .am-btn-save:disabled { opacity: 0.45; cursor: not-allowed; }

        /* Toast tùy chỉnh */
        .address-toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 2100;
            min-width: 250px;
        }

        @media (max-width: 768px) {
            .sidebar-menu { display: none; }
            .form-actions { flex-direction: column; }
            .btn-save, .btn-cancel { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <!-- Sidebar -->
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item"><i class="fas fa-chart-pie"></i><span>Bảng điều khiển</span></a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item"><i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span></a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item active"><i class="fas fa-user-edit"></i><span>Chỉnh sửa thông tin</span></a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item"><i class="fas fa-lock"></i><span>Đổi mật khẩu</span></a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item"><i class="fas fa-shopping-bag"></i><span>Đơn hàng của tôi</span></a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item"><i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span></a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item"><i class="fas fa-heart"></i><span>Sản phẩm yêu thích</span></a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item"><i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span></a>
        </div>
    </div>

    <!-- Main content -->
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

                <!-- Avatar -->
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
                    <button type="button" class="btn-upload" onclick="openAvatarModal()">
                        <i class="fas fa-camera"></i> Thay đổi ảnh đại diện
                    </button>
                    <div class="upload-hint">Hỗ trợ: JPG, PNG, GIF, WEBP · Tối đa 2MB · Ảnh vuông hiển thị đẹp nhất.</div>
                </div>

                <!-- Thông tin tài khoản -->
                <div class="form-section" style="margin-top: 30px;">
                    <h3 class="form-section-title"><i class="fas fa-user"></i> Thông tin tài khoản</h3>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">ID người dùng</label>
                            <input type="text" class="form-control" value="${user.getId()}" readonly disabled>
                            <small class="text-muted">ID không thể thay đổi</small>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" value="${user.getUsername()}" readonly disabled>
                            <small class="text-muted">Tên đăng nhập không thể thay đổi</small>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control ${not empty fullnameError ? 'is-invalid' : ''}" name="fullname" value="${fn:escapeXml(param.fullname != null ? param.fullname : user.fullname)}" required>
                            <small class="form-text text-muted">Nhập họ và tên đầy đủ (không dùng ký tự đặc biệt, tối thiểu 2 từ)</small>
                            <c:if test="${not empty fullnameError}"><div class="invalid-feedback">${fullnameError}</div></c:if>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control ${not empty emailError ? 'is-invalid' : ''}" name="email" value="${fn:escapeXml(param.email != null ? param.email : user.email)}" required>
                            <small class="form-text text-muted">Nhập email hợp lệ (VD: tenban@gmail.com)</small>
                            <c:if test="${not empty emailError}"><div class="invalid-feedback">${emailError}</div></c:if>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control ${not empty phonenumberError ? 'is-invalid' : ''}" name="phoneNumber" value="${fn:escapeXml(param.phoneNumber != null ? param.phoneNumber : user.phonenumber)}">
                            <small class="form-text text-muted">10–11 số, bắt đầu bằng 0 hoặc +84</small>
                            <c:if test="${not empty phonenumberError}"><div class="invalid-feedback">${phonenumberError}</div></c:if>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Vai trò</label>
                            <select class="form-select" name="role" disabled>
                                <option value="ROLE_USER" ${(param.role != null ? param.role : user.role) == 'ROLE_USER' ? 'selected' : ''}>ROLE_USER</option>
                                <option value="ROLE_ADMIN" ${(param.role != null ? param.role : user.role) == 'ROLE_ADMIN' ? 'selected' : ''}>ROLE_ADMIN</option>
                            </select>
                            <small class="text-muted">Vai trò chỉ được thay đổi bởi Admin</small>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description">${fn:escapeXml(param.description != null ? param.description : user.description)}</textarea>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Trạng thái</label>
                            <div class="status-options">
                                <label class="status-option"><input type="radio" name="status" value="active" ${(param.status != null ? param.status : user.status) == 'active' ? 'checked' : ''}> <span>Hoạt động</span></label>
                                <label class="status-option"><input type="radio" name="status" value="inactive" ${(param.status != null ? param.status : user.status) == 'inactive' ? 'checked' : ''}> <span>Không hoạt động</span></label>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Danh sách địa chỉ -->
                <div class="form-section">
                    <h3 class="form-section-title"><i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ</h3>
                    <c:choose>
                        <c:when test="${not empty listAddress}">
                            <%-- Địa chỉ chính --%>
                            <c:forEach var="a" items="${listAddress}">
                                <c:if test="${a.type == 'main'}">
                                    <div class="address-box" style="border-color: #000; box-shadow: 0 0 5px rgba(0,0,0,0.1);">
                                        <div class="address-box-header">
                                            <h4><i class="fas fa-star text-warning"></i> Địa chỉ chính: ${fn:escapeXml(a.nameAddress)}</h4>  <%-- SỬA --%>
                                            <div class="address-actions">
                                                <button type="button" class="btn-remove-address"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#confirmDeleteModal${a.id}">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Số nhà, tên đường</label>
                                                <input type="text" class="form-control" name="street${a.id}"
                                                       value="${fn:escapeXml(a.addressLine)}">       <%-- SỬA --%>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Xã/Phường</label>
                                                <input type="text" class="form-control" name="commune${a.id}"
                                                       value="${fn:escapeXml(a.wardName)}">          <%-- SỬA --%>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Quận/Huyện</label>
                                                <input type="text" class="form-control" name="district${a.id}"
                                                       value="${fn:escapeXml(a.districName)}">       <%-- THÊM MỚI --%>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Tỉnh/Thành phố</label>
                                                <input type="text" class="form-control" name="province${a.id}"
                                                       value="${fn:escapeXml(a.provinceName)}">      <%-- SỬA --%>
                                            </div>
                                        </div>
                                        <input type="hidden" name="addressId" value="${a.id}">
                                    </div>

                                    <div class="modal fade" id="confirmDeleteModal${a.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Xác nhận xóa</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">Bạn có chắc muốn xóa địa chỉ chính này không?</div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                    <a href="${pageContext.request.contextPath}/removeAddress?id=${a.id}" class="btn btn-danger">Xóa</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>

                            <%-- Địa chỉ phụ --%>
                            <c:forEach var="a" items="${listAddress}">
                                <c:if test="${a.type != 'main'}">
                                    <div class="address-box">
                                        <div class="address-box-header">
                                            <h4>Địa chỉ phụ: ${fn:escapeXml(a.nameAddress)}</h4>   <%-- SỬA --%>
                                            <div class="address-actions">
                                                <a href="${pageContext.request.contextPath}/setMainAddress?id=${a.id}" class="btn-set-main">
                                                    <i class="fas fa-check-circle"></i> Đặt làm mặc định
                                                </a>
                                                <button type="button" class="btn-remove-address"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#confirmDeleteModal${a.id}">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Số nhà, tên đường</label>
                                                <input type="text" class="form-control" name="street${a.id}"
                                                       value="${fn:escapeXml(a.addressLine)}">       <%-- SỬA --%>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Xã/Phường</label>
                                                <input type="text" class="form-control" name="commune${a.id}"
                                                       value="${fn:escapeXml(a.wardName)}">          <%-- SỬA --%>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Quận/Huyện</label>
                                                <input type="text" class="form-control" name="district${a.id}"
                                                       value="${fn:escapeXml(a.districName)}">       <%-- THÊM MỚI --%>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-label">Tỉnh/Thành phố</label>
                                                <input type="text" class="form-control" name="province${a.id}"
                                                       value="${fn:escapeXml(a.provinceName)}">      <%-- SỬA --%>
                                            </div>
                                        </div>
                                        <input type="hidden" name="addressId" value="${a.id}">
                                    </div>

                                    <div class="modal fade" id="confirmDeleteModal${a.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Xác nhận xóa</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">Bạn có chắc muốn xóa địa chỉ này không?</div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                    <a href="${pageContext.request.contextPath}/removeAddress?id=${a.id}" class="btn btn-danger">Xóa</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="address-box"><div class="address-box-header"><h4>Chưa có địa chỉ nào</h4></div></div>
                        </c:otherwise>
                    </c:choose>

                    <button type="button" class="btn btn-dark mt-3" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                        <i class="fas fa-plus"></i> Thêm địa chỉ mới
                    </button>
                </div>

                <!-- Form actions -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/profile" class="btn-cancel"><i class="fas fa-times"></i> Hủy bỏ</a>
                    <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu thay đổi</button>
                </div>
            </form>

            <!-- ========= MODAL THÊM ĐỊA CHỈ MỚI (ĐÃ SỬA API) ========= -->
            <div class="modal fade" id="addAddressModal" tabindex="-1" aria-labelledby="addAddressModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content" style="border-radius: 12px; border: none;">
                        <div class="modal-header" style="border-bottom: 1px solid #eee;">
                            <h5 class="modal-title fw-bold" id="addAddressModalLabel" style="color: #000;">
                                <i class="fas fa-map-marked-alt me-2"></i> Thêm địa chỉ mới
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" style="padding: 25px;">
                            <!-- Thông báo lỗi AJAX -->
                            <div id="addressModalError" class="alert alert-danger d-none" role="alert"></div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên địa chỉ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="addressName" placeholder="VD: Nhà riêng, Văn phòng, Công ty...">
                                <small class="text-muted">Đặt tên để dễ phân biệt các địa chỉ</small>
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
                                <input type="text" class="form-control" id="streetAddress" placeholder="VD: Số 120, đường Yên Lãng">
                            </div>
                        </div>
                        <div class="modal-footer" style="border-top: none; gap: 10px;">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">Hủy bỏ</button>
                            <button type="button" class="btn btn-dark" id="saveAddressBtn" style="border-radius: 8px; min-width: 120px;">
                                <i class="fas fa-save me-1"></i> Lưu địa chỉ
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ========= END MODAL THÊM ĐỊA CHỈ ========= -->

        </div><!-- end .form-card -->
    </div><!-- end .main-content -->
</div><!-- end .profile-wrapper -->

<!-- Avatar Modal -->
<div class="avatar-modal-overlay" id="avatarModalOverlay">
    <div class="avatar-modal" role="dialog" aria-modal="true" aria-labelledby="avatarModalTitle">
        <div class="avatar-modal-head">
            <h5 id="avatarModalTitle"><i class="fas fa-camera me-2"></i> Thay đổi ảnh đại diện</h5>
            <button type="button" class="avatar-modal-close" onclick="closeAvatarModal()" aria-label="Đóng">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/avatarEdit" method="post" enctype="multipart/form-data">
            <div class="avatar-modal-body">
                <c:if test="${not empty avatarError}">
                    <div class="am-err show"><i class="fas fa-exclamation-circle"></i><span>${fn:escapeXml(avatarError)}</span></div>
                </c:if>
                <div class="am-preview-wrap">
                    <div class="am-preview-ring">
                        <img id="amPreviewImg" src="${not empty user.imgURL ? pageContext.request.contextPath.concat('/').concat(user.imgURL) : pageContext.request.contextPath.concat('/assets/img/default-avatar.png')}" alt="Xem trước">
                    </div>
                </div>
                <div class="am-dropzone">
                    <i class="fas fa-cloud-upload-alt am-dz-icon"></i>
                    <div class="am-dz-title">Nhấn để chọn ảnh</div>
                    <div class="am-dz-hint">JPG, PNG, GIF, WEBP &nbsp;·&nbsp; Tối đa 2MB</div>
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
    // ======================= AVATAR MODAL (giữ nguyên) =======================
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
    document.getElementById('avatarModalOverlay').addEventListener('click', function(e) { if (e.target === this) closeAvatarModal(); });
    document.addEventListener('keydown', function(e) { if (e.key === 'Escape') closeAvatarModal(); });
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

    // ======================= MODAL THÊM ĐỊA CHỈ - DÙNG JSON TỪ GITHUB =======================
    const contextPath = "${pageContext.request.contextPath}";
    let addressData = [];           // Lưu toàn bộ dữ liệu tỉnh/huyện/xã

    // DOM elements
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

    // Reset form khi mở modal
    const addAddressModal = document.getElementById("addAddressModal");
    addAddressModal.addEventListener("show.bs.modal", function () {
        addressNameInput.value = "";
        streetInput.value = "";
        provinceSelect.innerHTML = '<option value="" selected disabled>-- Chọn Tỉnh / Thành phố --</option>';
        districtSelect.innerHTML = '<option value="" selected disabled>-- Chọn Quận / Huyện --</option>';
        wardSelect.innerHTML = '<option value="" selected disabled>-- Chọn Phường / Xã --</option>';
        districtSelect.disabled = true;
        wardSelect.disabled = true;
        addressModalError.classList.add("d-none");

        // Nếu chưa có dữ liệu thì tải về
        if (addressData.length === 0) {
            loadAddressData();
        } else {
            renderProvinces();
        }
    });

    // Tải file JSON từ GitHub
    async function loadAddressData() {
        try {
            const response = await fetch('https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json');
            if (!response.ok) throw new Error("Không thể tải dữ liệu địa chỉ");
            addressData = await response.json();
            renderProvinces();
        } catch (error) {
            console.error("Lỗi tải dữ liệu:", error);
            showModalError("Không thể tải danh sách tỉnh/thành phố. Vui lòng thử lại sau.");
        }
    }

    // Hiển thị danh sách tỉnh/thành phố
    function renderProvinces() {
        provinceSelect.innerHTML = '<option value="" selected disabled>-- Chọn Tỉnh / Thành phố --</option>';
        addressData.forEach(province => {
            let option = document.createElement('option');
            option.value = province.Name;          // gán value = tên tỉnh
            option.text = province.Name;
            option.dataset.id = province.Id;       // lưu mã tỉnh để tra cứu
            provinceSelect.appendChild(option);
        });
    }

    // Khi chọn tỉnh -> load danh sách quận/huyện
    provinceSelect.addEventListener('change', function() {
        // Xóa dữ liệu cũ của huyện và xã
        districtSelect.innerHTML = '<option value="" selected disabled>-- Chọn Quận / Huyện --</option>';
        wardSelect.innerHTML = '<option value="" selected disabled>-- Chọn Phường / Xã --</option>';
        wardSelect.disabled = true;
        districtSelect.disabled = false;

        const selectedOption = this.options[this.selectedIndex];
        if (!selectedOption.dataset.id) return;

        const provinceId = selectedOption.dataset.id;
        const province = addressData.find(p => p.Id === provinceId);
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

    // Khi chọn quận/huyện -> load danh sách phường/xã
    districtSelect.addEventListener('change', function() {
        wardSelect.innerHTML = '<option value="" selected disabled>-- Chọn Phường / Xã --</option>';
        wardSelect.disabled = false;

        const provinceSelectElem = document.getElementById('provinceSelect');
        const selectedProvOption = provinceSelectElem.options[provinceSelectElem.selectedIndex];
        if (!selectedProvOption.dataset.id) return;

        const province = addressData.find(p => p.Id === selectedProvOption.dataset.id);
        if (!province) return;

        const selectedDistOption = this.options[this.selectedIndex];
        const districtId = selectedDistOption.dataset.id;
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

    // Lưu địa chỉ mới (AJAX)
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
                console.error("Server error:", errorText);
                showModalError("Lưu địa chỉ thất bại. Vui lòng thử lại sau.");
                saveAddressBtn.disabled = false;
                saveAddressBtn.innerHTML = '<i class="fas fa-save me-1"></i> Lưu địa chỉ';
            }
        } catch (error) {
            console.error("Network error:", error);
            showModalError("Lỗi kết nối đến máy chủ.");
            saveAddressBtn.disabled = false;
            saveAddressBtn.innerHTML = '<i class="fas fa-save me-1"></i> Lưu địa chỉ';
        }
    });

    // Tải dữ liệu khi trang load
    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", loadAddressData);
    } else {
        loadAddressData();
    }
</script>
</body>
</html>