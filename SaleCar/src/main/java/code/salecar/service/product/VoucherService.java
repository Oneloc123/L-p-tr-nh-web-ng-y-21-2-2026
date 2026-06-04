package code.salecar.service.product;

import code.salecar.dao.VoucherDAO;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.Cart;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.product.entity.VoucherScope;
import code.salecar.model.product.filter.VoucherFilter;

import java.util.List;

public class VoucherService {
    private VoucherDAO voucherDAO = new VoucherDAO();

    // Phương thức không tham số - trả về tất cả voucher (dùng cho checkout, favorites, products...)
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

    // Phương thức cũ - dùng cho luồng checkout
    public void getFinalPrice(int voucherId, Cart cart) {
        Voucher voucher = voucherDAO.getVoucherById(voucherId);
        if (voucher == null) return;

        double cartTotal = cart.getTotal();
        double minOrder = voucher.getMinOrderValue() != null ? voucher.getMinOrderValue().doubleValue() : 0;
        double discount = 0;

        if (cartTotal >= minOrder) {
            if (voucher.getValueType() == DiscountValueType.PERCENT) {
                discount = voucher.getValue().doubleValue() * cartTotal / 100;
                if (voucher.getMaxDiscount() != null) {
                    discount = Math.min(discount, voucher.getMaxDiscount().doubleValue());
                }
            } else {
                discount = voucher.getValue().doubleValue();
            }
        }
        double finalPrice = cartTotal - discount;
        cart.setFinalTotal(finalPrice);
    }
}
