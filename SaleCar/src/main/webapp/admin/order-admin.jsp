<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - LUXCAR Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --admin-primary: #1e81b0; /* Xanh chuẩn theo ảnh mẫu */
            --admin-bg: #f5f7f9;
            --admin-sidebar: #ffffff;
            --admin-text: #333333;
            --admin-border: #eaedf1;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--admin-bg);
            color: var(--admin-text);
            margin: 0;
            overflow-x: hidden;
        }

        /* ================= BỐ CỤC CHUẨN (KHÔNG KHOẢNG TRẮNG) ================= */
        .admin-layout {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }

        /* ================= SIDEBAR ================= */
        .sidebar {
            width: 260px;
            flex-shrink: 0; /* Không cho sidebar bị bóp nhỏ */
            background-color: var(--admin-sidebar);
            border-right: 1px solid var(--admin-border);
            height: 100vh;
            position: sticky; /* Bám dính khi cuộn */
            top: 0;
            padding: 20px 15px;
            overflow-y: auto;
        }

        .logo {
            font-size: 1.4rem;
            font-weight: 700;
            color: #1a365d;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            padding-left: 10px;
        }

        .logo i {
            color: var(--admin-primary);
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar nav ul li {
            margin-bottom: 5px;
        }

        .sidebar nav ul li a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 15px;
            border-radius: 50px; /* Bo tròn hoàn toàn theo ảnh mẫu */
            color: #64748b;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            font-size: 0.95rem;
        }

        .sidebar nav ul li a i {
            font-size: 1.2rem;
        }

        .sidebar nav ul li a:hover {
            background-color: #f8fafc;
            color: var(--admin-primary);
        }

        .sidebar nav ul li a.active {
            background-color: #eff6ff;
            color: var(--admin-primary);
        }

        /* ================= MAIN CONTENT ================= */
        .main-content {
            flex: 1; /* Tự động lấp đầy phần còn lại */
            padding: 30px;
            /* ĐÃ XÓA MARGIN-LEFT ĐỂ TRÁNH KHOẢNG TRẮNG */
            max-width: calc(100% - 260px); /* Giới hạn độ rộng chống tràn bảng */
        }

        .content-card {
            background: #ffffff;
            border-radius: 16px; /* Bo góc to hơn */
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
            padding: 25px;
            border: 1px solid var(--admin-border);
        }

        /* Header block giống ảnh mẫu User */
        .page-header-block {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: var(--admin-primary);
        }

        /* Custom Input & Button bo tròn */
        .search-input, .custom-select, .btn-pill {
            border-radius: 50px !important;
            padding: 10px 20px !important;
            box-shadow: none !important;
            border-color: #cbd5e1;
        }

        .search-input:focus, .custom-select:focus {
            border-color: var(--admin-primary);
        }

        .btn-pill {
            background-color: var(--admin-primary);
            color: white;
            border: none;
            font-weight: 500;
        }

        .btn-pill:hover {
            background-color: #15658e;
            color: white;
        }

        /* ================= TABLE ================= */
        .table > thead > tr > th {
            text-transform: uppercase;
            font-size: 12px;
            color: #64748b;
            font-weight: 600;
            padding: 15px;
            border-bottom: 2px solid var(--admin-border);
            background-color: transparent;
        }

        .table > tbody > tr > td {
            vertical-align: middle;
            font-size: 14px;
            padding: 15px;
            color: #334155;
            border-bottom: 1px solid var(--admin-border);
        }

        /* Trạng thái */
        .status-badge {
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 500;
            border: 1px solid transparent;
        }
        .status-pending { background: #fffbeb; color: #b45309; border-color: #fde68a; }
        .status-confirmed { background: #eff6ff; color: #1d4ed8; border-color: #bfdbfe; }
        .status-delivered { background: #f0fdf4; color: #15803d; border-color: #bbf7d0; }
        .status-cancelled { background: #fef2f2; color: #b91c1c; border-color: #fecaca; }

        /* Nút Action trong bảng */
        .btn-action {
            border-radius: 50px;
            padding: 5px 12px;
            font-size: 12px;
            font-weight: 500;
            background: transparent;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid;
            transition: 0.2s;
        }
        .btn-view { border-color: #64748b; color: #64748b; }
        .btn-view:hover { background: #64748b; color: white; }

        .btn-confirm { border-color: #0ea5e9; color: #0ea5e9; }
        .btn-confirm:hover { background: #0ea5e9; color: white; }

        .btn-deliver { border-color: #22c55e; color: #22c55e; }
        .btn-deliver:hover { background: #22c55e; color: white; }

        .btn-cancel { border-color: #ef4444; color: #ef4444; }
        .btn-cancel:hover { background: #ef4444; color: white; }

        form { margin: 0; }
    </style>
</head>
<body>

<div class="admin-layout">

<!-- SIDEBAR MODERN -->
    <aside class="sidebar">
        <h2 class="logo"><i class="bi bi-car-front-fill me-2"></i><span>LUXCAR Admin</span></h2>
        <nav>
            <ul>
                <li><a href="dashboard"><i class="bi bi-speedometer2"></i><span> Dashboard</span></a></li>
                <li><a href="products"><i class="bi bi-box"></i><span> Sản phẩm</span></a></li>
                <li><a href="categories"><i class="bi bi-tags"></i><span> Danh mục</span></a></li>
                <li><a href="/orderAdmin"><i class="bi bi-cart"></i><span> Đơn hàng</span></a></li>
                <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i><span> Thanh toán</span></a></li>
                <li><a href="users" class="active"><i class="bi bi-people"></i><span> Người dùng</span></a></li>
                <li><a href="blogs"><i class="bi bi-journal-text"></i><span> Blog</span></a></li>
                <li><a href="banners"><i class="bi bi-image"></i><span> Banner</span></a></li>
                <li><a href="/logout"><i class="bi bi-box-arrow-right"></i><span> Đăng xuất</span></a></li>
            </ul>
        </nav>
    </aside>

    <main class="main-content">

        <c:choose>
            <%-- ================================================================
                 VIEW 1: DANH SÁCH ĐƠN HÀNG (Khi không có param 'id')
                 ================================================================ --%>
            <c:when test="${empty param.id}">
                
                <div class="content-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="page-title m-0"><i class="bi bi-receipt"></i> Quản lý đơn hàng</h2>
                        <button class="btn btn-teal"><i class="bi bi-download"></i> Xuất dữ liệu</button>
                    </div>

                    <form action="order-admin" method="GET" class="row g-3 mb-4">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                                <input type="text" name="search" class="form-control" placeholder="Tìm kiếm mã đơn, tên khách hàng...">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select name="status" class="form-select">
                                <option value="">Tất cả trạng thái</option>
                                <option value="PENDING">Chờ xử lý</option>
                                <option value="CONFIRMED">Đã xác nhận</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-teal w-100"><i class="bi bi-funnel"></i> Lọc dữ liệu</button>
                        </div>
                    </form>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ord" items="${orders}">
                                <tr>
                                    <td><strong>#ORD-${ord.id}</strong></td>
                                    <td>
                                        <div class="fw-bold">${ord.shippingAddress}</div>

                                    </td>
                                    <td>${ord.orderDate}</td>
                                    <td class="fw-bold text-danger">${ord.totalAmount} ₫</td>
                                    <td><span class="status-badge status-pending">${ord.orderStatus}</span></td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-1">
                                            
                                            <form action="order-admin" method="GET">
                                                <input type="hidden" name="id" value="${ord.id}"> <button type="submit" class="btn btn-outline-dark btn-action" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i> Xem
                                                </button>
                                            </form>

                                            <form action="update-order-status" method="POST">
                                                <input type="hidden" name="orderId" value="${ord.id}">
                                                <input type="hidden" name="status" value="CONFIRMED">
                                                <button type="submit" class="btn btn-outline-info btn-action" title="Xác nhận đơn">
                                                    <i class="bi bi-check-circle"></i> Xác nhận
                                                </button>
                                            </form>

                                            <form action="update-order-status" method="POST">
                                                <input type="hidden" name="orderId" value="${ord.id}">
                                                <input type="hidden" name="status" value="DELIVERED">
                                                <button type="submit" class="btn btn-outline-success btn-action" title="Đã giao hàng">
                                                    <i class="bi bi-truck"></i> Đã giao
                                                </button>
                                            </form>

                                            <form action="update-order-status" method="POST">
                                                <input type="hidden" name="orderId" value="${ord.id}">
                                                <input type="hidden" name="status" value="CANCELLED">
                                                <button type="submit" class="btn btn-outline-danger btn-action" title="Hủy đơn">
                                                    <i class="bi bi-x-circle"></i> Cancel
                                                </button>
                                            </form>

                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                                </tbody>
                        </table>
                    </div>
                    
                    </div>
            </c:when>


            <%-- ================================================================
                 VIEW 2: CHI TIẾT 1 ĐƠN HÀNG (Khi có param 'id')
                 ================================================================ --%>
            <c:otherwise>
                
                <div class="content-card">
                    
                    <div class="mb-4">
                        <form action="order-admin" method="GET">
                            <button type="submit" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-arrow-left"></i> Quay lại danh sách
                            </button>
                        </form>
                    </div>

                    <div class="detail-header d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="m-0 fw-bold">Chi tiết đơn hàng #${param.id}</h4>
                            <small class="text-muted">Ngày đặt: 27-03-2026 14:30:00</small> </div>
                        <div>
                            <span class="status-badge status-pending fs-6">Trạng thái: Đang xử lý</span>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="info-box">
                                <div class="info-title"><i class="bi bi-person-lines-fill"></i> Thông tin khách hàng</div>
                                <p class="mb-1"><strong>Họ tên:</strong> Lê Trần Nhật Huy</p> <p class="mb-1"><strong>Số điện thoại:</strong> 0123456789</p>
                                <p class="mb-0"><strong>Địa chỉ:</strong> Công ty, 120 Yên Lãng, Đống Đa, Hà Nội</p>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="info-box">
                                <div class="info-title"><i class="bi bi-credit-card"></i> Phương thức thanh toán</div>
                                <p class="mb-1"><strong>Hình thức:</strong> Thanh toán khi nhận hàng (COD)</p>
                                <p class="mb-1"><strong>Trạng thái thanh toán:</strong> <span class="text-danger">Chưa thanh toán</span></p>
                                <h5 class="mt-3 text-danger fw-bold">Tổng tiền: 41.948.000 ₫</h5> </div>
                        </div>

                        <div class="col-md-4">
                            <div class="info-box">
                                <div class="info-title"><i class="bi bi-clock-history"></i> Lịch sử đơn hàng</div>
                                <ul class="timeline m-0">
                                    <li>
                                        <strong>Đang xử lý</strong>
                                        <div class="text-muted" style="font-size: 12px;">27-03-2026 14:30:00</div>
                                    </li>
                                    <li>
                                        <strong>Đơn hàng đã được tạo</strong>
                                        <div class="text-muted" style="font-size: 12px;">27-03-2026 14:29:15</div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <h5 class="fw-bold mb-3"><i class="bi bi-box"></i> Danh sách sản phẩm</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-end">Đơn giá</th>
                                    <th class="text-end">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div style="width: 50px; height: 50px; background: #eee; border-radius: 4px;" class="d-flex align-items-center justify-content-center">
                                                <i class="bi bi-car-front text-muted fs-4"></i>
                                            </div>
                                            <span class="fw-bold">Ford Defender 2019</span>
                                        </div>
                                    </td>
                                    <td class="text-center">1</td>
                                    <td class="text-end">41.948.000 ₫</td>
                                    <td class="text-end fw-bold">41.948.000 ₫</td>
                                </tr>
                            </tbody>
                            <tfoot class="table-light">
                                <tr>
                                    <td colspan="3" class="text-end fw-bold">Mã giảm giá (Nếu có):</td>
                                    <td class="text-end text-success">- 0 ₫</td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="text-end fw-bold">Tổng thanh toán:</td>
                                    <td class="text-end text-danger fw-bold fs-5">41.948.000 ₫</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>

</body>
</html>