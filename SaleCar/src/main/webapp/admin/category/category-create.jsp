<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 4/30/2026
  Time: 13:00
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Tạo Danh mục | LUXCAR</title>
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

        /* ========== SLUG LOCK BUTTON ========== */
        .slug-input-wrapper {
            position: relative;
        }

        .slug-lock-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #64748b;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 8px;
            transition: 0.2s;
            font-size: 1.1rem;
        }

        .slug-lock-btn:hover {
            background-color: #f1f5f9;
            color: #2c7da0;
        }

        .readonly-highlight {
            background-color: #f8fafc;
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
                    <i class="bi bi-plus-circle me-2" style="color:#2c7da0;"></i> Create Category
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/categories">Categories</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Create</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/categories" class="admin-btn-outline text-decoration-none">
                    <i class="bi bi-arrow-left"></i> Back to Categories
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
            <form action="/admin/categories/create" method="post" id="categoryForm">
                <div class="row g-4">

                    <!-- Icon -->
                    <div class="col-md-6">
                        <label for="icon" class="form-label">
                            Icon <span class="text-danger">*</span>
                        </label>
                        <input type="text"
                               class="admin-input"
                               id="icon"
                               name="icon"
                               placeholder="e.g. bi-icon"
                               value="${param.icon}"
                               required>
                        <c:if test="${not empty errors.icon}">
                            <div class="text-danger">${errors.icon}</div>
                        </c:if>
                    </div>

                    <!-- Category Name -->
                    <div class="col-md-6">
                        <label for="name" class="form-label">
                            Category Name <span class="text-danger">*</span>
                        </label>
                        <input type="text"
                               class="admin-input"
                               id="name"
                               name="name"
                               placeholder="e.g. Sedan, SUV, Sport..."
                               value="${param.name}"
                               required>
                        <c:if test="${not empty errors.name}">
                            <div class="text-danger">${errors.name}</div>
                        </c:if>
                    </div>

<%--                    <!-- Slug -->--%>
<%--                    <div class="col-md-6">--%>
<%--                        <label for="slug" class="form-label">--%>
<%--                            Slug--%>
<%--                            <i class="bi bi-info-circle ms-1 text-muted"--%>
<%--                               data-bs-toggle="tooltip"--%>
<%--                               title="URL-friendly version of the name. Auto-generated if locked."></i>--%>
<%--                        </label>--%>
<%--                        <div class="slug-input-wrapper">--%>
<%--                            <input type="text"--%>
<%--                                   class="admin-input readonly-highlight"--%>
<%--                                   id="slug"--%>
<%--                                   name="slug"--%>
<%--                                   placeholder="e.g. sedan, suv"--%>
<%--                                   value="${param.slug}"--%>
<%--                                   readonly>--%>
<%--                            <button type="button" class="slug-lock-btn" id="slugLockBtn"--%>
<%--                                    data-bs-toggle="tooltip" title="Click to edit slug">--%>
<%--                                <i class="bi bi-lock-fill" id="slugLockIcon"></i>--%>
<%--                            </button>--%>
<%--                        </div>--%>
<%--                        <c:if test="${not empty errors.slug}">--%>
<%--                            <div class="text-danger">${errors.slug}</div>--%>
<%--                        </c:if>--%>
<%--                        <div class="form-text small text-muted">--%>
<%--                            Preview: /category/<span id="slugPreview">${empty param.slug ? '...' : param.slug}</span>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                    <!-- Status -->
                    <div class="col-md-4">
                        <label for="status" class="form-label">Status</label>
                        <select class="admin-select" id="status" name="status">
                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
<%--                            <option value="hidden" ${param.status == 'hidden' ? 'selected' : ''}>Hidden</option>--%>
                        </select>
                        <c:if test="${not empty errors.status}">
                            <div class="text-danger">${errors.status}</div>
                        </c:if>
                    </div>

                    <!-- Description -->
                    <div class="col-12">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="admin-textarea"
                                  id="description"
                                  name="description"
                                  rows="5"
                                  placeholder="Enter category description...">${param.description}</textarea>
                        <c:if test="${not empty errors.description}">
                            <div class="text-danger">${errors.description}</div>
                        </c:if>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                    <button type="reset" class="admin-btn-reset" id="resetBtn">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset Form
                    </button>
                    <a href="/admin/categories" class="admin-btn-outline text-decoration-none">
                        <i class="bi bi-x-lg"></i> Cancel
                    </a>
                    <button type="submit" class="admin-btn-primary">
                        <i class="bi bi-check2-circle"></i> Create Category
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ========== TOOLTIPS INIT ==========
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });

    // ========== SLUG GENERATOR (handles Vietnamese characters) ==========
    function generateSlug(name) {
        if (!name) return '';
        // Chuẩn hóa Unicode NFD để tách dấu
        var normalized = name.normalize('NFD');
        // Loại bỏ các ký tự tổ hợp dấu (dấu thanh, dấu mũ, ...)
        var withoutDiacritics = normalized.replace(/[\u0300-\u036f]/g, '');
        // Loại bỏ ký tự đặc biệt, giữ lại chữ cái, số, khoảng trắng và dấu gạch ngang
        var cleaned = withoutDiacritics.replace(/[^a-zA-Z0-9\s-]/g, '');
        // Thay thế khoảng trắng bằng dấu gạch ngang
        var slug = cleaned.trim().replace(/\s+/g, '-');
        // Loại bỏ dấu gạch ngang thừa
        slug = slug.replace(/-+/g, '-');
        // Xóa dấu gạch ngang ở đầu và cuối
        slug = slug.replace(/^-|-$/g, '');
        return slug.toLowerCase();
    }

    // ========== SLUG LOCK / UNLOCK MECHANISM ==========
    var slugInput = document.getElementById('slug');
    var slugLockBtn = document.getElementById('slugLockBtn');
    var slugLockIcon = document.getElementById('slugLockIcon');
    var nameInput = document.getElementById('name');
    var slugPreview = document.getElementById('slugPreview');
    var slugLocked = true;

    function updateSlugFromName() {
        if (slugLocked) {
            var newSlug = generateSlug(nameInput.value);
            slugInput.value = newSlug;
            slugPreview.textContent = newSlug || '...';
        }
    }

    nameInput.addEventListener('input', updateSlugFromName);

    slugLockBtn.addEventListener('click', function() {
        slugLocked = !slugLocked;
        if (slugLocked) {
            slugInput.readOnly = true;
            slugInput.classList.add('readonly-highlight');
            slugLockIcon.className = 'bi bi-lock-fill';
            slugLockBtn.setAttribute('data-bs-original-title', 'Click to edit slug');
            updateSlugFromName();
        } else {
            slugInput.readOnly = false;
            slugInput.classList.remove('readonly-highlight');
            slugLockIcon.className = 'bi bi-unlock-fill';
            slugLockBtn.setAttribute('data-bs-original-title', 'Click to lock slug (auto-generate)');
            slugInput.focus();
        }
        var tooltip = bootstrap.Tooltip.getInstance(slugLockBtn);
        if (tooltip) tooltip.dispose();
        new bootstrap.Tooltip(slugLockBtn);
    });

    // Lắng nghe thay đổi trực tiếp trên slug input khi mở khóa để cập nhật preview
    slugInput.addEventListener('input', function() {
        if (!slugLocked) {
            slugPreview.textContent = slugInput.value || '...';
        }
    });

    // ========== RESET FORM ==========
    document.getElementById('resetBtn').addEventListener('click', function() {
        setTimeout(function() {
            if (slugLocked) {
                updateSlugFromName();
            } else {
                slugPreview.textContent = slugInput.value || '...';
            }
        }, 10);
    });

    // Khởi tạo: nếu form load lần đầu với param trống, tạo slug từ name rỗng (sẽ là rỗng)
    // Nếu có param.name (do validation lỗi) và slug rỗng, tạo slug
    if (slugLocked && nameInput.value.trim() !== '') {
        updateSlugFromName();
    }
</script>
</body>
</html>
