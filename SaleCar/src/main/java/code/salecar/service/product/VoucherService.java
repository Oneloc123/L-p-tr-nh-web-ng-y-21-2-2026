package code.salecar.service.product;

import code.salecar.dao.VoucherDAO;
import code.salecar.model.Voucher;

import java.util.List;

public class VoucherService {
    private VoucherDAO voucherDAO = new VoucherDAO();
    public List<Voucher> getVouchers() {
        return  voucherDAO.getVouchers();
    }
}
