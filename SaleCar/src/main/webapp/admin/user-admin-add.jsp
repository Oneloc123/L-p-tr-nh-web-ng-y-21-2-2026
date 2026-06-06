<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Tạo mới Người dùng | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Các style giữ nguyên như cũ, không thay đổi */
        .avatar-upload-section { text-align: center; margin-bottom: 30px; padding: 20px; background: #ffffff; border-radius: 20px; border: 1px solid #e9ecef; }
        .current-avatar img { width: 120px; height: 120px; border-radius: 50%; border: 3px solid #2c7da0; object-fit: cover; }
        .btn-upload { background: linear-gradient(135deg, #2c7da0, #1f5e7a); color: #fff; padding: 10px 24px; border-radius: 30px; cursor: pointer; }
        .form-section { background: #ffffff; border-radius: 20px; padding: 20px; margin-bottom: 20px; }
        .address-box { border: 1px solid #e9ecef; border-radius: 16px; padding: 15px; margin-top: 10px; }
        .btn-remove-address { background: #dc3545; color: white; border: none; padding: 6px 14px; border-radius: 8px; }
        .form-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-save { background: #2c7da0; border: none; padding: 8px 18px; border-radius: 30px; color: white; }
        .btn-cancel { border: 1px solid #e2e8f0; padding: 8px 18px; border-radius: 30px; color: #64748b; text-decoration: none; }
        /* Các style khác giữ nguyên */
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="sidebar/sidebar.jsp" %>
    <main class="main-content">
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-people-fill me-2"></i> Tạo mới người dùng</h3>
        </header>
        <section class="blog-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="form-card">
                        <form id="userForm" action="/addUser" method="post" enctype="multipart/form-data">
                            <!-- Avatar -->
                            <div class="avatar-upload-section">
                                <div class="current-avatar">
                                    <img id="avatarPreview" src="${pageContext.request.contextPath}/assets/img/default-avatar.png" alt="Avatar">
                                </div>
                                <div class="upload-btn-wrapper">
                                    <label for="avatarInput" class="btn-upload"><i class="fas fa-camera"></i> Chọn ảnh đại diện</label>
                                    <input type="file" id="avatarInput" name="avatar" accept="image/jpeg,image/png,image/jpg" style="display: none;">
                                    <small class="text-muted d-block mt-2">Hỗ trợ: JPG, PNG. Tối đa 5MB</small>
                                    <c:if test="${not empty avatarError}">
                                        <span class="error-message text-danger">${avatarError}</span>
                                    </c:if>
                                </div>
                                <div id="uploadPreview" style="display: none;" class="mt-2">
                                    <div class="alert alert-info">Đã chọn: <span id="fileName"></span></div>
                                </div>
                            </div>

                            <!-- Thông tin user -->
                            <div class="form-section">
                                <h3 class="form-section-title"><i class="fas fa-user"></i> Thông tin tài khoản</h3>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label>Tên đăng nhập <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="username" value="${oldUsername != null ? oldUsername : ''}" required>
                                        <c:if test="${not empty usernameError}"><span class="text-danger">${usernameError}</span></c:if>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Mật khẩu <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="password" value="${oldPassword != null ? oldPassword : ''}" required>
                                        <c:if test="${not empty passwordError}"><span class="text-danger">${passwordError}</span></c:if>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Họ và tên <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="fullname" value="${oldFullname != null ? oldFullname : ''}" required>
                                        <c:if test="${not empty fullnameError}"><span class="text-danger">${fullnameError}</span></c:if>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Email <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control" name="email" value="${oldEmail != null ? oldEmail : ''}" required>
                                        <c:if test="${not empty emailError}"><span class="text-danger">${emailError}</span></c:if>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Số điện thoại</label>
                                        <input type="text" class="form-control" name="phoneNumber" value="${oldPhone != null ? oldPhone : ''}">
                                        <c:if test="${not empty phonenumberError}"><span class="text-danger">${phonenumberError}</span></c:if>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Vai trò</label>
                                        <select class="form-select" name="role">
                                            <option value="user" ${oldRole == 'user' ? 'selected' : ''}>ROLE_USER</option>
                                            <option value="admin" ${oldRole == 'admin' ? 'selected' : ''}>ROLE_ADMIN</option>
                                        </select>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label>Mô tả</label>
                                        <textarea class="form-control" name="description">${oldDescription != null ? oldDescription : ''}</textarea>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Trạng thái</label>
                                        <div class="status-options">
                                            <label><input type="radio" name="status" value="true" ${oldStatus == 'true' ? 'checked' : ''}> Hoạt động</label>
                                            <label><input type="radio" name="status" value="false" ${oldStatus == 'false' ? 'checked' : ''}> Không hoạt động</label>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="form-actions">
                                <a href="/userAdmin" class="btn-cancel"><i class="fas fa-times"></i> Hủy</a>
                                <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Avatar preview
    document.getElementById('avatarInput').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(ev) {
                document.getElementById('avatarPreview').src = ev.target.result;
                document.getElementById('fileName').innerText = file.name;
                document.getElementById('uploadPreview').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    });




</script>
</body>
</html>