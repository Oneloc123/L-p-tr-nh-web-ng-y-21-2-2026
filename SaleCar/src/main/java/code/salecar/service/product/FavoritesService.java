package code.salecar.service.product;

import code.salecar.dao.FavoriesDAO;
import code.salecar.model.product.dto.ProductDetailDTO;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class FavoritesService {
    private final FavoriesDAO favoriesDAO = new FavoriesDAO();
    private final ProductService productService = new ProductService();

    /**
     * Thêm sản phẩm vào wishlist. Trả về true nếu thành công, false nếu đã tồn tại.
     */
    public boolean addProduct(int productId, int userId) {
        if (favoriesDAO.hasDuplicate(productId, userId)) {
            return false;
        }
        return favoriesDAO.addProduct(productId, userId);
    }

    /**
     * Lấy danh sách sản phẩm yêu thích của user.
     * Sản phẩm đã bị xóa hoặc không tồn tại sẽ được bỏ qua (không add vào list).
     */
    public List<ProductDetailDTO> getFavorites(int userId) {
        List<Integer> favoritesList = favoriesDAO.getFavorites(userId);
        List<ProductDetailDTO> products = new ArrayList<>();
        for (Integer favoriteId : favoritesList) {
            ProductDetailDTO product = productService.getProductByID(favoriteId);
            if (product != null) {
                products.add(product);
            }
        }
        return products;
    }

    /**
     * Xóa sản phẩm khỏi wishlist. Filter theo cả productId và userId.
     */
    public boolean removeFavoritesProduct(int productId, int userId) {
        return favoriesDAO.removeFavoritesProduct(productId, userId);
    }

    /**
     * Kiểm tra sản phẩm đã có trong wishlist của user chưa.
     */
    public boolean isInWishlist(int productId, int userId) {
        return favoriesDAO.isInWishlist(productId, userId);
    }

    public Set<String> getFavoritesBrand(List<ProductDetailDTO> favoritesProducts) {
        Set<String> favoritesBrands = new HashSet<>();
        for (ProductDetailDTO product : favoritesProducts) {
            if (product.getBrand() != null) {
                favoritesBrands.add(product.getBrand().getName());
            }
        }
        return favoritesBrands;
    }

    public Set<String> getFavoritesCategory(List<ProductDetailDTO> favoritesProducts) {
        Set<String> favoritesCategory = new HashSet<>();
        for (ProductDetailDTO product : favoritesProducts) {
            if (product.getCategory() != null) {
                favoritesCategory.add(product.getCategory().getName());
            }
        }
        return favoritesCategory;
    }
}
