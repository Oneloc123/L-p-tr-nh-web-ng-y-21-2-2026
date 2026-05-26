<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sửa Banner | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ========== RESET & GLOBAL ========== */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
            color: #1e293b;
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

        /* ========== BUTTONS ========== */
        .admin-btn-primary {
            background-color: #2c7da0;
            border: none;
            padding: 8px 20px;
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
        }
        .admin-btn-outline {
            border: 1px solid #e2e8f0;
            background: transparent;
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
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
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .admin-btn-reset:hover { background-color: #f1f5f9; color: #1e293b; }

        /* ========== FORM CONTROLS ========== */
        .admin-input, .admin-select {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            color: #1e293b;
            border-radius: 14px;
            padding: 10px 16px;
            width: 100%;
        }
        .admin-input:focus, .admin-select:focus {
            background-color: #ffffff;
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
            color: #1e293b;
            outline: none;
        }
        .admin-textarea {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            color: #1e293b;
            border-radius: 14px;
            padding: 12px 16px;
            width: 100%;
            font-size: 0.95rem;
            transition: border-color 0.2s, box-shadow 0.2s;
            resize: vertical;
            min-height: 100px;
        }
        .admin-textarea:focus {
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
            outline: none;
        }
        .form-label { font-weight: 600; font-size: 0.85rem; color: #334155; margin-bottom: 0.5rem; }

        /* ========== INFO SECTIONS (consistent with product create/edit) ========== */
        .info-section {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s;
        }
        .info-section h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.2rem;
            color: #1e293b;
            border-left: 3px solid #2c7da0;
            padding-left: 0.75rem;
        }

        /* ========== IMAGE UPLOAD ========== */
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
            flex-shrink: 0;
            transition: border-color 0.2s;
        }
        .preview-wrapper.has-image { border-style: solid; border-color: #e2e8f0; }
        .preview-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .preview-placeholder { text-align: center; color: #94a3b8; }
        .preview-placeholder i { font-size: 3rem; display: block; margin-bottom: 0.5rem; }
        .upload-zone { flex: 1; min-width: 250px; }
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
        .file-input-label:hover { background-color: #e2e8f0; }
        .file-name { margin-left: 12px; color: #64748b; font-size: 0.9rem; }
        #imageInput { display: none; }
        .drop-zone-active { border-color: #2c7da0 !important; background-color: #f0f9ff; }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 992px) {
            .main-content { padding: 1rem; }


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
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0">
                    <i class="bi bi-pencil-square me-2" style="color:#2c7da0;"></i> Edit Banner
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/banners">Banners</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Edit</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/banners" class="admin-btn-outline text-decoration-none">
                    <i class="bi bi-arrow-left"></i> Back to Banners
                </a>
            </div>
        </header>

        <form action="/admin/banners/edit" method="post" enctype="multipart/form-data" id="bannerForm">
            <input type="hidden" name="id" value="${banner.id}">

            <!-- ========== SECTION 1: BASIC INFORMATION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-info-circle me-2"></i>Basic Information</h5>
                <div class="row g-4">
                    <div class="col-md-8">
                        <label for="title" class="form-label">Banner Title <span class="text-danger">*</span></label>
                        <input type="text" class="admin-input" id="title" name="title"
                               placeholder="Enter banner title..." value="${banner.title}" required>
                    </div>
                    <div class="col-md-4">
                        <label for="displayOrder" class="form-label">Display Order</label>
                        <input type="number" class="admin-input" id="displayOrder" name="displayOrder"
                               placeholder="0" value="${banner.sortOrder}" min="0">
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 2: DISPLAY SETTINGS ========== -->
            <div class="info-section">
                <h5><i class="bi bi-gear me-2"></i>Display Settings</h5>
                <div class="row g-4">
                    <div class="col-md-8">
                        <label for="link" class="form-label">Redirect Link</label>
                        <input type="text" class="admin-input" id="link" name="link"
                               placeholder="https://example.com or /products" value="${banner.redirectUrl}">
                    </div>
                    <div class="col-md-4">
                        <label for="status" class="form-label">Status</label>
                        <select class="admin-select" id="status" name="status">
                            <option value="active" ${banner.status.code == 1 ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${banner.status.code == 0 ? 'selected' : ''}>Hidden</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 3: IMAGE ========== -->
            <div class="info-section">
                <h5><i class="bi bi-image me-2"></i>Banner Image</h5>
                <label class="form-label mb-3">Current Image <span class="text-muted">(Leave empty to keep current)</span></label>
                <div class="upload-container">
                    <div class="preview-wrapper" id="previewWrapper">
                        <c:choose>
                            <c:when test="${not empty banner.imageUrl}">
                                <img id="previewImg" src="${banner.imageUrl}" alt="Current banner">
                                <div class="preview-placeholder" id="placeholder" style="display: none;">
                                    <i class="bi bi-card-image"></i>
                                    <span>No image</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <img id="previewImg" src="#" alt="Preview" style="display: none;">
                                <div class="preview-placeholder" id="placeholder">
                                    <i class="bi bi-card-image"></i>
                                    <span>No image</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="upload-zone">
                        <div id="dropZone"
                             class="p-4 rounded-4 border text-center"
                             style="border: 2px dashed #cbd5e1; background-color: #f8fafc; transition: 0.2s;">
                            <i class="bi bi-cloud-arrow-up fs-2 d-block mb-2" style="color:#2c7da0;"></i>
                            <p class="mb-2 fw-medium">Drag & drop new banner image (optional)</p>
                            <p class="text-muted small mb-3">Leave empty to keep current image. JPG, PNG, WEBP up to 10MB</p>
                            <label for="imageInput" class="file-input-label">
                                <i class="bi bi-folder2-open me-2"></i> Choose File
                            </label>
                            <input type="file" id="imageInput" name="image" accept="image/jpeg,image/png,image/webp">
                            <span class="file-name" id="fileNameDisplay"></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== SECTION 4: DESCRIPTION ========== -->
            <div class="info-section">
                <h5><i class="bi bi-file-text me-2"></i>Description</h5>
                <textarea class="admin-textarea" id="description" name="description"
                          rows="4" placeholder="Enter banner description...">${banner.description}</textarea>
            </div>

            <!-- ========== FORM ACTIONS ========== -->
            <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                <button type="reset" class="admin-btn-reset" id="resetBtn">
                    <i class="bi bi-arrow-counterclockwise"></i> Reset Changes
                </button>
                <a href="/admin/banners" class="admin-btn-outline text-decoration-none">
                    <i class="bi bi-x-lg"></i> Cancel
                </a>
                <button type="submit" class="admin-btn-primary">
                    <i class="bi bi-check2-circle"></i> Update Banner
                </button>
            </div>
        </form>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const originalImageSrc = '${banner.imageUrl}' || '';
    const imageInput = document.getElementById('imageInput');
    const previewImg = document.getElementById('previewImg');
    const placeholder = document.getElementById('placeholder');
    const previewWrapper = document.getElementById('previewWrapper');
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const dropZone = document.getElementById('dropZone');

    imageInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            handleFile(file);
        } else {
            restoreOriginalImage();
        }
    });

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, preventDefaults, false);
        document.body.addEventListener(eventName, preventDefaults, false);
    });
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
            imageInput.files = files;
            handleFile(files[0]);
        }
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    function handleFile(file) {
        if (!file) return;
        if (!file.type.startsWith('image/')) {
            alert('Please select an image file.');
            imageInput.value = '';
            restoreOriginalImage();
            return;
        }
        fileNameDisplay.textContent = file.name;
        const reader = new FileReader();
        reader.onload = function(e) {
            previewImg.src = e.target.result;
            previewImg.style.display = 'block';
            placeholder.style.display = 'none';
        };
        reader.readAsDataURL(file);
    }

    function restoreOriginalImage() {
        fileNameDisplay.textContent = '';
        imageInput.value = '';
        if (originalImageSrc) {
            previewImg.src = originalImageSrc;
            previewImg.style.display = 'block';
            placeholder.style.display = 'none';
        } else {
            previewImg.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    document.getElementById('resetBtn').addEventListener('click', function() {
        setTimeout(restoreOriginalImage, 10);
    });
</script>
</body>
</html>
