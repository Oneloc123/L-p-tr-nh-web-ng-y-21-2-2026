<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Người dùng | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* AVATAR SECTION CẢI TIẾN */
        .avatar-upload-section {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid #e9ecef;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .current-avatar {
            position: relative;
            display: inline-block;
        }

        .current-avatar img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #2c7da0;
            object-fit: cover;
            box-shadow: 0 0 12px rgba(44,125,160,0.2);
            transition: all 0.3s ease;
        }

        .current-avatar img:hover {
            transform: scale(1.05);
            box-shadow: 0 0 18px rgba(44,125,160,0.3);
        }

        .upload-btn-wrapper {
            margin-top: 15px;
        }

        .btn-upload {
            display: inline-block;
            background: linear-gradient(135deg, #2c7da0, #1f5e7a);
            color: #fff;
            padding: 10px 24px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 6px rgba(44,125,160,0.2);
        }

        .btn-upload:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(44,125,160,0.3);
            background: linear-gradient(135deg, #1f5e7a, #2c7da0);
        }

        .btn-upload i {
            margin-right: 8px;
        }

        .upload-hint {
            font-size: 12px;
            color: #7c8b9c;
            margin-top: 10px;
        }

        #uploadPreview {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 8px 12px;
            display: inline-block;
            margin-top: 10px;
        }

        #uploadPreview .alert {
            margin: 0;
            padding: 8px 12px;
            font-size: 13px;
        }

        /* Hiệu ứng khi drag & drop */
        .avatar-upload-section.drag-over {
            border: 2px dashed #2c7da0;
            background: rgba(44,125,160,0.05);
            transition: all 0.3s ease;
        }
        /* FORM CARD */
        .form-card {
            padding: 25px;
        }

        /* SECTION */
        .form-section {
            background: #ffffff;
            border: 1px solid #e9ecef;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            position: relative;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        /* TITLE */
        .form-section-title {
            font-size: 14px;
            font-weight: 600;
            color: #2c7da0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ADDRESS BOX */
        .address-box {
            border: 1px solid #e9ecef;
            border-radius: 16px;
            padding: 15px;
            margin-top: 10px;
            background: #fafcfd;
            transition: 0.2s;
        }

        .address-box:hover {
            border-color: #2c7da0;
            box-shadow: 0 0 10px rgba(44,125,160,0.08);
        }

        /* HEADER ADDRESS */
        .address-box-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .address-box-header h4 {
            font-size: 14px;
            color: #2c7da0;
            margin: 0;
        }

        /* BUTTON DELETE - HIỂN THỊ RÕ RÀNG */
        .btn-remove-address {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
            color: white;
            font-size: 13px;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 2px 4px rgba(220, 53, 69, 0.2);
        }

        .btn-remove-address i {
            font-size: 12px;
        }

        .btn-remove-address:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            color: white;
        }

        .btn-remove-address:active {
            transform: translateY(0);
        }

        /* STATUS RADIO */
        .status-options {
            display: flex;
            gap: 10px;
        }

        .status-option {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* ACTION BUTTONS */
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-save {
            background: #2c7da0;
            border: none;
            padding: 8px 18px;
            border-radius: 30px;
            color: white;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-save:hover {
            background: #1f5e7a;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2);
        }

        .btn-cancel {
            border: 1px solid #e2e8f0;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            text-decoration: none;
            background: transparent;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            border-color: #2c7da0;
            color: #2c7da0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .profile-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 1.5px solid #2c7da0;
            box-shadow: 0 0 4px rgba(44,125,160,0.2);
        }

        .profile-avatar-lg {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #2c7da0;
            box-shadow: 0 0 10px rgba(44,125,160,0.2);
        }

        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }

        .sidebar {
            width: 280px;
            background-color: #ffffff;
            border-right: 1px solid #e9edf2;
            height: 100vh;
            position: sticky;
            top: 0;
            padding: 2rem 1.2rem;
            transition: all 0.3s;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1e2a3a, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 2.5rem;
            letter-spacing: -0.5px;
        }

        .logo i {
            background: none;
            color: #2c7da0;
            -webkit-background-clip: unset;
            background-clip: unset;
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
        }

        .sidebar nav ul li {
            margin-bottom: 0.6rem;
        }

        .sidebar nav ul li a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 18px;
            border-radius: 14px;
            color: #5a6e7c;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 0.95rem;
        }

        .sidebar nav ul li a i {
            font-size: 1.3rem;
            width: 24px;
        }

        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #f0f9ff;
            color: #2c7da0;
            box-shadow: 0 2px 4px rgba(44,125,160,0.08);
            border-left: 2px solid #2c7da0;
        }

        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }

        .header {
            background: #ffffff;
            padding: 1rem 1.8rem;
            border-radius: 24px;
            margin-bottom: 2rem;
            border: 1px solid #e9edf2;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .btn-primary {
            background-color: #2c7da0;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
        }

        .btn-primary:hover {
            background-color: #1f5e7a;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2);
        }

        .card {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .card-body {
            padding: 1.2rem;
        }

        .form-control, .form-select {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            color: #1e293b;
            border-radius: 14px;
            padding: 10px 16px;
        }

        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
            color: #1e293b;
        }

        .status-badge, .role-badge {
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            letter-spacing: 0.3px;
        }

        .status-active {
            background-color: #e6f7ec;
            color: #2e7d5e;
            border: 0.5px solid #b8e0c2;
        }

        .status-inactive {
            background-color: #fff0f0;
            color: #c75c5c;
            border: 0.5px solid #f0c0c0;
        }

        .modal-content {
            background-color: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 28px;
            color: #1e293b;
        }

        .modal-header {
            border-bottom-color: #eef2f6;
        }

        .modal-footer {
            border-top-color: #eef2f6;
        }

        .btn-close {
            filter: none;
        }

        .text-muted {
            color: #7c8b9c !important;
        }

        .alert-warning {
            background-color: #fff8e8;
            border-color: #ffe0b2;
            color: #c9772e;
        }

        .alert-info {
            background-color: #eef2ff;
            border-color: #cbdff2;
            color: #2c5f8a;
        }

        .btn-success {
            background-color: #2e7d5e;
            border: none;
        }

        .btn-success:hover {
            background-color: #236b4f;
        }

        .btn-secondary {
            background-color: #e2e8f0;
            border: none;
            color: #475569;
        }

        .btn-secondary:hover {
            background-color: #cbd5e1;
            color: #1e293b;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 1rem 0.5rem;
            }
            .sidebar .logo span {
                display: none;
            }
            .sidebar nav ul li a span {
                display: none;
            }
            .sidebar nav ul li a i {
                font-size: 1.5rem;
            }
        }
    </style>
</head>

<body>
<div class="d-flex">
    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2 class="logo"><i class="bi bi-car-front-fill me-2"></i><span>LUXCAR Admin</span></h2>
        <nav>
            <ul>
                <li><a href="dashboard"><i class="bi bi-speedometer2"></i><span> Dashboard</span></a></li>
                <li><a href="products"><i class="bi bi-box"></i><span> Sản phẩm</span></a></li>
                <li><a href="categories"><i class="bi bi-tags"></i><span> Danh mục</span></a></li>
                <li><a href="orders"><i class="bi bi-cart"></i><span> Đơn hàng</span></a></li>
                <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i><span> Thanh toán</span></a></li>
                <li><a href="users" class="active"><i class="bi bi-people"></i><span> Người dùng</span></a></li>
                <li><a href="blogs"><i class="bi bi-journal-text"></i><span> Blog</span></a></li>
                <li><a href="banners"><i class="bi bi-image"></i><span> Banner</span></a></li>
                <li><a href="/logout"><i class="bi bi-box-arrow-right"></i><span> Đăng xuất</span></a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main -->
    <main class="main-content">
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-people-fill me-2" style="color:#2c7da0;"></i> Chỉnh sửa thông tin người dùng
            </h3>
        </header>

        <section class="blog-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="form-card">
                        <form action="/updateUser" method="post" enctype="multipart/form-data">

                            <!-- Avatar Upload Section -->
                            <div class="avatar-upload-section">
                                <div class="current-avatar">
                                    <c:choose>
                                        <c:when test="${not empty user.imgURL}">
                                            <img id="avatarPreview" src="${pageContext.request.contextPath}/${user.imgURL}" alt="Avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="avatarPreview" src="${pageContext.request.contextPath}/assets/img/default-avatar.png" alt="Avatar">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="upload-btn-wrapper">
                                    <label for="avatarInput" class="btn-upload">
                                        <i class="fas fa-camera"></i> Chọn ảnh đại diện
                                    </label>
                                    <input type="file"
                                           id="avatarInput"
                                           name="avatar"
                                           accept="image/jpeg,image/png,image/gif,image/jpg"
                                           style="display: none;">
                                    <small class="text-muted d-block mt-2">Hỗ trợ: JPG, PNG, GIF. Tối đa 5MB</small>
                                </div>

                                <div id="uploadPreview" class="mt-2" style="display: none;">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle"></i> Đã chọn: <span id="fileName"></span>
                                    </div>
                                </div>
                            </div>

                            <!-- User Information Section -->
                            <div class="form-section address-box">
                                <h3 class="form-section-title">
                                    <i class="fas fa-user"></i> Thông tin tài khoản (USER)
                                </h3>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">ID người dùng</label>
                                        <input type="text" class="form-control" name="id" value="${user.getId()}" readonly >
                                        <small class="text-muted">ID không thể thay đổi</small>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên đăng nhập</label>
                                        <input type="text" class="form-control" name="username" value="${user.getUsername()}" required>
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
                                        <select class="form-select" name="role">
                                            <option value="user" ${user.role == 'user' ? 'selected' : ''}>ROLE_USER</option>
                                            <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>ROLE_ADMIN</option>
                                        </select>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label class="form-label">Mô tả</label>
                                        <textarea class="form-control" name="description">${user.getDescription()}</textarea>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Trạng thái</label>
                                        <div class="status-options">
                                            <label class="status-option">
                                                <input type="radio" name="status" value="true" ${user.status ? 'checked' : ''}>
                                                <span class="status-badge status-active">Hoạt động</span>
                                            </label>
                                            <label class="status-option">
                                                <input type="radio" name="status" value="false" ${!user.status ? 'checked' : ''}>
                                                <span class="status-badge status-inactive">Không hoạt động</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Address ID</label>
                                        <select class="form-select" name="addressId">
                                            <option value="0">Chọn địa chỉ chính</option>
                                            <c:forEach var="a" items="${listAddress}">
                                                <option value="${a.id}" ${a.type == 'main' ? 'selected' : ''}>
                                                        ${a.id} - ${a.name} - ${a.type == 'main' ? 'Địa chỉ chính' : 'Địa chỉ phụ'}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Address Information Section -->
                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ (ADDRESS)
                                </h3>

                                <c:choose>
                                    <c:when test="${not empty listAddress}">
                                        <c:forEach var="a" items="${listAddress}" varStatus="status">
                                            <div class="address-box">
                                                <div class="address-box-header">
                                                    <h4>
                                                        <c:choose>
                                                            <c:when test="${a.type == 'main'}">
                                                                🏠 Địa chỉ chính: ${a.name} (ID: ${a.id})
                                                            </c:when>
                                                            <c:otherwise>
                                                                📍 Địa chỉ phụ: ${a.name} (ID: ${a.id})
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </h4>
                                                    <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#deleteAddressModal_${a.id}">
                                                        <i class="fas fa-trash-alt"></i> Xóa địa chỉ
                                                    </button>
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
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="address-box">
                                            <div class="address-box-header">
                                                <h4>📭 Chưa có địa chỉ nào</h4>
                                            </div>
                                            <p class="text-muted">Hãy thêm địa chỉ mới bằng nút bên dưới.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                                    <i class="fas fa-plus-circle"></i> Thêm địa chỉ mới
                                </button>
                            </div>

                            <!-- Form Actions -->
                            <div class="form-actions">
                                <a href="/userAdmin" class="btn-cancel">
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
        </section>
    </main>
</div>

<c:forEach var="a" items="${listAddress}">
    <div class="modal fade" id="deleteAddressModal_${a.id}" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-danger"></i> Xác nhận xóa địa chỉ
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa địa chỉ này không?</p>
                    <p class="text-danger mb-0"><strong>${a.name}</strong></p>
                    <p class="text-muted small">${a.street}, ${a.commune}, ${a.province}</p>
                    <c:if test="${a.type == 'main'}">
                        <div class="alert alert-warning mt-2">
                            <i class="fas fa-exclamation-circle"></i> Lưu ý: Đây là địa chỉ chính. Sau khi xóa, bạn cần chọn địa chỉ chính mới.
                        </div>
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <a href="/addAdressAdmin?id=${a.id}&userId=${user.id}" class="btn btn-danger">
                        <i class="fas fa-trash-alt"></i> Xóa vĩnh viễn
                    </a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Modal thêm địa chỉ -->
<div class="modal fade" id="addAddressModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-plus-circle text-primary"></i> Thêm địa chỉ mới
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/addAdressAdmin" method="post">
                <div class="modal-body">
                    <input type="hidden" name="id" value="${user.id}">

                    <div class="mb-3">
                        <label class="form-label">Tên địa chỉ <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" placeholder="Ví dụ: Nhà riêng, Văn phòng, Công ty..." required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Loại địa chỉ</label>
                        <select class="form-select" name="type">
                            <option value="normal">Địa chỉ phụ</option>
                            <option value="main">Địa chỉ chính</option>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Số nhà, tên đường</label>
                            <input type="text" class="form-control" name="street" placeholder="Số nhà, tên đường">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Xã/Phường</label>
                            <input type="text" class="form-control" name="commune" placeholder="Xã/Phường">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tỉnh/Thành phố</label>
                            <input type="text" class="form-control" name="province" placeholder="Tỉnh/Thành phố">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Thêm địa chỉ
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Preview avatar before upload
    document.getElementById('avatarInput').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.getElementById('avatarPreview').src = event.target.result;
                document.getElementById('fileName').innerText = file.name;
                document.getElementById('uploadPreview').style.display = 'block';
            }
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>