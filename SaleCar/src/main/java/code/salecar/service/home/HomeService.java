package code.salecar.service.home;

import code.salecar.dao.CategoryDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Category;
import code.salecar.model.Discount;
import code.salecar.model.Product;

import java.util.List;

public class HomeService {

    ProductDAO  productDAO = new ProductDAO();
    CategoryDAO categoryDAO = new CategoryDAO();

    public List<Product> getProductNew(){
        return productDAO.getProductNew();
    }

    public List<Product> getProductByCategory(int category_id){
        return null;
    }

    public List<Product> getProductByFavorites(int uers_id){
        return null;
    }

    public List<Product> getProductSale(){
        return null;
    }

    public List<Product> getProductSaleByCategory(int category_id){
        return null;
    }

    public List<Discount> getVoucher(){
        return null;
    }

    public List<Product> getProductHot() {
        return productDAO.getProductHot();
    }
}
