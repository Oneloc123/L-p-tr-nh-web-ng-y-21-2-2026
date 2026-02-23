<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa ảnh đại diện - LUXCAR</title>

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
            padding: 40px 0;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .avatar-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .avatar-header {
            padding: 25px 30px;
            border-bottom: 1px solid #eeeeee;
            background-color: #000000;
            color: #ffffff;
        }

        .avatar-header h2 {
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }

        .avatar-header p {
            color: #cccccc;
            font-size: 14px;
            margin-top: 5px;
        }

        .avatar-body {
            padding: 30px;
            text-align: center;
        }

        .current-avatar-large {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            margin: 0 auto 30px;
            background-color: #000000;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 72px;
            font-weight: 600;
            border: 4px solid #ffffff;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .current-avatar-large img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .upload-area {
            border: 3px dashed #000000;
            border-radius: 12px;
            padding: 40px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 20px;
        }

        .upload-area:hover {
            background-color: #f0f0f0;
        }

        .upload-area i {
            font-size: 48px;
            color: #000000;
            margin-bottom: 15px;
        }

        .upload-area h4 {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 10px;
        }

        .upload-area p {
            color: #666666;
            margin: 0;
        }

        .file-info {
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: left;
        }

        .file-info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .file-info-label {
            font-weight: 500;
            color: #000000;
        }

        .file-info-value {
            color: #666666;
        }

        .avatar-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
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
            font-size: 16px;
        }

        .btn-save:hover {
            background-color: #ffffff;
            color: #000000;
        }

        .btn-save:disabled {
            opacity: 0.5;
            cursor: not-allowed;
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
            display: inline-block;
        }

        .btn-cancel:hover {
            background-color: #f0f0f0;
        }

        .btn-remove {
            padding: 12px 30px;
            background-color: #ffffff;
            color: #dc3545;
            border: 2px solid #dc3545;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
        }

        .btn-remove:hover {
            background-color: #dc3545;
            color: #ffffff;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #000000;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .breadcrumb-nav {
            margin-bottom: 20px;
        }

        .breadcrumb {
            background: none;
            padding: 0;
        }

        .breadcrumb-item a {
            color: #666666;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #000000;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Breadcrumb -->
    <div class="breadcrumb-nav">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/profile.jsp">Thông tin cá nhân</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/profile-edit.jsp">Chỉnh sửa thông tin</a></li>
                <li class="breadcrumb-item active">Chỉnh sửa ảnh</li>
            </ol>
        </nav>
    </div>

    <div class="avatar-card">
        <div class="avatar-header">
            <h2>Chỉnh sửa ảnh đại diện</h2>
            <p>Cập nhật ảnh đại diện cho tài khoản của bạn</p>
        </div>

        <div class="avatar-body">
            <!-- Current Avatar -->
            <div class="current-avatar-large">
                <span>ND</span>
            </div>

            <!-- Upload Area -->
            <form action="#" method="post" enctype="multipart/form-data">
                <label for="file-upload" class="upload-area">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <h4>Chọn ảnh để tải lên</h4>
                    <p>Kéo thả hoặc click để chọn ảnh</p>
                    <p style="font-size: 12px; margin-top: 10px;">Hỗ trợ: JPG, PNG, GIF (Tối đa 5MB)</p>
                </label>
                <input type="file" id="file-upload" name="avatar" accept="image/*" style="display: none;">

                <!-- File Info (show when file selected) -->
                <div class="file-info" id="fileInfo" style="display: none;">
                    <div class="file-info-item">
                        <span class="file-info-label">Tên file:</span>
                        <span class="file-info-value" id="fileName">-</span>
                    </div>
                    <div class="file-info-item">
                        <span class="file-info-label">Kích thước:</span>
                        <span class="file-info-value" id="fileSize">-</span>
                    </div>
                    <div class="file-info-item">
                        <span class="file-info-label">Loại file:</span>
                        <span class="file-info-value" id="fileType">-</span>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="avatar-actions">
                    <button type="submit" class="btn-save" id="saveBtn" disabled>
                        <i class="fas fa-save"></i> Lưu ảnh
                    </button>
                    <button type="button" class="btn-remove" onclick="removeAvatar()">
                        <i class="fas fa-trash-alt"></i> Xóa ảnh
                    </button>
                </div>
            </form>

            <a href="${pageContext.request.contextPath}/user/profile-edit.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Quay lại chỉnh sửa thông tin
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Handle file selection
    document.getElementById('file-upload').addEventListener('change', function(e) {
        const file = e.target.files[0];
        const fileInfo = document.getElementById('fileInfo');
        const saveBtn = document.getElementById('saveBtn');

        if (file) {
            // Check file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                alert('File quá lớn. Vui lòng chọn file dưới 5MB.');
                this.value = '';
                fileInfo.style.display = 'none';
                saveBtn.disabled = true;
                return;
            }

            // Check file type
            const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                alert('Loại file không hỗ trợ. Vui lòng chọn JPG, PNG hoặc GIF.');
                this.value = '';
                fileInfo.style.display = 'none';
                saveBtn.disabled = true;
                return;
            }

            // Display file info
            document.getElementById('fileName').textContent = file.name;
            document.getElementById('fileSize').textContent = (file.size / 1024).toFixed(2) + ' KB';
            document.getElementById('fileType').textContent = file.type;
            fileInfo.style.display = 'block';
            saveBtn.disabled = false;

            // Preview image
            const reader = new FileReader();
            reader.onload = function(e) {
                const avatarDiv = document.querySelector('.current-avatar-large');
                avatarDiv.innerHTML = `<img src="${e.target.result}" alt="Preview">`;
            }
            reader.readAsDataURL(file);
        } else {
            fileInfo.style.display = 'none';
            saveBtn.disabled = true;
        }
    });

    // Remove avatar function
    function removeAvatar() {
        if (confirm('Bạn có chắc chắn muốn xóa ảnh đại diện?')) {
            // Reset to default avatar
            const avatarDiv = document.querySelector('.current-avatar-large');
            avatarDiv.innerHTML = '<span>ND</span>';

            // Clear file input
            document.getElementById('file-upload').value = '';
            document.getElementById('fileInfo').style.display = 'none';
            document.getElementById('saveBtn').disabled = true;

            alert('Đã xóa ảnh đại diện');
        }
    }

    // Click on upload area to trigger file input
    document.querySelector('.upload-area').addEventListener('click', function() {
        document.getElementById('file-upload').click();
    });
</script>
</body>
</html>