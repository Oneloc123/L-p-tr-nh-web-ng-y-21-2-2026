<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* Copy styles from user-admin.jsp */
        .product-detail-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 20px;
        }

        .gallery-thumb {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s;
        }

        .gallery-thumb:hover, .gallery-thumb.active {
            border-color: #2c7da0;
        }

        .info-section {
            background: #fefefe;
            border: 1px solid #eef2f6;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .info-label {
            font-size: 12px;
            color: #7c8b9c;
            margin-bottom: 5px;
        }

        .info-value {
            font-size: 16px;
            font-weight: 500;
            color: #1e293b;
        }

        .price-detail {
            font-size: 24px;
            font-weight: 700;
            color: #2c7da0;
        }

        .original-price {
            font-size: 16px;
            text-decoration: line-through;
            color: #7c8b9c;
        }

        .activity-log {
            max-height: 300px;
            overflow-y: auto;
        }

        .log-item {
            padding: 10px;
            border-bottom: 1px solid #eef2f6;
        }

        .inventory-log {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 15px;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/admin/sidebar/sidebar.jsp"%>

    <main class="main-content">
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0">
                <i class="bi bi-box-seam me-2" style="color:#2c7da0;"></i>
                Chi tiết sản phẩm: ${product.productName}
            </h3>
            <div>
                <a href="/updateProduct?id=${product.id}" class="btn btn-primary">
                    <i class="bi bi-pencil-square"></i> Chỉnh sửa
                </a>
                <a href="/productList" class="btn btn-outline-secondary ms-2">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <div class="row">
            <!-- Left Column - Images -->
            <div class="col-md-5">
                <div class="info-section">
                    <div class="text-center">
                        <img id="mainProductImage" src="${product.mainImage}"
                             class="product-detail-image" alt="${product.productName}">
                    </div>
                    <div class="gallery-preview mt-3 d-flex gap-2 flex-wrap">
                        <c:forEach items="${product.galleryImages}" var="img">
                            <img src="${img}" class="gallery-thumb" onclick="changeMainImage('${img}')" alt="Thumb">
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Right Column - Product Info -->
            <div class="col-md-7">
                <div class="info-section">
                    <h4 class="mb-3">${product.productName}</h4>
                    <div class="mb-3">
                        <span class="badge bg-secondary">SKU: ${product.sku}</span>
                        <span class="badge ${product.status == 'active' ? 'bg-success' : 'bg-secondary'} ms-2">
                            ${product.status == 'active' ? 'Hoạt động' : 'Không hoạt động'}
                        </span>
                    </div>

                    <div class="price-detail">
                        <fmt:formatNumber value="${product.finalPrice}" type="currency" currencySymbol="₫"/>
                        <span class="original-price ms-2">
                            <fmt:formatNumber value="${product.originalPrice}" type="currency" currencySymbol="₫"/>
                        </span>
                        <span class="badge bg-danger ms-2">-${product.discountPercent}%</span>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="info-label">Danh mục</div>
                            <div class="info-value">${product.categoryName}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Thương hiệu</div>
                            <div class="info-value">${product.brandName}</div>
                        </div>
                        <div class="col-md-6 mt-3">
                            <div class="info-label">Tồn kho</div>
                            <div class="info-value">
                                ${product.quantity}
                                <c:if test="${product.quantity <= product.lowStockThreshold}">
                                    <span class="badge bg-warning ms-2">Cảnh báo tồn kho thấp</span>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-6 mt-3">
                            <div class="info-label">Tags</div>
                            <div class="info-value">${product.tags}</div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <div class="info-label">Mô tả ngắn</div>
                        <div class="info-value">${product.shortDescription}</div>
                    </div>
                </div>

                <!-- Special Status -->
                <div class="info-section">
                    <h5>Đặc biệt</h5>
                    <div class="d-flex gap-3">
                        <c:if test="${product.featured}">
                            <span class="badge bg-info">Nổi bật</span>
                        </c:if>
                        <c:if test="${product.newArrival}">
                            <span class="badge bg-success">Hàng mới về</span>
                        </c:if>
                        <c:if test="${product.bestSeller}">
                            <span class="badge bg-warning">Bán chạy</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Detailed Description -->
        <div class="info-section">
            <h5>Mô tả chi tiết</h5>
            <div class="mt-3">${product.description}</div>
        </div>

        <!-- SEO Information -->
        <div class="info-section">
            <h5>SEO</h5>
            <div class="row">
                <div class="col-md-6">
                    <div class="info-label">Meta Title</div>
                    <div class="info-value">${product.metaTitle}</div>
                </div>
                <div class="col-md-6">
                    <div class="info-label">Meta Description</div>
                    <div class="info-value">${product.metaDescription}</div>
                </div>
                <div class="col-md-12 mt-3">
                    <div class="info-label">Meta Keywords</div>
                    <div class="info-value">${product.metaKeywords}</div>
                </div>
            </div>
        </div>

        <!-- System Information -->
        <div class="row">
            <div class="col-md-6">
                <div class="info-section">
                    <h5>Thông tin hệ thống</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">Ngày tạo</div>
                            <div class="info-value"><fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Người tạo</div>
                            <div class="info-value">${product.createdBy}</div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Cập nhật lần cuối</div>
                            <div class="info-value"><fmt:formatDate value="${product.updatedAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="info-label">Người cập nhật</div>
                            <div class="info-value">${product.updatedBy}</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="info-section">
                    <h5>Quản lý kho</h5>
                    <div class="inventory-log">
                        <div class="mb-3">
                            <label class="form-label">Điều chỉnh số lượng</label>
                            <div class="input-group">
                                <button class="btn btn-outline-secondary" onclick="adjustQuantity(-1)">-1</button>
                                <button class="btn btn-outline-secondary" onclick="adjustQuantity(-10)">-10</button>
                                <input type="number" id="adjustAmount" class="form-control" placeholder="Số lượng" value="1">
                                <button class="btn btn-outline-secondary" onclick="adjustQuantity(1)">+1</button>
                                <button class="btn btn-outline-secondary" onclick="adjustQuantity(10)">+10</button>
                            </div>
                        </div>
                        <button class="btn btn-primary w-100" onclick="updateInventory()">
                            <i class="bi bi-save"></i> Cập nhật tồn kho
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity Log -->
        <div class="info-section">
            <h5>Lịch sử hoạt động</h5>
            <div class="activity-log">
                <c:forEach items="${product.activityLogs}" var="log">
                    <div class="log-item">
                        <div class="d-flex justify-content-between">
                            <strong>${log.action}</strong>
                            <small class="text-muted"><fmt:formatDate value="${log.timestamp}" pattern="dd/MM/yyyy HH:mm"/></small>
                        </div>
                        <div class="small text-muted">Người thực hiện: ${log.user}</div>
                        <div class="small">${log.details}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function changeMainImage(imageUrl) {
        document.getElementById('mainProductImage').src = imageUrl;

        // Update active class on thumbnails
        document.querySelectorAll('.gallery-thumb').forEach(thumb => {
            thumb.classList.remove('active');
            if (thumb.src === imageUrl) {
                thumb.classList.add('active');
            }
        });
    }

    function adjustQuantity(amount) {
        const adjustAmount = parseInt(document.getElementById('adjustAmount').value) || 0;
        const totalAmount = amount * (amount > 0 ? adjustAmount : 1);

        fetch(`/api/products/${productId}/adjust-inventory`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                quantity: totalAmount,
                type: amount > 0 ? 'ADD' : 'REMOVE',
                reason: 'Manual adjustment'
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Cập nhật tồn kho thành công');
                    location.reload();
                } else {
                    alert('Cập nhật thất bại: ' + data.message);
                }
            });
    }

    function updateInventory() {
        const adjustAmount = parseInt(document.getElementById('adjustAmount').value) || 0;
        if (adjustAmount === 0) {
            alert('Vui lòng nhập số lượng');
            return;
        }

        if (confirm(`Xác nhận điều chỉnh số lượng ${adjustAmount > 0 ? '+' : ''}${adjustAmount}?`)) {
            adjustQuantity(adjustAmount > 0 ? 1 : -1);
        }
    }

    const productId = ${product.id};
</script>
</body>
</html>