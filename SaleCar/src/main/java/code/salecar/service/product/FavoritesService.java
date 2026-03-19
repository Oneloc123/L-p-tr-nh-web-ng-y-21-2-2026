package code.salecar.service.product;

import code.salecar.dao.FavoriesDAO;
import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.entity.Product;

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

    public List<ProductDetail> getFavorites(int userId) {
        List<Integer> favoritesList = favoriesDAO.getFavorites(userId);
        List<ProductDetail> products = new ArrayList<>();
        for (Integer favoriteId : favoritesList) {
            products.add(productService.getProductByID(favoriteId));
        }
        return products;
    }

    public boolean removeFavoritesProduct(int prid) {
        return favoriesDAO.removeFavoritesProduct(prid);
    }




    public Set<String> getFavoritesBrand(List<ProductDetail> favoritesProducts) {
        Set<String> favoritesBrands = new HashSet<>();
        for (ProductDetail product : favoritesProducts) {
            favoritesBrands.add(product.getBrandName());
        }
        return favoritesBrands;
    }

    public Set<String> getFavoritesCategory(List<ProductDetail> favoritesProducts) {
        Set<String> favoritesCategory = new HashSet<>();
        for (ProductDetail product : favoritesProducts) {
            favoritesCategory.add(product.getCategoryName());
        }
        return favoritesCategory;
    }
}
