package code.salecar.controller.admin.category;

import code.salecar.service.product.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin/categories/bulk-action")
public class category_bulk_action extends HttpServlet {
    CategoryService categoryService = new CategoryService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy action
        String action = request.getParameter("action");
        if (action.isEmpty() || action == null) {
            response.sendRedirect("admin/categories");
        }

        //Lấy danh sách ids
        String[] idsParam = request.getParameterValues("ids");
        List<Integer> ids = idsParam == null ? new ArrayList<>()
                : Arrays.stream(idsParam)
                .filter(s -> s != null && !s.isBlank())
                .map(Integer::parseInt)
                .toList();
        if (ids == null || ids.size() == 0) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            if (action.equals("active")) {
                for (int id : ids) {
                    categoryService.toggleStatus(id,1);
                }
            }else if (action.equals("inactive")) {
                for (int id : ids) {
                    categoryService.toggleStatus(id,0);
                }
            }

        }catch (Exception ex){
            ex.printStackTrace();
        }


        String redirectUrl =  request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
