<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Voucher | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: #f1f5f9; font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; color: #1e293b; }
        .main-content { flex: 1; padding: 2rem 2rem 3rem 2rem; background-color: #f1f5f9; overflow-y: auto; }
        .admin-header { background: #ffffff; padding: 1rem 1.8rem; border-radius: 24px; margin-bottom: 2rem; border: 1px solid #e9edf2; box-shadow: 0 1px 3px rgba(0,0,0,0.03); }
        .admin-header h3 { font-weight: 700; background: linear-gradient(135deg, #1e293b, #2c7da0); -webkit-background-clip: text; background-clip: text; color: transparent; }
        .admin-btn-primary { background-color: #2c7da0; border: none; padding: 8px 20px; font-weight: 600; border-radius: 40px; color: #ffffff; transition: 0.2s; cursor: pointer; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; }
        .admin-btn-primary:hover { background-color: #1f5e7a; transform: translateY(-1px); box-shadow: 0 4px 10px rgba(44,125,160,0.2); color: #fff; }
        .admin-btn-outline { border: 1px solid #e2e8f0; background: transparent; padding: 8px 18px; border-radius: 30px; color: #64748b; transition: 0.2s; cursor: pointer; display: inline-flex; align-items: center; gap: 6px; text-decoration: none; }
        .admin-btn-outline:hover { border-color: #2c7da0; color: #2c7da0; background-color: #f8fafc; }
        .admin-btn-danger { background-color: #dc2626; border: none; padding: 6px 16px; font-weight: 500; border-radius: 40px; color: white; transition: 0.2s; cursor: pointer; }
        .admin-btn-danger:hover { background-color: #b91c1c; }
        .admin-input, .admin-select { background-color: #ffffff; border: 1px solid #e2e8f0; color: #1e293b; border-radius: 14px; padding: 10px 16px; width: 100%; }
        .admin-input:focus, .admin-select:focus { background-color: #ffffff; border-color: #2c7da0; box-shadow: 0 0 0 3px rgba(44,125,160,0.1); color: #1e293b; outline: none; }
        .admin-card { background: #ffffff; border: 1px solid #e9edf2; border-radius: 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.03); }
        .admin-card-body { padding: 1.2rem; }
        .admin-table { color: #1e293b; border-color: #e9edf2; }
        .admin-table thead { background-color: #f8fafc; }
        .admin-table th { font-weight: 600; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .admin-badge-status { padding: 5px 12px; border-radius: 40px; font-size: 12px; font-weight: 600; display: inline-block; }
        .admin-badge-active { background-color: #e6f7ec; color: #2e7d5e; border: 0.5px solid #b8e0c2; }
        .admin-badge-inactive { background-color: #fff0f0; color: #c75c5c; border: 0.5px solid #f0c0c0; }
        .admin-badge-upcoming { background-color: #fff8e8; color: #c9772e; border: 0.5px solid #f0dbaa; }
        .admin-badge-expired { background-color: #f0f0f0; color: #94a3b8; border: 0.5px solid #e0e0e0; }
        .admin-badge-type { padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 600; display: inline-block; }
        .admin-badge-percent { background-color: #eef2ff; color: #4f46e5; }
        .admin-badge-amount { background-color: #fef3c7; color: #d97706; }
        .admin-action-btn { padding: 6px 12px; border-radius: 40px; font-size: 12px; font-weight: 500; transition: all 0.2s; border: none; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; margin: 0 3px; cursor: pointer; }
        .admin-action-view { background-color: #eef2ff; color: #2c7da0; }
        .admin-action-view:hover { background-color: #e0e8f5; color: #1f5e7a; }
        .admin-action-edit { background-color: #fff8e8; color: #c9772e; }
        .admin-action-edit:hover { background-color: #fff0dd; color: #b85f1a; }
        .admin-action-delete { background-color: #fff0f0; color: #c75c5c; }
        .admin-action-delete:hover { background-color: #ffe0e0; color: #b84c4c; }
        .admin-pagination { margin-top: 20px; }
        .admin-page-link { color: #2c7da0; border-radius: 10px; margin: 0 3px; padding: 8px 12px; text-decoration: none; border: 1px solid #e2e8f0; background: white; cursor: pointer; display: inline-block; }
        .admin-page-item.active .admin-page-link { background-color: #2c7da0; border-color: #2c7da0; color: white; }
        .admin-page-item.disabled .admin-page-link { color: #cbd5e1; pointer-events: none; cursor: not-allowed; }
        .page-size-select { width: auto; display: inline-block; padding: 6px 12px; }
        .sort-link { cursor: pointer; display: inline-flex; align-items: center; gap: 4px; color: #1e293b !important; text-decoration: none; }
        .sort-link:hover { color: #2c7da0 !important; }
        .status-toggle-form { display: inline-block; margin-left: 6px; }
        .status-toggle-btn { background: none; border: none; padding: 0; cursor: pointer; font-size: 12px; color: #64748b; }
        .status-toggle-btn:hover { color: #2c7da0; }
        .empty-state { text-align: center; padding: 3rem; }
        .empty-state i { font-size: 4rem; color: #cbd5e1; margin-bottom: 1rem; }
        .scope-badge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 10px; font-weight: 500; margin: 1px; }
        .scope-product { background-color: #e0f2fe; color: #0369a1; }
        .scope-brand { background-color: #fef3c7; color: #92400e; }
        .scope-category { background-color: #dcfce7; color: #166534; }
        .scope-order { background-color: #f3e8ff; color: #6b21a8; }
        .admin-filter-sidebar { background: white; border-radius: 20px; padding: 20px; margin-bottom: 20px; border: 1px solid #e9edf2; }
        .admin-filter-sidebar h6 { color: #2c7da0; font-weight: 600; }
        .breadcrumb { background: transparent; padding: 0; margin: 0; font-size: 0.85rem; }
        .breadcrumb-item a { color: #5a6e7c; text-decoration: none; }
        .breadcrumb-item.active { color: #2c7da0; font-weight: 500; }
        @media (max-width: 992px) { .main-content { padding: 1rem; } }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp" %>

    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0">
                    <i class="bi bi-ticket-perforated me-2" style="color:#2c7da0;"></i> Quản lý Voucher
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Vouchers</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/vouchers/create" class="admin-btn-primary text-decoration-none">
                    <i class="bi bi-plus-lg"></i> Thêm Voucher
                </a>
            </div>
        </header>

        <!-- Filter Section -->
        <form action="/admin/vouchers" method="get" id="filterForm">
            <div class="admin-filter-sidebar">
                <h6 class="mb-3"><i class="bi bi-funnel"></i> Bộ lọc</h6>
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label small">Tìm theo mã</label>
                        <input type="text" class="admin-input" name="search" placeholder="Nhập mã voucher..." value="${param.search}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small">Trạng thái</label>
                        <select class="admin-select" name="status" onchange="this.form.submit()">
                            <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small">Thời gian</label>
                        <select class="admin-select" name="timeStatus" onchange="this.form.submit()">
                            <option value="all" ${param.timeStatus == 'all' || empty param.timeStatus ? 'selected' : ''}>Tất cả</option>
                            <option value="active" ${param.timeStatus == 'active' ? 'selected' : ''}>Đang hoạt động</option>
                            <option value="upcoming" ${param.timeStatus == 'upcoming' ? 'selected' : ''}>Sắp diễn ra</option>
                            <option value="expired" ${param.timeStatus == 'expired' ? 'selected' : ''}>Đã kết thúc</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="admin-btn-outline w-100"><i class="bi bi-search"></i> Tìm</button>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <a href="/admin/vouchers" class="admin-btn-outline w-100"><i class="bi bi-x-circle"></i> Xóa bộ lọc</a>
                    </div>
                </div>
                <input type="hidden" name="sort" id="sortField" value="${param.sort}">
                <input type="hidden" name="order" id="sortOrder" value="${param.order}">
                <input type="hidden" name="page" id="page" value="${currentPage}">
                <input type="hidden" name="limit" id="limit" value="${pageSize}">
            </div>
        </form>

        <!-- Page Size Selector -->
        <div class="d-flex justify-content-end align-items-center mb-3">
            <div class="d-flex align-items-center gap-2">
                <label class="text-muted small">Hiển thị:</label>
                <select class="admin-select page-size-select" onchange="changePageSize(this.value)">
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                    <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                    <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                    <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                </select>
            </div>
        </div>

        <!-- Voucher Table -->
        <div class="admin-card shadow-sm">
            <div class="admin-card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th><a href="#" class="sort-link" data-sort="code">Code <c:if test="${param.sort == 'code'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th><a href="#" class="sort-link" data-sort="value_type">Loại <c:if test="${param.sort == 'value_type'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th><a href="#" class="sort-link" data-sort="value">Giá trị <c:if test="${param.sort == 'value'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th><a href="#" class="sort-link" data-sort="max_discount">Giới hạn <c:if test="${param.sort == 'max_discount'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th><a href="#" class="sort-link" data-sort="min_order_value">Tối thiểu <c:if test="${param.sort == 'min_order_value'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th><a href="#" class="sort-link" data-sort="remaining">Còn lại <c:if test="${param.sort == 'remaining'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th>Phạm vi</th>
                            <th><a href="#" class="sort-link" data-sort="status">Trạng thái <c:if test="${param.sort == 'status'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th><a href="#" class="sort-link" data-sort="created_at">Ngày tạo <c:if test="${param.sort == 'created_at'}"><i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i></c:if></a></th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty vouchers}">
                                <c:forEach items="${vouchers}" var="v">
                                    <tr>
                                        <td class="fw-semibold">${v.code}</td>
                                        <td>
                                            <span class="admin-badge-type ${v.valueType == 'PERCENT' ? 'admin-badge-percent' : 'admin-badge-amount'}">
                                                <c:choose>
                                                    <c:when test="${v.valueType == 'PERCENT'}"><i class="bi bi-percent"></i> %</c:when>
                                                    <c:otherwise><i class="bi bi-currency-dollar"></i> Số tiền</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${v.valueType == 'PERCENT'}"><fmt:formatNumber value="${v.value}" pattern="#,##0"/>%</c:when>
                                                <c:otherwise><fmt:formatNumber value="${v.value}" type="currency"/></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${v.maxDiscount != null}"><fmt:formatNumber value="${v.maxDiscount}" type="currency"/></c:if>
                                            <c:if test="${v.maxDiscount == null}"><span class="text-muted">---</span></c:if>
                                        </td>
                                        <td>
                                            <c:if test="${v.minOrderValue != null}"><fmt:formatNumber value="${v.minOrderValue}" type="currency"/></c:if>
                                            <c:if test="${v.minOrderValue == null}"><span class="text-muted">---</span></c:if>
                                        </td>
                                        <td>
                                            <span class="${v.usageLimit - v.usedCount <= 0 ? 'text-danger fw-bold' : ''}">
                                                ${v.usageLimit - v.usedCount}/${v.usageLimit}
                                            </span>
                                        </td>
                                        <td>
                                            <c:set var="scopes" value="${scopeMap[v.id]}"/>
                                            <c:if test="${empty scopes}">
                                                <span class="text-muted small">---</span>
                                            </c:if>
                                            <c:if test="${not empty scopes}">
                                                <c:forEach items="${scopes}" var="s">
                                                    <span class="scope-badge scope-${s.entityType}">${s.scopeDisplay}</span>
                                                </c:forEach>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="admin-badge-status ${v.status.code == 1 ? 'admin-badge-active' : 'admin-badge-inactive'}">
                                                ${v.status.code == 1 ? 'Active' : 'Inactive'}
                                            </span>
                                            <form action="/admin/vouchers" method="post" class="status-toggle-form">
                                                <input type="hidden" name="action" value="toggle-status">
                                                <input type="hidden" name="id" value="${v.id}">
                                                <input type="hidden" name="redirectUrl" value="${currentUrl}">
                                                <button type="submit" class="status-toggle-btn" data-bs-toggle="tooltip" title="Toggle status">
                                                    <i class="bi bi-arrow-repeat"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td><fmt:formatDate value="${v.createdAtDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>
                                            <a href="/admin/vouchers/edit?id=${v.id}" class="admin-action-btn admin-action-edit text-decoration-none" data-bs-toggle="tooltip" title="Sửa voucher">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <button type="button" class="admin-action-btn admin-action-delete border-0" onclick="confirmDelete(${v.id}, '${v.code}')" data-bs-toggle="tooltip" title="Xóa voucher">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" class="empty-state">
                                        <i class="bi bi-ticket-perforated"></i>
                                        <h5 class="mt-2">Không có voucher nào</h5>
                                        <p class="text-muted">
                                            <c:if test="${not empty param.search || not empty param.status || (not empty param.timeStatus && param.timeStatus != 'all')}">
                                                Không tìm thấy voucher phù hợp. Hãy thử thay đổi điều kiện lọc.
                                            </c:if>
                                            <c:if test="${empty param.search && empty param.status && (empty param.timeStatus || param.timeStatus == 'all')}">
                                                Chưa có voucher nào trong hệ thống.
                                            </c:if>
                                        </p>
                                        <c:if test="${empty param.search && empty param.status && (empty param.timeStatus || param.timeStatus == 'all')}">
                                            <a href="/admin/vouchers/create" class="admin-btn-primary text-decoration-none"><i class="bi bi-plus-lg"></i> Tạo voucher đầu tiên</a>
                                        </c:if>
                                        <c:if test="${not empty param.search || not empty param.status || (not empty param.timeStatus && param.timeStatus != 'all')}">
                                            <a href="/admin/vouchers" class="admin-btn-outline text-decoration-none"><i class="bi bi-x-circle"></i> Xóa bộ lọc</a>
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

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center admin-pagination">
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="1" title="Trang đầu"><i class="bi bi-chevron-double-left"></i></a>
                    </li>
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${currentPage - 1}" title="Trang trước"><i class="bi bi-chevron-left"></i></a>
                    </li>
                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                    <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}"/>
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="admin-page-item ${currentPage == i ? 'active' : ''}">
                            <a class="admin-page-link" href="#" data-page="${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${currentPage + 1}" title="Trang sau"><i class="bi bi-chevron-right"></i></a>
                    </li>
                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${totalPages}" title="Trang cuối"><i class="bi bi-chevron-double-right"></i></a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <!-- Results summary -->
        <c:if test="${not empty vouchers}">
            <div class="text-center text-muted small mt-2">
                Trang ${currentPage} / ${totalPages}
                <c:if test="${not empty totalVouchers}"> · ${totalVouchers} voucher</c:if>
            </div>
        </c:if>
    </main>
</div>

<!-- Delete Form -->
<form id="deleteForm" method="post" action="/admin/vouchers" style="display:none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" id="deleteId">
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (el) { return new bootstrap.Tooltip(el, { delay: { show: 300, hide: 100 } }); });
    });

    // Sorting
    document.querySelectorAll('.sort-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const sort = this.dataset.sort;
            const currentSort = '${param.sort}';
            const currentOrder = '${param.order}';
            let newOrder = 'asc';
            if (currentSort === sort && currentOrder === 'asc') newOrder = 'desc';
            const url = new URL(window.location.href);
            url.searchParams.set('sort', sort);
            url.searchParams.set('order', newOrder);
            url.searchParams.set('page', 1);
            window.location.href = url.toString();
        });
    });

    // Pagination
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

    // Page Size
    function changePageSize(limit) {
        const url = new URL(window.location.href);
        url.searchParams.set('limit', limit);
        url.searchParams.set('page', 1);
        window.location.href = url.toString();
    }

    // Confirm Delete
    function confirmDelete(id, code) {
        Swal.fire({
            title: 'Xác nhận xóa',
            text: 'Bạn có chắc chắn muốn xóa voucher "' + code + '"?',
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
