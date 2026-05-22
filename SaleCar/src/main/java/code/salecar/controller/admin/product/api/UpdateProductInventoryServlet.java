package code.salecar.controller.admin.product.api;

import code.salecar.model.User;
import code.salecar.model.product.entity.ProductSalesInfo;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.service.product.InventoryService;
import code.salecar.service.product.ProductVariantsService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/admin/variants/*")
public class UpdateProductInventoryServlet extends HttpServlet {
    ProductVariantsService pvs = new ProductVariantsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String[] parts = pathInfo.split("/");

        long variantId = Long.parseLong(parts[1]);
        String action = parts[2];

        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String type = request.getParameter("type");

        ProductVariants variant = pvs.getVariantByVariantId(variantId);
        int current = variant.getQuantity();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        switch (type) {
            case "add":
                current += quantity;
                variant.setQuantity(current);
                pvs.createImportReceipt(variant,user);
                break;
            case "subtract":
                if (quantity > current) {request.getSession().setAttribute("error","Không thể trừ vượt quá tồn kho");
                    response.sendRedirect(request.getContextPath()+ "/admin/products/detail?id="+ variant.getProductId());
                    return;
                }
                current -= quantity;
                variant.setQuantity(current);
                pvs.createExportReceipt(variant,user);
                break;
        }



        response.sendRedirect(request.getContextPath() + "/admin/products/detail?id=" + variant.getProductId());


    }
}