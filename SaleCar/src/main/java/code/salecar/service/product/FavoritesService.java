package code.salecar.service.product;

import code.salecar.dao.FavoriesDAO;
import code.salecar.model.Product;

import java.util.ArrayList;
import java.util.List;

public class FavoritesService {
    private FavoriesDAO favoriesDAO = new FavoriesDAO();
    private ProductService productService = new ProductService();

    public boolean addProduct(int productId, int userId) {
        return favoriesDAO.addProduct(productId,userId);

    }

    public List<Product> getFavorites(int userId) {
        List<Integer> favoritesList = favoriesDAO.getFavorites(userId);
        List<Product> products = new ArrayList<>();
        for (Integer favoriteId : favoritesList) {
           products.add(productService.getProductByID(favoriteId));
        }
        return products;
    }

    static void main() {
        FavoriesDAO favoriesDAO = new FavoriesDAO();
        ProductService productService = new ProductService();
        List<Integer> favoritesList = favoriesDAO.getFavorites(1);
        List<Product> products = new ArrayList<>();
        for (Integer favoriteId : favoritesList) {
            products.add(productService.getProductByID(favoriteId));
        }
        System.out.println(favoritesList);
        System.out.println(products);

    }
}
