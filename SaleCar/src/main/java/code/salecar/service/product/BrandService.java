package code.salecar.service.product;

import code.salecar.dao.BrandDAO;
import code.salecar.model.Brand;
import code.salecar.model.Image;
import code.salecar.service.Image.ImageService;

import java.util.List;

public class BrandService {

    BrandDAO brandDAO = new BrandDAO();
    ImageService  imageService = new ImageService();

    public Brand getBrandByID(int brandid) {
        return brandDAO.getBrandByID(brandid);
    }

    public int getTotalBrand() {
        return brandDAO.getTotalBrand();
    }

    public List<String> getBrandName() {
        return brandDAO.getBrandName();
    }
    public String getBrandName(int productId) {
        return brandDAO.getBrandName(productId);
    }

    public List<Brand> getBrands() {
        List<Brand> brands =  brandDAO.getBrands();
        for (Brand brand : brands) {
            String image = imageService.getImage(Image.entityType.brand,brand.getId());
            brand.setImage(image);
        }
        return brands;
    }
}
