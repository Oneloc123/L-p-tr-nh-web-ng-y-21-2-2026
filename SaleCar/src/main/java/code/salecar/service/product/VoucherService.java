package code.salecar.service.product;

import code.salecar.dao.VoucherDAO;
import code.salecar.model.Cart;
import code.salecar.model.CartItem;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.entity.VoucherScope;
import code.salecar.model.product.filter.VoucherFilter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class VoucherService {
    private VoucherDAO voucherDAO = new VoucherDAO();

    // Phương thức không tham số - trả về tất cả voucher
    public List<Voucher> getVouchers() {
        VoucherFilter filter = new VoucherFilter();
        filter.setPage(1);
        filter.setLimit(Integer.MAX_VALUE);
        return voucherDAO.getVouchers(filter);
    }

    public List<Voucher> getVouchers(VoucherFilter filter) {
        return voucherDAO.getVouchers(filter);
    }

    public int getTotalVouchers(VoucherFilter filter) {
        return voucherDAO.getTotalVouchers(filter);
    }

    public Voucher getVoucher(long id) {
        return voucherDAO.getVoucherById(id);
    }

    public Voucher getVoucherByCode(String code) {
        return voucherDAO.getVoucherByCode(code);
    }

    public long createVoucher(Voucher voucher) {
        return voucherDAO.createVoucher(voucher);
    }

    public boolean updateVoucher(Voucher voucher) {
        return voucherDAO.updateVoucher(voucher);
    }

    public boolean deleteVoucher(long id) {
        return voucherDAO.deleteVoucher(id);
    }

    public boolean toggleStatus(long id) {
        return voucherDAO.toggleStatus(id);
    }

    public boolean isCodeExists(String code, Long excludeId) {
        return voucherDAO.isCodeExists(code, excludeId);
    }

    // Các phương thức phạm vi
    public List<VoucherScope> getScopes(long voucherId) {
        return voucherDAO.getScopesByVoucherId(voucherId);
    }

    public void saveScopes(long voucherId, List<VoucherScope> scopes) {
        voucherDAO.saveScopes(voucherId, scopes);
    }

    // Dữ liệu tham chiếu
    public List<Object[]> getAllBrands() { return voucherDAO.getAllBrands(); }
    public List<Object[]> getAllCategories() { return voucherDAO.getAllCategories(); }
    public List<Object[]> getAllProducts() { return voucherDAO.getAllProducts(); }

    // Tăng số lần sử dụng voucher
    public boolean incrementUsedCount(long voucherId) {
        return voucherDAO.incrementUsedCount(voucherId);
    }

    /**
     * Kiểm tra voucher có hợp lệ để áp dụng cho giỏ hàng không.
     */
    public boolean isValidForCart(Voucher voucher, Cart cart) {
        if (voucher == null) return false;

        // 1. Check status ACTIVE
        if (voucher.getStatus() != Status.ACTIVE) return false;

        LocalDateTime now = LocalDateTime.now();

        // 2. Check thời gian hiệu lực
        if (voucher.getStartAt() != null && now.isBefore(voucher.getStartAt())) return false;
        if (voucher.getEndAt() != null && now.isAfter(voucher.getEndAt())) return false;

        // 3. Check số lần sử dụng còn lại
        if (voucher.getUsageLimit() > 0 && voucher.getUsedCount() >= voucher.getUsageLimit()) return false;

        // 4. Check giá trị đơn hàng tối thiểu
        double cartTotal = cart.getTotal();
        if (voucher.getMinOrderValue() != null && cartTotal < voucher.getMinOrderValue().doubleValue()) return false;

        // 5. Check VoucherScope (phạm vi áp dụng)
        List<VoucherScope> scopes = voucherDAO.getScopesByVoucherId(voucher.getId());
        if (scopes != null && !scopes.isEmpty()) {
            boolean hasOrderScope = false;
            for (VoucherScope s : scopes) {
                if ("order".equals(s.getEntityType())) {
                    hasOrderScope = true;
                    break;
                }
            }
            if (hasOrderScope) return true; // "order" scope = áp dụng toàn bộ đơn hàng

            // Kiểm tra từng item trong giỏ có match scope không
            for (VoucherScope scope : scopes) {
                for (CartItem item : cart.getItems()) {
                    code.salecar.model.product.dto.ProductDetailDTO productDetail = item.getProductDetail();
                    if (productDetail == null) continue;
                    switch (scope.getEntityType()) {
                        case "product":
                            if (productDetail.getProductId() == scope.getEntityId()) return true;
                            break;
                        case "brand":
                            if (productDetail.getBrandId() == scope.getEntityId()) return true;
                            break;
                        case "category":
                            if (productDetail.getCategoryId() == scope.getEntityId()) return true;
                            break;
                    }
                }
            }
            return false; // Không có item nào match scope
        }

        return true; // Không có scope restriction
    }

    /**
     * Lấy danh sách voucher khả dụng cho giỏ hàng.
     */
    public List<Voucher> getAvailableVouchers(Cart cart) {
        List<Voucher> allVouchers = getVouchers();
        List<Voucher> available = new ArrayList<>();
        for (Voucher v : allVouchers) {
            if (isValidForCart(v, cart)) {
                available.add(v);
            }
        }
        return available;
    }

    /**
     * Tính giá cuối cùng sau voucher (có validation đầy đủ).
     * Trả về finalTotal. Nếu voucher không hợp lệ, trả về cartTotal (không giảm).
     */
    public double getFinalPrice(int voucherId, Cart cart) {
        Voucher voucher = voucherDAO.getVoucherById(voucherId);
        if (!isValidForCart(voucher, cart)) {
            cart.setFinalTotal(cart.getTotal());
            return cart.getTotal();
        }

        double cartTotal = cart.getTotal();
        double discount = 0;

        if (voucher.getValueType() == DiscountValueType.PERCENT) {
            discount = voucher.getValue().doubleValue() * cartTotal / 100;
            if (voucher.getMaxDiscount() != null) {
                discount = Math.min(discount, voucher.getMaxDiscount().doubleValue());
            }
        } else {
            discount = voucher.getValue().doubleValue();
        }

        double finalPrice = Math.max(0, cartTotal - discount); // Không cho âm
        cart.setFinalTotal(finalPrice);
        return finalPrice;
    }
}
