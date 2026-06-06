<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thanh toán - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header.jsp" %>

    <style>
        :root {
            --black: #000000;
            --gold: #D4AF37;
            --white: #FFFFFF;
            --dark-gold: #b8960f;
            --gray-dark: #2c2c2c;
            --gray-medium: #666666;
            --gray-light: #f5f5f5;
            --border-light: #e5e5e5;
            --danger: #dc3545;
            --success: #28a745;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f4f6fa; }

        /* Main layout & Sidebar */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: var(--black); color: var(--white); padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 0 20px 20px; border-bottom: 1px solid #333; text-align: center; }
        .sidebar-header h3 { color: var(--white); font-size: 24px; font-weight: 600; margin: 0; }
        .sidebar-header p { color: #999; font-size: 14px; margin-top: 5px; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: var(--white); text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333; color: var(--white); transform: translateX(4px); }
        .menu-item.active { background-color: var(--white); color: var(--black); }
        .menu-item.active i { color: var(--black); }
        .menu-divider { height: 1px; background-color: #333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; background: #f4f6fa; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 700; color: var(--black); margin-bottom: 10px; letter-spacing: -0.3px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; flex-wrap: wrap; font-size: 13px; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #5a6874; text-decoration: none; transition: color 0.2s; }
        .breadcrumb-item a:hover { color: var(--gold); }
        .breadcrumb-item.active { color: var(--black); font-weight: 600; }

        /* Checkout Layout */
        .checkout-container { display: flex; gap: 30px; align-items: flex-start; }
        .checkout-form-section { flex: 2; }
        .checkout-summary-section { flex: 1; position: sticky; top: 30px; }

        /* Form & Cards */
        .checkout-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 8px 25px -8px rgba(0,0,0,0.06);
            padding: 30px;
            margin-bottom: 25px;
            border: 1px solid var(--border-light);
            transition: all 0.3s;
        }
        .checkout-card:hover {
            border-color: #ddd;
        }
        .checkout-card h3 {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--black);
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--black);
        }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #333; text-transform: uppercase; letter-spacing: 0.3px; }
        .form-control { width: 100%; padding: 12px 16px; border: 1.5px solid var(--border-light); border-radius: 10px; font-size: 14px; transition: border-color 0.3s, box-shadow 0.3s; }
        .form-control:focus { outline: none; border-color: var(--black); box-shadow: 0 0 0 3px rgba(0,0,0,0.05); }
        textarea.form-control { resize: vertical; min-height: 80px; }

        /* Payment Methods */
        .payment-method {
            border: 1.5px solid var(--border-light);
            border-radius: 12px;
            padding: 16px 18px;
            margin-bottom: 15px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s;
            background: var(--white);
        }
        .payment-method:hover {
            border-color: var(--black);
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
        .payment-method input[type="radio"] { width: 18px; height: 18px; accent-color: var(--black); }
        .payment-icon { font-size: 24px; color: var(--black); width: 40px; text-align: center; }
        .payment-details h4 { font-size: 15px; font-weight: 600; margin-bottom: 4px; color: var(--black); }
        .payment-details p { font-size: 13px; color: var(--gray-medium); margin: 0; }

        /* Order Summary */
        .summary-item { display: flex; justify-content: space-between; align-items: center; padding-bottom: 15px; margin-bottom: 15px; border-bottom: 1px dashed var(--border-light); transition: all 0.2s; }
        .summary-item:hover { background: #fafafa; margin-left: -8px; margin-right: -8px; padding-left: 8px; padding-right: 8px; border-radius: 8px; }
        .summary-item-info { display: flex; align-items: center; gap: 15px; }
        .summary-img { width: 60px; height: 45px; background: var(--gray-light); border-radius: 8px; overflow: hidden; flex-shrink: 0; border: 1px solid var(--border-light); }
        .summary-img img { width: 100%; height: 100%; object-fit: cover; }
        .summary-name { font-size: 14px; font-weight: 600; color: var(--black); }
        .summary-qty { font-size: 12px; color: var(--gray-medium); }
        .summary-price { font-size: 14px; font-weight: 600; color: var(--black); }

        .summary-calc { margin-top: 20px; }
        .calc-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 14px; color: var(--gray-medium); padding: 3px 0; }
        .calc-row.total {
            border-top: 2px solid var(--black);
            padding-top: 15px;
            font-size: 18px;
            font-weight: 700;
            color: var(--danger);
            margin-bottom: 25px;
        }

        .btn-submit-order {
            width: 100%;
            background-color: var(--black);
            color: var(--white);
            padding: 15px;
            border: 2px solid transparent;
            border-radius: 40px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-submit-order:hover {
            background-color: var(--gold);
            border-color: var(--black);
            color: var(--black);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(212,175,55,0.3);
        }
        .btn-submit-order:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .checkout-container { flex-direction: column; }
            .checkout-summary-section { position: static; width: 100%; }
        }

        /* Address slots */
        .address-slot {
            border: 1.5px solid var(--border-light);
            border-radius: 12px;
            padding: 16px 18px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.25s ease;
            position: relative;
            display: block;
            background: var(--white);
        }
        .address-slot:hover {
            border-color: var(--black);
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            transform: translateX(4px);
        }
        .address-slot.selected {
            border-color: var(--black);
            background-color: #fafafa;
            box-shadow: 0 4px 15px rgba(0,0,0,0.04);
        }
        .address-radio-hidden {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }
        .address-name { font-weight: 700; color: var(--black); margin-bottom: 5px; font-size: 15px; }
        .address-phone { font-size: 13px; color: #555; margin-bottom: 5px; }
        .address-detail { font-size: 13px; color: var(--gray-medium); margin-bottom: 0; line-height: 1.4; }
        .badge-default {
            background: var(--black); color: var(--white); font-size: 10px;
            padding: 3px 10px; border-radius: 12px; margin-left: 8px; vertical-align: middle;
            font-weight: 600;
        }

        /* Voucher */
        .voucher-input-group { transition: all 0.3s; }
        .input-row { display: flex; align-items: stretch; }
        .input-row .form-control:focus { border-color: var(--black); box-shadow: none; }
        .input-row .btn-dark { border: 1px solid var(--black); border-left: none; }
        .input-row .btn-dark:hover { background: var(--gray-dark); }

        .voucher-msg { font-size: 13px; padding: 8px 12px; border-radius: 8px; }
        .voucher-msg.success { color: #155724; background: #d4edda; border: 1px solid #c3e6cb; }
        .voucher-msg.error { color: #721c24; background: #f8d7da; border: 1px solid #f5c6cb; }

        .voucher-applied {
            display: flex; align-items: center; justify-content: space-between;
            background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
            border: 1px solid #a5d6a7; border-radius: 12px;
            padding: 14px 18px; margin-top: 10px;
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .voucher-applied-left { display: flex; align-items: center; gap: 12px; }
        .voucher-applied-left i { font-size: 24px; color: #2e7d32; }
        .voucher-applied-code { font-weight: 700; font-size: 15px; color: #1b5e20; }
        .voucher-applied-desc { font-size: 12px; color: #388e3c; margin-top: 2px; }
        .voucher-remove-btn {
            background: transparent; border: 1px solid #a5d6a7;
            color: #2e7d32; padding: 8px 16px; border-radius: 8px;
            font-size: 12px; font-weight: 600; cursor: pointer;
            transition: all 0.2s;
        }
        .voucher-remove-btn:hover {
            background: #2e7d32; color: var(--white); border-color: #2e7d32;
        }

        .loading-spinner {
            display: inline-block; width: 14px; height: 14px;
            border: 2px solid var(--white); border-top-color: transparent;
            border-radius: 50%; animation: spin 0.6s linear infinite;
        }
        .spin { animation: spin 0.6s linear infinite; display: inline-block; }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* Add address button */
        .btn-add-address {
            border: 2px dashed var(--border-light);
            background: transparent;
            color: var(--gray-medium);
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.25s;
            text-align: center;
            cursor: pointer;
        }
        .btn-add-address:hover {
            border-color: var(--black);
            color: var(--black);
            background: #fafafa;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item"><i class="bi bi-speedometer2"></i><span>Bảng điều khiển</span></a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item "><i class="bi bi-person-circle"></i><span>Thông tin cá nhân</span></a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item"><i class="bi bi-person-gear"></i><span>Chỉnh sửa thông tin</span></a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item"><i class="bi bi-lock"></i><span>Đổi mật khẩu</span></a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item"><i class="bi bi-bag"></i><span>Đơn hàng của tôi</span></a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item active"><i class="bi bi-cart3"></i><span>Giỏ hàng</span></a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item"><i class="bi bi-heart"></i><span>Sản phẩm yêu thích</span></a>
            <a href="${pageContext.request.contextPath}/notifications" class="menu-item"><i class="bi bi-bell"></i><span>Thông báo</span></a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item"><i class="bi bi-box-arrow-right"></i><span>Đăng xuất</span></a>
        </div>
    </div>



    <div class="main-content">
        <div class="content-header">
            <h1>Thanh toán</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a> <i class="bi bi-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a> <i class="bi bi-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item active">Thanh toán</li>
                </ol>
            </nav>
        </div>

        <form action="process-checkout"  method="POST">

            <input type="hidden" name="type" value="${param.type}">
            <div class="checkout-container">

                <div class="checkout-form-section">
                    <div class="checkout-card">
                        <h3><i class="bi bi-geo-alt-fill"></i> Thông tin giao hàng (Shipping Address)</h3>

                        <div class="form-group">
                            <label for="fullName">Họ và tên người nhận</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" value="${sessionScope.user != null ? sessionScope.user.username : ''}" placeholder="Nhập họ tên..." required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Số điện thoại (Phone)</label>
                            <input type="text" id="phone" name="phone" class="form-control" value="${sessionScope.user != null ? sessionScope.user.phonenumber : ''}" placeholder="Nhập số điện thoại..." required>
                        </div>


                        <!--Dia chi nhan hang -->
                        <div class="form-group mb-4">
                            <label class="mb-3">Địa chỉ nhận hàng (Shipping Address) <span class="text-danger">*</span></label>

                            <div id="address-slots-container">
                            <c:choose>
                        <c:when test="${empty listAddress}">
                            <div class="alert alert-warning py-2 mb-3" style="font-size: 14px; border-radius: 8px;">
                                <i class="bi bi-exclamation-triangle-fill"></i> Bạn chưa có địa chỉ nào, hãy thêm mới để đặt hàng!
                            </div>
                        </c:when>
                            <c:otherwise>
                                <%-- xu ly nut chon dia chi giao hang --%>                        <c:forEach var="addr" items="${listAddress}" varStatus="status">
                        <c:set var="radioId" value="addr_${addr.id}" />
                        <input type="radio" class="address-radio-hidden" id="${radioId}" name="shippingAddress" value="${addr.street}, ${addr.commune}, ${addr.province}" ${status.first ? 'checked' : ''}
                            data-ghn-district-id="${addr.ghnDistrictId}" data-ghn-ward-code="${addr.ghnWardCode}">
                            <label for="${radioId}" class="address-slot ${status.first ? 'selected' : ''}">
                                <div class="address-name">
                                    <i class="bi bi-person-tag text-muted me-1"></i> ${addr.name}
                                    <c:if test="${addr.type == 'main'}"><span class="badge-default">Mặc định</span></c:if>
                                </div>
                            <div class="address-detail"><i class="bi bi-geo-alt text-muted me-2"></i> ${addr.street}, ${addr.commune}, ${addr.province}</div>
                            </label>
                    </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                            <button type="button" class="btn-add-address mt-2" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                                <i class="bi bi-plus-circle me-1"></i> Thêm địa chỉ mới
                            </button>
                        </div>
                    </div>

                    <!-- SHIPPING METHOD -->
                    <div class="checkout-card">
                        <h3><i class="bi bi-truck"></i> Phương thức giao hàng</h3>

                        <label class="payment-method">
                            <input type="radio" name="shippingMethod" value="Tiêu chuẩn" checked>
                            <div class="payment-icon"><i class="bi bi-box"></i></div>
                            <div class="payment-details">
                                <h4>Giao hàng tiêu chuẩn</h4>
                                <p>Nhận hàng từ 5-8 ngày. Phí ship được tính theo khu vực.</p>
                            </div>
                        </label>

                        <label class="payment-method">
                            <input type="radio" name="shippingMethod" value="Nhanh">
                            <div class="payment-icon"><i class="bi bi-rocket-takeoff"></i></div>
                            <div class="payment-details">
                                <h4>Giao hàng nhanh</h4>
                                <p>Nhận hàng trong 1-3 ngày. Phí ship cao hơn.</p>
                            </div>
                        </label>
                    </div>

                    <!-- ORDER NOTE -->
                    <div class="checkout-card">
                        <h3><i class="bi bi-sticky"></i> Ghi chú đơn hàng</h3>
                        <div class="form-group">
                            <label for="note">Lời nhắn cho người bán (không bắt buộc)</label>
                            <textarea id="note" name="note" class="form-control" rows="3"
                                      placeholder="VD: Giao hàng trong giờ hành chính, Gọi trước khi giao,..."
                                      style="resize: vertical;"></textarea>
                        </div>
                    </div>

                    <div class="checkout-card">
                        <h3><i class="bi bi-wallet2"></i> Phương thức thanh toán (Payment Method)</h3>

                        <label class="payment-method">
                            <input type="radio" name="paymentMethod" value="COD" checked>
                            <div class="payment-icon"><i class="bi bi-cash"></i></div>
                            <div class="payment-details">
                                <h4>Thanh toán khi nhận hàng (COD)</h4>
                                <p>Thanh toán bằng tiền mặt khi giao hàng tận nơi.</p>
                            </div>
                        </label>

                        <label class="payment-method">
                            <input type="radio" name="paymentMethod" value="VNPAY">
                            <div class="payment-icon"><i class="bi bi-qr-code" style="color: #005baa;"></i></div>
                            <div class="payment-details">
                                <h4>Thanh toán qua VNPAY</h4>
                                <p>Thanh toán an toàn qua ví điện tử VNPay hoặc quét mã QR ứng dụng ngân hàng.</p>
                            </div>
                        </label>
                    </div>
                </div>

                <div class="checkout-summary-section">
                    <div class="checkout-card">
                        <h3><i class="bi bi-receipt"></i> Tóm tắt đơn hàng</h3>

                        <!-- Voucher -->
                        <div class="mb-3">
                            <label class="form-label">Mã giảm giá (Voucher)</label>
                            <div id="voucherInputGroup" class="voucher-input-group">
                                <div class="input-row">
                                    <input type="text" id="voucherCodeInput" class="form-control"
                                           placeholder="Nhập mã voucher..." autocomplete="off"
                                           style="flex:1; border-radius: 6px 0 0 6px;">
                                    <button type="button" id="btnApplyVoucher" class="btn btn-dark"
                                            style="border-radius: 0 6px 6px 0; padding: 12px 20px; font-weight: 600;">
                                        <i class="bi bi-tag"></i> Áp dụng
                                    </button>
                                </div>
                                <div id="voucherMessage" class="voucher-msg mt-2" style="display:none;"></div>
                            </div>

                            <!-- Voucher applied card -->
                            <div id="voucherAppliedCard" class="voucher-applied" style="display:none;">
                                <div class="voucher-applied-left">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <div class="voucher-applied-code" id="voucherAppliedCode"></div>
                                        <div class="voucher-applied-desc" id="voucherAppliedDesc"></div>
                                    </div>
                                </div>
                                <button type="button" id="btnRemoveVoucher" class="voucher-remove-btn">
                                    <i class="bi bi-x"></i> Hủy
                                </button>
                            </div>
                        </div>

                        <input type="hidden" name="voucherId" id="voucherIdHidden" value="">


                        <div class="summary-items-list">
                             <c:forEach var="item" items="${checkoutCart.items}">
                                <div class="summary-item">
                                    <div class="summary-item-info">

                                        <img src="${not empty item.productDetail.images ? pageContext.request.contextPath.concat('/uploads/').concat(item.productDetail.images[0]) : 'https://placehold.co/50'}" style="width: 50px; height: 50px; object-fit: cover;" alt="${item.productDetail.productName}" />

                                        <div>

                                            <div class="summary-name">${item.productDetail.productName}</div>
                                            <div class="summary-qty">Số lượng: ${item.quantity}</div>
                                        </div>
                                    </div>
                                    <div class="summary-price">

                                        <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/> ₫
                                    </div>
                                </div>
                             </c:forEach>
                        </div>

                        <div class="summary-calc">
                            <div class="calc-row">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${checkoutCart.total}" type="number" groupingUsed="true"/> ₫</span>
                            </div>
                            <div class="calc-row" id="shippingFeeRow">
                                <span>Phí vận chuyển:</span>
                                <span id="shippingFeeDisplay">Đang tính...</span>
                            </div>
                            <div class="calc-row total">
                                <span>Tổng cộng (Total Amount):</span>
                                <span id="totalPrice"><fmt:formatNumber value="${checkoutCart.total}" type="number" groupingUsed="true"/> ₫</span>
                            </div>
                            <input type="hidden" name="shippingFee" id="shippingFeeInput" value="0">
                        </div>


                        <!-- Dat hang -->
                        <c:choose>
                            <%-- Nếu danh sách địa chỉ rỗng -> Hiển thị nút ảo bị mờ (Disabled) --%>
                            <c:when test="${empty listAddress}">
                                <button type="button" class="btn-submit-order" style="background-color: #6c757d; cursor: not-allowed;" disabled>
                                    <i class="bi bi-lock-fill"></i> Vui lòng thêm địa chỉ để Đặt hàng
                                </button>
                            </c:when>

                            <%-- Nếu có địa chỉ -> Hiển thị nút Đặt hàng bình thường --%>
                            <c:otherwise>
                                <button type="submit" class="btn-submit-order">
                                    <i class="bi bi-check-circle-fill"></i> Đặt Hàng
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>
        </form>
    </div>
</div>


<%-- Modal dia chi --%>
<div class="modal fade" id="addAddressModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 12px; border: none;">
            <div class="modal-header" style="border-bottom: 1px solid #eee;">
                <h5 class="modal-title fw-bold" style="color: #000;">
                    <i class="bi bi-geo-alt-fill me-2"></i> Thêm địa chỉ giao hàng
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body" style="padding: 25px;">
                <form id="newAddressForm">
                    <div class="mb-3">
                        <label class="form-label fw-bold small">Tên người nhận</label>
                        <input type="text" class="form-control" id="newAddrName" name="newName" placeholder="Nhập họ tên..." required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small">Tỉnh / Thành phố <span class="text-danger">*</span></label>
                        <select class="form-select" id="newAddrProvince" required>
                            <option value="" selected disabled>Chọn Tỉnh / Thành phố</option>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3">
                            <label class="form-label fw-bold small">Quận / Huyện <span class="text-danger">*</span></label>
                            <select class="form-select" id="newAddrDistrict" required disabled>
                                <option value="" selected disabled>Chọn Quận / Huyện</option>
                            </select>
                        </div>
                        <div class="col-6 mb-3">
                            <label class="form-label fw-bold small">Phường / Xã <span class="text-danger">*</span></label>
                            <select class="form-select" id="newAddrWard" required disabled>
                                <option value="" selected disabled>Chọn Phường / Xã</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small">Số nhà, Tên đường <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="newAddrStreet" name="newStreet" placeholder="VD: Số 120 Yên Lãng" required>
                    </div>
                </form>
            </div>

            <div class="modal-footer" style="border-top: none;">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">Hủy bỏ</button>

                <button type="button" class="btn btn-dark" id="btnSaveAddress" style="border-radius: 8px;">
                    <i class="bi bi-save me-1"></i> Lưu địa chỉ
                </button>
            </div>
        </div>
    </div>
</div>

</body>
<script>

    // ========== BIẾN TOÀN CỤC ==========
    const contextPath = '${pageContext.request.contextPath}';
    const cartTotal = ${checkoutCart.total};
    let currentShippingFee = 0;

    // Format số VNĐ
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN').format(amount) + ' ₫';
    }

    // Cập nhật tổng tiền
    function updateTotalDisplay() {
        const totalElement = document.getElementById('totalPrice');
        const feeDisplay = document.getElementById('shippingFeeDisplay');
        const feeInput = document.getElementById('shippingFeeInput');

        if (currentShippingFee > 0) {
            feeDisplay.textContent = formatCurrency(currentShippingFee);
        } else {
            feeDisplay.textContent = 'Đang tính...';
        }

        const total = cartTotal + currentShippingFee;
        totalElement.textContent = formatCurrency(total);
        feeInput.value = currentShippingFee;
    }

    // ========== TÍNH PHÍ VẬN CHUYỂN ==========
    function calculateShippingFee(districtId, wardCode) {
        if (!districtId || !wardCode) {
            currentShippingFee = 0;
            updateTotalDisplay();
            return;
        }

        const feeDisplay = document.getElementById('shippingFeeDisplay');
        feeDisplay.textContent = 'Đang tính...';

        fetch(contextPath + '/api/shipping?action=fee&districtId=' + districtId + '&wardCode=' + encodeURIComponent(wardCode))
            .then(response => response.json())
            .then(data => {
                if (data.code === 200 && data.data && data.data.total) {
                    currentShippingFee = data.data.total;
                } else {
                    currentShippingFee = 30000; // mặc định nếu API lỗi
                }
                updateTotalDisplay();
            })
            .catch(error => {
                console.error('Lỗi tính phí ship:', error);
                currentShippingFee = 30000; // mặc định nếu lỗi mạng
                updateTotalDisplay();
            });
    }

    // ========== XỬ LÝ KHI CHỌN ĐỊA CHỈ ==========
    function handleAddressSelection(radio) {
        // Cập nhật UI selected
        document.querySelectorAll('.address-slot').forEach(function(slot) {
            slot.classList.remove('selected');
        });
        if (radio.checked) {
            const targetLabel = document.querySelector('label[for="' + radio.id + '"]');
            if (targetLabel) {
                targetLabel.classList.add('selected');
            }
        }

        // Tính phí vận chuyển dựa trên GHN districtId và wardCode
        const districtId = radio.getAttribute('data-ghn-district-id');
        const wardCode = radio.getAttribute('data-ghn-ward-code');
        calculateShippingFee(districtId, wardCode);
    }


    document.querySelectorAll('input[name="shippingAddress"]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            handleAddressSelection(this);
        });
    });


    document.addEventListener('DOMContentLoaded', function() {
        const checkedRadio = document.querySelector('input[name="shippingAddress"]:checked');
        if (checkedRadio) {
            const districtId = checkedRadio.getAttribute('data-ghn-district-id');
            const wardCode = checkedRadio.getAttribute('data-ghn-ward-code');
            calculateShippingFee(districtId, wardCode);
        }
    });

    // ========== VOUCHER STATE ==========
    let currentAppliedVoucher = null; // { code, discountValue, valueType, finalTotal }

    // ========== HIỂN THỊ THÔNG BÁO VOUCHER ==========
    function showVoucherMessage(message, type) {
        const msgEl = document.getElementById('voucherMessage');
        msgEl.textContent = message;
        msgEl.className = 'voucher-msg ' + type + ' mt-2';
        msgEl.style.display = 'block';
        setTimeout(function() {
            msgEl.style.display = 'none';
        }, 4000);
    }

    // ========== HIỂN THỊ / ẨN THẺ VOUCHER ĐÃ ÁP DỤNG ==========
    function showAppliedVoucher(data) {
        const inputGroup = document.getElementById('voucherInputGroup');
        const appliedCard = document.getElementById('voucherAppliedCard');
        const hiddenInput = document.getElementById('voucherIdHidden');

        inputGroup.style.display = 'none';
        hiddenInput.value = data.voucherId || '';

        document.getElementById('voucherAppliedCode').textContent = '\u2705 ' + data.voucherCode;
        let desc = '';
        if (data.valueType === 'PERCENT') {
            desc = 'Gi\u1ea3m ' + data.discountValue + '%';
        } else {
            desc = 'Gi\u1ea3m ' + formatCurrency(data.discountValue);
        }
        document.getElementById('voucherAppliedDesc').textContent = desc;

        appliedCard.style.display = 'flex';

        // Cập nhật tổng tiền
        document.getElementById("totalPrice").textContent = formatCurrency(data.finalTotal + currentShippingFee);

        currentAppliedVoucher = data;
    }

    function hideAppliedVoucher() {
        document.getElementById('voucherInputGroup').style.display = 'block';
        document.getElementById('voucherAppliedCard').style.display = 'none';
        document.getElementById('voucherIdHidden').value = '';
        document.getElementById('voucherCodeInput').value = '';
        document.getElementById('voucherCodeInput').focus();

        currentAppliedVoucher = null;
    }

    // ========== ÁP DỤNG VOUCHER (NHẬP MÃ) ==========
    function applyVoucher() {
        const code = document.getElementById('voucherCodeInput').value.trim();
        if (!code) {
            showVoucherMessage('Vui l\u00f2ng nh\u1eadp m\u00e3 voucher', 'error');
            return;
        }

        const btn = document.getElementById('btnApplyVoucher');
        btn.disabled = true;
        btn.innerHTML = '<span class="loading-spinner"></span>';

        const urlParams = new URLSearchParams(window.location.search);
        const type = urlParams.get('type') || '';

        fetch(contextPath + "/voucher", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "action=apply&voucherCode=" + encodeURIComponent(code) + "&type=" + type
        })
        .then(response => response.json())
        .then(data => {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-tag"></i> \u00c1p d\u1ee5ng';

            if (data.success) {
                showAppliedVoucher(data);
            } else {
                showVoucherMessage(data.message, 'error');
                // Reset tổng tiền về gốc
                document.getElementById("totalPrice").textContent = formatCurrency(cartTotal + currentShippingFee);
            }
        })
        .catch(error => {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-tag"></i> \u00c1p d\u1ee5ng';
            showVoucherMessage('L\u1ed7i k\u1ebft n\u1ed1i, vui l\u00f2ng th\u1eed l\u1ea1i', 'error');
            console.error("Voucher error:", error);
        });
    }

    // ========== HỦY VOUCHER ==========
    function removeVoucher() {
        const btn = document.getElementById('btnRemoveVoucher');
        btn.disabled = true;
        btn.innerHTML = '<span class="loading-spinner" style="border-color:#2e7d32;border-top-color:transparent;"></span>';

        const urlParams = new URLSearchParams(window.location.search);
        const type = urlParams.get('type') || '';

        fetch(contextPath + "/voucher", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "action=remove&type=" + type
        })
        .then(response => response.json())
        .then(data => {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-x"></i> H\u1ee7y';

            if (data.success) {
                hideAppliedVoucher();
                // Reset tổng tiền về gốc
                document.getElementById("totalPrice").textContent = formatCurrency(cartTotal + currentShippingFee);
            }
        })
        .catch(error => {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-x"></i> H\u1ee7y';
            console.error("Remove voucher error:", error);
        });
    }

    // ========== EVENTS ==========
    document.getElementById("btnApplyVoucher").addEventListener("click", applyVoucher);
    document.getElementById("btnRemoveVoucher").addEventListener("click", removeVoucher);

    // Nhấn Enter trong ô input cũng áp dụng voucher
    document.getElementById("voucherCodeInput").addEventListener("keydown", function(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            applyVoucher();
        }
    });

    // ========== KHÔI PHỤC VOUCHER TỪ SESSION (nếu có) ==========
    // Khi load trang, nếu session có selectedVoucherId, gọi API để hiển thị lại
    document.addEventListener('DOMContentLoaded', function() {
        const savedVoucherId = '${sessionScope.selectedVoucherId}';
        const savedCode = '${sessionScope.appliedVoucherCode}';
        if (savedVoucherId && savedVoucherId !== '' && savedVoucherId !== '0') {
            // Có voucher đã chọn từ trước → gọi API áp dụng lại
            const urlParams = new URLSearchParams(window.location.search);
            const type = urlParams.get('type') || '';
            fetch(contextPath + "/voucher", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "action=apply&voucherCode=" + encodeURIComponent(savedCode) + "&type=" + type
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAppliedVoucher(data);
                }
            })
            .catch(error => console.error("Restore voucher error:", error));
        }
    });

    //thêm addr  (GHN API)
    fetch(contextPath + '/api/shipping?action=provinces')
        .then(response => response.json())
        .then(data => {
            if (data.code === 200 && data.data) {
                const provinceSelect = document.getElementById('newAddrProvince');
                provinceSelect.innerHTML = '<option value="" selected disabled>Chọn Tỉnh / Thành phố</option>';
                data.data.forEach(function(province) {
                    let option = document.createElement('option');
                    option.value = province.ProvinceName;
                    option.text = province.ProvinceName;
                    // Lưu GHN ProvinceID để gọi API quận/huyện
                    option.dataset.provinceId = province.ProvinceID;
                    provinceSelect.add(option);
                });
            }
        })
        .catch(error => console.error('Lỗi load tỉnh:', error));

    // chọn tỉnh load quận huyện
    document.getElementById('newAddrProvince').addEventListener('change', function() {
        const districtSelect = document.getElementById('newAddrDistrict');
        const wardSelect = document.getElementById('newAddrWard');

        districtSelect.innerHTML = '<option value="" selected disabled>Đang tải...</option>';
        districtSelect.disabled = true;
        wardSelect.innerHTML = '<option value="" selected disabled>Chọn Phường / Xã</option>';
        wardSelect.disabled = true;

        const provinceId = this.options[this.selectedIndex].dataset.provinceId;

        fetch(contextPath + '/api/shipping?action=districts&provinceId=' + provinceId)
            .then(response => response.json())
            .then(data => {
                districtSelect.innerHTML = '<option value="" selected disabled>Chọn Quận / Huyện</option>';
                districtSelect.disabled = false;
                if (data.code === 200 && data.data) {
                    data.data.forEach(function(district) {
                        let option = document.createElement('option');
                        option.value = district.DistrictName;
                        option.text = district.DistrictName;
                        // Lưu GHN DistrictID để load phường/xã và tính phí ship
                        option.dataset.districtId = district.DistrictID;
                        districtSelect.add(option);
                    });
                }
            })
            .catch(error => console.error('Lỗi load quận/huyện:', error));
    });

    // chọn quận/huyện load phường/xã
    document.getElementById('newAddrDistrict').addEventListener('change', function() {
        const wardSelect = document.getElementById('newAddrWard');
        wardSelect.innerHTML = '<option value="" selected disabled>Đang tải...</option>';
        wardSelect.disabled = true;

        const districtId = this.options[this.selectedIndex].dataset.districtId;

        fetch(contextPath + '/api/shipping?action=wards&districtId=' + districtId)
            .then(response => response.json())
            .then(data => {
                wardSelect.innerHTML = '<option value="" selected disabled>Chọn Phường / Xã</option>';
                wardSelect.disabled = false;
                if (data.code === 200 && data.data) {
                    data.data.forEach(function(ward) {
                        let option = document.createElement('option');
                        option.value = ward.WardName;
                        option.text = ward.WardName;
                        // Lưu GHN WardCode để tính phí ship
                        option.dataset.wardCode = ward.WardCode;
                        wardSelect.add(option);
                    });
                }
            })
            .catch(error => console.error('Lỗi load phường/xã:', error));
    });

    // lưu địa chỉ
    document.getElementById("btnSaveAddress").addEventListener("click", function(){

        const name = document.getElementById('newAddrName').value.trim();
        const province = document.getElementById('newAddrProvince').value;
        const district = document.getElementById('newAddrDistrict').value;
        const ward = document.getElementById('newAddrWard').value;
        const street = document.getElementById('newAddrStreet').value.trim();

        // Lấy GHN DistrictID và WardCode từ dataset của option đang chọn
        const districtOption = document.getElementById('newAddrDistrict').options[document.getElementById('newAddrDistrict').selectedIndex];
        const wardOption = document.getElementById('newAddrWard').options[document.getElementById('newAddrWard').selectedIndex];
        const ghnDistrictId = districtOption ? districtOption.dataset.districtId : '';
        const ghnWardCode = wardOption ? wardOption.dataset.wardCode : '';

        //check form
        if(!name || !province || !district || !ward || !street){
            alert("Vui lòng điền đủ thông tin!");
            return;
        }

        const fullCommune = ward + ", " + district;

        const formData = new URLSearchParams();
        formData.append("name", name);
        formData.append("province", province);
        formData.append("commune", fullCommune);
        formData.append("street", street);
        formData.append("type", "sub");
        formData.append("ghnDistrictId", ghnDistrictId);
        formData.append("ghnWardCode", ghnWardCode);

        // UI hien thi dang luu
        const btnSave = document.getElementById('btnSaveAddress');
        btnSave.innerHTML = '<i class="bi bi-arrow-clockwise spin me-1"></i> Đang lưu...';
        btnSave.disabled = true;

        fetch(contextPath + '/add-address', {
            method: 'POST',
            headers: {
                'Content-type' : 'application/x-www-form-urlencoded',
            },
            body: formData.toString()
        })
        .then(response => response.text())
        .then(data => {
            if(data === 'success') {
                window.location.reload();
            } else if(data === 'full_slot') {
                alert("Bạn chỉ lưu tối đa được 6 địa chỉ, vui lòng xóa để thêm!");
                btnSave.innerHTML = '<i class="bi bi-save me-1"></i> Lưu địa chỉ';
                btnSave.disabled = false;
            } else {
                alert("Có lỗi xảy ra, không thể lưu địa chỉ!");
                btnSave.innerHTML = '<i class="bi bi-save me-1"></i> Lưu địa chỉ';
                btnSave.disabled = false;
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("Lỗi kết nối!");
            btnSave.disabled = false;
        });
    });

</script>
</html>