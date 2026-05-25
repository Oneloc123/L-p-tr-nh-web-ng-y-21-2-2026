<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Tạo Banner | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* ========== GIỐNG product-create.jsp ========== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
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
        }
        .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1e2a3a, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 2.5rem;
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
        }
        .sidebar nav ul li a i {
            font-size: 1.3rem;
            width: 24px;
        }
        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #f0f9ff;
            color: #2c7da0;
            border-left: 2px solid #2c7da0;
        }
        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }
        .admin-header {
            background: #ffffff;
            padding: 1rem 1.8rem;
            border-radius: 24px;
            margin-bottom: 2rem;
            border: 1px solid #e9edf2;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }
        .admin-header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        .admin-btn-primary {
            background-color: #2c7da0;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
            cursor: pointer;
        }
        .admin-btn-primary:hover {
            background-color: #1f5e7a;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2);
        }
        .admin-btn-outline {
            border: 1px solid #e2e8f0;
            background: transparent;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .admin-btn-outline:hover {
            border-color: #2c7da0;
            color: #2c7da0;
            background-color: #f8fafc;
        }
        .info-section {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .info-section h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.2rem;
            color: #1e293b;
            border-left: 3px solid #2c7da0;
            padding-left: 0.75rem;
        }
        .form-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 0.6rem 1rem;
            font-size: 0.9rem;
            transition: all 0.2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
        }
        .is-invalid {
            border-color: #dc3545;
        }
        .invalid-feedback {
            font-size: 0.75rem;
            margin-top: 0.25rem;
            color: #dc3545;
        }
        /* Image upload zone (giữ drag & drop nhưng style lại) */
        .upload-container {
            display: flex;
            align-items: start;
            gap: 1.5rem;
            flex-wrap: wrap;
        }
        .preview-wrapper {
            width: 320px;
            height: 180px;
            border-radius: 16px;
            border: 2px dashed #cbd5e1;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .preview-wrapper.has-image { border-style: solid; border-color: #e2e8f0; }
        .preview-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .preview-placeholder { text-align: center; color: #94a3b8; }
        .preview-placeholder i { font-size: 3rem; display: block; margin-bottom: 0.5rem; }
        .upload-zone { flex: 1; }
        .file-input-label {
            display: inline-block;
            background-color: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 12px 20px;
            cursor: pointer;
            font-weight: 500;
        }
        .file-input-label:hover { background-color: #e2e8f0; }
        .file-name { margin-left: 12px; color: #64748b; }
        #imageInput { display: none; }
        .drop-zone-active { border-color: #2c7da0 !important; background-color: #f0f9ff; }
        .sticky-create-btn {
            position: sticky;
            bottom: 2rem;
            text-align: center;
            z-index: 100;
        }
        .spinner-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1200;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar (đường dẫn tương đối, giữ nguyên include) -->
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0">
                    <i class="bi bi-plus-circle me-2" style="color:#2c7da0;"></i> Tạo banner mới
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/banners">Banner</a></li>
                        <li class="breadcrumb-item active">Tạo banner</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/banners" class="admin-btn-outline">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <!-- Hiển thị lỗi từ server nếu có -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form id="bannerForm" action="${pageContext.request.contextPath}/admin/banners/create" method="post" enctype="multipart/form-data">
            <!-- CSRF token nếu cần: <input type="hidden" name="csrfToken" value="${csrfToken}"> -->

            <!-- SECTION 1: Thông tin cơ bản -->
            <div class="info-section">
                <h5><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h5>
                <div class="row g-4">
                    <div class="col-md-8">
                        <label for="title" class="form-label">Tiêu đề banner <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tiêu đề banner..." value="${param.title}" required>
                        <div class="invalid-feedback">Vui lòng nhập tiêu đề</div>
                    </div>
                    <div class="col-md-4">
                        <label for="displayOrder" class="form-label">Thứ tự hiển thị</label>
                        <input type="number" class="form-control" id="displayOrder" name="displayOrder" value="0" min="0">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-8">
                        <label for="link" class="form-label">Đường dẫn (Link)</label>
                        <input type="text" class="form-control" id="link" name="link" placeholder="https://example.com hoặc /san-pham">
                    </div>
                    <div class="col-md-4">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status">
                            <option value="active" selected>Hoạt động</option>
                            <option value="inactive">Ẩn</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- SECTION 2: Hình ảnh banner (bắt buộc) -->
            <div class="info-section">
                <h5><i class="bi bi-image me-2"></i>Hình ảnh banner</h5>
                <label class="form-label mb-3">Tải ảnh lên <span class="text-danger">*</span> <span class="text-muted">(JPG, PNG, WEBP, tối đa 10MB)</span></label>
                <div class="upload-container">
                    <div class="preview-wrapper" id="previewWrapper">
                        <div class="preview-placeholder" id="placeholder">
                            <i class="bi bi-card-image"></i>
                            <span>Chưa có ảnh</span>
                        </div>
                        <img id="previewImg" src="#" alt="Preview" style="display: none;">
                    </div>
                    <div class="upload-zone">
                        <div id="dropZone" class="p-4 rounded-4 border text-center" style="border: 2px dashed #cbd5e1; background: #f8fafc;">
                            <i class="bi bi-cloud-arrow-up fs-2 d-block mb-2" style="color:#2c7da0;"></i>
                            <p class="mb-2 fw-medium">Kéo & thả ảnh banner vào đây</p>
                            <p class="text-muted small mb-3">Khuyến nghị: 1920x600px. JPG, PNG, WEBP ≤ 10MB</p>
                            <label for="imageInput" class="file-input-label">
                                <i class="bi bi-folder2-open me-2"></i> Chọn file
                            </label>
                            <input type="file" id="imageInput" name="image" accept="image/jpeg,image/png,image/webp" required>
                            <span class="file-name" id="fileNameDisplay"></span>
                        </div>
                        <div class="invalid-feedback d-block" id="imageError" style="display: none;">Vui lòng chọn ảnh banner</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 3: Mô tả -->
            <div class="info-section">
                <h5><i class="bi bi-file-text me-2"></i>Mô tả banner</h5>
                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập mô tả (không bắt buộc)...">${param.description}</textarea>
            </div>

            <!-- Sticky nút tạo -->
            <div class="sticky-create-btn">
                <button type="submit" id="createBannerBtn" class="admin-btn-primary btn-lg px-5">
                    <i class="bi bi-check-lg"></i> Tạo banner
                </button>
            </div>
        </form>
    </main>
</div>

<div class="spinner-overlay" id="loadingSpinner">
    <div class="spinner-border text-light" style="width: 3rem; height: 3rem;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ========== TOAST ==========
    function showToast(message, type = 'error') {
        const iconMap = { danger: 'error', warning: 'warning', success: 'success' };
        Swal.fire({ icon: iconMap[type] || 'error', text: message, toast: true, position: 'top-end', showConfirmButton: false, timer: 3000 });
    }

    // ========== PREVIEW ẢNH ==========
    const imgInput = document.getElementById('imageInput');
    const previewImg = document.getElementById('previewImg');
    const placeholderDiv = document.getElementById('placeholder');
    const previewWrapper = document.getElementById('previewWrapper');
    const fileNameSpan = document.getElementById('fileNameDisplay');
    const dropZone = document.getElementById('dropZone');
    const imageError = document.getElementById('imageError');

    function handleFile(file) {
        if (!file) { resetPreview(); return; }
        if (!file.type.startsWith('image/')) {
            showToast('Vui lòng chọn file ảnh (JPG, PNG, WEBP).', 'danger');
            resetPreview(); return;
        }
        if (file.size > 10 * 1024 * 1024) {
            showToast('Kích thước ảnh tối đa 10MB.', 'danger');
            resetPreview(); return;
        }
        fileNameSpan.textContent = file.name;
        const reader = new FileReader();
        reader.onload = function(e) {
            previewImg.src = e.target.result;
            previewImg.style.display = 'block';
            placeholderDiv.style.display = 'none';
            previewWrapper.classList.add('has-image');
            imageError.style.display = 'none';
        };
        reader.readAsDataURL(file);
    }

    function resetPreview() {
        previewImg.src = '#';
        previewImg.style.display = 'none';
        placeholderDiv.style.display = 'flex';
        previewWrapper.classList.remove('has-image');
        fileNameSpan.textContent = '';
        imgInput.value = '';
        imageError.style.display = 'none';
    }

    imgInput.addEventListener('change', (e) => {
        if (e.target.files.length) handleFile(e.target.files[0]);
        else resetPreview();
    });

    // Drag & drop
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(ev => {
        dropZone.addEventListener(ev, preventDefaults);
        document.body.addEventListener(ev, preventDefaults);
    });
    ['dragenter', 'dragover'].forEach(ev => {
        dropZone.addEventListener(ev, () => dropZone.classList.add('drop-zone-active'));
    });
    ['dragleave', 'drop'].forEach(ev => {
        dropZone.addEventListener(ev, () => dropZone.classList.remove('drop-zone-active'));
    });
    dropZone.addEventListener('drop', (e) => {
        const files = e.dataTransfer.files;
        if (files.length) {
            imgInput.files = files;
            handleFile(files[0]);
        }
    });
    function preventDefaults(e) { e.preventDefault(); e.stopPropagation(); }

    // ========== VALIDATION & SUBMIT ==========
    const form = document.getElementById('bannerForm');
    const titleInput = document.getElementById('title');

    form.addEventListener('submit', function(e) {
        e.preventDefault();
        let isValid = true;

        if (!titleInput.value.trim()) {
            titleInput.classList.add('is-invalid');
            isValid = false;
        } else {
            titleInput.classList.remove('is-invalid');
        }

        if (!imgInput.files.length) {
            imageError.style.display = 'block';
            imageError.innerText = 'Vui lòng chọn ảnh banner.';
            isValid = false;
        } else {
            imageError.style.display = 'none';
        }

        if (!isValid) {
            const firstError = document.querySelector('.is-invalid') || imageError;
            if (firstError) firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            return;
        }

        const btn = document.getElementById('createBannerBtn');
        const original = btn.innerHTML;
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang tạo...';
        document.getElementById('loadingSpinner').style.display = 'flex';

        form.submit();
    });

    // Cảnh báo khi rời trang chưa lưu
    let formChanged = false;
    document.querySelectorAll('#bannerForm input, #bannerForm select, #bannerForm textarea').forEach(el => {
        el.addEventListener('change', () => formChanged = true);
        el.addEventListener('input', () => formChanged = true);
    });
    window.addEventListener('beforeunload', (e) => {
        if (formChanged) {
            e.preventDefault();
            e.returnValue = 'Bạn có thay đổi chưa lưu. Rời trang sẽ mất dữ liệu.';
            return e.returnValue;
        }
    });
</script>
</body>
</html>