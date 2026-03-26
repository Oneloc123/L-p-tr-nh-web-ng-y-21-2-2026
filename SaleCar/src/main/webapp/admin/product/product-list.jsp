<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Sản phẩm | LUXCAR</title>
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

        /* ========== BUTTONS ========== */
        .admin-btn-primary {
            background-color: #2c7da0;
            border: none;
            padding: 8px 20px;
            font-weight: 600;
            border-radius: 40px;
            color: #ffffff;
            transition: 0.2s;
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
            padding: 8px 18px;
            border-radius: 30px;
            color: #64748b;
            transition: 0.2s;
        }

        .admin-btn-outline:hover {
            border-color: #2c7da0;
            color: #2c7da0;
            background-color: #f8fafc;
        }

        /* ========== FORM CONTROLS ========== */
        .admin-input,
        .admin-select {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            color: #1e293b;
            border-radius: 14px;
            padding: 10px 16px;
            width: 100%;
        }

        .admin-input:focus,
        .admin-select:focus {
            background-color: #ffffff;
            border-color: #2c7da0;
            box-shadow: 0 0 0 3px rgba(44,125,160,0.1);
            color: #1e293b;
            outline: none;
        }

        /* ========== CARD ========== */
        .admin-card {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }

        .admin-card-body {
            padding: 1.2rem;
        }

        /* ========== FILTER SIDEBAR ========== */
        .admin-filter-sidebar {
            background: white;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #e9edf2;
        }

        .admin-filter-sidebar h6 {
            color: #2c7da0;
            font-weight: 600;
        }

        /* ========== TABLE ========== */
        .admin-table {
            color: #1e293b;
            border-color: #e9edf2;
        }

        .admin-table thead {
            background-color: #f8fafc;
            color: #1e293b;
        }

        .admin-table th {
            font-weight: 600;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .admin-table-hover tbody tr:hover {
            background-color: #f8fafc;
        }

        /* ========== BADGES ========== */
        .admin-badge-status {
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .admin-badge-active {
            background-color: #e6f7ec;
            color: #2e7d5e;
            border: 0.5px solid #b8e0c2;
        }

        .admin-badge-inactive {
            background-color: #fff0f0;
            color: #c75c5c;
            border: 0.5px solid #f0c0c0;
        }

        .admin-badge-draft {
            background-color: #f0f0f0;
            color: #6c757d;
            border: 0.5px solid #e0e0e0;
        }

        .admin-badge-stock {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .admin-badge-stock-high {
            background-color: #e6f7ec;
            color: #2e7d5e;
        }

        .admin-badge-stock-medium {
            background-color: #fff8e8;
            color: #c9772e;
        }

        .admin-badge-stock-low {
            background-color: #fff0f0;
            color: #c75c5c;
        }

        /* ========== ACTION BUTTONS ========== */
        .admin-action-btn {
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

        .admin-action-view {
            background-color: #eef2ff;
            color: #2c7da0;
        }

        .admin-action-view:hover {
            background-color: #e0e8f5;
            color: #1f5e7a;
        }

        .admin-action-edit {
            background-color: #fff8e8;
            color: #c9772e;
        }

        .admin-action-edit:hover {
            background-color: #fff0dd;
            color: #b85f1a;
        }

        .admin-action-delete {
            background-color: #fff0f0;
            color: #c75c5c;
        }

        .admin-action-delete:hover {
            background-color: #ffe0e0;
            color: #b84c4c;
        }

        /* ========== PRODUCT SPECIFIC ========== */
        .product-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 12px;
            border: 1px solid #e9edf2;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .product-card {
            background: white;
            border-radius: 20px;
            border: 1px solid #e9edf2;
            overflow: hidden;
            transition: all 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .product-card-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-card-body {
            padding: 15px;
        }

        /* ========== BULK ACTIONS ========== */
        .admin-bulk-bar {
            background: white;
            border-radius: 16px;
            padding: 12px 20px;
            margin-bottom: 20px;
            display: none;
            border: 1px solid #e9edf2;
        }

        .admin-bulk-bar.show {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* ========== PAGINATION ========== */
        .admin-pagination {
            margin-top: 20px;
        }

        .admin-page-link {
            color: #2c7da0;
            border-radius: 10px;
            margin: 0 3px;
            padding: 8px 12px;
            text-decoration: none;
            border: 1px solid #e2e8f0;
            background: white;
        }

        .admin-page-item.active .admin-page-link {
            background-color: #2c7da0;
            border-color: #2c7da0;
            color: white;
        }

        .admin-page-item.disabled .admin-page-link {
            color: #cbd5e1;
            pointer-events: none;
        }

        /* ========== VIEW TOGGLE ========== */
        .admin-view-toggle {
            display: flex;
            gap: 10px;
        }

        .admin-view-toggle .admin-btn-outline.active {
            background-color: #2c7da0;
            color: white;
            border-color: #2c7da0;
        }

        /* ========== LOADING ========== */
        .admin-loading {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999;
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
    <%@ include file="/admin/sidebar/sidebar.jsp"%>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-box-seam me-2" style="color:#2c7da0;"></i> Quản lý sản phẩm</h3>
            <div>
                <button class="admin-btn-primary me-2" onclick="exportProducts()">
                    <i class="bi bi-download"></i> Export
                </button>
                <button class="admin-btn-primary" onclick="location.href='/createProduct'">
                    <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                </button>
            </div>
        </header>

        <!-- Search Bar -->
        <div class="mb-4">
            <div class="input-group">
                <input type="text" class="admin-input" id="searchKeyword" name="keyword" datatype="String"
                       placeholder="🔍 Tìm kiếm theo tên sản phẩm, SKU, danh mục..." onkeyup="searchProducts()">
                <button class="admin-btn-outline" onclick="searchProducts()">
                    <i class="bi bi-search"></i> Tìm
                </button>
            </div>
        </div>

        <!-- Filter Sidebar -->
        <div class="admin-filter-sidebar">
            <h6 class="mb-3"><i class="bi bi-funnel"></i> Bộ lọc nâng cao</h6>
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">Danh mục</label>
                    <select class="admin-select" id="filterCategory" name="categoryId" datatype="Long" onchange="filterProducts()">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach items="${categories}" var="cat">
                            <option value="${cat.id}">${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Trạng thái</label>
                    <select class="admin-select" id="filterStatus" name="status" datatype="String" onchange="filterProducts()">
                        <option value="">Tất cả</option>
                        <option value="active">Hoạt động</option>
                        <option value="inactive">Không hoạt động</option>
                        <option value="draft">Nháp</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Tồn kho</label>
                    <select class="admin-select" id="filterStock" name="stockStatus" datatype="String" onchange="filterProducts()">
                        <option value="">Tất cả</option>
                        <option value="high">Còn nhiều (>50)</option>
                        <option value="medium">Trung bình (10-50)</option>
                        <option value="low">Sắp hết (<10)</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Khoảng giá</label>
                    <div class="d-flex gap-2">
                        <input type="number" class="admin-input price-range-input" id="minPrice" name="minPrice"
                               datatype="double" placeholder="Từ" onchange="filterProducts()">
                        <input type="number" class="admin-input price-range-input" id="maxPrice" name="maxPrice"
                               datatype="double" placeholder="Đến" onchange="filterProducts()">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Ngày tạo từ</label>
                    <input type="date" class="admin-input" id="fromDate" name="fromDate" datatype="LocalDate" onchange="filterProducts()">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Đến ngày</label>
                    <input type="date" class="admin-input" id="toDate" name="toDate" datatype="LocalDate" onchange="filterProducts()">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Sắp xếp theo</label>
                    <select class="admin-select" id="sortBy" name="sortBy" datatype="String" onchange="filterProducts()">
                        <option value="name_asc">Tên A-Z</option>
                        <option value="name_desc">Tên Z-A</option>
                        <option value="price_asc">Giá tăng dần</option>
                        <option value="price_desc">Giá giảm dần</option>
                        <option value="createdAt_desc">Mới nhất</option>
                        <option value="createdAt_asc">Cũ nhất</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Hiển thị</label>
                    <div class="admin-view-toggle">
                        <button class="admin-btn-outline active" onclick="setView('table')">
                            <i class="bi bi-table"></i>
                        </button>
                        <button class="admin-btn-outline" onclick="setView('grid')">
                            <i class="bi bi-grid-3x3-gap-fill"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bulk Actions Bar -->
        <div id="bulkActionsBar" class="admin-bulk-bar">
            <span id="selectedCount">0</span> sản phẩm được chọn
            <button class="admin-action-delete" onclick="bulkDelete()">
                <i class="bi bi-trash"></i> Xóa
            </button>
            <button class="admin-action-edit" onclick="bulkChangeStatus()">
                <i class="bi bi-arrow-repeat"></i> Đổi trạng thái
            </button>
            <button class="admin-action-view" onclick="bulkAssignCategory()">
                <i class="bi bi-tags"></i> Gán danh mục
            </button>
            <button class="admin-btn-outline" onclick="clearSelection()">
                <i class="bi bi-x-lg"></i> Bỏ chọn
            </button>
        </div>

        <!-- Loading Spinner -->
        <div id="loadingSpinner" class="admin-loading">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>

        <!-- Product Table View -->
        <div id="tableView" class="product-table-view">
            <div class="admin-card shadow-sm">
                <div class="admin-card-body p-0">
                    <div class="table-responsive">
                        <table class="admin-table table table-hover align-middle mb-0">
                            <thead class="table-light">
                            <tr>
                                <th width="40">
                                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                                </th>
                                <th>ID</th>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>SKU</th>
                                <th>Giá gốc</th>
                                <th>Giá KM</th>
                                <th>Giảm giá</th>
                                <th>Danh mục</th>
                                <th>Tồn kho</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody id="productTableBody">
                            <!-- Dynamic content will be populated by JavaScript -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Grid View -->
        <div id="gridView" class="product-grid" style="display: none;">
            <!-- Dynamic content -->
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center admin-pagination" id="pagination">
                <!-- Dynamic pagination -->
            </ul>
        </nav>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Keep existing JavaScript functions, they work with the new class names
    // The functions remain unchanged as they only use IDs
    let currentView = 'table';
    let selectedProducts = new Set();
    let currentPage = 1;
    let totalPages = 1;

    document.addEventListener('DOMContentLoaded', function() {
        loadProducts();
    });

    // Rest of JavaScript remains the same...
    // [All existing JavaScript functions stay unchanged]

    function loadProducts() {
        showLoading();
        const params = getFilterParams();
        fetch('/api/products?' + new URLSearchParams(params))
            .then(response => response.json())
            .then(data => {
                currentPage = data.page;
                totalPages = data.totalPages;
                renderProducts(data.products);
                renderPagination();
                hideLoading();
            })
            .catch(error => {
                console.error('Error:', error);
                hideLoading();
                showError('Không thể tải danh sách sản phẩm');
            });
    }

    function getFilterParams() {
        return {
            page: currentPage,
            keyword: document.getElementById('searchKeyword').value,
            categoryId: document.getElementById('filterCategory').value,
            status: document.getElementById('filterStatus').value,
            stockStatus: document.getElementById('filterStock').value,
            minPrice: document.getElementById('minPrice').value,
            maxPrice: document.getElementById('maxPrice').value,
            fromDate: document.getElementById('fromDate').value,
            toDate: document.getElementById('toDate').value,
            sortBy: document.getElementById('sortBy').value
        };
    }

    function renderProducts(products) {
        if (currentView === 'table') {
            renderTableView(products);
        } else {
            renderGridView(products);
        }
        updateBulkActionsBar();
    }

    function renderTableView(products) {
        const tbody = document.getElementById('productTableBody');
        tbody.innerHTML = products.map(product => `
            <tr>
                <td><input type="checkbox" class="product-checkbox" value="${product.id}" onchange="toggleProductSelection(${product.id})"></td>
                <td>${product.id}</td>
                <td><img src="${product.thumbnail || '/assets/img/default-product.png'}" class="product-thumb" alt="${product.productName}"></td>
                <td class="fw-semibold">${product.productName}</td>
                <td><code>${product.sku}</code></td>
                <td>${formatCurrency(product.originalPrice)}</td>
                <td class="text-primary fw-bold">${formatCurrency(product.finalPrice)}</td>
                <td>${product.discountPercent}%</td>
                <td>${product.categoryName}</td>
                <td><span class="admin-badge-stock ${getStockClass(product.quantity)}">${product.quantity}</span></td>
                <td><span class="admin-badge-status ${getStatusClass(product.status)}">${getStatusText(product.status)}</span></td>
                <td>${formatDate(product.createdAt)}</td>
                <td>
                    <button class="admin-action-btn admin-action-view" onclick="viewProduct(${product.id})"><i class="bi bi-eye"></i></button>
                    <button class="admin-action-btn admin-action-edit" onclick="editProduct(${product.id})"><i class="bi bi-pencil-square"></i></button>
                    <button class="admin-action-btn admin-action-delete" onclick="deleteProduct(${product.id})"><i class="bi bi-trash"></i></button>
                    <button class="admin-action-btn admin-action-edit" onclick="duplicateProduct(${product.id})"><i class="bi bi-files"></i></button>
                </td>
            </tr>
        `).join('');
    }

    function renderGridView(products) {
        const grid = document.getElementById('gridView');
        grid.innerHTML = products.map(product => `
            <div class="product-card">
                <img src="${product.thumbnail || '/assets/img/default-product.png'}" class="product-card-img" alt="${product.productName}">
                <div class="product-card-body">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <h6 class="mb-0 fw-bold">${product.productName}</h6>
                        <input type="checkbox" class="product-checkbox" value="${product.id}" onchange="toggleProductSelection(${product.id})">
                    </div>
                    <code class="small">${product.sku}</code>
                    <div class="mt-2">
                        <span class="text-decoration-line-through text-muted small">${formatCurrency(product.originalPrice)}</span>
                        <span class="text-primary fw-bold ms-2">${formatCurrency(product.finalPrice)}</span>
                        <span class="badge bg-danger ms-2">-${product.discountPercent}%</span>
                    </div>
                    <div class="mt-2 d-flex justify-content-between align-items-center">
                        <span class="admin-badge-stock ${getStockClass(product.quantity)}"><i class="bi bi-box"></i> ${product.quantity}</span>
                        <span class="admin-badge-status ${getStatusClass(product.status)}">${getStatusText(product.status)}</span>
                    </div>
                    <div class="mt-3">
                        <button class="admin-action-btn admin-action-view btn-sm" onclick="viewProduct(${product.id})"><i class="bi bi-eye"></i> Xem</button>
                        <button class="admin-action-btn admin-action-edit btn-sm" onclick="editProduct(${product.id})"><i class="bi bi-pencil-square"></i> Sửa</button>
                    </div>
                </div>
            </div>
        `).join('');
    }

    function setView(view) {
        currentView = view;
        const tableView = document.getElementById('tableView');
        const gridView = document.getElementById('gridView');
        const btns = document.querySelectorAll('.admin-view-toggle .admin-btn-outline');

        if (view === 'table') {
            tableView.style.display = 'block';
            gridView.style.display = 'none';
            btns[0].classList.add('active');
            btns[1].classList.remove('active');
        } else {
            tableView.style.display = 'none';
            gridView.style.display = 'grid';
            btns[0].classList.remove('active');
            btns[1].classList.add('active');
        }
        loadProducts();
    }

    function toggleSelectAll() {
        const selectAll = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.product-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
            if (selectAll.checked) {
                selectedProducts.add(parseInt(checkbox.value));
            } else {
                selectedProducts.clear();
            }
        });
        updateBulkActionsBar();
    }

    function toggleProductSelection(productId) {
        if (selectedProducts.has(productId)) {
            selectedProducts.delete(productId);
        } else {
            selectedProducts.add(productId);
        }
        updateBulkActionsBar();
    }

    function updateBulkActionsBar() {
        const bar = document.getElementById('bulkActionsBar');
        const count = selectedProducts.size;
        document.getElementById('selectedCount').innerText = count;
        if (count > 0) {
            bar.classList.add('show');
        } else {
            bar.classList.remove('show');
        }
    }

    function clearSelection() {
        selectedProducts.clear();
        document.querySelectorAll('.product-checkbox').forEach(cb => cb.checked = false);
        updateBulkActionsBar();
    }

    function searchProducts() { currentPage = 1; loadProducts(); }
    function filterProducts() { currentPage = 1; loadProducts(); }

    function renderPagination() {
        const pagination = document.getElementById('pagination');
        let html = `
            <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="admin-page-link" href="#" onclick="changePage(1)">Đầu</a>
            </li>
            <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="admin-page-link" href="#" onclick="changePage(${currentPage - 1})">Trước</a>
            </li>
        `;
        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, currentPage + 2);
        for (let i = startPage; i <= endPage; i++) {
            html += `<li class="admin-page-item ${currentPage == i ? 'active' : ''}">
                        <a class="admin-page-link" href="#" onclick="changePage(${i})">${i}</a>
                     </li>`;
        }
        html += `
            <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="admin-page-link" href="#" onclick="changePage(${currentPage + 1})">Sau</a>
            </li>
            <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="admin-page-link" href="#" onclick="changePage(${totalPages})">Cuối</a>
            </li>
        `;
        pagination.innerHTML = html;
    }

    function changePage(page) {
        if (page >= 1 && page <= totalPages) {
            currentPage = page;
            loadProducts();
        }
    }

    function viewProduct(id) { window.location.href = '/productDetail?id=' + id; }
    function editProduct(id) { window.location.href = '/updateProduct?id=' + id; }

    function deleteProduct(id) {
        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) {
            fetch('/api/products/' + id, { method: 'DELETE' })
                .then(response => response.ok ? (showSuccess('Xóa thành công'), loadProducts()) : showError('Xóa thất bại'));
        }
    }

    function duplicateProduct(id) {
        if (confirm('Bạn có muốn nhân bản sản phẩm này?')) {
            fetch('/api/products/' + id + '/duplicate', { method: 'POST' })
                .then(response => response.ok ? (showSuccess('Nhân bản thành công'), loadProducts()) : showError('Nhân bản thất bại'));
        }
    }

    function bulkDelete() {
        if (confirm(`Xóa ${selectedProducts.size} sản phẩm?`)) {
            fetch('/api/products/bulk-delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ ids: Array.from(selectedProducts) })
            }).then(response => response.ok ? (showSuccess('Xóa thành công'), clearSelection(), loadProducts()) : showError('Xóa thất bại'));
        }
    }

    function exportProducts() { window.location.href = '/api/products/export?' + new URLSearchParams(getFilterParams()); }
    function getStockClass(q) { if (q > 50) return 'admin-badge-stock-high'; if (q >= 10) return 'admin-badge-stock-medium'; return 'admin-badge-stock-low'; }
    function getStatusClass(s) { return { 'active': 'admin-badge-active', 'inactive': 'admin-badge-inactive', 'draft': 'admin-badge-draft' }[s] || 'admin-badge-draft'; }
    function getStatusText(s) { return { 'active': 'Hoạt động', 'inactive': 'Không hoạt động', 'draft': 'Nháp' }[s] || s; }
    function formatDate(d) { return d ? new Date(d).toLocaleDateString('vi-VN') : ''; }
    function formatCurrency(amount) { return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount); }
    function showLoading() { document.getElementById('loadingSpinner').style.display = 'block'; }
    function hideLoading() { document.getElementById('loadingSpinner').style.display = 'none'; }
    function showSuccess(m) { alert(m); }
    function showError(m) { alert(m); }
    function bulkChangeStatus() { alert('Tính năng đang phát triển'); }
    function bulkAssignCategory() { alert('Tính năng đang phát triển'); }
</script>
</body>
</html>