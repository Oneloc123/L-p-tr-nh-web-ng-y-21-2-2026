<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Banner | LUXCAR</title>
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
        .admin-btn-danger:hover { background-color: #b91c1c; }

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

        /* ========== CARD ========== */
        .admin-card {
            background: #ffffff;
            border: 1px solid #e9edf2;
            border-radius: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        }
        .admin-card-body { padding: 1.2rem; }

        /* ========== TABLE ========== */
        .admin-table { color: #1e293b; border-color: #e9edf2; }
        .admin-table thead { background-color: #f8fafc; }
        .admin-table th { font-weight: 600; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .admin-table-hover tbody tr:hover { background-color: #f8fafc; }

        /* ========== BADGES (consistent with product pages) ========== */
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
        .admin-pagination { margin-top: 20px; }
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
        .page-size-select { width: auto; display: inline-block; padding: 6px 12px; margin-left: 10px; }

        /* ========== BANNER SPECIFIC ========== */
        .banner-thumb {
            width: 100px;
            height: 56px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e9edf2;
            transition: transform 0.2s;
            cursor: pointer;
        }
        .banner-thumb:hover { transform: scale(1.5); box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 10; position: relative; }
        .banner-placeholder {
            width: 100px; height: 56px; border-radius: 8px; border: 1px dashed #cbd5e1;
            background: #f8fafc; display: inline-flex; align-items: center; justify-content: center;
            color: #94a3b8; font-size: 1.2rem;
        }
        .empty-state { text-align: center; padding: 3rem; }
        .empty-state i { font-size: 4rem; color: #cbd5e1; margin-bottom: 1rem; }

        /* ========== STATUS TOGGLE ========== */
        .status-toggle-form { display: inline-block; margin-left: 6px; }
        .status-toggle-btn { background: none; border: none; padding: 0; cursor: pointer; font-size: 12px; color: #64748b; }
        .status-toggle-btn:hover { color: #2c7da0; }
        .sort-link { cursor: pointer; display: inline-flex; align-items: center; gap: 4px; }
        .sort-link:hover { color: #2c7da0 !important; }

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
                    <i class="bi bi-images me-2" style="color:#2c7da0;"></i> Banner Management
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Banners</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/banners/create" class="admin-btn-primary text-decoration-none">
                    <i class="bi bi-plus-lg"></i> Create Banner
                </a>
            </div>
        </header>

        <!-- Search and Filter -->
        <form action="/admin/banners" method="get" id="filterForm" class="mb-4">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <input type="text" class="admin-input" name="search"
                           placeholder="Search by title or description..."
                           value="${param.search}">
                </div>
                <div class="col-md-2">
                    <select class="admin-select" name="status" onchange="this.form.submit()">
                        <option value="">All Status</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Hidden</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="admin-btn-outline w-100">
                        <i class="bi bi-search"></i> Search
                    </button>
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
                <label class="text-muted small">Show:</label>
                <select class="admin-select page-size-select" onchange="changePageSize(this.value)">
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                    <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                    <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                </select>
            </div>
        </div>

        <!-- Banner Table -->
        <div class="admin-card shadow-sm">
            <div class="admin-card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th width="60">
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="id">
                                    ID
                                    <c:if test="${param.sort == 'id'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th width="120">Image</th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="title">
                                    Title
                                    <c:if test="${param.sort == 'title'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="display_order">
                                    Order
                                    <c:if test="${param.sort == 'display_order'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="status">
                                    Status
                                    <c:if test="${param.sort == 'status'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="created_at">
                                    Created
                                    <c:if test="${param.sort == 'created_at'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th width="160">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty banners}">
                                <c:forEach items="${banners}" var="banner">
                                    <tr>
                                        <td class="fw-semibold">${banner.id}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty banner.imageUrl}">
                                                    <img src="${banner.imageUrl}"
                                                         alt="${banner.title}"
                                                         class="banner-thumb"
                                                         onerror="this.onerror=null; this.style.display='none'; this.parentNode.querySelector('.banner-placeholder').style.display='inline-flex';">
                                                    <span class="banner-placeholder" style="display:none;">
                                                        <i class="bi bi-image"></i>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="banner-placeholder">
                                                        <i class="bi bi-card-image"></i>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="fw-semibold">${banner.title}</div>
                                            <c:if test="${not empty banner.description}">
                                                <small class="text-muted">${banner.description}</small>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary bg-opacity-10 text-dark px-3 py-2 rounded-pill">
                                                <i class="bi bi-sort-numeric-down me-1"></i> ${banner.sortOrder}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${banner.status.code == 1}">
                                                    <span class="admin-badge-status admin-badge-active">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="admin-badge-status admin-badge-inactive">Hidden</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <form action="/admin/banners/toggle-status" method="post" class="status-toggle-form">
                                                <input type="hidden" name="id" value="${banner.id}">
                                                <input type="hidden" name="redirectUrl" value="${currentUrl}">
                                                <button type="submit" class="status-toggle-btn" data-bs-toggle="tooltip" title="Toggle status">
                                                    <i class="bi bi-arrow-repeat"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${banner.createdAtDate}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td>
                                            <a href="/admin/banners/edit?id=${banner.id}"
                                               class="admin-action-btn admin-action-edit text-decoration-none"
                                               data-bs-toggle="tooltip" title="Edit banner">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <button type="button"
                                                    class="admin-action-btn admin-action-delete border-0"
                                                    data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                    data-banner-id="${banner.id}"
                                                    data-banner-title="${banner.title}"
                                                    title="Delete banner">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="empty-state">
                                        <i class="bi bi-images"></i>
                                        <h5 class="mt-2">No banners found</h5>
                                        <p class="text-muted">
                                            <c:choose>
                                                <c:when test="${not empty param.search || not empty param.status}">
                                                    No banners match your search criteria. Try adjusting your filters.
                                                </c:when>
                                                <c:otherwise>
                                                    Get started by creating your first banner.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <c:if test="${empty param.search && empty param.status}">
                                            <a href="/admin/banners/create" class="admin-btn-primary text-decoration-none">
                                                <i class="bi bi-plus-lg"></i> Create your first banner
                                            </a>
                                        </c:if>
                                        <c:if test="${not empty param.search || not empty param.status}">
                                            <a href="/admin/banners" class="admin-btn-outline text-decoration-none">
                                                <i class="bi bi-x-circle"></i> Clear filters
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

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center admin-pagination">
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="1" data-bs-toggle="tooltip" title="First page">
                            <i class="bi bi-chevron-double-left"></i>
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${currentPage - 1}" data-bs-toggle="tooltip" title="Previous page">
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
                        <a class="admin-page-link" href="#" data-page="${currentPage + 1}" data-bs-toggle="tooltip" title="Next page">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${totalPages}" data-bs-toggle="tooltip" title="Last page">
                            <i class="bi bi-chevron-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <!-- Results summary -->
        <c:if test="${not empty banners}">
            <div class="text-center text-muted small mt-2">
                Showing page ${currentPage} of ${totalPages}
                <c:if test="${not empty totalItems}"> · ${totalItems} banners total</c:if>
            </div>
        </c:if>
    </main>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 px-4 pt-4">
                <h5 class="modal-title fw-bold" id="deleteModalLabel">
                    <i class="bi bi-exclamation-triangle text-danger me-2"></i> Delete Banner
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4">
                <p class="mb-1">Are you sure you want to delete the banner:</p>
                <p class="fw-bold fs-5 text-dark" id="deleteBannerTitle"></p>
                <p class="text-danger mb-0 small">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer border-0 px-4 pb-4">
                <button type="button" class="admin-btn-outline" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg"></i> Cancel
                </button>
                <form action="/admin/banners/delete" method="post" id="deleteForm">
                    <input type="hidden" name="id" id="deleteBannerId">
                    <button type="submit" class="admin-btn-danger">
                        <i class="bi bi-trash"></i> Delete
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, { delay: { show: 300, hide: 100 } });
        });
    });

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

    function changePageSize(limit) {
        const url = new URL(window.location.href);
        url.searchParams.set('limit', limit);
        url.searchParams.set('page', 1);
        window.location.href = url.toString();
    }

    const deleteModal = document.getElementById('deleteModal');
    if (deleteModal) {
        deleteModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const bannerId = button.getAttribute('data-banner-id');
            const bannerTitle = button.getAttribute('data-banner-title');
            document.getElementById('deleteBannerId').value = bannerId;
            document.getElementById('deleteBannerTitle').textContent = bannerTitle;
        });
    }
</script>
</body>
</html>
