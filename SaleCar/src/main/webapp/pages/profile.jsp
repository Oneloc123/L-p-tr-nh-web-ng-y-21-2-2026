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

        /* ── Layout chính (giữ nguyên sidebar) ── */
        .profile-wrapper {
            display: flex;
            align-items: flex-start;
            min-height: 100vh;
        }

        /* Sidebar (giữ nguyên từ yêu cầu) */
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
        /* KHU VỰC NỘI DUNG CHÍNH (ĐÃ NÂNG CẤP)          */
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

        /* Profile Card chính */
        .profile-card {
            background: #fff;
            border-radius: 28px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: all 0.2s;
        }

        /* Cover gradient */
        .profile-cover {
            height: 140px;
            background: linear-gradient(135deg, #0a0a0a 0%, #2d2d2d 100%);
        }

        /* Header avatar & thông tin */
        .profile-header {
            padding: 0 32px 24px;
            position: relative;
        }

        .avatar-section {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: -60px;
            margin-bottom: 20px;
        }

        .avatar-wrapper {
            position: relative;
            display: inline-block;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.15);
            background: #f0f2f5;
        }

        .edit-avatar-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid #000;
            color: #000;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            font-size: 14px;
        }

        .edit-avatar-btn:hover {
            background: #000;
            color: #fff;
            transform: scale(1.05);
        }

        .profile-title {
            flex: 1;
        }

        .profile-title h2 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 6px;
            color: #111;
        }

        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #f1f5f9;
            padding: 6px 14px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            color: #1e293b;
        }

        .edit-profile-btn {
            background: #000;
            color: #fff;
            border: none;
            padding: 10px 24px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .edit-profile-btn:hover {
            background: #2c2c2c;
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.1);
            color: #fff;
        }

        /* Info section */
        .info-section {
            padding: 28px 32px;
            border-top: 1px solid #edf2f7;
        }

        .section-title {
            font-size: 20px;
            font-weight: 700;
            color: #111;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 24px;
        }

        .section-title i {
            font-size: 20px;
            color: #000;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-card {
            background: #fafcff;
            border: 1px solid #eef2f8;
            border-radius: 20px;
            padding: 18px 20px;
            transition: all 0.25s ease;
        }

        .info-card:hover {
            border-color: #cbd5e1;
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
        }

        .info-label {
            font-size: 12px;
            font-weight: 700;
            color: #5b6e8c;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-label i {
            font-size: 13px;
            width: 18px;
        }

        .info-value {
            font-size: 15px;
            font-weight: 500;
            color: #1e293b;
            word-break: break-word;
        }

        .info-value.description {
            font-size: 14px;
            font-weight: 400;
            line-height: 1.5;
            color: #334155;
        }

        /* Status badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background: #e3f7ec;
            color: #1e7b48;
        }

        .status-inactive {
            background: #feeceb;
            color: #c2412c;
        }

        /* Description section riêng */
        .description-section {
            margin-top: 24px;
            background: #fafcff;
            border-radius: 20px;
            padding: 20px 24px;
            border: 1px solid #eef2f8;
        }

        .description-section .info-label {
            margin-bottom: 12px;
        }

        /* Address grid */
        .address-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 24px;
            margin-top: 8px;
        }

        /* Address card */
        .address-card {
            background: #fff;
            border-radius: 20px;
            border: 1px solid #edf2f8;
            overflow: hidden;
            transition: all 0.25s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.02);
        }

        .address-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -12px rgba(0, 0, 0, 0.1);
            border-color: #dce3ec;
        }

        .address-card-main {
            border-left: 4px solid #f5b042;
        }

        .address-card-sub {
            border-left: 4px solid #2d9cdb;
        }

        .address-badge {
            padding: 14px 18px;
            background: #fefefe;
            border-bottom: 1px solid #edf2f8;
        }

        .badge-main, .badge-sub {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 5px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-main {
            background: #fff2e0;
            color: #b45f06;
        }

        .badge-sub {
            background: #e6f4ff;
            color: #0c6b9e;
        }

        .address-content {
            padding: 18px;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .address-field {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            font-size: 14px;
            border-bottom: 1px dashed #f0f3f8;
            padding-bottom: 8px;
        }

        .address-field:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .field-icon {
            width: 24px;
            color: #7e8c9e;
            font-size: 14px;
            text-align: center;
            margin-top: 2px;
        }

        .field-label {
            font-weight: 600;
            color: #334155;
            min-width: 100px;
            font-size: 13px;
        }

        .field-value {
            color: #1e293b;
            flex: 1;
            word-break: break-word;
        }

        /* Empty state */
        .empty-address {
            text-align: center;
            padding: 48px 24px;
            background: #fafcff;
            border-radius: 24px;
            margin-top: 12px;
            border: 1px solid #edf2f8;
        }

        .empty-icon {
            font-size: 56px;
            color: #b9c3d0;
            margin-bottom: 16px;
        }

        .empty-address p {
            color: #5b6e8c;
            font-size: 15px;
            margin-bottom: 20px;
        }

        .btn-add-address {
            background: #000;
            color: #fff;
            border: none;
            padding: 10px 26px;
            border-radius: 40px;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.2s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add-address:hover {
            background: #2c2c2c;
            transform: translateY(-2px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar-menu {
                display: none;
            }
            .main-content {
                padding: 20px;
            }
            .profile-header {
                padding: 0 20px 20px;
            }
            .info-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }
            .address-grid {
                grid-template-columns: 1fr;
            }
            .avatar-section {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            .profile-title {
                text-align: center;
            }
            .edit-profile-btn {
                align-self: center;
            }
            .address-field {
                flex-wrap: wrap;
                gap: 6px;
            }
            .field-label {
                min-width: 85px;
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
            <a href="${pageContext.request.contextPath}/profile" class="menu-item active"><i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span></a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item"><i class="fas fa-user-edit"></i><span>Chỉnh sửa thông tin</span></a>
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