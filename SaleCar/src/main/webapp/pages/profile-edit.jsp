<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa thông tin - LUXCAR</title>

    <%-- Include header --%>
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


        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">
                <i class="fas fa-chart-pie"></i>
                <span>Bảng điều khiển</span>
            </a>

            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                <i class="fas fa-user-circle"></i>
                <span>Thông tin cá nhân</span>
            </a>

            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item active">
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

        <!-- Edit Form Card -->
        <div class="form-card">
            <form action="/profileEdit" method="post" >
                <!-- Avatar Upload Section -->
                <div class="avatar-upload-section">
                    <div class="current-avatar">
                        <span>ND</span>
                    </div>

                    <div class="upload-btn-wrapper">
                        <a href="${pageContext.request.contextPath}/avatar-edit" class="btn-upload">
                            <i class="fas fa-camera"></i> Thay đổi ảnh đại diện
                        </a>
                    </div>

                    <div class="upload-hint">
                        Hỗ trợ: JPG, PNG, GIF. Tối đa 5MB. Ảnh vuông sẽ hiển thị đẹp nhất.
                    </div>
                </div>

                <!-- User Information Section (USER table) -->
                <div class="form-section address-box">
                    <h3 class="form-section-title">
                        <i class="fas fa-user"></i> Thông tin tài khoản (USER)
                    </h3>

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
                            <input type="text" class="form-control" name="fullname" value="${user.getFullname()}" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" value="${user.getEmail()}" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="phoneNumber" value="${user.getPhonenumber()}">
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
                            <textarea class="form-control" name="description">${user.getDescription()}</textarea>
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
                                <c:choose>
                                    <c:when test="${not empty listAddress}">
                                        <c:forEach var="a" items="${listAddress}" >
                                            <c:choose>
                                                <c:when test="${a.type=='main'}">
                                                    <option value="${a.id}" selected>${a.id}- ${a.name}-địa chỉ chính</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${a.id}">${a.id}- ${a.name}-địa chỉ phụ</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="0" selected>chưa có địa chỉ</option>
                                    </c:otherwise>
                                </c:choose>


                            </select>
                        </div>
                    </div>
                </div>

                <!-- Address Information Section (ADDRESS table) -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ (ADDRESS)
                    </h3>

                    <c:choose>
                        <c:when test="${not empty listAddress}">
                            <c:forEach var="a" items="${listAddress}">
                                <c:choose>
                                    <c:when test="${a.type=='main'}">
                                        <!-- Main Address -->
                                        <div class="address-box">
                                            <div class="address-box-header">
                                                <h4>Địa chỉ chính: ${a.name} (id = ${a.id})</h4>
                                                <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal${a.id}">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                                <div class="modal fade" id="confirmDeleteModal${a.id}" tabindex="-1">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Xác nhận xóa</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>

                                                            <div class="modal-body">
                                                                Bạn có chắc muốn xóa địa chỉ này không?
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                                    Hủy
                                                                </button>
                                                                <input type="hidden" name="id" value="${a.id}">
                                                                <a href="/removeAddress?id=${a.id}" type="submit" class="btn btn-danger">
                                                                    Xóa
                                                                </a>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>


                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Số nhà, tên đường</label>
                                                    <input type="text" class="form-control" name="street${a.id}" value="${a.street}">
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Xã/Phường</label>
                                                    <input type="text" class="form-control" name="commune${a.id}" value="${a.commune}">
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Tỉnh/Thành phố</label>
                                                    <input type="text" class="form-control" name="province${a.id}" value="${a.province}">
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Secondary Address -->
                                        <div class="address-box">
                                            <div class="address-box-header">
                                                <h4>Địa chỉ phụ: ${a.name} (id = ${a.id})</h4>
                                                <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal${a.id}">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                                <div class="modal fade" id="confirmDeleteModal${a.id}" tabindex="-1">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Xác nhận xóa</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>

                                                            <div class="modal-body">
                                                                Bạn có chắc muốn xóa địa chỉ này không?
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                                    Hủy
                                                                </button>
                                                                    <input type="hidden" name="id" value="${a.id}">
                                                                    <a href="/removeAddress?id=${a.id}" type="submit" class="btn btn-danger">
                                                                        Xóa
                                                                    </a>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Số nhà, tên đường</label>
                                                    <input type="text" class="form-control" name="street${a.id}" value="${a.street}">
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Xã/Phường</label>
                                                    <input type="text" class="form-control" name="commune${a.id}" value="${a.commune}">
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Tỉnh/Thành phố</label>
                                                    <input type="text" class="form-control" name="province${a.id}" value="${a.province}">
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Main Address -->
                            <div class="address-box">
                                <div class="address-box-header">
                                    <h4>chưa có địa chỉ</h4>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <!-- Add new address button -->
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                        <i class="fas fa-plus"></i> Thêm địa chỉ
                    </button>

                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="/profile" class="btn-cancel">
                        <i class="fas fa-times"></i> Hủy bỏ
                    </a>
                    <button type="submit" class="btn-save">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                </div>
            </form>

            <div class="modal fade" id="addAddressModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm địa chỉ mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/addAddress" method="post">
                            <div class="modal-body">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">tên địa chỉ <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="name" placeholder="ví dụ: địa chỉ nhà, công ty, vv" required>
                                </div>
                                <label class="form-label">Loại địa chỉ</label>
                                <select class="form-select" name="type">
                                    <option value="normal" selected>địa chỉ phụ</option>
                                    <option value="main" >địa chỉ chính</option>
                                </select>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Số nhà, tên đường</label>
                                        <input type="text" class="form-control" name="street" >
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Xã/Phường</label>
                                        <input type="text" class="form-control" name="commune" >
                                    </div>

                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Tỉnh/Thành phố</label>
                                        <input type="text" class="form-control" name="province" >
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                    Hủy
                                </button>
                                <button type="submit" class="btn btn-success">
                                    Thêm địa chỉ
                                </button>
                            </div>
                        </form>
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