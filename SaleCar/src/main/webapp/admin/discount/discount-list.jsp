<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Discount | LUXCAR</title>
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

        .admin-btn-danger {
            background-color: #dc2626;
            border: none;
            padding: 6px 16px;
            font-weight: 500;
            border-radius: 40px;
            color: white;
            transition: 0.2s;
            cursor: pointer;
        }

        .admin-btn-danger:hover {
            background-color: #b91c1c;
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

        .admin-badge-upcoming {
            background-color: #fff8e8;
            color: #c9772e;
            border: 0.5px solid #f0dbaa;
        }

        .admin-badge-expired {
            background-color: #f0f0f0;
            color: #94a3b8;
            border: 0.5px solid #e0e0e0;
        }

        .admin-badge-type {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .admin-badge-percent {
            background-color: #eef2ff;
            color: #4f46e5;
        }

        .admin-badge-amount {
            background-color: #fef3c7;
            color: #d97706;
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

            .main-content {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Include sidebar -->
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <main class="main-content">
        <!-- Header với Breadcrumb -->
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0">
                    <i class="bi bi-percent me-2" style="color:#2c7da0;"></i> Quản lý Discount
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Discounts</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/discounts/create" class="admin-btn-primary text-decoration-none">
                    <i class="bi bi-plus-lg"></i> Thêm Discount
                </a>
            </div>
        </header>

        <!-- Phần bộ lọc -->
        <form action="/admin/discounts" method="get" id="filterForm">
            <div class="admin-filter-sidebar">
                <h6 class="mb-3"><i class="bi bi-funnel"></i> Bộ lọc</h6>
                <div class="row g-3">
                    <!-- Lọc thời gian -->
                    <div class="col-md-3">
                        <label class="form-label">Thời gian hoạt động</label>
                        <select class="admin-select" name="timeStatus" onchange="this.form.submit()">
                            <option value="all" ${param.timeStatus == 'all' || empty param.timeStatus ? 'selected' : ''}>Tất cả</option>
                            <option value="active" ${param.timeStatus == 'active' ? 'selected' : ''}>Đang hoạt động</option>
                            <option value="upcoming" ${param.timeStatus == 'upcoming' ? 'selected' : ''}>Sắp diễn ra</option>
                            <option value="expired" ${param.timeStatus == 'expired' ? 'selected' : ''}>Đã kết thúc</option>
                        </select>
                    </div>

                    <!-- Lọc thương hiệu -->
                    <div class="col-md-3">
                        <label class="form-label">Thương hiệu</label>
                        <select class="admin-select" name="brandId" onchange="this.form.submit()">
                            <option value="">Tất cả thương hiệu</option>
                            <c:forEach items="${brands}" var="br">
                                <option value="${br.id}" ${param.brandId == br.id ? 'selected' : ''}>${br.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Lọc danh mục -->
                    <div class="col-md-3">
                        <label class="form-label">Danh mục</label>
                        <select class="admin-select" name="categoryId" onchange="this.form.submit()">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="ct">
                                <option value="${ct.id}" ${param.categoryId == ct.id ? 'selected' : ''}>${ct.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Lọc sản phẩm -->
                    <div class="col-md-3">
                        <label class="form-label">Sản phẩm</label>
                        <select class="admin-select" name="productId" onchange="this.form.submit()">
                            <option value="">Tất cả sản phẩm</option>
                            <c:forEach items="${products}" var="p">
                                <option value="${p.id}" ${param.productId == p.id ? 'selected' : ''}>${p.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="mt-3">
                    <a href="/admin/discounts" class="admin-btn-outline text-decoration-none">
                        <i class="bi bi-x-circle"></i> Xóa bộ lọc
                    </a>
                </div>
            </div>

            <!-- Trường ẩn cho phân trang -->
            <input type="hidden" name="page" id="page" value="${currentPage}">
        </form>

        <!-- Bảng Discount -->
        <div class="admin-card shadow-sm">
            <div class="admin-card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên discount</th>
                            <th>Loại</th>
                            <th>Giá trị</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Số SP áp dụng</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty discounts}">
                                <c:forEach items="${discounts}" var="d">
                                    <tr>
                                        <td class="fw-semibold">${d.id}</td>
                                        <td class="fw-semibold">${d.name}</td>
                                        <td>
                                            <span class="admin-badge-type ${d.valueType == 'PERCENT' ? 'admin-badge-percent' : 'admin-badge-amount'}">
                                                <c:choose>
                                                    <c:when test="${d.valueType == 'PERCENT'}"><i class="bi bi-percent"></i> %</c:when>
                                                    <c:otherwise><i class="bi bi-currency-dollar"></i> Số tiền</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${d.valueType == 'PERCENT'}">
                                                    <fmt:formatNumber value="${d.value}" pattern="#,##0"/>%
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${d.value}" type="currency"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${d.startAt != null}">
                                                <fmt:formatDate value="${d.startAtDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </c:if>
                                            <c:if test="${d.startAt == null}">
                                                <span class="text-muted">--</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${d.endAt != null}">
                                                <fmt:formatDate value="${d.endAtDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </c:if>
                                            <c:if test="${d.endAt == null}">
                                                <span class="text-muted">--</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="admin-badge-status
                                                ${d.status.code == 1 ? 'admin-badge-active' : 'admin-badge-inactive'}">
                                                    ${d.status.code == 1 ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary bg-opacity-10 text-dark px-3 py-2 rounded-pill">
                                                <i class="bi bi-box me-1"></i> ${d.appliedProductsCount}
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${d.createAt != null}">
                                                <fmt:formatDate value="${d.createAtDate}" pattern="dd/MM/yyyy"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="/admin/products/detail?id=${d.entityId}"
                                               class="admin-action-btn admin-action-view text-decoration-none"
                                               data-bs-toggle="tooltip" title="Xem sản phẩm liên quan">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <button type="button"
                                                    class="admin-action-btn admin-action-delete border-0"
                                                    onclick="confirmDelete(${d.id}, '${d.name}')"
                                                    data-bs-toggle="tooltip" title="Xóa discount">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        <h5 class="text-muted">Không có discount nào</h5>
                                        <p class="text-muted">
                                            <c:if test="${not empty param.timeStatus || not empty param.brandId || not empty param.categoryId || not empty param.productId}">
                                                Không có discount phù hợp với bộ lọc. Hãy thử thay đổi điều kiện lọc.
                                            </c:if>
                                            <c:if test="${empty param.timeStatus && empty param.brandId && empty param.categoryId && empty param.productId}">
                                                Chưa có discount nào trong hệ thống.
                                            </c:if>
                                        </p>
                                        <c:if test="${not empty param.timeStatus || not empty param.brandId || not empty param.categoryId || not empty param.productId}">
                                            <a href="/admin/discounts" class="admin-btn-outline text-decoration-none">
                                                <i class="bi bi-x-circle"></i> Xóa bộ lọc
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Phân trang -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center admin-pagination">
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="1" title="Trang đầu">
                            <i class="bi bi-chevron-double-left"></i>
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${currentPage - 1}" title="Trang trước">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>

                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                    <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}"/>

                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="admin-page-item ${currentPage == i ? 'active' : ''}">
                            <a class="admin-page-link" href="#" data-page="${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${currentPage + 1}" title="Trang sau">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${totalPages}" title="Trang cuối">
                            <i class="bi bi-chevron-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <!-- Tổng kết kết quả -->
        <c:if test="${not empty discounts}">
            <div class="text-center text-muted small mt-2">
                Trang ${currentPage} / ${totalPages}
                <c:if test="${not empty totalDiscounts}"> · ${totalDiscounts} discount</c:if>
            </div>
        </c:if>
    </main>
</div>

<!-- Xác nhận xóa -->
<form id="deleteForm" method="post" action="/admin/discounts" style="display:none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" id="deleteId">
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ========== KHỞI TẠO TOOLTIPS ==========
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                delay: { show: 300, hide: 100 }
            });
        });
    });

    // ========== PHÂN TRANG ==========
    document.querySelectorAll('.admin-page-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const page = this.dataset.page;
            if (page && !this.parentElement.classList.contains('disabled')) {
                const url = new URL(window.location.href);
                url.searchParams.set('page', page);
                window.location.href = url.toString();
            }
        });
    });

    // ========== XÁC NHẬN XÓA ==========
    function confirmDelete(id, name) {
        Swal.fire({
            title: 'Xác nhận xóa',
            text: 'Bạn có chắc chắn muốn xóa discount "' + name + '"?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteId').value = id;
                document.getElementById('deleteForm').submit();
            }
        });
    }
</script>
</body>
</html>
