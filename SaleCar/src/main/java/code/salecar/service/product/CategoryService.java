package code.salecar.service.product;

import code.salecar.dao.CategoryDAO;
import code.salecar.model.category.Category;
import code.salecar.model.Image;
import code.salecar.model.category.CategoryFilter;
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
    public  List<Category> getCategories(CategoryFilter categoryFilter) {
        List<Category> categories = categoryDAO.getCategories(categoryFilter);
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

    public boolean updateCategory(Category category) {
        return categoryDAO.updateCategory(category);
    }

    public boolean toggleStatus(int id) {
        Category category = categoryDAO.getCategoryById(id);
        if (category != null) {
            // toggle
            int newStatus = category.getIntStatus() == 1 ? 0 : 1;
            category.setStatus(newStatus);
            return categoryDAO.updateCategory(category);
        }
        return false;
    }
    public boolean toggleStatus(int id, int status) {
        Category category = categoryDAO.getCategoryById(id);
        if (category != null) {
            // toggle
            category.setStatus(status);
            return categoryDAO.updateCategory(category);
        }
        return false;
    }
}
