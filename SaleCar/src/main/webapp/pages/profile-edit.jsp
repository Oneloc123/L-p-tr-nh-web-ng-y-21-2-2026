<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa thông tin - LUXCAR</title>

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

        /* Form Card */
        .form-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .form-header {
            padding: 25px 30px;
            border-bottom: 1px solid #eeeeee;
        }

        .form-header h2 {
            font-size: 20px;
            font-weight: 600;
            color: #000000;
            margin: 0;
        }

        .form-header p {
            color: #666666;
            font-size: 14px;
            margin-top: 5px;
        }

        .form-body {
            padding: 30px;
        }

        .form-section {
            margin-bottom: 40px;
        }

        .form-section-title {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #000000;
        }

        .form-label {
            font-weight: 500;
            color: #000000;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 10px 15px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: #000000;
            box-shadow: none;
        }

        .form-control.is-invalid {
            border-color: #dc3545;
        }

        .invalid-feedback {
            font-size: 13px;
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        /* Avatar Upload */
        .avatar-upload-section {
            background-color: #f8f9fa;
            border: 2px dashed #000000;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            margin-bottom: 30px;
        }

        .current-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px;
            background-color: #000000;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: 600;
            border: 4px solid #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .current-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .upload-btn-wrapper {
            position: relative;
            display: inline-block;
        }

        .btn-upload {
            padding: 10px 25px;
            background-color: #000000;
            color: #ffffff;
            border: 2px solid #000000;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-block;
            text-decoration: none;
        }

        .btn-upload:hover {
            background-color: #ffffff;
            color: #000000;
        }

        .upload-hint {
            font-size: 12px;
            color: #666666;
            margin-top: 10px;
        }

        /* Address Box */
        .address-box {
            background-color: #f8f9fa;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }

        .address-box-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .address-box-header h4 {
            font-size: 16px;
            font-weight: 600;
            margin: 0;
        }

        .btn-remove-address {
            color: #dc3545;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-add-address {
            color: #000000;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: inline-block;
            margin-top: 15px;
        }

        .btn-add-address i {
            margin-right: 5px;
        }

        /* Form Actions */
        .form-actions {
            padding: 30px;
            background-color: #f8f9fa;
            border-top: 1px solid #eeeeee;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .btn-save {
            padding: 12px 30px;
            background-color: #000000;
            color: #ffffff;
            border: 2px solid #000000;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
        }

        .btn-save:hover {
            background-color: #ffffff;
            color: #000000;
        }

        .btn-cancel {
            padding: 12px 30px;
            background-color: #ffffff;
            color: #000000;
            border: 2px solid #000000;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background-color: #f0f0f0;
        }

        /* Status options */
        .status-options {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .status-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-option input[type="radio"] {
            width: 18px;
            height: 18px;
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

            .form-actions {
                flex-direction: column;
            }

            .btn-save, .btn-cancel {
                width: 100%;
                text-align: center;
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

            <a href="${pageContext.request.contextPath}/user/profile.jsp" class="menu-item">
                <i class="fas fa-user-circle"></i>
                <span>Thông tin cá nhân</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/profile-edit.jsp" class="menu-item active">
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
            <h1>Chỉnh sửa thông tin</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/dashboard.jsp">Tài khoản</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/profile.jsp">Thông tin cá nhân</a></li>
                    <li class="breadcrumb-item active">Chỉnh sửa</li>
                </ol>
            </nav>
        </div>

        <!-- Edit Form Card -->
        <div class="form-card">
            <form action="#" method="post" enctype="multipart/form-data">
                <!-- Avatar Upload Section -->
                <div class="avatar-upload-section">
                    <div class="current-avatar">
                        <span>ND</span>
                    </div>

                    <div class="upload-btn-wrapper">
                        <a href="${pageContext.request.contextPath}/user/avatar-edit.jsp" class="btn-upload">
                            <i class="fas fa-camera"></i> Thay đổi ảnh đại diện
                        </a>
                    </div>

                    <div class="upload-hint">
                        Hỗ trợ: JPG, PNG, GIF. Tối đa 5MB. Ảnh vuông sẽ hiển thị đẹp nhất.
                    </div>
                </div>

                <!-- User Information Section (USER table) -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-user"></i> Thông tin tài khoản (USER)
                    </h3>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">ID người dùng</label>
                            <input type="text" class="form-control" value="USR001" readonly disabled>
                            <small class="text-muted">ID không thể thay đổi</small>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" value="nguyenvanan" readonly disabled>
                            <small class="text-muted">Tên đăng nhập không thể thay đổi</small>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="fullname" value="Nguyễn Văn An" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" value="nguyenvanan@email.com" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="phoneNumber" value="0987654321">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Vai trò</label>
                            <select class="form-select" name="role" disabled>
                                <option value="ROLE_USER" selected>ROLE_USER</option>
                                <option value="ROLE_ADMIN">ROLE_ADMIN</option>
                            </select>
                            <small class="text-muted">Vai trò chỉ được thay đổi bởi Admin</small>
                        </div>

                        <div class="col-12 mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description">Người dùng đam mê mô hình xe hơi, đặc biệt là các dòng xe thể thao và siêu xe.</textarea>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Trạng thái</label>
                            <div class="status-options">
                                <label class="status-option">
                                    <input type="radio" name="status" value="active" checked>
                                    <span class="status-badge status-active">Hoạt động</span>
                                </label>
                                <label class="status-option">
                                    <input type="radio" name="status" value="inactive">
                                    <span class="status-badge status-inactive">Không hoạt động</span>
                                </label>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Address ID</label>
                            <select class="form-select" name="addressId">
                                <option value="ADD001" selected>ADD001 - Địa chỉ chính</option>
                                <option value="ADD002">ADD002 - Địa chỉ phụ</option>
                                <option value="ADD003">ADD003 - Địa chỉ công ty</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Address Information Section (ADDRESS table) -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ (ADDRESS)
                    </h3>

                    <!-- Main Address -->
                    <div class="address-box">
                        <div class="address-box-header">
                            <h4>Địa chỉ chính (ADD001)</h4>
                            <button type="button" class="btn-remove-address" onclick="return confirm('Xóa địa chỉ này?')">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Số nhà, tên đường</label>
                                <input type="text" class="form-control" name="street" value="123 Đường Lê Lợi">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Xã/Phường</label>
                                <input type="text" class="form-control" name="commune" value="Phường Bến Nghé">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Tỉnh/Thành phố</label>
                                <input type="text" class="form-control" name="province" value="Quận 1, TP. Hồ Chí Minh">
                            </div>
                        </div>
                    </div>

                    <!-- Secondary Address -->
                    <div class="address-box">
                        <div class="address-box-header">
                            <h4>Địa chỉ phụ (ADD002)</h4>
                            <button type="button" class="btn-remove-address" onclick="return confirm('Xóa địa chỉ này?')">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Số nhà, tên đường</label>
                                <input type="text" class="form-control" name="street2" value="456 Đường Nguyễn Huệ">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Xã/Phường</label>
                                <input type="text" class="form-control" name="commune2" value="Phường Bến Thành">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Tỉnh/Thành phố</label>
                                <input type="text" class="form-control" name="province2" value="Quận 1, TP. Hồ Chí Minh">
                            </div>
                        </div>
                    </div>

                    <!-- Add new address button -->
                    <a href="#" class="btn-add-address">
                        <i class="fas fa-plus-circle"></i> Thêm địa chỉ mới
                    </a>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/user/profile.jsp" class="btn-cancel">
                        <i class="fas fa-times"></i> Hủy bỏ
                    </a>
                    <button type="submit" class="btn-save">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>