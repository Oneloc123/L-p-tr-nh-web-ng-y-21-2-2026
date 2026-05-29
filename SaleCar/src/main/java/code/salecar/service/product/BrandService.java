package code.salecar.service.product;

import code.salecar.dao.BrandDAO;
import code.salecar.model.brand.Brand;
import code.salecar.model.brand.BrandFilter;
import code.salecar.model.enumeration.Status;
import java.util.List;

public class BrandService {

    BrandDAO brandDAO = new BrandDAO();

    public Brand getBrandByID(long brandid) {
        Brand brand = brandDAO.getBrandByID(brandid);
        return brand;
    }

    public int getTotalBrand() {
        return brandDAO.getTotalBrand();
    }

    public List<String> getBrandName() {
        return brandDAO.getBrandName();
    }
    public String getBrandName(long productId) {
        return brandDAO.getBrandName(productId);
    }

    public List<Brand> getBrands() {
        List<Brand> brands =  brandDAO.getBrands();
        return brands;
    }
    public List<Brand> getBrands(BrandFilter brandFilter) {
        List<Brand> brands =  brandDAO.getBrands(brandFilter);
        return brands;
    }

    public boolean updateBrand(Brand brand) {
        return brandDAO.updateBrand(brand);
    }

    public long createBrand(Brand brand) {
        return brandDAO.insertBrand(brand);
    }

    public boolean toggleStatus(int id) {
        Brand brand = brandDAO.getBrandByID(id);
        if (brand != null) {
            /** Chuyển đổi trạng thái */
            Status newStatus = brand.getIntStatus() == 1 ? Status.INACTIVE : Status.ACTIVE;
            brand.setStatus(newStatus);
            return brandDAO.updateBrand(brand);
        }
        return false;
    }
    public boolean toggleStatus(int id, Status status) {
        Brand brand = brandDAO.getBrandByID(id);
        if (brand != null) {
            /** Chuyển đổi trạng thái */
            brand.setStatus(status);
            return brandDAO.updateBrand(brand);
        }
        return false;
    }
}
