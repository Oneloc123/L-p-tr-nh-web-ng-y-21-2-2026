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
}
