package code.salecar.service.product;

import code.salecar.dao.ProductDAO;
import code.salecar.model.Product;

import java.util.List;

public class ProductService {
    ProductDAO productDAO = new ProductDAO();


    public Product getProductByID(int id) {
        return productDAO.getProductByID(id);
    }

    public List<Product> getProducts() {
        return productDAO.getproducts();
    }
}
