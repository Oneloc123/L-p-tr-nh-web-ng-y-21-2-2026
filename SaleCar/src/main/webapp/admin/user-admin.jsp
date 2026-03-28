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

    <style>
        /* FORM CARD */
        .form-card {
            padding: 25px;
        }

        /* SECTION */
        .form-section {
            background: #fefefe;
            border: 1px solid #eef2f6;
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
            border: 1px solid #eef2f6;
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
            margin-bottom: 10px;
        }

        .address-box-header h4 {
            font-size: 14px;
            color: #2c7da0;
        }

        /* BUTTON DELETE */
        .btn-remove-address {
            background: transparent;
            border: none;
            color: #dc3545;
            font-size: 16px;
        }

        .btn-remove-address:hover {
            color: #c82333;
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

        /* AVATAR SECTION */
        .avatar-upload-section {
            text-align: center;
            margin-bottom: 20px;
        }

        .current-avatar img {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            border: 2px solid #2c7da0;
            object-fit: cover;
            box-shadow: 0 0 8px rgba(44,125,160,0.15);
        }

        /* BUTTON UPLOAD */
        .btn-upload {
            display: inline-block;
            margin-top: 10px;
            background: #2c7da0;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            text-decoration: none;
        }

        .btn-upload:hover {
            background: #1f5e7a;
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
        }

        .btn-save:hover {
            background: #1f5e7a;
        }

        .btn-cancel {
            border: 1px solid #e2e8f0;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            text-decoration: none;
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

        /* Avatar trong modal (to hơn) */
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

        /* SIDEBAR STYLE - Soft Gray */
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

        /* MAIN CONTENT */
        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }

        /* HEADER */
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
            color: #fff;
        }

        .btn-outline-secondary {
            border-color: #e2e8f0;
            color: #5a6e7c;
        }

        .btn-outline-secondary:hover {
            background-color: #f8fafc;
            border-color: #2c7da0;
            color: #2c7da0;
        }

        /* Filter & Card */
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

        .table {
            color: #1e293b;
            border-color: #e9edf2;
        }

        .table-light {
            background-color: #f8fafc;
            color: #1e293b;
        }

        .table-hover > tbody > tr:hover {
            background-color: #f8fafc;
        }

        /* Badges */
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

        .role-admin {
            background-color: #eef2ff;
            color: #2c5f8a;
            border: 0.5px solid #cbdff2;
        }

        .role-user {
            background-color: #f5f0ff;
            color: #7a5c9e;
            border: 0.5px solid #ddd0f0;
        }

        /* Action Buttons */
        .action-btn {
            padding: 6px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.2s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin: 0 3px;
        }

        .action-view {
            background-color: #eef2ff;
            color: #2c7da0;
        }

        .action-view:hover {
            background-color: #e0e8f5;
            color: #1f5e7a;
        }

        .action-edit {
            background-color: #fff8e8;
            color: #c9772e;
        }

        .action-edit:hover {
            background-color: #fff0dd;
            color: #b85f1a;
        }

        .action-delete {
            background-color: #fff0f0;
            color: #c75c5c;
        }

        .action-delete:hover {
            background-color: #ffe0e0;
            color: #b84c4c;
        }

        /* Avatar mặc định */
        .default-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(145deg, #eef2ff, #e2e8f0);
            border: 1.5px solid #2c7da0;
            color: #2c7da0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
            box-shadow: 0 0 4px rgba(44,125,160,0.15);
        }

        /* Modal Light */
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

        /* responsive */
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

    <!-- SIDEBAR MODERN -->
    <aside class="sidebar">
        <h2 class="logo"><i class="bi bi-car-front-fill me-2"></i><span>LUXCAR Admin</span></h2>
        <nav>
            <ul>
                <li><a href="dashboard"><i class="bi bi-speedometer2"></i><span> Dashboard</span></a></li>
                <li><a href="products"><i class="bi bi-box"></i><span> Sản phẩm</span></a></li>
                <li><a href="categories"><i class="bi bi-tags"></i><span> Danh mục</span></a></li>
                <li><a href="/orderAdmin"><i class="bi bi-cart"></i><span> Đơn hàng</span></a></li>
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
            <h3 class="fw-bold m-0"><i class="bi bi-people-fill me-2" style="color:#2c7da0;"></i> Quản lý người dùng
            </h3>
            <div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="bi bi-plus-lg"></i> Thêm người dùng
                </button>
            </div>
        </header>

        <!-- SEARCH + FILTERS -->
        <form class="input-group mb-4" action="/filterUser" method="get">
            <input type="text" class="form-control" name="keyword"
                   placeholder="🔍 Tìm kiếm theo tên, email, số điện thoại..." value="">
            <button class="btn btn-outline-secondary"><i class="bi bi-search"></i> Tìm</button>
        </form>

        <section class="filters mt-2 mb-4">
            <form action="/filterUser" method="post" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <select class="form-select" name="role">
                        <option value="">📌 Tất cả vai trò</option>
                        <option value="admin">👑 Admin</option>
                        <option value="user">👤 User</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <select class="form-select" name="status">
                        <option value="">⚡ Tất cả trạng thái</option>
                        <option value="true">🟢 Hoạt động</option>
                        <option value="false">🔴 Đã khóa</option>
                    </select>
                </div>
                <input type="hidden" name="keyword" value=""/>
                <div class="col-md-4 text-md-end">
                    <button class="btn btn-primary w-100 w-md-auto"><i class="bi bi-funnel"></i> Lọc dữ liệu</button>
                </div>
            </form>
        </section>

        <!-- Bảng người dùng -->
        <section class="blog-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                            <tr class="text-uppercase small">
                                <th>#</th>
                                <th>Avatar</th>
                                <th>Tên đăng nhập</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listUser}" var="u">
                                <tr>
                                    <td>${u.id}</td>
                                    <td class="avatar-cell">
                                        <c:choose>
                                            <c:when test="${not empty u.imgURL}">
                                                <img src="${pageContext.request.contextPath}/${u.imgURL}"
                                                     class="profile-avatar" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png"
                                                     class="profile-avatar" alt="Avatar">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-semibold">${u.username}</td>
                                    <td>${u.fullname}</td>
                                    <td>${u.email}</td>
                                    <td>${u.phonenumber}</td>
                                    <td><span class="role-badge role-admin">${u.role}</span></td>
                                    <c:choose>
                                        <c:when test="${u.status}">
                                            <td><span class="status-badge status-active">Hoạt động</span></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><span class="status-badge status-inactive">Đã khóa</span></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${u.createdat}</td>
                                    <td>
                                        <button class="action-btn action-view" data-bs-toggle="modal"
                                                data-bs-target="#viewUserModal${u.id}"><i class="bi bi-eye"></i>
                                        </button>
                                        <a href="/updateUser?id=${u.id}" class="action-btn action-edit"><i
                                                class="bi bi-pencil-square"></i></a>
                                        <a href="/deleteUser?id=${u.id}"
                                           onclick="return confirm('Xóa người dùng này?')"
                                           class="action-btn action-delete"><i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <c:forEach items="${listUser}" var="u">
        <!-- MODAL VIEW USER  -->
        <c:forEach items="${listUser}" var="u">
            <div class="modal fade" id="viewUserModal${u.id}" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="form-card">
                            <!-- Avatar Upload Section (View only) -->
                            <div class="avatar-upload-section">
                                <div class="current-avatar">
                                    <c:choose>
                                        <c:when test="${not empty u.imgURL}">
                                            <img src="${pageContext.request.contextPath}/${u.imgURL}" alt="Avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png" alt="Avatar">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="upload-hint">
                                    Ảnh đại diện người dùng
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
                                        <input type="text" class="form-control" value="${u.getId()}" readonly >
                                        <small class="text-muted">ID không thể thay đổi</small>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên đăng nhập</label>
                                        <input type="text" class="form-control" value="${u.getUsername()}" readonly >
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Họ và tên</label>
                                        <input type="text" class="form-control" value="${u.getFullname()}" readonly >
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="${u.getEmail()}" readonly >
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" class="form-control" value="${u.getPhonenumber()}" readonly >
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Vai trò</label>
                                        <input type="text" class="form-control" value="${u.role}" readonly >
                                    </div>

                                    <div class="col-12 mb-3">
                                        <label class="form-label">Mô tả</label>
                                        <textarea class="form-control" readonly >${u.getDescription()}</textarea>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Trạng thái</label>
                                        <div class="status-options">
                                            <c:choose>
                                                <c:when test="${u.status}">
                                                    <span class="status-badge status-active">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-inactive">Đã khóa</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Address ID</label>
                                        <select class="form-select" >
                                            <c:choose>
                                                <c:when test="${not empty listAddress}">
                                                    <c:forEach var="a" items="${listAddress}" >
                                                        <c:choose>
                                                            <c:when test="${a.type=='main' && a.userId==u.id}">
                                                                <option selected>${a.id}- ${a.name}-địa chỉ chính</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option>${a.id}- ${a.name}-địa chỉ phụ</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <option selected>chưa có địa chỉ</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Address Information Section (ADDRESS table) - VIEW ONLY -->
                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ
                                </h3>

                                <c:set var="hasAddress" value="false"/>

                                <c:forEach var="a" items="${listAddress}">
                                    <c:if test="${a.userId == u.id}">
                                        <c:set var="hasAddress" value="true"/>

                                        <div class="address-box">
                                            <div class="address-box-header">
                                                <h4>
                                                    <c:choose>
                                                        <c:when test="${a.type == 'main'}">
                                                            🏠 Địa chỉ chính:
                                                        </c:when>
                                                        <c:otherwise>
                                                            📍 Địa chỉ phụ:
                                                        </c:otherwise>
                                                    </c:choose>
                                                        ${a.name} (ID: ${a.id})
                                                </h4>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Số nhà, đường</label>
                                                    <input type="text" class="form-control" value="${a.street}" readonly >
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Phường/Xã</label>
                                                    <input type="text" class="form-control" value="${a.commune}" readonly >
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label class="form-label">Tỉnh/TP</label>
                                                    <input type="text" class="form-control" value="${a.province}" readonly >
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <!-- Nếu không có địa chỉ -->
                                <c:if test="${!hasAddress}">
                                    <div class="address-box">
                                        <h4>⚠️ Người dùng chưa có địa chỉ</h4>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Form Actions -->
                            <div class="form-actions">
                                <button type="button" class="btn-cancel" data-bs-dismiss="modal">
                                    <i class="fas fa-times"></i> Đóng
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- MODAL THÊM NGƯỜI DÙNG -->
<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill text-primary me-2"></i> Thêm người dùng
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="/addUser" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label">Tên đăng nhập *</label><input type="text"
                                                                                                      class="form-control"
                                                                                                      name="username"
                                                                                                      required></div>
                        <div class="col-md-6"><label class="form-label">Mật khẩu *</label><input type="password"
                                                                                                 class="form-control"
                                                                                                 name="password"
                                                                                                 required></div>
                        <div class="col-md-6"><label class="form-label">Họ tên</label><input type="text"
                                                                                             class="form-control"
                                                                                             name="fullname"></div>
                        <div class="col-md-6"><label class="form-label">Email</label><input type="email"
                                                                                            class="form-control"
                                                                                            name="email"></div>
                        <div class="col-md-6"><label class="form-label">Description</label><input type="text"
                                                                                                  class="form-control"
                                                                                                  name="description"></div>
                        <div class="col-md-6"><label class="form-label">Số điện thoại</label><input type="text"
                                                                                                    class="form-control"
                                                                                                    name="phonenumber">
                        </div>
                        <div class="col-md-6"><label class="form-label">Vai trò</label><select class="form-select"
                                                                                               name="role">
                            <option value="user">user</option>
                            <option value="admin">admin</option>
                        </select></div>
                        <div class="col-md-6"><label class="form-label">Trạng thái</label><select class="form-select"
                                                                                                  name="status">
                            <option value="true">Hoạt động</option>
                            <option value="false">Đã khóa</option>
                        </select></div>
                        <div class="col-12">
                            <div class="border rounded p-3 mt-3">
                                <h6 class="mb-3">Thông tin địa chỉ tam thời</h6>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên địa chỉ <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="name"
                                               placeholder="ví dụ: địa chỉ nhà, công ty..." required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Số nhà, tên đường</label>
                                        <input type="text" class="form-control" name="street">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Xã/Phường</label>
                                        <input type="text" class="form-control" name="commune">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Tỉnh/Thành phố</label>
                                        <input type="text" class="form-control" name="province">
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-12"><label class="form-label">Ảnh đại diện URL</label> <input type="file"
                                                                                                         class="form-control" id="imageUpload" accept="image/*" name="avatar">
                        </div>
                    </div>
                    <div class="modal-footer mt-4 px-0 pb-0 border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button class="btn btn-primary" type="submit">Thêm mới</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


</body>
</html>