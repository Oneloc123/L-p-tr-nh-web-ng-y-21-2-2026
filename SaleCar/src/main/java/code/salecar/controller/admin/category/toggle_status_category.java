package code.salecar.controller.admin.category;

import code.salecar.service.product.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories/toggle-status")
public class toggle_status_category extends HttpServlet {
    CategoryService categoryService = new CategoryService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String  idParam = request.getParameter("id");
        if (idParam != null  && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam.trim());
            categoryService.toggleStatus(id);
        }


        String redirectUrl =  request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }

    }
}
