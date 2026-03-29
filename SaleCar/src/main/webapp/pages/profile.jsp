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
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar (Dùng chung từ profile.jsp) */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: #000000; color: #ffffff; padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 0 20px 20px; border-bottom: 1px solid #333333; text-align: center; }
        .sidebar-header h3 { color: #ffffff; font-size: 24px; font-weight: 600; margin: 0; }
        .sidebar-header p { color: #999999; font-size: 14px; margin-top: 5px; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: #ffffff; text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333333; color: #ffffff; }
        .menu-item.active { background-color: #ffffff; color: #000000; }
        .menu-item.active i { color: #000000; }
        .menu-divider { height: 1px; background-color: #333333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 600; color: #000000; margin-bottom: 10px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #666666; text-decoration: none; }
        .breadcrumb-item.active { color: #000000; font-weight: 500; }

        /* Profile Card */
        .profile-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .profile-cover {
            height: 150px;
            background: linear-gradient(135deg, #000000 0%, #333333 100%);
        }

        .profile-header {
            padding: 0 30px 20px;
            position: relative;
        }

        .avatar-section {
            position: relative;
            margin-top: -60px;
            margin-bottom: 20px;
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
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
        }

        .default-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #ffffff;
            background-color: #000000;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .edit-avatar-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #ffffff;
            border: 2px solid #000000;
            color: #000000;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .edit-avatar-btn:hover {
            background-color: #000000;
            color: #ffffff;
        }

        .profile-title {
            flex: 1;
            margin-left: 20px;
        }

        .profile-title h2 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #000000;
        }

        .profile-title .role-badge {
            display: inline-block;
            padding: 5px 12px;
            background-color: #f0f0f0;
            border: 1px solid #000000;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            color: #000000;
        }

        .edit-profile-btn {
            padding: 10px 25px;
            background-color: #000000;
            color: #ffffff;
            border: 2px solid #000000;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s;
        }

        .edit-profile-btn:hover {
            background-color: #ffffff;
            color: #000000;
        }

        /* Enhanced Info Sections */
        .info-section {
            padding: 30px;
            border-top: 1px solid #eeeeee;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            font-size: 20px;
            color: #000000;
        }

        /* Enhanced Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }

        .info-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 16px 20px;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }

        .info-card:hover {
            transform: translateX(5px);
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            border-color: #dee2e6;
        }

        .info-label {
            font-size: 12px;
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .info-label i {
            font-size: 12px;
        }

        .info-value {
            font-size: 15px;
            font-weight: 500;
            color: #212529;
            word-break: break-word;
        }

        .info-value.description {
            font-size: 14px;
            font-weight: 400;
            line-height: 1.6;
            color: #495057;
        }

        /* Status Badge Enhanced */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-active {
            background-color: #e7f3e8;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        .status-inactive {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
        }

        .role-badge {
            display: inline-block;
            padding: 5px 12px;
            background-color: #e9ecef;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            color: #495057;
        }

        /* Description Section */
        .description-section {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
            border: 1px solid #e9ecef;
        }

        .description-section .info-label {
            margin-bottom: 12px;
        }

        /* Address Grid Layout */
        .address-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 20px;
            margin-top: 15px;
        }

        /* Address Card */
        .address-card {
            background: white;
            border-radius: 12px;
            padding: 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
            overflow: hidden;
        }

        .address-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
        }

        .address-card-main {
            border-left: 4px solid #ffc107;
            background: linear-gradient(to right, #fff9e6, white);
        }

        .address-card-sub {
            border-left: 4px solid #17a2b8;
        }

        /* Badge Styles */
        .address-badge {
            padding: 12px 16px;
            border-bottom: 1px solid #f0f0f0;
        }

        .badge-main, .badge-sub {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-main {
            background: #fff3cd;
            color: #856404;
        }

        .badge-sub {
            background: #d1ecf1;
            color: #0c5460;
        }

        .badge-main i, .badge-sub i {
            font-size: 11px;
        }

        /* Address Content */
        .address-content {
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .address-field {
            display: flex;
            align-items: baseline;
            gap: 12px;
            font-size: 14px;
            line-height: 1.5;
            padding: 4px 0;
            border-bottom: 1px dashed #f0f0f0;
        }

        .address-field:last-child {
            border-bottom: none;
        }

        .field-icon {
            width: 20px;
            color: #6c757d;
            font-size: 14px;
            text-align: center;
        }

        .field-label {
            font-weight: 600;
            color: #495057;
            min-width: 100px;
            font-size: 13px;
        }

        .field-value {
            color: #212529;
            flex: 1;
            word-break: break-word;
        }

        /* Empty State */
        .empty-address {
            text-align: center;
            padding: 40px 20px;
            background: #f8f9fa;
            border-radius: 12px;
            margin-top: 15px;
        }

        .empty-icon {
            font-size: 48px;
            color: #adb5bd;
            margin-bottom: 15px;
        }

        .empty-address p {
            color: #6c757d;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .btn-add-address {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-add-address:hover {
            background: #0056b3;
            transform: translateY(-1px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .address-grid {
                grid-template-columns: 1fr;
            }

            .field-label {
                min-width: 85px;
            }

            .address-field {
                flex-wrap: wrap;
                gap: 6px;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .sidebar-menu {
                width: 0;
                display: none;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<%-- Include header --%>
<div class="profile-wrapper">
    <!-- Sidebar Menu -->
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">
                <i class="fas fa-chart-pie"></i>
                <span>Bảng điều khiển</span>
            </a>

            <a href="${pageContext.request.contextPath}/profile" class="menu-item active">
                <i class="fas fa-user-circle"></i>
                <span>Thông tin cá nhân</span>
            </a>

            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item">
                <i class="fas fa-user-edit"></i>
                <span>Chỉnh sửa thông tin</span>
            </a>

            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item">
                <i class="fas fa-lock"></i>
                <span>Đổi mật khẩu</span>
            </a>

            <a href="${pageContext.request.contextPath}/order" class="menu-item">
                <i class="fas fa-shopping-bag"></i>
                <span>Đơn hàng của tôi</span>
            </a>

            <a href="${pageContext.request.contextPath}/cart" class="menu-item">
                <i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span>
            </a>

            <a href="${pageContext.request.contextPath}/favorites" class="menu-item">
                <i class="fas fa-heart"></i>
                <span>Sản phẩm yêu thích</span>
            </a>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/address-list" class="menu-item">
                <i class="fas fa-map-marker-alt"></i>
                <span>Sổ địa chỉ</span>
            </a>

            <a href="${pageContext.request.contextPath}/notifications" class="menu-item">
                <i class="fas fa-bell"></i>
                <span>Thông báo</span>
            </a>

            <a href="${pageContext.request.contextPath}/settings" class="menu-item">
                <i class="fas fa-cog"></i>
                <span>Cài đặt</span>
            </a>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/loggout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
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

        <!-- Profile Card -->
        <div class="profile-card">
            <div class="profile-cover"></div>

            <div class="profile-header">
                <div class="avatar-section">
                    <div class="avatar-wrapper">
                        <c:choose>
                            <c:when test="${not empty user.imgURL}">
                                <img src="${pageContext.request.contextPath}/${user.imgURL}" class="profile-avatar" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png" class="profile-avatar" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/avatarEdit" class="edit-avatar-btn">
                            <i class="fas fa-camera"></i>
                        </a>
                    </div>

                    <div class="profile-title">
                        <h2>${user.getFullname()}</h2>
                        <span class="role-badge">${user.getRole()}</span>
                    </div>

                    <a href="${pageContext.request.contextPath}/profileEdit" class="edit-profile-btn">
                        <i class="fas fa-edit"></i> Chỉnh sửa
                    </a>
                </div>
            </div>

            <!-- User Information from USER table - Enhanced -->
            <div class="info-section">
                <h3 class="section-title">
                    <i class="fas fa-user-circle"></i>
                    Thông tin tài khoản
                </h3>

                <div class="info-grid">
                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-id-card"></i>
                            ID người dùng
                        </div>
                        <div class="info-value">${user.getId()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-user-tag"></i>
                            Tên đăng nhập
                        </div>
                        <div class="info-value">${user.getUsername()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-user"></i>
                            Họ và tên
                        </div>
                        <div class="info-value">${user.getFullname()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-envelope"></i>
                            Email
                        </div>
                        <div class="info-value">${user.getEmail()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-phone"></i>
                            Số điện thoại
                        </div>
                        <div class="info-value">${user.getPhonenumber()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-briefcase"></i>
                            Vai trò
                        </div>
                        <div class="info-value">
                            <span class="role-badge">${user.getRole()}</span>
                        </div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-circle-info"></i>
                            Trạng thái
                        </div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${user.getStatus()==true}">
                                    <span class="status-badge status-active">
                                        <i class="fas fa-check-circle"></i> Hoạt động
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">
                                        <i class="fas fa-times-circle"></i> Không hoạt động
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-map-marker-alt"></i>
                            Địa chỉ mặc định
                        </div>
                        <div class="info-value">${user.getAddressid()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-calendar-plus"></i>
                            Ngày tạo
                        </div>
                        <div class="info-value">${user.getCreatedat()}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">
                            <i class="fas fa-calendar-alt"></i>
                            Cập nhật lần cuối
                        </div>
                        <div class="info-value">${user.getUpdatedat()}</div>
                    </div>
                </div>

                <!-- Description Section - Enhanced -->
                <div class="description-section">
                    <div class="info-label">
                        <i class="fas fa-align-left"></i>
                        Mô tả
                    </div>
                    <div class="info-value description">
                        ${not empty user.getDescription() ? user.getDescription() : 'Chưa có mô tả'}
                    </div>
                </div>
            </div>

            <!-- Address Information from ADDRESS table - Enhanced -->
            <div class="info-section">
                <h3 class="section-title">
                    <i class="fas fa-map-marker-alt"></i>
                    Sổ địa chỉ
                </h3>

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
                                            <span class="field-value">${a.name}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-road field-icon"></i>
                                            <span class="field-label">Đường:</span>
                                            <span class="field-value">${a.street}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-map-pin field-icon"></i>
                                            <span class="field-label">Xã/Phường:</span>
                                            <span class="field-value">${a.commune}</span>
                                        </div>
                                        <div class="address-field">
                                            <i class="fas fa-city field-icon"></i>
                                            <span class="field-label">Tỉnh/Thành phố:</span>
                                            <span class="field-value">${a.province}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-address">
                            <i class="fas fa-map-marker-alt empty-icon"></i>
                            <p>Chưa có địa chỉ nào</p>
                            <button class="btn-add-address">Thêm địa chỉ mới</button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/footer.jsp" %>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>