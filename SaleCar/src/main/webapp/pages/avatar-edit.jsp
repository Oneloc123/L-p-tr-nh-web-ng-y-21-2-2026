<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa ảnh đại diện - LUXCAR</title>

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>
        body { padding: 40px 0; }

        .avatar-card {
            background: var(--bg-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
            overflow: hidden;
        }

        .avatar-header {
            padding: 25px 30px;
            border-bottom: 1px solid var(--border-subtle);
            background: linear-gradient(135deg, #0a0a0a, #1f1f1f);
        }
        .avatar-header h2 {
            font-size: 24px;
            font-weight: 600;
            margin: 0;
            font-family: 'Playfair Display', serif;
        }
        .avatar-header p { color: var(--text-muted); font-size: 14px; margin-top: 5px; }

        .avatar-body { padding: 30px; text-align: center; }

        .current-avatar-large {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            margin: 0 auto 30px;
            border: 4px solid var(--bg-surface);
            box-shadow: var(--shadow-card);
            overflow: hidden;
            background: var(--bg-elevated);
        }
        .current-avatar-large img { width: 100%; height: 100%; object-fit: cover; }

        .upload-area {
            border: 3px dashed var(--border-gold);
            border-radius: var(--radius-md);
            padding: 40px;
            background: var(--bg-elevated);
            cursor: pointer;
            transition: all var(--transition-base);
            margin-bottom: 20px;
        }
        .upload-area:hover { background: rgba(212,175,55,0.04); }
        .upload-area i { font-size: 48px; color: var(--gold); margin-bottom: 15px; }
        .upload-area h4 { font-size: 18px; font-weight: 600; color: var(--text-primary); margin-bottom: 10px; }
        .upload-area p { color: var(--text-muted); margin: 0; }

        .file-info {
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
            padding: 15px;
            border-radius: var(--radius-sm);
            margin: 20px 0;
            text-align: left;
        }
        .file-info-item { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .file-info-label { font-weight: 500; color: var(--text-secondary); }
        .file-info-value { color: var(--text-muted); }

        .avatar-actions { display: flex; gap: 15px; justify-content: center; margin-top: 30px; }

        .btn-save {
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: #101010;
            border: none;
            border-radius: 40px;
            padding: 12px 30px;
            font-weight: 700;
            font-size: 16px;
            text-decoration: none;
            transition: all var(--transition-base);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 6px 14px rgba(212,175,55,0.25); }
        .btn-save:disabled { opacity: 0.5; cursor: not-allowed; transform: none; }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--text-muted);
            text-decoration: none;
            transition: color var(--transition-fast);
        }
        .back-link:hover { color: var(--gold); text-decoration: none; }

        .breadcrumb-nav { margin-bottom: 20px; }

        .error-message {
            display: block;
            padding: 10px;
            margin-bottom: 15px;
            background: rgba(231,76,60,0.12);
            border: 1px solid rgba(231,76,60,0.2);
            color: #e74c3c;
            border-radius: var(--radius-sm);
            font-size: 13px;
        }

        #imageUpload { display: none; }
    </style>
</head>
<body>

<%-- Include header --%>
<%@ include file="/common/header-for-login-ex.jsp" %>

<div class="container">
    <!-- Breadcrumb -->
    <div class="breadcrumb-nav">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile-edit">Chỉnh sửa thông tin</a></li>
                <li class="breadcrumb-item active"><a href="${pageContext.request.contextPath}/avatarEdit">Chỉnh sửa ảnh</a></li>
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
                <img id="avatarPreview"
                     src="${empty user.imgURL
                        ? pageContext.request.contextPath.concat('/assets/img/default-avatar.png')
                        : pageContext.request.contextPath.concat('/').concat(user.imgURL)}"
                     alt="Avatar">
            </div>
            <c:if test="${not empty avatarError}">
                                <span class="error-message" style="color: red;">
                                    <i class="bi bi-x-circle"></i> ${avatarError}
                                </span>
            </c:if>
            <!-- Upload Area -->
            <form action="${pageContext.request.contextPath}/avatarEdit"
                  method="post"
                  enctype="multipart/form-data">
                <label for="imageUpload" class="upload-area">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <h4>Chọn ảnh để tải lên</h4>
                    <p>Kéo thả hoặc click để chọn ảnh</p>
                    <p style="font-size: 12px; margin-top: 10px;">Hỗ trợ: JPG, PNG, GIF (Tối đa 5MB)</p>
                </label>
                <input type="file"
                       class="form-control"
                       id="imageUpload"
                       accept="image/*"
                       name="avatar">

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
                    <button type="submit" class="btn-save" id="saveBtn" >
                        <i class="fas fa-save"></i> Lưu ảnh
                    </button>
                    <a type="button" class="btn-remove" href="/profileEdit">
                        <i class="fas fa-trash-alt"></i> huỷ
                    </a>
                </div>
            </form>

            <a href="${pageContext.request.contextPath}/profileEdit" class="back-link">
                <i class="fas fa-arrow-left"></i> Quay lại chỉnh sửa thông tin
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/common/footer.jsp" %>

</body>
</html>