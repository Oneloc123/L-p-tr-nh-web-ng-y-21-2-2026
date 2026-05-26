package code.salecar.controller.admin.product.api;

import code.salecar.model.User;
import code.salecar.model.product.entity.ActivityLog;
import code.salecar.model.product.entity.ProductSalesInfo;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.service.file.ActivityLogFileService;
import code.salecar.service.product.InventoryService;
import code.salecar.service.product.ProductVariantsService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/admin/variants/*")
public class UpdateProductInventoryServlet extends HttpServlet {
    ProductVariantsService pvs = new ProductVariantsService();
    ActivityLogFileService ls = new ActivityLogFileService();

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
        ActivityLog log =null;
        switch (type) {
            case "add":
                current += quantity;
                variant.setQuantity(current);
                log = ActivityLog.builder().action("Nhập Hàng").timestamp(new Date()).user(user.getFullname()).details(type+": +"+quantity).build();
                System.out.println(log.getAction());
                System.out.println(log.getTimestamp());
                System.out.println(log.getUser());
                System.out.println(log.getDetails());
                ls.writeLog(variant.getProductId(), log);
                pvs.createImportReceipt(variant,user);
                break;
            case "subtract":
                if (quantity > current) {
                    NotificationUtil.setError(request.getSession(), "Không thể trừ vượt quá tồn kho");
                    response.sendRedirect(request.getContextPath()+ "/admin/products/detail?id="+ variant.getProductId());
                    return;
                }
                current -= quantity;
                variant.setQuantity(current);
                log = ActivityLog.builder().action("Xuất hàng").timestamp(new Date()).user(user.getFullname()).details(type+": -"+quantity).build();
                ls.writeLog(variant.getProductId(), log);
                pvs.createExportReceipt(variant,user);
                break;
        }



        /** Thông báo thành công dựa trên loại hành động */
        if ("add".equals(type)) {
            NotificationUtil.setSuccess(request.getSession(), "Nhập kho thành công!");
        } else if ("subtract".equals(type)) {
            NotificationUtil.setSuccess(request.getSession(), "Xuất kho thành công!");
        }
        response.sendRedirect(request.getContextPath() + "/admin/products/detail?id=" + variant.getProductId());


    }
}