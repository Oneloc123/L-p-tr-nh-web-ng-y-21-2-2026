<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cá nhân - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        /* Main layout */
        .profile-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Menu */
        .sidebar-menu {
            width: 280px;
            background-color: #000000;
            color: #ffffff;
            padding: 30px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid #333333;
            text-align: center;
        }

        .sidebar-header h3 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }

        .sidebar-header p {
            color: #999999;
            font-size: 14px;
            margin-top: 5px;
        }

        .menu-items {
            padding: 20px 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 25px;
            color: #ffffff;
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
            background-color: #333333;
            color: #ffffff;
        }

        .menu-item.active {
            background-color: #ffffff;
            color: #000000;
        }

        .menu-item.active i {
            color: #000000;
        }

        .menu-divider {
            height: 1px;
            background-color: #333333;
            margin: 15px 20px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 30px;
        }

        .content-header {
            margin-bottom: 30px;
        }

        .content-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 10px;
        }

        .content-header .breadcrumb {
            background: none;
            padding: 0;
            margin: 0;
        }

        .breadcrumb-item a {
            color: #666666;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #000000;
            font-weight: 500;
        }

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
            border: 4px solid #ffffff;
            background-color: #f0f0f0;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
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

        /* Info Sections */
        .info-section {
            padding: 30px;
            border-top: 1px solid #eeeeee;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 20px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            margin-bottom: 15px;
        }

        .info-label {
            font-size: 13px;
            color: #666666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .info-value {
            font-size: 16px;
            font-weight: 500;
            color: #000000;
        }

        .info-value.description {
            line-height: 1.6;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .address-box {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            margin-top: 10px;
        }

        .address-item {
            display: flex;
            margin-bottom: 10px;
        }

        .address-item i {
            width: 25px;
            color: #000000;
            font-size: 16px;
        }

        .date-info {
            display: flex;
            gap: 30px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eeeeee;
        }

        .date-item {
            text-align: center;
        }

        .date-label {
            font-size: 12px;
            color: #666666;
            text-transform: uppercase;
        }

        .date-value {
            font-size: 14px;
            font-weight: 500;
            color: #000000;
            margin-top: 5px;
        }

        /* Sample data for demo */
        .sample-data {
            background-color: #f0f0f0;
            border-left: 4px solid #000000;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-size: 13px;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 768px) {
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
<div class="profile-wrapper">
    <!-- Sidebar Menu -->
    <div class="sidebar-menu">
        <div class="sidebar-header">
            <h3>LUXCAR</h3>
            <p>Mô hình xe cao cấp</p>
        </div>

        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="menu-item">
                <i class="fas fa-chart-pie"></i>
                <span>Bảng điều khiển</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/profile.jsp" class="menu-item active">
                <i class="fas fa-user-circle"></i>
                <span>Thông tin cá nhân</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/profile-edit.jsp" class="menu-item">
                <i class="fas fa-user-edit"></i>
                <span>Chỉnh sửa thông tin</span>
            </a>

            <a href="${pageContext.request.contextPath}/change-password.jsp" class="menu-item">
                <i class="fas fa-lock"></i>
                <span>Đổi mật khẩu</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/orders.jsp" class="menu-item">
                <i class="fas fa-shopping-bag"></i>
                <span>Đơn hàng của tôi</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/wishlist.jsp" class="menu-item">
                <i class="fas fa-heart"></i>
                <span>Sản phẩm yêu thích</span>
            </a>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/user/address-list.jsp" class="menu-item">
                <i class="fas fa-map-marker-alt"></i>
                <span>Sổ địa chỉ</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/notifications.jsp" class="menu-item">
                <i class="fas fa-bell"></i>
                <span>Thông báo</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/settings.jsp" class="menu-item">
                <i class="fas fa-cog"></i>
                <span>Cài đặt</span>
            </a>

            <div class="menu-divider"></div>

            <a href="${pageContext.request.contextPath}/logout.jsp" class="menu-item">
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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/dashboard.jsp">Tài khoản</a></li>
                    <li class="breadcrumb-item active">Thông tin cá nhân</li>
                </ol>
            </nav>
        </div>

        <!-- Sample Data Notice (for demo) -->
        <div class="sample-data">
            <i class="fas fa-info-circle"></i>
            Đây là dữ liệu mẫu minh họa từ bảng USER và ADDRESS
        </div>

        <!-- Profile Card -->
        <div class="profile-card">
            <div class="profile-cover"></div>

            <div class="profile-header">
                <div class="avatar-section">
                    <div class="avatar-wrapper">
                        <div class="default-avatar">
                            <span>ND</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/user/avatar-edit.jsp" class="edit-avatar-btn">
                            <i class="fas fa-camera"></i>
                        </a>
                    </div>

                    <div class="profile-title">
                        <h2>Nguyễn Văn An</h2>
                        <span class="role-badge">ROLE_USER</span>
                    </div>

                    <a href="${pageContext.request.contextPath}/user/profile-edit.jsp" class="edit-profile-btn">
                        <i class="fas fa-edit"></i> Chỉnh sửa
                    </a>
                </div>
            </div>

            <!-- User Information from USER table -->
            <div class="info-section">
                <h3 class="section-title">
                    <i class="fas fa-user"></i>
                    Thông tin tài khoản (USER)
                </h3>

                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">ID người dùng</div>
                        <div class="info-value">USR001</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Tên đăng nhập</div>
                        <div class="info-value">nguyenvanan</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Họ và tên</div>
                        <div class="info-value">Nguyễn Văn An</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">nguyenvanan@email.com</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Số điện thoại</div>
                        <div class="info-value">0987654321</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Vai trò</div>
                        <div class="info-value">
                            <span class="role-badge">ROLE_USER</span>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Trạng thái</div>
                        <div class="info-value">
                                <span class="status-badge status-active">
                                    <i class="fas fa-check-circle"></i> Hoạt động
                                </span>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Address ID</div>
                        <div class="info-value">ADD001</div>
                    </div>
                </div>

                <div class="info-item" style="margin-top: 20px;">
                    <div class="info-label">Mô tả</div>
                    <div class="info-value description">
                        Người dùng đam mê mô hình xe hơi, đặc biệt là các dòng xe thể thao và siêu xe.
                    </div>
                </div>

                <div class="date-info">
                    <div class="date-item">
                        <div class="date-label">Ngày tạo</div>
                        <div class="date-value">15/01/2024</div>
                    </div>
                    <div class="date-item">
                        <div class="date-label">Cập nhật lần cuối</div>
                        <div class="date-value">20/02/2024</div>
                    </div>
                </div>
            </div>

            <!-- Address Information from ADDRESS table -->
            <div class="info-section" style="border-top: 2px solid #000000;">
                <h3 class="section-title">
                    <i class="fas fa-map-marker-alt"></i>
                    Thông tin địa chỉ (ADDRESS)
                </h3>

                <div class="address-box">
                    <div class="address-item">
                        <i class="fas fa-hashtag"></i>
                        <div><strong>ID:</strong> ADD001</div>
                    </div>
                    <div class="address-item">
                        <i class="fas fa-road"></i>
                        <div><strong>Đường:</strong> 123 Đường Lê Lợi</div>
                    </div>
                    <div class="address-item">
                        <i class="fas fa-map-pin"></i>
                        <div><strong>Xã/Phường:</strong> Phường Bến Nghé</div>
                    </div>
                    <div class="address-item">
                        <i class="fas fa-city"></i>
                        <div><strong>Tỉnh/Thành phố:</strong> Quận 1, TP. Hồ Chí Minh</div>
                    </div>
                </div>

                <!-- Additional sample addresses -->
                <div style="margin-top: 20px;">
                    <h4 style="font-size: 16px; font-weight: 600; margin-bottom: 15px;">Địa chỉ khác</h4>

                    <div class="address-box" style="margin-top: 0;">
                        <div class="address-item">
                            <i class="fas fa-hashtag"></i>
                            <div><strong>ID:</strong> ADD002</div>
                        </div>
                        <div class="address-item">
                            <i class="fas fa-road"></i>
                            <div><strong>Đường:</strong> 456 Đường Nguyễn Huệ</div>
                        </div>
                        <div class="address-item">
                            <i class="fas fa-map-pin"></i>
                            <div><strong>Xã/Phường:</strong> Phường Bến Thành</div>
                        </div>
                        <div class="address-item">
                            <i class="fas fa-city"></i>
                            <div><strong>Tỉnh/Thành phố:</strong> Quận 1, TP. Hồ Chí Minh</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>