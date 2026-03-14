package code.salecar.service.product;

import code.salecar.dao.VoucherDAO;
import code.salecar.model.Cart;
import code.salecar.model.Voucher;

import java.util.List;

public class VoucherService {
    private VoucherDAO voucherDAO = new VoucherDAO();

    public List<Voucher> getVouchers() {
        return voucherDAO.getVouchers();
    }

    public Voucher getVoucher(int id) {
        return voucherDAO.getVoucherId(id);
    }

    public void getFinalPrice(int voucherId, Cart cart) {


        Voucher voucher = getVoucher(voucherId);
        double cartTotal = cart.getTotal();
        double minOder = voucher.getMinOrderValue().doubleValue();
        double discount = 0;


        if (cart.getTotal() >= minOder) {
            if (voucher.getValueType().equals("percent")) {

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
