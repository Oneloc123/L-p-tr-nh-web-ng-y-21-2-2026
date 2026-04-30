package code.salecar.service.product;

import code.salecar.dao.CategoryDAO;
import code.salecar.model.Category;
import code.salecar.model.Image;
import code.salecar.service.Image.ImageService;

import java.util.List;

public class CategoryService {
    CategoryDAO categoryDAO = new CategoryDAO();
    ImageService imageService = new ImageService();
    public  List<Category> getCategory() {
        List<Category> categories = categoryDAO.getCategory();
        for(Category category:categories){
            category.setImage(imageService.getImage(Image.entityType.category,category.getId()));
        }
        return categories;
    }


    public  List<Category> getCategories() {
        List<Category> categories = categoryDAO.getCategories();
        for(Category category:categories){
            category.setImage(imageService.getImage(Image.entityType.category,category.getId()));
        }
        return categories;
    }

    public int getTotalCategory() {
        return categoryDAO.getTotalCategory();
    }

    public List<String> getCategoryName() {
        return categoryDAO.getCategoryName();
    }
    public String  getCategoryName(int id) {
        return categoryDAO.getCategoryName(id);
    }
    public Category  getCategoryById(int id) {
        return categoryDAO.getCategoryById(id);
    }

}
