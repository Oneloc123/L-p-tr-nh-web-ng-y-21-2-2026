package code.salecar.service.product;

import code.salecar.dao.BrandDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Brand;
import code.salecar.model.Product;

import java.util.List;

public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    BrandService bs = new BrandService();

    public Product getProductByID(int id) {
        Product product = productDAO.getProductByID(id);
        Brand brand = bs.getBrandByID(product.getBrandid());
        product.setBrandName(brand.getName());
        return product;
    }

    public List<Product> getProducts() {
        return productDAO.getproducts();
    }

    public List<Product> getProductsByPage(int page, int limit) {
        return productDAO.getProductsByPage( page, limit);
    }

    public int getTotalProduct() {
        return productDAO.getTotalProduct();
    }
    public int getTotalProduct(String find,String[] categories, String[] brands) {
        return productDAO.getTotalProduct(find,categories,brands);
    }

    public List<Product> getProductFilter(String find,String[] categories, String[] brands,int page, int limit) {
        return productDAO.getProductFilter(find,categories,brands,page, limit);
    }
}
