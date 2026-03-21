package code.salecar.service.Image;

import code.salecar.dao.ImageDAO;
import code.salecar.model.Image;

public class ImageService {
    ImageDAO imageDAO = new ImageDAO();
    public String getImage(Image.entityType type ,int id) {
        return  imageDAO.getImage(type,id);
    }
}
