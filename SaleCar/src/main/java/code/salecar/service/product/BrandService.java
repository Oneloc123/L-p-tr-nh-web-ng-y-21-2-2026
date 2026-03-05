package code.salecar.service.product;

import code.salecar.dao.BrandDAO;
import code.salecar.model.Brand;

import java.util.List;

public class BrandService {

    BrandDAO brandDAO = new BrandDAO();

    public Brand getBrandByID(int brandid) {
        return brandDAO.getBrandByID(brandid);
    }

    public int getTotalBrand() {
        return brandDAO.getTotalBrand();
    }

    public List<String> getBrandName() {
        return brandDAO.getBrandName();
    }
}
