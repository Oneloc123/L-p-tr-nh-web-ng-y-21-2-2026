package code.salecar.service.product;

import code.salecar.dao.FavoriesDAO;
import code.salecar.model.product.dto.ProductDetailDTO;

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

    public List<ProductDetailDTO> getFavorites(int userId) {
        List<Integer> favoritesList = favoriesDAO.getFavorites(userId);
        List<ProductDetailDTO> products = new ArrayList<>();
        for (Integer favoriteId : favoritesList) {
            products.add(productService.getProductByID(favoriteId));
        }
        return products;
    }

    public boolean removeFavoritesProduct(int prid) {
        return favoriesDAO.removeFavoritesProduct(prid);
    }




    public Set<String> getFavoritesBrand(List<ProductDetailDTO> favoritesProducts) {
        Set<String> favoritesBrands = new HashSet<>();
        for (ProductDetailDTO product : favoritesProducts) {
            favoritesBrands.add(product.getBrand().getName());
        }
        return favoritesBrands;
    }

    public Set<String> getFavoritesCategory(List<ProductDetailDTO> favoritesProducts) {
        Set<String> favoritesCategory = new HashSet<>();
        for (ProductDetailDTO product : favoritesProducts) {
            favoritesCategory.add(product.getCategory().getName());
        }
        return favoritesCategory;
    }
}
