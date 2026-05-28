package code.salecar.service.product;

import code.salecar.dao.CategoryDAO;
import code.salecar.model.category.Category;
import code.salecar.model.Image;
import code.salecar.model.category.CategoryFilter;
import code.salecar.model.enumeration.Status;
import code.salecar.service.Image.ImageService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public String  getCategoryName(long id) {
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
            /** Chuyển đổi trạng thái */
            Status newStatus = category.getIntStatus() == 1 ? Status.INACTIVE : Status.ACTIVE;
            category.setStatus(newStatus);
            return categoryDAO.updateCategory(category);
        }
        return false;
    }
    public boolean toggleStatus(int id, Status status) {
        Category category = categoryDAO.getCategoryById(id);
        if (category != null) {
            /** Chuyển đổi trạng thái */
            category.setStatus(status);
            return categoryDAO.updateCategory(category);
        }
        return false;
    }

    public Map<String, String> validateCategory(Category category) {
        Map<String, String> errors = new HashMap<>();

        /** Kiểm tra tên */
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            errors.put("name", "Tên danh mục không được để trống");
        } else if (category.getName().length() > 100) {
            errors.put("name", "Tên danh mục không được vượt quá 100 ký tự");
        }

        /** Kiểm tra icon */
        if (category.getIcon() == null || category.getIcon().trim().isEmpty()) {
            errors.put("icon", "Icon không được để trống");
        } else if (category.getIcon().length() > 50) {
            errors.put("icon", "Icon không được vượt quá 50 ký tự");
        }

        /** Kiểm tra mô tả */
        if (category.getDescription() != null && category.getDescription().length() > 500) {
            errors.put("description", "Mô tả không được vượt quá 500 ký tự");
        }

        /** Kiểm tra tên bị trùng */
        if (category.getName() != null && !category.getName().trim().isEmpty()) {
            List<String> existingNames = categoryDAO.getCategoryName();
            for (String name : existingNames) {
                if (name.equalsIgnoreCase(category.getName().trim())) {
                    errors.put("name", "Category name already exists");
                    break;
                }
            }
        }

        return errors;
    }

    public boolean createCategory(Category category) throws Exception {
        Map<String, String> errors = validateCategory(category);
        if (!errors.isEmpty()) {
            throw new IllegalArgumentException("Validation failed: " + errors.toString());
        }

        return categoryDAO.createCategory(category);
    }
}
