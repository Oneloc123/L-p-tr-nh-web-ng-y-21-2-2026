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
            cursor: pointer;
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
            cursor: pointer;
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
            cursor: pointer;
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
            cursor: pointer;
        }

        .admin-page-item.active .admin-page-link {
            background-color: #2c7da0;
            border-color: #2c7da0;
            color: white;
        }

        .admin-page-item.disabled .admin-page-link {
            color: #cbd5e1;
            pointer-events: none;
            cursor: not-allowed;
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
    <!-- Include sidebar (optional) -->
     <%@ include file="/admin/sidebar/sidebar.jsp"%>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-box-seam me-2" style="color:#2c7da0;"></i> Quản lý sản phẩm</h3>
            <div>
                <form action="/admin/products/export" method="get" style="display: inline-block;">
                    <input type="hidden" name="keyword" value="${param.keyword}">
                    <input type="hidden" name="categoryId" value="${param.categoryId}">
                    <input type="hidden" name="status" value="${param.status}">
                    <input type="hidden" name="stockStatus" value="${param.stockStatus}">
                    <input type="hidden" name="minPrice" value="${param.minPrice}">
                    <input type="hidden" name="maxPrice" value="${param.maxPrice}">
                    <input type="hidden" name="fromDate" value="${param.fromDate}">
                    <input type="hidden" name="toDate" value="${param.toDate}">
                    <button type="submit" class="admin-btn-primary me-2">
                        <i class="bi bi-download"></i> Export
                    </button>
                </form>
                <a href="/admin/products/create" class="admin-btn-primary text-decoration-none">
                    <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                </a>
            </div>
        </header>

        <!-- Search & Filter Form -->
        <form action="/admin/products" method="get" id="filterForm">
            <!-- Search Bar -->
            <div class="mb-4">
                <div class="input-group">
                    <input type="text" class="admin-input" id="searchKeyword" name="keyword"
                           placeholder="🔍 Tìm kiếm theo tên sản phẩm, SKU, danh mục..."
                           value="${param.keyword}">
                    <button type="submit" class="admin-btn-outline">
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
                        <select class="admin-select" id="filterCategory" name="categoryId" onchange="this.form.submit()">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Trạng thái</label>
                        <select class="admin-select" id="filterStatus" name="status" onchange="this.form.submit()">
                            <option value="">Tất cả</option>
                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                            <option value="draft" ${param.status == 'draft' ? 'selected' : ''}>Nháp</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Tồn kho</label>
                        <select class="admin-select" id="filterStock" name="stockStatus" onchange="this.form.submit()">
                            <option value="">Tất cả</option>
                            <option value="high" ${param.stockStatus == 'high' ? 'selected' : ''}>Còn nhiều (>50)</option>
                            <option value="medium" ${param.stockStatus == 'medium' ? 'selected' : ''}>Trung bình (10-50)</option>
                            <option value="low" ${param.stockStatus == 'low' ? 'selected' : ''}>Sắp hết (<10)</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Khoảng giá</label>
                        <div class="d-flex gap-2">
                            <input type="number" class="admin-input price-range-input" id="minPrice" name="minPrice"
                                   placeholder="Từ" value="${param.minPrice}">
                            <input type="number" class="admin-input price-range-input" id="maxPrice" name="maxPrice"
                                   placeholder="Đến" value="${param.maxPrice}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Ngày tạo từ</label>
                        <input type="date" class="admin-input" id="fromDate" name="fromDate" value="${param.fromDate}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Đến ngày</label>
                        <input type="date" class="admin-input" id="toDate" name="toDate" value="${param.toDate}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Sắp xếp theo</label>
                        <select class="admin-select" id="sortBy" name="sortBy" onchange="this.form.submit()">
                            <option value="name_asc" ${param.sortBy == 'name_asc' ? 'selected' : ''}>Tên A-Z</option>
                            <option value="name_desc" ${param.sortBy == 'name_desc' ? 'selected' : ''}>Tên Z-A</option>
                            <option value="price_asc" ${param.sortBy == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                            <option value="price_desc" ${param.sortBy == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                            <option value="createdAt_desc" ${param.sortBy == 'createdAt_desc' ? 'selected' : ''}>Mới nhất</option>
                            <option value="createdAt_asc" ${param.sortBy == 'createdAt_asc' ? 'selected' : ''}>Cũ nhất</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <div>
                            <button type="submit" class="admin-btn-primary w-100">
                                <i class="bi bi-funnel"></i> Áp dụng bộ lọc
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hidden fields for pagination -->
            <input type="hidden" name="page" id="page" value="${currentPage}">
        </form>

        <!-- Product Table View -->
        <div id="tableView" class="product-table-view">
            <div class="admin-card shadow-sm">
                <div class="admin-card-body p-0">
                    <div class="table-responsive">
                        <table class="admin-table table table-hover align-middle mb-0">
                            <thead class="table-light">
                            <tr>
                                <th width="40">
                                    <input type="checkbox" id="selectAll">
                                </th>
                                <th>ID</th>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>id</th>
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
                            <c:forEach items="${products}" var="product">
                                <tr>
                                    <td><input type="checkbox" class="product-checkbox" value="${product.id}"></td>
                                    <td>${product.id}</td>
                                    <td><img src="${product.image != null ? product.image : '/assets/img/default-product.png'}" class="product-thumb" alt="${product.name}"></td>
                                    <td class="fw-semibold">${product.name}</td>
                                    <td><code>${product.id}</code></td>
                                    <td><fmt:formatNumber value="${product.price}" type="currency" /></td>
                                    <td class="text-primary fw-bold"><fmt:formatNumber value="${product.finalPrice}" type="currency" /></td>
                                    <td class="text-danger fw-bold">${product.discountPercent}%</td>
                                    <td>${product.categoryName}</td>
                                    <td>
<%--                                            <span class="admin-badge-stock--%>
<%--                                                ${product.quantity > 50 ? 'admin-badge-stock-high' :--%>
<%--                                                  (product.quantity >= 10 ? 'admin-badge-stock-medium' : 'admin-badge-stock-low')}">--%>
<%--                                                    ${product.quantity}--%>
<%--                                            </span>--%>1
                                    </td>
                                    <td>
                                            <span class="admin-badge-status
                                                ${product.status == 1 ? 'admin-badge-active' :
                                                  (product.status == 0 ? 'admin-badge-inactive' : 'admin-badge-draft')}">
                                                    ${product.status == 1 ? 'Hoạt động' : (product.status == 0 ? 'Không hoạt động' : 'Nháp')}
                                            </span>
                                    </td>
                                    <td><fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <a href="/admin/products/detail?id=${product.id}" class="admin-action-btn admin-action-view text-decoration-none">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <a href="/admin/products/edit?id=${product.id}" class="admin-action-btn admin-action-edit text-decoration-none">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <form action="/admin/products/delete" method="post" style="display: inline-block;"
                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                            <input type="hidden" name="id" value="${product.id}">
                                            <button type="submit" class="admin-action-btn admin-action-delete border-0">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                        <a href="/admin/products/duplicate?id=${product.id}" class="admin-action-btn admin-action-edit text-decoration-none"
                                           onclick="return confirm('Bạn có muốn nhân bản sản phẩm này?');">
                                            <i class="bi bi-files"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty products}">
                                <tr>
                                    <td colspan="13" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block"></i>
                                        Không có sản phẩm nào
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center admin-pagination" id="pagination">
                <c:if test="${totalPages > 1}">
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="?page=1&keyword=${param.keyword}&categoryId=${param.categoryId}&status=${param.status}&stockStatus=${param.stockStatus}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}">
                            Đầu
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="?page=${currentPage - 1}&keyword=${param.keyword}&categoryId=${param.categoryId}&status=${param.status}&stockStatus=${param.stockStatus}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}">
                            Trước
                        </a>
                    </li>

                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                    <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}"/>

                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="admin-page-item ${currentPage == i ? 'active' : ''}">
                            <a class="admin-page-link" href="?page=${i}&keyword=${param.keyword}&categoryId=${param.categoryId}&status=${param.status}&stockStatus=${param.stockStatus}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}">
                                    ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="?page=${currentPage + 1}&keyword=${param.keyword}&categoryId=${param.categoryId}&status=${param.status}&stockStatus=${param.stockStatus}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}">
                            Sau
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="?page=${totalPages}&keyword=${param.keyword}&categoryId=${param.categoryId}&status=${param.status}&stockStatus=${param.stockStatus}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}">
                            Cuối
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </main>
</div>

<script>

    // Chọn 1 sản phẩm
    const selectAllCheckbox = document.getElementById('selectAll');
    const productCheckboxes = document.querySelectorAll('.product-checkbox');

    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            productCheckboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
        });
    }

    // Optional: Maintain selected state (client-side only)
    productCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            if (selectAllCheckbox) {
                const allChecked = Array.from(productCheckboxes).every(cb => cb.checked);
                selectAllCheckbox.checked = allChecked;
            }
        });
    });
</script>
</body>
</html>