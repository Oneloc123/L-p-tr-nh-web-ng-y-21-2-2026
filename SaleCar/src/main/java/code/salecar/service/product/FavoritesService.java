package code.salecar.service.product;

import code.salecar.dao.FavoriesDAO;
import code.salecar.model.Product;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class FavoritesService {
    private FavoriesDAO favoriesDAO = new FavoriesDAO();
    private ProductService productService = new ProductService();

    public boolean addProduct(int productId, int userId) {
        List<Integer> favoritesList = favoriesDAO.getFavorites(userId);
        for (Integer favoriteId : favoritesList) {
            if (favoriteId == productId) {
                return false;
            }
        }
        return favoriesDAO.addProduct(productId, userId);

    }

    public List<Product> getFavorites(int userId) {
        List<Integer> favoritesList = favoriesDAO.getFavorites(userId);
        List<Product> products = new ArrayList<>();
        for (Integer favoriteId : favoritesList) {
            products.add(productService.getProductByID(favoriteId));
        }
        return products;
    }

    public boolean removeFavoritesProduct(int prid) {
        return favoriesDAO.removeFavoritesProduct(prid);
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


    public Set<String> getFavoritesBrand(List<Product> favoritesProducts) {
        Set<String> favoritesBrands = new HashSet<>();
        for (Product product : favoritesProducts) {
            favoritesBrands.add(product.getBrandName());
        }
        return favoritesBrands;
    }

    public Set<String> getFavoritesCategory(List<Product> favoritesProducts) {
        Set<String> favoritesCategory = new HashSet<>();
        for (Product product : favoritesProducts) {
            favoritesCategory.add(product.getCategoryName());
        }
        return favoritesCategory;
    }
}
