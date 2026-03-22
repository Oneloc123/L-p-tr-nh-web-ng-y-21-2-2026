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
            border: 1.5px solid #00ffcc;
            box-shadow: 0 0 6px rgba(0, 255, 204, 0.4);
        }

        /* Avatar trong modal (to hơn) */
        .profile-avatar-lg {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #00ffcc;
            box-shadow: 0 0 10px rgba(0, 255, 204, 0.5);
        }
        body {
            background-color: #000000;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #e5e9f0;
        }

        /* SIDEBAR STYLE - Dark Glass */
        .sidebar {
            width: 280px;
            background-color: #0a0a0a;
            border-right: 1px solid #1f2a2e;
            height: 100vh;
            position: sticky;
            top: 0;
            padding: 2rem 1.2rem;
            transition: all 0.3s;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(135deg, #ffffff, #00ffcc);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 2.5rem;
            letter-spacing: -0.5px;
        }

        .logo i {
            background: none;
            color: #00ffcc;
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
            color: #b0bec5;
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
            background-color: #00ffcc10;
            color: #00ffcc;
            box-shadow: 0 2px 6px rgba(0, 255, 204, 0.05);
            border-left: 2px solid #00ffcc;
        }

        /* MAIN CONTENT */
        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #000000;
            overflow-y: auto;
        }

        /* HEADER */
        .header {
            background: #0a0a0a;
            padding: 1rem 1.8rem;
            border-radius: 28px;
            margin-bottom: 2rem;
            border: 1px solid #1e2a2a;
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.4);
        }

        .header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #f0f0f0, #aafff0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .btn-primary {
            background-color: #00ccaa;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #000000;
            transition: 0.2s;
        }

        .btn-primary:hover {
            background-color: #00ffcc;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 255, 204, 0.3);
            color: #000;
        }

        .btn-outline-secondary {
            border-color: #2c3a3a;
            color: #ccddee;
        }

        .btn-outline-secondary:hover {
            background-color: #00ffcc20;
            border-color: #00ffcc;
            color: #00ffcc;
        }

        /* Filter & Card */
        .card {
            background: #0c0c0c;
            border: 1px solid #1e2a2a;
            border-radius: 24px;
            backdrop-filter: blur(2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
        }

        .card-body {
            padding: 1.2rem;
        }

        .form-control, .form-select {
            background-color: #111111;
            border: 1px solid #2a3a3a;
            color: #f0f0f0;
            border-radius: 14px;
            padding: 10px 16px;
        }

        .form-control:focus, .form-select:focus {
            background-color: #1a1a1a;
            border-color: #00ffcc;
            box-shadow: 0 0 0 3px rgba(0, 255, 204, 0.2);
            color: white;
        }

        .table {
            color: #e2e8f0;
            border-color: #1f2a2e;
        }

        .table-light {
            background-color: #0f1215;
            color: #b3f0e0;
        }

        .table-hover > tbody > tr:hover {
            background-color: #00ffcc0c;
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
            background-color: #0f2e1f;
            color: #00ffaa;
            border: 0.5px solid #00ffaa50;
        }

        .status-inactive {
            background-color: #3a1e22;
            color: #ff8a7a;
            border: 0.5px solid #ff6b5b50;
        }

        .role-admin {
            background-color: #001f3f;
            color: #5bc0ff;
            border: 0.5px solid #2f7fff;
        }

        .role-user {
            background-color: #1e2a2e;
            color: #b0d4ff;
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
            background-color: #1f3a44;
            color: #8dd0ff;
        }

        .action-view:hover {
            background-color: #2f5f77;
            color: white;
        }

        .action-edit {
            background-color: #3a3f1f;
            color: #ffea80;
        }

        .action-edit:hover {
            background-color: #b8860b;
            color: black;
        }

        .action-delete {
            background-color: #4a1f2c;
            color: #ffa098;
        }

        .action-delete:hover {
            background-color: #c82333;
            color: white;
        }

        /* Avatar mặc định */
        .default-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(145deg, #1f3a3a, #000000);
            border: 1.5px solid #00ffcc;
            color: #00ffcc;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
            box-shadow: 0 0 6px rgba(0, 255, 204, 0.4);
        }

        /* Modal Dark */
        .modal-content {
            background-color: #0e1217;
            border: 1px solid #2a4242;
            border-radius: 28px;
            color: #eef5ff;
        }

        .modal-header {
            border-bottom-color: #2a3a3a;
        }

        .modal-footer {
            border-top-color: #2a3a3a;
        }

        .btn-close {
            filter: invert(1);
        }

        .text-muted {
            color: #8c9aa8 !important;
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

    <!-- SIDEBAR DARK PREMIUM -->
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
            <h3 class="fw-bold m-0"><i class="bi bi-people-fill me-2" style="color:#00ffcc;"></i> Quản lý người dùng
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

        <!-- Bảng người dùng Dark Style -->
        <section class="blog-table mt-4">
            <div class="card shadow-lg">
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
                                        <button class="action-btn action-edit" data-bs-toggle="modal"
                                                data-bs-target="#editUserModal${u.id}"><i
                                                class="bi bi-pencil-square"></i></button>
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
        <!-- MODAL VIEW USER 1 -->
        <div class="modal fade" id="viewUserModal${u.id}" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header"><h5 class="modal-title">👤 Chi tiết người dùng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="d-flex gap-4 flex-wrap">
                            <div>
                                <img src="${pageContext.request.contextPath}/${empty u.imgURL ? 'assets/img/default-avatar.png' : u.imgURL}"
                                     class="profile-avatar-lg" alt="Avatar">
                            </div>
                            <div>
                                <table class="table table-borderless text-white">
                                    <tr>
                                        <th>ID:</th>
                                        <td>${u.id}</td>
                                    </tr>
                                    <tr>
                                        <th>Tên đăng nhập:</th>
                                        <td>${u.username}</td>
                                    </tr>
                                    <tr>
                                        <th>Họ tên:</th>
                                        <td>${u.fullname}</td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td>${u.email}</td>
                                    </tr>
                                    <tr>
                                        <th>SĐT:</th>
                                        <td>${u.phonenumber}</td>
                                    </tr>
                                    <tr>
                                        <th>Vai trò:</th>
                                        <td><span class="role-badge role-admin">${u.role}</span></td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái:</th>
                                        <c:choose>
                                            <c:when test="${u.status}">
                                                <td><span class="status-badge status-active">Hoạt động</span></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><span class="status-badge status-inactive">Đã khóa</span></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL EDIT USER 1 -->
        <div class="modal fade" id="editUserModal${u.id}" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header"><h5 class="modal-title">✏️ Cập nhật người dùng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="/updateUser?id=${u.id}" method="post">
                        <div class="modal-body"><input type="hidden" name="id" value="1">
                            <div class="row g-3">
                                <div class="col-md-6"><label>Tên đăng nhập</label><input class="form-control" name="username"
                                                                                         placeholder="${u.username}"  ></div>
                                <div class="col-md-6"><label>Mật khẩu mới</label><input type="password" class="form-control"
                                                                                        name="password"
                                                                                        placeholder="Để trống nếu không đổi">
                                </div>
                                <div class="col-md-6"><label>Họ tên</label><input class="form-control" name="fullname"
                                                                                  placeholder="${u.fullname}"  ></div>
                                <div class="col-md-6"><label>Email</label><input class="form-control" name="email"
                                                                                 placeholder="${u.email}"  ></div>
                                <div class="col-md-6"><label>Số điện thoại</label><input class="form-control" name="phonenumber"
                                                                                         placeholder="${u.phonenumber}"     ></div>
                                <div class="col-md-6"><label>Vai trò</label><select class="form-select" name="role">
                                    <option value="user">User</option>
                                    <option value="admin" selected>Admin</option>
                                </select></div>
                                <div class="col-md-6"><label>Trạng thái</label><select class="form-select" name="status">
                                    <option value="true" selected>Hoạt động</option>
                                    <option value="false">Đã khóa</option>
                                </select></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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
                <form action="/addUser" method="post">
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
                        <div class="col-md-12"><label class="form-label">Ảnh đại diện URL</label><input type="text"
                                                                                                        class="form-control"
                                                                                                        name="imgURL"
                                                                                                        placeholder="/assets/img/avatar.png">
                        </div>
                    </div>
                    <div class="modal-footer mt-4 px-0 pb-0 border-0">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button class="btn btn-primary" type="submit">Thêm mới</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


</body>
</html>