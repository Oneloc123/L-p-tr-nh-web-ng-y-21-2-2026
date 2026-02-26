<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thanh toán - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header-for-login-ex.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar (Dùng chung) */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: #000000; color: #ffffff; padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 0 20px 20px; border-bottom: 1px solid #333333; text-align: center; }
        .sidebar-header h3 { color: #ffffff; font-size: 24px; font-weight: 600; margin: 0; }
        .sidebar-header p { color: #999999; font-size: 14px; margin-top: 5px; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: #ffffff; text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333333; color: #ffffff; }
        .menu-item.active { background-color: #ffffff; color: #000000; }
        .menu-item.active i { color: #000000; }
        .menu-divider { height: 1px; background-color: #333333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; }
        .content-header { margin-bottom: 30px; }
        .content-header h1 { font-size: 28px; font-weight: 600; color: #000000; margin-bottom: 10px; }
        .breadcrumb { background: none; padding: 0; margin: 0; list-style: none; display: flex; }
        .breadcrumb-item { margin-right: 10px; }
        .breadcrumb-item a { color: #666666; text-decoration: none; }
        .breadcrumb-item.active { color: #000000; font-weight: 500; }

        /* Checkout Layout */
        .checkout-container { display: flex; gap: 30px; align-items: flex-start; }
        .checkout-form-section { flex: 2; }
        .checkout-summary-section { flex: 1; position: sticky; top: 30px; }

        /* Form & Cards */
        .checkout-card { background: #ffffff; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); padding: 30px; margin-bottom: 25px; }
        .checkout-card h3 { font-size: 18px; font-weight: 600; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #000; display: flex; align-items: center; gap: 10px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 14px; font-weight: 500; margin-bottom: 8px; color: #333; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 6px; font-size: 14px; transition: border-color 0.3s; }
        .form-control:focus { outline: none; border-color: #000; }

        /* Payment Methods */
        .payment-method { border: 1px solid #ddd; border-radius: 8px; padding: 15px; margin-bottom: 15px; cursor: pointer; display: flex; align-items: center; gap: 15px; transition: 0.3s; }
        .payment-method:hover { border-color: #000; }
        .payment-method input[type="radio"] { width: 18px; height: 18px; accent-color: #000; }
        .payment-icon { font-size: 24px; color: #000; width: 40px; text-align: center; }
        .payment-details h4 { font-size: 15px; font-weight: 600; margin-bottom: 5px; color: #000; }
        .payment-details p { font-size: 13px; color: #666; margin: 0; }

        /* Order Summary */
        .summary-item { display: flex; justify-content: space-between; align-items: center; padding-bottom: 15px; margin-bottom: 15px; border-bottom: 1px dashed #eee; }
        .summary-item-info { display: flex; align-items: center; gap: 15px; }
        .summary-img { width: 60px; height: 45px; background: #f0f0f0; border-radius: 4px; display: flex; align-items: center; justify-content: center; color: #999; }
        .summary-name { font-size: 14px; font-weight: 600; color: #000; }
        .summary-qty { font-size: 12px; color: #666; }
        .summary-price { font-size: 14px; font-weight: 600; color: #000; }

        .summary-calc { margin-top: 20px; }
        .calc-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 14px; color: #666; }
        .calc-row.total { border-top: 2px solid #000; padding-top: 15px; font-size: 18px; font-weight: 700; color: #d9534f; margin-bottom: 25px; }

        .btn-submit-order { width: 100%; background-color: #000; color: #fff; padding: 15px; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; justify-content: center; gap: 10px; }
        .btn-submit-order:hover { background-color: #333; }

        /* Responsive */
        @media (max-width: 992px) {
            .checkout-container { flex-direction: column; }
            .checkout-summary-section { position: static; width: 100%; }
        }
    </style>
</head>
<body>
<div class="profile-wrapper">
    <div class="sidebar-menu">
        <div class="sidebar-header">
            <h3>LUXCAR</h3>
            <p>Mô hình xe cao cấp</p>
        </div>
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item">
                <i class="fas fa-chart-pie"></i><span>Bảng điều khiển</span>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item">
                <i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item active">
                <i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item">
                <i class="fas fa-shopping-bag"></i><span>Đơn hàng của tôi</span>
            </a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span>
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="content-header">
            <h1>Thanh toán</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> <i class="fas fa-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a> <i class="fas fa-chevron-right" style="font-size: 10px; margin: 0 5px;"></i></li>
                    <li class="breadcrumb-item active">Thanh toán</li>
                </ol>
            </nav>
        </div>

        <form action="process-checkout.jsp" method="POST">
            <div class="checkout-container">

                <div class="checkout-form-section">
                    <div class="checkout-card">
                        <h3><i class="fas fa-map-marker-alt"></i> Thông tin giao hàng (Shipping Address)</h3>

                        <div class="form-group">
                            <label for="fullName">Họ và tên người nhận</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" value="Nguyễn Văn An" placeholder="Nhập họ tên...">
                        </div>

                        <div class="form-group">
                            <label for="phone">Số điện thoại (Phone)</label>
                            <input type="text" id="phone" name="phone" class="form-control" value="0987654321" placeholder="Nhập số điện thoại...">
                        </div>

                        <div class="form-group">
                            <label for="shippingAddress">Địa chỉ nhận hàng (Shipping Address)</label>
                            <textarea id="shippingAddress" name="shippingAddress" class="form-control" rows="3" placeholder="Nhập địa chỉ chi tiết (Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố)...">123 Đường Lê Lợi, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh</textarea>
                        </div>
                    </div>

                    <div class="checkout-card">
                        <h3><i class="fas fa-wallet"></i> Phương thức thanh toán (Payment Method)</h3>

                        <label class="payment-method">
                            <input type="radio" name="paymentMethod" value="COD" checked>
                            <div class="payment-icon"><i class="fas fa-money-bill-wave"></i></div>
                            <div class="payment-details">
                                <h4>Thanh toán khi nhận hàng (COD)</h4>
                                <p>Thanh toán bằng tiền mặt khi giao hàng tận nơi.</p>
                            </div>
                        </label>

                        <label class="payment-method">
                            <input type="radio" name="paymentMethod" value="BANK_TRANSFER">
                            <div class="payment-icon"><i class="fas fa-university"></i></div>
                            <div class="payment-details">
                                <h4>Chuyển khoản ngân hàng</h4>
                                <p>Chuyển khoản trực tiếp qua số tài khoản ngân hàng của cửa hàng.</p>
                            </div>
                        </label>

                        <label class="payment-method">
                            <input type="radio" name="paymentMethod" value="MOMO">
                            <div class="payment-icon"><i class="fas fa-qrcode"></i></div>
                            <div class="payment-details">
                                <h4>Thanh toán qua ví MoMo</h4>
                                <p>Quét mã QR qua ứng dụng ví điện tử MoMo.</p>
                            </div>
                        </label>
                    </div>
                </div>

                <div class="checkout-summary-section">
                    <div class="checkout-card">
                        <h3><i class="fas fa-receipt"></i> Tóm tắt đơn hàng</h3>

                        <div class="summary-items-list">
                            <div class="summary-item">
                                <div class="summary-item-info">
                                    <div class="summary-img"><i class="fas fa-car"></i></div>
                                    <div>
                                        <div class="summary-name">Lamborghini Aventador 1:18</div>
                                        <div class="summary-qty">Số lượng: 1</div>
                                    </div>
                                </div>
                                <div class="summary-price">2,500,000 ₫</div>
                            </div>

                            <div class="summary-item">
                                <div class="summary-item-info">
                                    <div class="summary-img"><i class="fas fa-car"></i></div>
                                    <div>
                                        <div class="summary-name">Porsche 911 GT3 RS 1:24</div>
                                        <div class="summary-qty">Số lượng: 2</div>
                                    </div>
                                </div>
                                <div class="summary-price">2,400,000 ₫</div>
                            </div>
                        </div>

                        <div class="summary-calc">
                            <div class="calc-row">
                                <span>Tạm tính:</span>
                                <span>4,900,000 ₫</span>
                            </div>
                            <div class="calc-row">
                                <span>Phí vận chuyển:</span>
                                <span>Miễn phí</span>
                            </div>
                            <div class="calc-row total">
                                <span>Tổng cộng (Total Amount):</span>
                                <span>4,900,000 ₫</span>
                            </div>
                        </div>

                        <button type="submit" class="btn-submit-order">
                            <i class="fas fa-check-circle"></i> Đặt Hàng
                        </button>
                    </div>
                </div>

            </div>
        </form>
    </div>
</div>
</body>
</html>