<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 4/28/2026
  Time: 16:06
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
    <title>Admin - Quản lý Thương hiệu | LUXCAR</title>
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
            box-shadow: 0 2px 4px rgba(44, 125, 160, 0.08);
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
            box-shadow: 0 4px 10px rgba(44, 125, 160, 0.2);
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
            box-shadow: 0 0 0 3px rgba(44, 125, 160, 0.1);
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
        .badge-status {
            padding: 5px 12px;
            border-radius: 40px;
            font-size: 11px;
            font-weight: 600;
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

        .status-toggle-form {
            display: inline-block;
            margin-left: 6px;
        }

        .status-toggle-btn {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
            font-size: 12px;
            color: #64748b;
        }

        .status-toggle-btn:hover {
            color: #2c7da0;
        }

        /* ========== SORT LINKS ========== */
        .sort-link {
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .sort-link:hover {
            color: #2c7da0 !important;
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

        .page-size-select {
            width: auto;
            display: inline-block;
            padding: 6px 12px;
            margin-left: 10px;
        }

        /* ========== EMPTY STATE ========== */
        .empty-state {
            text-align: center;
            padding: 3rem;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        /* ========== LOGO PREVIEW ========== */
        .brand-logo-preview {
            width: 42px;
            height: 42px;
            object-fit: contain;
            border-radius: 10px;
            border: 1px solid #e9edf2;
            background: #f8fafc;
            padding: 2px;
            transition: transform 0.2s;
        }

        .brand-logo-preview:hover {
            transform: scale(1.15);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            z-index: 2;
            position: relative;
        }

        .logo-placeholder {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            border: 1px dashed #cbd5e1;
            background: #f8fafc;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #94a3b8;
            font-size: 1.2rem;
        }

        /* ========== COUNTRY FLAG / INDICATOR ========== */
        .country-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #f1f5f9;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
        }

        .country-badge i {
            color: #2c7da0;
            font-size: 0.9rem;
        }

        /* ========== TOOLTIP OVERRIDE ========== */
        [data-bs-toggle="tooltip"] {
            cursor: pointer;
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
        <!-- Header with Breadcrumb -->
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0">
                    <i class="bi bi-building me-2" style="color:#2c7da0;"></i> Brand Management
                </h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Brands</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="/admin/brands/create" class="admin-btn-primary text-decoration-none">
                    <i class="bi bi-plus-lg"></i> Create Brand
                </a>
            </div>
        </header>

        <!-- Search and Filter Bar -->
        <form action="/admin/brands" method="get" id="filterForm" class="mb-4">
            <div class="row g-3 align-items-end">
                <!-- Search by name -->
                <div class="col-md-3">
                    <input type="text" class="admin-input" name="search"
                           placeholder="Search by name..."
                           value="${param.search}">
                </div>

                <!-- Status Filter -->
                <div class="col-md-2">
                    <select class="admin-select" name="status" onchange="this.form.submit()">
                        <option value="">All Status</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <!-- Submit search -->
                <div class="col-md-2">
                    <button type="submit" class="admin-btn-outline w-100">
                        <i class="bi bi-search"></i> Search
                    </button>
                </div>
                <!-- Hidden fields for sort and pagination -->
                <input type="hidden" name="sort" id="sortField" value="${param.sort}">
                <input type="hidden" name="order" id="sortOrder" value="${param.order}">
                <input type="hidden" name="page" id="page" value="${currentPage}">
                <input type="hidden" name="limit" id="limit" value="${pageSize}">
            </div>
        </form>

        <!-- Bulk Actions Bar -->
        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
            <div class="d-flex gap-2 align-items-center">
                <form action="/admin/brands/bulk-action" method="post" id="bulkActionForm">
                    <input type="hidden" name="action" id="bulkActionType">
                    <div class="input-group">
                        <select class="admin-select" id="bulkActionSelect" style="width: auto;">
                            <option value="">Bulk Actions</option>
                            <option value="delete">Delete Selected</option>
                            <option value="active">Change Status → Active</option>
                            <option value="inactive">Change Status → Inactive</option>
                        </select>
                        <button type="button" class="admin-btn-outline" onclick="executeBulkAction()">Apply</button>
                    </div>
                </form>
            </div>
            <div class="d-flex align-items-center gap-2">
                <label class="text-muted small">Show:</label>
                <select class="admin-select page-size-select" onchange="changePageSize(this.value)">
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                    <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                    <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                    <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                </select>
            </div>
        </div>

        <!-- Brand Table -->
        <div class="admin-card shadow-sm">
            <div class="admin-card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th width="40">
                                <input type="checkbox" id="selectAll" data-bs-toggle="tooltip" title="Select all brands">
                            </th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="id">
                                    ID
                                    <c:if test="${param.sort == 'id'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th>Logo</th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="name">
                                    Brand Name
                                    <c:if test="${param.sort == 'name'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th>
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="product_count">
                                    Products
                                    <c:if test="${param.sort == 'product_count'}">
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
                                <a href="#" class="sort-link text-dark text-decoration-none" data-sort="created_date">
                                    Created Date
                                    <c:if test="${param.sort == 'created_date'}">
                                        <i class="bi bi-arrow-${param.order == 'asc' ? 'up' : 'down'}"></i>
                                    </c:if>
                                </a>
                            </th>
                            <th>Updated Date</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty brands}">
                                <c:forEach items="${brands}" var="brand">
                                    <tr>
                                        <td>
                                            <input type="checkbox" class="brand-checkbox" value="${brand.id}">
                                        </td>
                                        <td class="fw-semibold">${brand.id}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty brand.image}">
                                                    <img src="${brand.image}"
                                                         alt="${brand.name} logo"
                                                         class="brand-logo-preview"
                                                         data-bs-toggle="tooltip"
                                                         title="${brand.name}"
                                                         onerror="this.onerror=null; this.style.display='none'; this.parentNode.querySelector('.logo-placeholder').style.display='inline-flex';">
                                                    <span class="logo-placeholder" style="display:none;">
                                                        <i class="bi bi-image"></i>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="logo-placeholder">
                                                        <i class="bi bi-building"></i>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="fw-semibold">${brand.name}</td>

                                        <td>
                                            <span class="badge bg-secondary bg-opacity-10 text-dark px-3 py-2 rounded-pill">
                                                <i class="bi bi-box me-1"></i> ${brand.productCount}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${brand.status == 'active'}">
                                                    <span class="badge bg-success badge-status">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary badge-status">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <!-- Quick toggle form -->
                                            <form action="/admin/brands/toggle-status" method="post" class="status-toggle-form">
                                                <input type="hidden" name="id" value="${brand.id}">
                                                <input type="hidden" name="redirectUrl" value="${currentUrl}">
                                                <button type="submit"
                                                        class="status-toggle-btn"
                                                        data-bs-toggle="tooltip"
                                                        title="Toggle status">
                                                    <i class="bi bi-arrow-repeat"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${brand.createdAt}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${brand.updatedAt}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <a href="/admin/brands/edit?id=${brand.id}"
                                               class="admin-action-btn admin-action-edit text-decoration-none"
                                               data-bs-toggle="tooltip"
                                               title="Edit brand">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <button type="button"
                                                    class="admin-action-btn admin-action-delete border-0"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#deleteModal"
                                                    data-brand-id="${brand.id}"
                                                    data-brand-name="${brand.name}"
                                                    title="Delete brand">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" class="empty-state">
                                        <i class="bi bi-building-dash"></i>
                                        <h5 class="mt-2">No brands found</h5>
                                        <p class="text-muted">
                                            <c:choose>
                                                <c:when test="${not empty param.search || not empty param.status}">
                                                    No brands match your search criteria. Try adjusting your filters.
                                                </c:when>
                                                <c:otherwise>
                                                    Get started by creating your first brand.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                         <c:if test="${empty param.search && empty param.status}">
                                            <a href="/admin/brands/create" class="admin-btn-primary text-decoration-none">
                                                <i class="bi bi-plus-lg"></i> Create your first brand
                                            </a>
                                        </c:if>
                                        <c:if test="${not empty param.search || not empty param.status}">
                                            <a href="/admin/brands" class="admin-btn-outline text-decoration-none">
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
                        <a class="admin-page-link" href="#" data-page="1"
                           data-bs-toggle="tooltip" title="First page">
                            <i class="bi bi-chevron-double-left"></i>
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${currentPage - 1}"
                           data-bs-toggle="tooltip" title="Previous page">
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
                        <a class="admin-page-link" href="#" data-page="${currentPage + 1}"
                           data-bs-toggle="tooltip" title="Next page">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                    <li class="admin-page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="admin-page-link" href="#" data-page="${totalPages}"
                           data-bs-toggle="tooltip" title="Last page">
                            <i class="bi bi-chevron-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <!-- Results summary -->
        <c:if test="${not empty brands}">
            <div class="text-center text-muted small mt-2">
                Showing page ${currentPage} of ${totalPages}
                <c:if test="${not empty totalItems}"> · ${totalItems} brands total</c:if>
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
                    <i class="bi bi-exclamation-triangle text-danger me-2"></i> Delete Brand
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4">
                <p class="mb-1">Are you sure you want to delete the brand:</p>
                <p class="fw-bold fs-5 text-dark" id="deleteBrandName"></p>
                <p class="text-danger mb-0 small">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    This will also affect all products associated with this brand. This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer border-0 px-4 pb-4">
                <button type="button" class="admin-btn-outline" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg"></i> Cancel
                </button>
                <form action="/admin/brands/delete" method="post" id="deleteForm">
                    <input type="hidden" name="id" id="deleteBrandId">
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
    // ========== INIT TOOLTIPS ==========
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                delay: { show: 300, hide: 100 }
            });
        });
    });

    // ========== SORTING ==========
    document.querySelectorAll('.sort-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const sort = this.dataset.sort;
            const currentSort = '${param.sort}';
            const currentOrder = '${param.order}';
            let newOrder = 'asc';
            if (currentSort === sort && currentOrder === 'asc') {
                newOrder = 'desc';
            }
            const url = new URL(window.location.href);
            url.searchParams.set('sort', sort);
            url.searchParams.set('order', newOrder);
            url.searchParams.set('page', 1);
            window.location.href = url.toString();
        });
    });

    // ========== PAGINATION ==========
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

    // ========== PAGE SIZE ==========
    function changePageSize(limit) {
        const url = new URL(window.location.href);
        url.searchParams.set('limit', limit);
        url.searchParams.set('page', 1);
        window.location.href = url.toString();
    }

    // ========== DELETE MODAL ==========
    const deleteModal = document.getElementById('deleteModal');
    if (deleteModal) {
        deleteModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const brandId = button.getAttribute('data-brand-id');
            const brandName = button.getAttribute('data-brand-name');
            document.getElementById('deleteBrandId').value = brandId;
            document.getElementById('deleteBrandName').textContent = brandName;
        });
    }

    // ========== SELECT ALL CHECKBOXES ==========
    const selectAllCheckbox = document.getElementById('selectAll');
    const brandCheckboxes = document.querySelectorAll('.brand-checkbox');

    function updateSelectAllState() {
        if (selectAllCheckbox) {
            const allChecked = Array.from(brandCheckboxes).every(cb => cb.checked);
            const anyChecked = Array.from(brandCheckboxes).some(cb => cb.checked);
            selectAllCheckbox.checked = allChecked;
            selectAllCheckbox.indeterminate = anyChecked && !allChecked;
        }
    }

    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            brandCheckboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
            updateSelectAllState();
        });
    }

    brandCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            updateSelectAllState();
        });
    });

    // ========== BULK ACTIONS ==========
    function executeBulkAction() {
        const selected = Array.from(brandCheckboxes).filter(cb => cb.checked).map(cb => cb.value);
        if (selected.length === 0) {
            alert('Please select at least one brand.');
            return;
        }

        const action = document.getElementById('bulkActionSelect').value;
        if (!action) {
            alert('Please select an action.');
            return;
        }

        let confirmMessage = '';
        if (action === 'delete') {
            confirmMessage = 'Are you sure you want to delete ' + selected.length + ' selected brand(s)?\n\nThis will also affect all associated products. This action cannot be undone.';
        } else if (action === 'active') {
            confirmMessage = 'Are you sure you want to change ' + selected.length + ' brand(s) status to Active?';
        } else if (action === 'inactive') {
            confirmMessage = 'Are you sure you want to change ' + selected.length + ' brand(s) status to Inactive?';
        }

        if (confirm(confirmMessage)) {
            const form = document.getElementById('bulkActionForm');
            const actionInput = document.getElementById('bulkActionType');
            actionInput.value = action;

            // Remove any existing hidden inputs for ids
            const existingIds = form.querySelectorAll('input[name="ids"]');
            existingIds.forEach(input => input.remove());

            // Add selected IDs to form
            selected.forEach(id => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'ids';
                input.value = id;
                form.appendChild(input);
            });

            form.submit();
        }
    }
</script>
</body>
</html>