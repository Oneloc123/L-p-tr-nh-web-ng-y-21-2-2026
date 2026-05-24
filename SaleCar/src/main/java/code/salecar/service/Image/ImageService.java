package code.salecar.service.Image;

import code.salecar.dao.ProductImageDAO;
import code.salecar.model.Image;
import code.salecar.model.product.entity.ProductImage;

import java.util.List;

public class ImageService {
    ProductImageDAO imageDAO = new ProductImageDAO();
    public String getImage(Image.entityType type ,long id) {
        return  imageDAO.getImage(type,id);
    }

    public List<String> getImageProduct(long id) {
        return imageDAO.getImageProduct(id);
    }

    public void createProductImage(ProductImage image) {
        imageDAO.insertImage(image);
    }

    /**
     * Xóa ảnh sản phẩm khỏi database
     */
    public void deleteProductImage(long productId, String imageUrl) {
        imageDAO.deleteImage(productId, imageUrl);
    }

    /**
     * Đặt ảnh làm ảnh chính của sản phẩm
     */
    public void setMainImage(long productId, String imageUrl) {
        imageDAO.setMainImage(productId, imageUrl);
    }

    /**
     * Lấy URL ảnh chính của sản phẩm
     */
    public String getMainImage(long productId) {
        return imageDAO.getMainImage(productId);
    }

    /**
     * Kiểm tra ảnh có phải là ảnh chính không
     */
    public boolean isMainImage(long productId, String imageUrl) {
        return imageDAO.isMainImage(productId, imageUrl);
    }
}
