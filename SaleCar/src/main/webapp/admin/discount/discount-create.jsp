<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Tạo Discount | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* ========== RESET & GLOBAL ========== */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }
        .sidebar {
            width: 280px; background-color: #ffffff; border-right: 1px solid #e9edf2;
            height: 100vh; position: sticky; top: 0; padding: 2rem 1.2rem; transition: all 0.3s;
        }
        .logo {
            font-size: 1.6rem; font-weight: 700;
            background: linear-gradient(135deg, #1e2a3a, #2c7da0);
            -webkit-background-clip: text; background-clip: text; color: transparent;
            margin-bottom: 2.5rem; letter-spacing: -0.5px;
        }
        .logo i { background: none; color: #2c7da0; }
        .sidebar nav ul { list-style: none; padding: 0; }
        .sidebar nav ul li { margin-bottom: 0.6rem; }
        .sidebar nav ul li a {
            display: flex; align-items: center; gap: 14px;
            padding: 12px 18px; border-radius: 14px;
            color: #5a6e7c; font-weight: 500; text-decoration: none;
            transition: all 0.2s ease; font-size: 0.95rem;
        }
        .sidebar nav ul li a i { font-size: 1.3rem; width: 24px; }
        .sidebar nav ul li a:hover, .sidebar nav ul li a.active {
            background-color: #f0f9ff; color: #2c7da0;
            box-shadow: 0 2px 4px rgba(44,125,160,0.08); border-left: 2px solid #2c7da0;
        }
        .main-content { flex: 1; padding: 2rem 2rem 3rem 2rem; background-color: #f1f5f9; overflow-y: auto; }
        .admin-header {
            background: #ffffff; padding: 1rem 1.8rem; border-radius: 24px;
            margin-bottom: 2rem; border: 1px solid #e9edf2; box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }
        .admin-header h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #1e293b, #2c7da0);
            -webkit-background-clip: text; background-clip: text; color: transparent;
        }
        .breadcrumb { background: transparent; padding: 0; margin: 0; font-size: 0.85rem; }
        .breadcrumb-item a { color: #5a6e7c; text-decoration: none; }
        .breadcrumb-item.active { color: #2c7da0; font-weight: 500; }
        .admin-btn-primary {
            background-color: #2c7da0; border: none; padding: 10px 24px;
            font-weight: 600; border-radius: 40px; color: #ffffff;
            transition: 0.2s; cursor: pointer; display: inline-flex; align-items: center; gap: 8px;
        }
        .admin-btn-primary:hover {
            background-color: #1f5e7a; transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(44,125,160,0.2); color: #fff;
        }
        .admin-btn-outline {
            border: 1px solid #e2e8f0; background: transparent;
            padding: 10px 20px; border-radius: 30px; color: #64748b;
            transition: 0.2s; cursor: pointer; text-decoration: none;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .admin-btn-outline:hover { border-color: #2c7da0; color: #2c7da0; background-color: #f8fafc; }
        .admin-btn-reset {
            background-color: transparent; border: 1px solid #e2e8f0;
            padding: 10px 20px; border-radius: 30px; color: #64748b;
            transition: 0.2s; cursor: pointer;
        }
        .admin-btn-reset:hover { background-color: #f1f5f9; color: #1e293b; }
        .admin-input, .admin-select {
            background-color: #ffffff; border: 1px solid #e2e8f0;
            color: #1e293b; border-radius: 14px; padding: 12px 16px;
            width: 100%; font-size: 0.95rem; transition: border-color 0.2s, box-shadow 0.2s;
        }
        .admin-input:focus, .admin-select:focus {
            border-color: #2c7da0; box-shadow: 0 0 0 3px rgba(44,125,160,0.1); outline: none;
        }
        .form-label { font-weight: 500; font-size: 0.9rem; color: #334155; margin-bottom: 0.4rem; }
        .admin-card {
            background: #ffffff; border: 1px solid #e9edf2;
            border-radius: 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.03); padding: 2rem;
        }
        .text-danger { font-size: 0.8rem; margin-top: 0.3rem; }
        @media (max-width: 992px) {
            .sidebar { width: 80px; padding: 1rem 0.5rem; }
            .sidebar .logo span, .sidebar nav ul li a span { display: none; }
            .sidebar nav ul li a i { font-size: 1.5rem; }
            .main-content { padding: 1rem; }
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
                    <i class="bi bi-plus-circle me-2" style="color:#2c7da0;"></i> Tạo Discount
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/discounts">Discounts</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Create</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/discounts" class="admin-btn-outline text-decoration-none">
                    <i class="bi bi-arrow-left"></i> Back to Discounts
                </a>
            </div>
        </header>

        <div class="admin-card">
            <form action="/admin/discounts/create" method="post" id="discountForm">
                <div class="row g-4">
                    <!-- Discount Name -->
                    <div class="col-md-6">
                        <label for="name" class="form-label">Tên discount <span class="text-danger">*</span></label>
                        <input type="text" class="admin-input" id="name" name="name"
                               placeholder="VD: Sale Tết 2026, Black Friday..." required>
                    </div>

                    <!-- Value Type -->
                    <div class="col-md-3">
                        <label for="valueType" class="form-label">Loại <span class="text-danger">*</span></label>
                        <select class="admin-select" id="valueType" name="valueType" required>
                            <option value="rate">Phần trăm (%)</option>
                            <option value="amount">Số tiền cố định</option>
                        </select>
                    </div>

                    <!-- Value -->
                    <div class="col-md-3">
                        <label for="value" class="form-label">Giá trị <span class="text-danger">*</span></label>
                        <input type="number" class="admin-input" id="value" name="value"
                               min="0" step="0.01" placeholder="VD: 10" required>
                        <small class="text-muted" id="valueHint">Nhập phần trăm giảm (0-100)</small>
                    </div>

                    <!-- Entity Type -->
                    <div class="col-md-4">
                        <label for="entityType" class="form-label">Áp dụng cho <span class="text-danger">*</span></label>
                        <select class="admin-select" id="entityType" name="entityType" required>
                            <option value="">-- Chọn đối tượng --</option>
                            <option value="product">Sản phẩm</option>
                            <option value="category">Danh mục</option>
                            <option value="brand">Thương hiệu</option>
                        </select>
                    </div>

                    <!-- Entity Selection - Product -->
                    <div class="col-md-4 entity-select" id="productSelect" style="display:none;">
                        <label for="productId" class="form-label">Nhập ID sản phẩm <span class="text-danger">*</span></label>
                        <input type="number" class="admin-input" id="productId" name="entityId"
                               placeholder="VD: 123" min="1" disabled>
                        <small class="text-muted">Nhập ID của sản phẩm muốn áp dụng discount</small>
                    </div>

                    <!-- Entity Selection - Category -->
                    <div class="col-md-4 entity-select" id="categorySelect" style="display:none;">
                        <label for="categoryId" class="form-label">Chọn danh mục <span class="text-danger">*</span></label>
                        <select class="admin-select" id="categoryId" name="entityId">
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="ct">
                                <option value="${ct.id}">${ct.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Entity Selection - Brand -->
                    <div class="col-md-4 entity-select" id="brandSelect" style="display:none;">
                        <label for="brandId" class="form-label">Chọn thương hiệu <span class="text-danger">*</span></label>
                        <select class="admin-select" id="brandId" name="entityId">
                            <option value="">-- Chọn thương hiệu --</option>
                            <c:forEach items="${brands}" var="br">
                                <option value="${br.id}">${br.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Start Date -->
                    <div class="col-md-3">
                        <label for="startDate" class="form-label">Ngày bắt đầu <span class="text-danger">*</span></label>
                        <input type="date" class="admin-input" id="startDate" name="startDate"
                               value="${today}" required>
                    </div>

                    <!-- End Date -->
                    <div class="col-md-3">
                        <label for="endDate" class="form-label">Ngày kết thúc <span class="text-danger">*</span></label>
                        <input type="date" class="admin-input" id="endDate" name="endDate"
                               value="${thirtyDaysLater}">
                        <small class="text-muted">Mặc định: 30 ngày sau</small>
                    </div>

                    <!-- Status -->
                    <div class="col-md-2">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="admin-select" id="status" name="status">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                    <button type="reset" class="admin-btn-reset" id="resetBtn">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset
                    </button>
                    <a href="/admin/discounts" class="admin-btn-outline text-decoration-none">
                        <i class="bi bi-x-lg"></i> Hủy
                    </a>
                    <button type="submit" class="admin-btn-primary">
                        <i class="bi bi-check2-circle"></i> Tạo Discount
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ========== ENTITY TYPE TOGGLE ==========
    const entityTypeSelect = document.getElementById('entityType');
    const productSelect = document.getElementById('productSelect');
    const categorySelect = document.getElementById('categorySelect');
    const brandSelect = document.getElementById('brandSelect');

    entityTypeSelect.addEventListener('change', function() {
        // Hide all entity selects
        document.querySelectorAll('.entity-select').forEach(el => el.style.display = 'none');
        // Disable all entity selects to prevent validation issues
        document.querySelectorAll('.entity-select select').forEach(el => el.disabled = true);

        const type = this.value;
        if (type === 'product') {
            productSelect.style.display = 'block';
            document.getElementById('productId').disabled = false;
        } else if (type === 'category') {
            categorySelect.style.display = 'block';
            document.getElementById('categoryId').disabled = false;
        } else if (type === 'brand') {
            brandSelect.style.display = 'block';
            document.getElementById('brandId').disabled = false;
        }
    });

    // ========== VALUE TYPE HINT ==========
    const valueTypeSelect = document.getElementById('valueType');
    const valueHint = document.getElementById('valueHint');

    valueTypeSelect.addEventListener('change', function() {
        if (this.value === 'rate') {
            valueHint.textContent = 'Nhập phần trăm giảm (0-100)';
            document.getElementById('value').setAttribute('max', '100');
        } else {
            valueHint.textContent = 'Nhập số tiền giảm (VNĐ)';
            document.getElementById('value').removeAttribute('max');
        }
    });

    // ========== SET DEFAULT DATES ==========
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date();
        const todayStr = today.toISOString().split('T')[0];
        const thirtyDaysLater = new Date(today.getTime() + 30 * 24 * 60 * 60 * 1000);
        const thirtyDaysStr = thirtyDaysLater.toISOString().split('T')[0];

        if (!document.getElementById('startDate').value) {
            document.getElementById('startDate').value = todayStr;
        }
        if (!document.getElementById('endDate').value) {
            document.getElementById('endDate').value = thirtyDaysStr;
        }
    });
</script>
</body>
</html>
