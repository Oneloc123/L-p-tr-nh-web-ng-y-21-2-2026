package code.salecar.service.Image;

import code.salecar.dao.ImageDAO;
import code.salecar.model.Image;

import java.util.List;

public class ImageService {
    ImageDAO imageDAO = new ImageDAO();
    public String getImage(Image.entityType type ,int id) {
        return  imageDAO.getImage(type,id);
    }

    public List<String> getImageProduct(int id) {
        return imageDAO.getImageProduct(id);
    }
}
