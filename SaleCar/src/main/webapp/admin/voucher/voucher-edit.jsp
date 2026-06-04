<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sửa Voucher | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: #f1f5f9; font-family: 'Inter', system-ui, -apple-system, sans-serif; color: #1e293b; }
        .main-content { flex: 1; padding: 2rem 2rem 3rem 2rem; background-color: #f1f5f9; overflow-y: auto; }
        .admin-header { background: #fff; padding: 1rem 1.8rem; border-radius: 24px; margin-bottom: 2rem; border: 1px solid #e9edf2; box-shadow: 0 1px 3px rgba(0,0,0,0.03); }
        .admin-header h3 { font-weight: 700; background: linear-gradient(135deg,#1e293b,#2c7da0); -webkit-background-clip: text; background-clip: text; color: transparent; }
        .admin-btn-primary { background-color: #2c7da0; border: none; padding: 8px 20px; font-weight: 600; border-radius: 40px; color: #fff; transition: 0.2s; cursor: pointer; }
        .admin-btn-primary:hover { background-color: #1f5e7a; transform: translateY(-1px); box-shadow: 0 4px 10px rgba(44,125,160,0.2); }
        .admin-btn-outline { border: 1px solid #e2e8f0; background: transparent; padding: 8px 18px; border-radius: 30px; color: #64748b; transition: 0.2s; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; }
        .admin-btn-outline:hover { border-color: #2c7da0; color: #2c7da0; background-color: #f8fafc; }
        .admin-input, .admin-select { background: #fff; border: 1px solid #e2e8f0; color: #1e293b; border-radius: 14px; padding: 10px 16px; width: 100%; }
        .admin-input:focus, .admin-select:focus { border-color: #2c7da0; box-shadow: 0 0 0 3px rgba(44,125,160,0.1); outline: none; }
        .admin-card { background: #fff; border: 1px solid #e9edf2; border-radius: 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.03); }
        .admin-card-body { padding: 2rem; }
        .form-label { font-weight: 600; font-size: 13px; color: #475569; margin-bottom: 6px; }
        .breadcrumb { background: transparent; padding: 0; margin: 0; font-size: 0.85rem; }
        .breadcrumb-item a { color: #5a6e7c; text-decoration: none; }
        .breadcrumb-item.active { color: #2c7da0; font-weight: 500; }
        .scope-entry { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 14px; padding: 12px; margin-bottom: 8px; }
        .remove-scope { color: #ef4444; cursor: pointer; }
        @media (max-width: 992px) { .main-content { padding: 1rem; } }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp" %>
    <main class="main-content">
        <header class="admin-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h3 class="fw-bold m-0"><i class="bi bi-pencil-square me-2" style="color:#2c7da0;"></i> Sửa Voucher</h3>
                <nav aria-label="breadcrumb" class="mt-1">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/vouchers">Vouchers</a></li>
                        <li class="breadcrumb-item active">Sửa: ${voucher.code}</li>
                    </ol>
                </nav>
            </div>
            <a href="/admin/vouchers" class="admin-btn-outline"><i class="bi bi-arrow-left"></i> Quay lại</a>
        </header>

        <div class="admin-card">
            <div class="admin-card-body">
                <form action="/admin/vouchers/edit" method="post" id="voucherForm">
                    <input type="hidden" name="id" value="${voucher.id}">
                    <div class="row g-4">
                        <!-- Thông tin cơ bản -->
                        <div class="col-md-4">
                            <label class="form-label">Mã voucher <span class="text-danger">*</span></label>
                            <input type="text" class="admin-input" name="code" id="code" required value="${voucher.code}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Loại giảm giá <span class="text-danger">*</span></label>
                            <select class="admin-select" name="valueType" required>
                                <option value="percent" ${voucher.valueType == 'PERCENT' ? 'selected' : ''}>Phần trăm (%)</option>
                                <option value="amount" ${voucher.valueType == 'AMOUNT' ? 'selected' : ''}>Số tiền cố định</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Giá trị <span class="text-danger">*</span></label>
                            <input type="number" class="admin-input" name="value" required step="0.01" min="0.01" value="${voucher.value}">
                        </div>

                        <!-- Giới hạn -->
                        <div class="col-md-3">
                            <label class="form-label">Giới hạn giảm tối đa</label>
                            <input type="number" class="admin-input" name="maxDiscount" step="0.01" min="0" value="${voucher.maxDiscount}" placeholder="Để trống nếu không giới hạn">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Giá trị đơn tối thiểu</label>
                            <input type="number" class="admin-input" name="minOrderValue" step="0.01" min="0" value="${voucher.minOrderValue}" placeholder="Để trống nếu không yêu cầu">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Tổng số lượt dùng</label>
                            <input type="number" class="admin-input" name="usageLimit" min="0" value="${voucher.usageLimit}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Giới hạn / người dùng</label>
                            <input type="number" class="admin-input" name="maxUsagePerUser" min="1" value="${voucher.maxUsagePerUser}">
                        </div>

                        <!-- Ngày tháng -->
                        <c:set var="startAtStr" value=""/>
                        <c:if test="${voucher.startAt != null}">
                            <fmt:formatDate value="${voucher.startAtDate}" pattern="yyyy-MM-dd'T'HH:mm" var="startAtStr"/>
                        </c:if>
                        <c:set var="endAtStr" value=""/>
                        <c:if test="${voucher.endAt != null}">
                            <fmt:formatDate value="${voucher.endAtDate}" pattern="yyyy-MM-dd'T'HH:mm" var="endAtStr"/>
                        </c:if>
                        <div class="col-md-4">
                            <label class="form-label">Ngày bắt đầu</label>
                            <input type="datetime-local" class="admin-input" name="startAt" value="${startAtStr}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Ngày kết thúc</label>
                            <input type="datetime-local" class="admin-input" name="endAt" value="${endAtStr}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Trạng thái</label>
                            <select class="admin-select" name="status">
                                <option value="active" ${voucher.status.code == 1 ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${voucher.status.code == 0 ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>

                        <!-- Phạm vi -->
                        <div class="col-12">
                            <hr>
                            <label class="form-label">Phạm vi áp dụng</label>
                            <div id="scopeList">
                                <c:if test="${empty scopes}">
                                <div class="scope-entry">
                                    <div class="row g-2 align-items-center">
                                        <div class="col-md-4">
                                            <select class="admin-select scope-type" name="scopeType" onchange="toggleScopeEntity(this)">
                                                <option value="order">Toàn bộ đơn hàng</option>
                                                <option value="product">Sản phẩm cụ thể</option>
                                                <option value="brand">Thương hiệu</option>
                                                <option value="category">Danh mục</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <select class="admin-select scope-entity" name="scopeEntityId" style="display:none;"><option value="">Chọn...</option></select>
                                            <select class="admin-select scope-entity-brand" name="scopeEntityId" style="display:none;">
                                                <option value="">Chọn thương hiệu...</option>
                                                <c:forEach items="${brands}" var="b"><option value="${b[0]}">${b[1]}</option></c:forEach>
                                            </select>
                                            <select class="admin-select scope-entity-category" name="scopeEntityId" style="display:none;">
                                                <option value="">Chọn danh mục...</option>
                                                <c:forEach items="${categories}" var="c"><option value="${c[0]}">${c[1]}</option></c:forEach>
                                            </select>
                                            <select class="admin-select scope-entity-product" name="scopeEntityId" style="display:none;">
                                                <option value="">Chọn sản phẩm...</option>
                                                <c:forEach items="${products}" var="p"><option value="${p[0]}">${p[1]}</option></c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <span class="remove-scope" onclick="this.closest('.scope-entry').remove()"><i class="bi bi-x-circle-fill fs-5"></i></span>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                                <c:if test="${not empty scopes}">
                                    <c:forEach items="${scopes}" var="s">
                                    <div class="scope-entry">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-md-4">
                                                <select class="admin-select scope-type" name="scopeType" onchange="toggleScopeEntity(this)">
                                                    <option value="order" ${s.entityType == 'order' ? 'selected' : ''}>Toàn bộ đơn hàng</option>
                                                    <option value="product" ${s.entityType == 'product' ? 'selected' : ''}>Sản phẩm cụ thể</option>
                                                    <option value="brand" ${s.entityType == 'brand' ? 'selected' : ''}>Thương hiệu</option>
                                                    <option value="category" ${s.entityType == 'category' ? 'selected' : ''}>Danh mục</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <select class="admin-select scope-entity" name="scopeEntityId" style="${s.entityType == 'order' ? 'display:none;' : 'display:none;'}"><option value="">Chọn...</option></select>
                                                <select class="admin-select scope-entity-brand" name="scopeEntityId" style="${s.entityType == 'brand' ? '' : 'display:none;'}">
                                                    <option value="">Chọn thương hiệu...</option>
                                                    <c:forEach items="${brands}" var="b"><option value="${b[0]}" ${s.entityType == 'brand' && s.entityId == b[0] ? 'selected' : ''}>${b[1]}</option></c:forEach>
                                                </select>
                                                <select class="admin-select scope-entity-category" name="scopeEntityId" style="${s.entityType == 'category' ? '' : 'display:none;'}">
                                                    <option value="">Chọn danh mục...</option>
                                                    <c:forEach items="${categories}" var="c"><option value="${c[0]}" ${s.entityType == 'category' && s.entityId == c[0] ? 'selected' : ''}>${c[1]}</option></c:forEach>
                                                </select>
                                                <select class="admin-select scope-entity-product" name="scopeEntityId" style="${s.entityType == 'product' ? '' : 'display:none;'}">
                                                    <option value="">Chọn sản phẩm...</option>
                                                    <c:forEach items="${products}" var="p"><option value="${p[0]}" ${s.entityType == 'product' && s.entityId == p[0] ? 'selected' : ''}>${p[1]}</option></c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-2 text-end">
                                                <span class="remove-scope" onclick="this.closest('.scope-entry').remove()"><i class="bi bi-x-circle-fill fs-5"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <button type="button" class="admin-btn-outline mt-2" onclick="addScope()">
                                <i class="bi bi-plus-lg"></i> Thêm phạm vi
                            </button>
                        </div>

                        <!-- Thống kê (chỉ đọc) -->
                        <div class="col-12">
                            <hr>
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <div class="p-3 bg-light rounded-4">
                                        <small class="text-muted">Đã dùng</small>
                                        <div class="fw-bold fs-5">${voucher.usedCount}</div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="p-3 bg-light rounded-4">
                                        <small class="text-muted">Còn lại</small>
                                        <div class="fw-bold fs-5">${voucher.usageLimit - voucher.usedCount}</div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="p-3 bg-light rounded-4">
                                        <small class="text-muted">Ngày tạo</small>
                                        <div class="fw-bold fs-6"><fmt:formatDate value="${voucher.createdAtDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Nút gửi -->
                        <div class="col-12 mt-4">
                            <button type="submit" class="admin-btn-primary me-2"><i class="bi bi-check-lg"></i> Lưu thay đổi</button>
                            <a href="/admin/vouchers" class="admin-btn-outline"><i class="bi bi-x-lg"></i> Hủy</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleScopeEntity(select) {
        const entry = select.closest('.scope-entry');
        const entitySelects = entry.querySelectorAll('[name="scopeEntityId"]');
        entitySelects.forEach(s => {
            s.style.display = 'none';
            s.disabled = true;
        });
        const val = select.value;
        if (val === 'product') {
            const el = entry.querySelector('.scope-entity-product');
            el.style.display = 'block';
            el.disabled = false;
        } else if (val === 'brand') {
            const el = entry.querySelector('.scope-entity-brand');
            el.style.display = 'block';
            el.disabled = false;
        } else if (val === 'category') {
            const el = entry.querySelector('.scope-entity-category');
            el.style.display = 'block';
            el.disabled = false;
        }
    }

    function addScope() {
        const container = document.getElementById('scopeList');
        const first = container.querySelector('.scope-entry');
        const clone = first.cloneNode(true);
        clone.querySelectorAll('select').forEach(s => {
            s.selectedIndex = 0;
            s.disabled = true;
        });
        toggleScopeEntity(clone.querySelector('.scope-type'));
        container.appendChild(clone);
    }

    document.querySelectorAll('.scope-type').forEach(toggleScopeEntity);
</script>
</body>
</html>
