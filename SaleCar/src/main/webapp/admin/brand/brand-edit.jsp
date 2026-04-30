<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 4/28/2026
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sửa Thương hiệu | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ========== RESET & GLOBAL ========== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }

        /* ========== SIDEBAR STYLES ========== */
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

        /* ========== MAIN CONTENT ========== */
        .main-content {
            flex: 1;
            padding: 2rem 2rem 3rem 2rem;
            background-color: #f1f5f9;
            overflow-y: auto;
        }

        /* ========== HEADER ========== */
        .admin-header {
            background: #ffffff;
            padding: 1rem 1.8rem;
            border-radius: 24px;
            margin-bottom: 2rem;
            border: 1px solid #e9edf2;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .admin-header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
            font-size: 0.85rem;
        }

        .breadcrumb-item a {
            color: #5a6e7c;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #2c7da0;
            font-weight: 500;
        }

        /* ========== BUTTONS ========== */
        .admin-btn-primary {
            background-color: #2c7da0;
            border: none;
            padding: 10px 24px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .admin-btn-primary:hover {
            background-color: #1f5e7a;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2);
            color: #fff;
        }

        .admin-btn-outline {
            border: 1px solid #e2e8f0;
            background: transparent;
            padding: 10px 20px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
            cursor: pointer;
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

        .admin-btn-reset {
            background-color: transparent;
            border: 1px solid #e2e8f0;
            padding: 10px 20px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
            cursor: pointer;
        }

        .admin-btn-reset:hover {
            background-color: #f1f5f9;
            color: #1e293b;
        }

        /* ========== FORM CONTROLS ========== */
        .admin-input,
        .admin-select,
        .admin-textarea {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            color: #1e293b;
            border-radius: 14px;
            padding: 12px 16px;
            width: 100%;
            font-size: 0.95rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .admin-input:focus,
        .admin-select:focus,
        .admin-textarea:focus {
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
            outline: none;
        }

        .admin-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
            color: #334155;
            margin-bottom: 0.4rem;
        }

        .text-danger {
            font-size: 0.8rem;
            margin-top: 0.3rem;
        }

        /* ========== CARD ========== */
        .admin-card {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
            padding: 2rem;
        }

        /* ========== LOGO UPLOAD ========== */
        .logo-upload-container {
            display: flex;
            align-items: start;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .logo-preview-wrapper {
            width: 150px;
            height: 150px;
            border-radius: 20px;
            border: 2px dashed #cbd5e1;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
            transition: border-color 0.2s;
        }

        .logo-preview-wrapper.has-image {
            border-style: solid;
            border-color: #e2e8f0;
        }

        .logo-preview-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 8px;
        }

        .logo-placeholder {
            text-align: center;
            color: #94a3b8;
        }

        .logo-placeholder i {
            font-size: 3rem;
            display: block;
            margin-bottom: 0.5rem;
        }

        .logo-upload-zone {
            flex: 1;
            min-width: 250px;
        }

        .file-input-label {
            display: inline-block;
            background-color: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 12px 20px;
            cursor: pointer;
            font-weight: 500;
            color: #334155;
            transition: 0.2s;
        }

        .file-input-label:hover {
            background-color: #e2e8f0;
        }

        .file-name {
            margin-left: 12px;
            color: #64748b;
            font-size: 0.9rem;
        }

        #logoInput {
            display: none;
        }

        .drop-zone-active {
            border-color: #2c7da0;
            background-color: #f0f9ff;
        }

        /* ========== ALERTS ========== */
        .admin-alert {
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid transparent;
            font-weight: 500;
        }

        .admin-alert-success {
            background-color: #ecfdf5;
            border-color: #a7f3d0;
            color: #065f46;
        }

        .admin-alert-error {
            background-color: #fef2f2;
            border-color: #fecaca;
            color: #991b1b;
        }

        /* ========== RESPONSIVE ========== */
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
    <!-- Include sidebar -->
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <main class="main-content">
        <!-- Header with Breadcrumb -->
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0">
                    <i class="bi bi-pencil-square me-2" style="color:#2c7da0;"></i> Edit Brand
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/brands">Brands</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Edit</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/brands" class="admin-btn-outline text-decoration-none">
                    <i class="bi bi-arrow-left"></i> Back to Brands
                </a>
            </div>
        </header>

        <!-- Success / Error messages -->
        <c:if test="${not empty successMessage}">
            <div class="admin-alert admin-alert-success d-flex align-items-center gap-3">
                <i class="bi bi-check-circle-fill fs-5"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="admin-alert admin-alert-error d-flex align-items-center gap-3">
                <i class="bi bi-exclamation-triangle-fill fs-5"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Form Card -->
        <div class="admin-card">
            <form action="/admin/brands/edit" method="post" enctype="multipart/form-data" id="brandForm">
                <!-- Hidden ID -->
                <input type="hidden" name="id" value="${brand.id}">

                <div class="row g-4">
                    <!-- Brand Name -->
                    <div class="col-md-6">
                        <label for="name" class="form-label">
                            Brand Name <span class="text-danger">*</span>
                        </label>
                        <input type="text"
                               class="admin-input"
                               id="name"
                               name="name"
                               placeholder="e.g. Ferrari, Porsche..."
                               value="${brand.name}"
                               required>
                        <c:if test="${not empty errors.name}">
                            <div class="text-danger">${errors.name}</div>
                        </c:if>
                    </div>

                    <!-- Link brand -->
                    <div class="col-md-4">
                        <label for="linkBrand" class="form-label">Link Brand</label>
                        <input type="text"
                               class="admin-input"
                               id="linkBrand"
                               name="linkBrand"
                               placeholder="${brand.name}.com"
                               value="${brand.linkBrand}">
                        <c:if test="${not empty errors.linkBrand}">
                            <div class="text-danger">${errors.linkBrand}</div>
                        </c:if>
                    </div>

                    <!-- Status -->
                    <div class="col-md-4">
                        <label for="status" class="form-label">Status</label>
                        <select class="admin-select" id="status" name="status">
                            <option value="active" ${brand.status == 'active' ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${brand.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <c:if test="${not empty errors.status}">
                            <div class="text-danger">${errors.status}</div>
                        </c:if>
                    </div>

                    <!-- Logo Upload -->
                    <div class="col-12">
                        <label class="form-label">Brand Logo</label>
                        <div class="logo-upload-container">
                            <!-- Preview -->
                            <div class="logo-preview-wrapper has-image" id="logoPreviewWrapper">
                                <!-- Current logo from server -->
                                <img id="logoPreviewImg"
                                     src="${brand.image}"
                                     alt="Current logo"
                                     class="img-fluid"
                                     onerror="this.style.display='none'; document.getElementById('logoPlaceholder').style.display='block';">
                                <div class="logo-placeholder" id="logoPlaceholder" style="display: none;">
                                    <i class="bi bi-image"></i>
                                    <span>No logo</span>
                                </div>
                            </div>
                            <!-- Upload zone -->
                            <div class="logo-upload-zone">
                                <div id="dropZone"
                                     class="p-4 rounded-4 border text-center"
                                     style="border: 2px dashed #cbd5e1; background-color: #f8fafc; transition: 0.2s;">
                                    <i class="bi bi-cloud-arrow-up fs-2 d-block mb-2" style="color:#2c7da0;"></i>
                                    <p class="mb-2 fw-medium">Drag & drop new logo here (optional)</p>
                                    <p class="text-muted small mb-3">Leave empty to keep current logo</p>
                                    <label for="logoInput" class="file-input-label">
                                        <i class="bi bi-folder2-open me-2"></i> Choose File
                                    </label>
                                    <input type="file"
                                           id="logoInput"
                                           name="logo"
                                           accept="image/*">
                                    <span class="file-name" id="fileNameDisplay"></span>
                                </div>
                                <c:if test="${not empty errors.image}">
                                    <div class="text-danger mt-2">${errors.image}</div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="col-12">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="admin-textarea"
                                  id="description"
                                  name="description"
                                  rows="5"
                                  placeholder="Enter brand description...">${brand.description}</textarea>
                        <c:if test="${not empty errors.description}">
                            <div class="text-danger">${errors.description}</div>
                        </c:if>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                    <button type="reset" class="admin-btn-reset" id="resetBtn">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset Changes
                    </button>
                    <a href="/admin/brands" class="admin-btn-outline text-decoration-none">
                        <i class="bi bi-x-lg"></i> Cancel
                    </a>
                    <button type="submit" class="admin-btn-primary">
                        <i class="bi bi-check2-circle"></i> Update Brand
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Lưu URL logo ban đầu để có thể khôi phục nếu người dùng hủy chọn file
    const originalLogoSrc = '${brand.image}';
    const logoInput = document.getElementById('logoInput');
    const logoPreviewImg = document.getElementById('logoPreviewImg');
    const logoPlaceholder = document.getElementById('logoPlaceholder');
    const logoPreviewWrapper = document.getElementById('logoPreviewWrapper');
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const dropZone = document.getElementById('dropZone');

    // Hiển thị logo hiện tại từ server (đã có sẵn trong src)
    // Nếu ảnh lỗi (onerror) thì ẩn và hiện placeholder (giống như đã xử lý trong HTML)

    // Preview khi chọn file mới
    logoInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            handleFile(file);
        } else {
            // Nếu người dùng cancel chọn file, khôi phục logo cũ
            restoreOriginalLogo();
        }
    });

    // Drag & drop
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, preventDefaults, false);
        document.body.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.add('drop-zone-active'), false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.remove('drop-zone-active'), false);
    });

    dropZone.addEventListener('drop', function(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        if (files.length > 0) {
            logoInput.files = files;
            handleFile(files[0]);
        }
    });

    function handleFile(file) {
        if (!file.type.startsWith('image/')) {
            alert('Please select an image file.');
            logoInput.value = '';
            restoreOriginalLogo();
            return;
        }

        fileNameDisplay.textContent = file.name;
        const reader = new FileReader();
        reader.onload = function(e) {
            logoPreviewImg.src = e.target.result;
            logoPreviewImg.style.display = 'block';
            logoPlaceholder.style.display = 'none';
            logoPreviewWrapper.classList.add('has-image');
        };
        reader.readAsDataURL(file);
    }

    function restoreOriginalLogo() {
        fileNameDisplay.textContent = '';
        logoInput.value = ''; // Xóa file đã chọn
        // Nếu có logo cũ từ server thì hiện lại
        if (originalLogoSrc && originalLogoSrc.trim() !== '') {
            logoPreviewImg.src = originalLogoSrc;
            logoPreviewImg.style.display = 'block';
            logoPlaceholder.style.display = 'none';
            logoPreviewWrapper.classList.add('has-image');
        } else {
            // Không có logo cũ, hiện placeholder
            logoPreviewImg.style.display = 'none';
            logoPlaceholder.style.display = 'block';
            logoPreviewWrapper.classList.remove('has-image');
        }
    }

    // Nút Reset: trả về trạng thái logo ban đầu
    document.getElementById('resetBtn').addEventListener('click', function(e) {
        // Form reset sẽ xóa hết input, nhưng logoInput không reset theo HTML (vì là file)
        // Ta cần chủ động khôi phục logo cũ sau một chút để form reset xong
        setTimeout(function() {
            restoreOriginalLogo();
        }, 10);
    });

    // Nếu người dùng xóa file đã chọn bằng cách nhấn lại "Choose File" và bấm Cancel,
    // trình duyệt sẽ giữ nguyên file cũ (file input không đổi), nhưng ta vẫn muốn khôi phục.
    // Ta có thể lắng nghe sự kiện change, nhưng khi cancel thì change không fire.
    // Để xử lý trường hợp này, thêm một trick: khi click vào label, ta lưu file hiện tại,
    // sau đó khi focus trở lại (sau dialog file), nếu file input vẫn giữ file cũ thì không làm gì,
    // nhưng nếu người dùng chọn file mới thì change sẽ fire.
    // Vì vậy, không cần thêm xử lý phức tạp, chỉ cần sự kiện change là đủ.
</script>
</body>
</html>