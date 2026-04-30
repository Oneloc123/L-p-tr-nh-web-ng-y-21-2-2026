package code.salecar.controller.admin.brand;

import code.salecar.model.brand.Brand;
import code.salecar.service.product.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Locale;

@WebServlet("/admin/brands/edit")
@MultipartConfig

public class brand_edit extends HttpServlet {
    BrandService brandService = new BrandService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int branId ;
        String idParam = request.getParameter("id");
        if (idParam != null  && !idParam.isEmpty()) {
            branId = Integer.parseInt(idParam.trim());
            Brand brand = brandService.getBrandByID(branId);
            request.setAttribute("brand", brand);
            request.getRequestDispatcher("/admin/brand/brand-edit.jsp").forward(request, response);

        }else {
            response.sendRedirect("/admin/brands");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Brand brand = new Brand();

        String  idParam = request.getParameter("id");
        if (idParam != null  && !idParam.isEmpty()) {
           int id = Integer.parseInt(idParam.trim());
            brand.setId(id);
        }
        String  nameParam = request.getParameter("name");
        if (nameParam != null  && !nameParam.isEmpty()) {
            brand.setName(nameParam);
        }
        String statusParam  = request.getParameter("status");
        if (statusParam != null  && !statusParam.isEmpty()) {
            brand.setStatus(statusParam.trim().toLowerCase());
        }
        String linkBrandParam = request.getParameter("linkBrand");
        if (linkBrandParam != null  && !linkBrandParam.isEmpty()) {
            brand.setLinkBrand(linkBrandParam.trim());
        }
        String  descriptionParam = request.getParameter("description");
        if (descriptionParam != null  && !descriptionParam.isEmpty()) {
            brand.setDescription(descriptionParam);
        }
        String imageParam = request.getParameter("image");

//        System.out.println(idParam);
        boolean updated = brandService.updateBrand(brand);
//        System.out.println(updated);
        response.sendRedirect("/admin/brands");

    }
}