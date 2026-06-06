<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cá nhân - LUXCAR</title>
    <%@ include file="/common/header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>
        .profile-card {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
            overflow: hidden;
        }
        .profile-cover {
            height: 140px;
            background: linear-gradient(135deg, #0a0a0a 0%, #2d2d2d 100%);
            border-bottom: 1px solid var(--border-subtle);
        }
        .profile-header { padding: 0 32px 24px; position: relative; }
        .avatar-section {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: -60px;
            margin-bottom: 20px;
        }
        .avatar-wrapper { position: relative; display: inline-block; }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--bg-surface);
            box-shadow: var(--shadow-card);
            background: var(--bg-elevated);
        }
        .edit-avatar-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: var(--bg-elevated);
            border: 2px solid var(--border-subtle);
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-fast);
            text-decoration: none;
            font-size: 14px;
        }
        .edit-avatar-btn:hover { background: var(--gold); color: #101010; border-color: var(--gold); }

        .profile-title { flex: 1; }
        .profile-title h2 { font-size: 26px; font-weight: 700; margin-bottom: 6px; color: var(--text-primary); }

        .info-section { padding: 28px 32px; border-top: 1px solid var(--border-subtle); }

        .description-section {
            margin-top: 24px;
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-md);
            padding: 20px 24px;
        }
        .description-section .info-label { margin-bottom: 12px; }

        .address-card {
            background: var(--bg-elevated);
            border-radius: var(--radius-md);
            border: 1px solid var(--border-subtle);
            overflow: hidden;
            transition: all var(--transition-base);
            box-shadow: var(--shadow-card);
        }
        .address-card:hover {
            transform: translateY(-3px);
            border-color: var(--border-gold);
            box-shadow: var(--shadow-card);
        }
        .address-card-main { border-left: 4px solid var(--gold); }
        .address-card-sub { border-left: 4px solid rgba(255, 255, 255, 0.15); }
        .address-badge {
            padding: 14px 18px;
            background: var(--bg-surface);
            border-bottom: 1px solid var(--border-subtle);
        }
        .address-content { padding: 18px; display: flex; flex-direction: column; gap: 14px; }
        .address-field {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            font-size: 14px;
            border-bottom: 1px dashed var(--border-subtle);
            padding-bottom: 8px;
        }
        .address-field:last-child { border-bottom: none; padding-bottom: 0; }
        .field-icon { width: 24px; color: var(--text-muted); font-size: 14px; text-align: center; margin-top: 2px; }
        .field-label { font-weight: 600; color: var(--text-secondary); min-width: 100px; font-size: 13px; }
        .field-value { color: var(--text-primary); flex: 1; word-break: break-word; }

        .empty-address {
            text-align: center;
            padding: 48px 24px;
            background: var(--bg-elevated);
            border-radius: var(--radius-md);
            margin-top: 12px;
            border: 1px solid var(--border-subtle);
        }
        .empty-icon { font-size: 56px; color: rgba(255,255,255,0.08); margin-bottom: 16px; }
        .empty-address p { color: var(--text-muted); font-size: 15px; margin-bottom: 20px; }

        @media (max-width: 768px) {
            .sidebar-menu { display: none; }
            .main-content { padding: 20px; }
            .profile-header { padding: 0 20px 20px; }
            .info-grid { grid-template-columns: 1fr; gap: 16px; }
            .address-grid { grid-template-columns: 1fr; }
            .avatar-section { flex-direction: column; align-items: center; text-align: center; }
            .profile-title { text-align: center; }
            .edit-profile-btn { align-self: center; }
            .address-field { flex-wrap: wrap; gap: 6px; }
            .field-label { min-width: 85px; }
        }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <!-- Sidebar chung -->
    <%@ include file="/common/user-sidebar.jsp" %>

    <!-- Nội dung chính đã nâng cấp -->
    <div class="main-content">
        <div class="content-header">
            <h1>Thông tin cá nhân</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">Tài khoản</a></li>
                    <li class="breadcrumb-item active">Thông tin cá nhân</li>
                </ol>
            </nav>
        </div>

        <div class="profile-card">
            <!-- Cover ảnh nền -->
            <div class="profile-cover"></div>

            <div class="profile-header">
                <div class="avatar-section">
                    <div class="avatar-wrapper">
                        <img src="${pageContext.request.contextPath}${sessionScope.user.imgURL}" class="profile-avatar" alt="Avatar" />
                        <a href="${pageContext.request.contextPath}/profileEdit" class="edit-avatar-btn">
                            <i class="fas fa-camera"></i>
                        </a>
                    </div>
                    <div class="profile-title">
                        <h2>${user.getFullname()}</h2>
                        <span class="role-badge"><i class="fas fa-user-tag"></i> ${user.getRole()}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/profileEdit" class="edit-profile-btn">
                        <i class="fas fa-pen"></i> Chỉnh sửa hồ sơ
                    </a>
                </div>
            </div>

            <!-- Thông tin tài khoản -->
            <div class="info-section">
                <div class="section-title">
                    <i class="fas fa-user-circle"></i>
                    Thông tin tài khoản
                </div>
                <div class="info-grid">
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-id-card"></i> ID người dùng</div>
                        <div class="info-value">${user.getId()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-user-tag"></i> Tên đăng nhập</div>
                        <div class="info-value">${user.getUsername()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-user"></i> Họ và tên</div>
                        <div class="info-value">${user.getFullname()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-envelope"></i> Email</div>
                        <div class="info-value">${user.getEmail()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-phone"></i> Số điện thoại</div>
                        <div class="info-value">${user.getPhonenumber()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-briefcase"></i> Vai trò</div>
                        <div class="info-value"><span class="role-badge">${user.getRole()}</span></div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-circle-info"></i> Trạng thái</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${user.getStatus()==true}">
                                    <span class="status-badge status-active"><i class="fas fa-check-circle"></i> Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive"><i class="fas fa-times-circle"></i> Không hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ mặc định</div>
                        <div class="info-value">${user.getAddressid()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-calendar-plus"></i> Ngày tạo</div>
                        <div class="info-value">${user.getCreatedat()}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label"><i class="fas fa-calendar-alt"></i> Cập nhật lần cuối</div>
                        <div class="info-value">${user.getUpdatedat()}</div>
                    </div>
                </div>

                <!-- Mô tả riêng -->
                <div class="description-section">
                    <div class="info-label"><i class="fas fa-align-left"></i> Mô tả</div>
                    <div class="info-value description">
                        ${not empty user.getDescription() ? user.getDescription() : 'Chưa có mô tả'}
                    </div>
                </div>
            </div>

            <!-- Sổ địa chỉ -->
            <div class="info-section">
                <div class="section-title">
                    <i class="fas fa-map-marked-alt"></i>
                    Sổ địa chỉ
                </div>

                <c:choose>
                    <c:when test="${not empty listAddress}">
                        <div class="address-grid">
                            <c:forEach var="a" items="${listAddress}">
                                <div class="address-card ${a.type == 'main' ? 'address-card-main' : 'address-card-sub'}">
                                    <div class="address-badge">
                                        <c:choose>
                                            <c:when test="${a.type == 'main'}">
                                                <span class="badge-main"><i class="fas fa-star"></i> Địa chỉ chính</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-sub"><i class="fas fa-home"></i> Địa chỉ phụ</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="address-content">
                                        <div class="address-field">
                                            <i class="fas fa-qrcode field-icon"></i>
                                            <span class="field-label">Mã địa chỉ:</span>
                                            <span class="field-value">${a.id}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-tag field-icon"></i>
                                            <span class="field-label">Tên địa chỉ:</span>
                                            <span class="field-value">${a.nameAddress}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-road field-icon"></i>
                                            <span class="field-label">Đường:</span>
                                            <span class="field-value">${a.addressLine}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-map-pin field-icon"></i>
                                            <span class="field-label">Xã/Phường:</span>
                                            <span class="field-value">${a.wardName}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-building field-icon"></i>
                                            <span class="field-label">Quận/Huyện:</span>
                                            <span class="field-value">${a.districName}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-city field-icon"></i>
                                            <span class="field-label">Tỉnh/Thành phố:</span>
                                            <span class="field-value">${a.provinceName}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-address">
                            <i class="fas fa-map-marker-alt empty-icon"></i>
                            <p>Chưa có địa chỉ nào trong sổ</p>
                            <a href="${pageContext.request.contextPath}/profileEdit" class="btn-add-address">
                                <i class="fas fa-plus"></i> Thêm địa chỉ mới
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>