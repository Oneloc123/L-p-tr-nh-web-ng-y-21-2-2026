package code.salecar.service.product;

import code.salecar.dao.BrandDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Brand;
import code.salecar.model.Product;

import java.util.List;

public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    BrandDAO brandDAO = new BrandDAO();

    public Product getProductByID(int id) {
        Product product = productDAO.getProductByID(id);
        Brand brand = brandDAO.getBrandByID(product.getBrandid());
        product.setBrandName(brand.getName());
        return product;
    }

    public List<Product> getProducts() {
        return productDAO.getproducts();
    }
}
