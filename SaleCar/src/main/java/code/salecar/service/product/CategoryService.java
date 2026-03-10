package code.salecar.service.product;

import code.salecar.dao.CategoryDAO;

import java.util.List;

public class CategoryService {
    CategoryDAO categoryDAO = new CategoryDAO();

    public int getTotalCategory() {
        return categoryDAO.getTotalCategory();
    }

    public List<String> getCategoryName() {
        return categoryDAO.getCategoryName();
    }
    public String  getCategoryName(int id) {
        return categoryDAO.getCategoryName(id);
    }
}
