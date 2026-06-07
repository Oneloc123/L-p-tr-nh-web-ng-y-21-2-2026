package code.salecar.controller.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Cart;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import code.salecar.model.User;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ReorderServlet", value = "/reorder")
public class ReorderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy orderId từ request
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);

            // 3. Lấy thông tin đơn hàng và kiểm tra quyền sở hữu
            OrderDAO ordDAO = new OrderDAO();
            Order order = ordDAO.getOrderById(orderId);

            if (order == null || order.getUserId() != user.getId()) {
                session.setAttribute("toastMessage", "Không tìm thấy đơn hàng!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/order");
                return;
            }

            // 4. Lấy danh sách items từ đơn hàng
            List<OrderItem> items = ordDAO.getOrderItemsByOrderId(orderId);
            if (items == null || items.isEmpty()) {
                session.setAttribute("toastMessage", "Đơn hàng không có sản phẩm nào!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/order");
                return;
            }

            // 5. Lấy/Create giỏ hàng từ session
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            // 6. Thêm từng sản phẩm vào giỏ hàng
            ProductService productService = new ProductService();
            int addedCount = 0;

            for (OrderItem item : items) {
                int productId = item.getProductId();
                int variantId = item.getVariantId();
                int quantity = item.getQuantity();

                ProductDetailDTO productDetail = productService.getProductByID(productId);
                if (productDetail == null) continue;

                if (variantId > 0) {
                    // Thêm với variant cụ thể
                    code.salecar.model.product.entity.ProductVariants selectedVariant = null;
                    if (productDetail.getVariants() != null) {
                        for (code.salecar.model.product.entity.ProductVariants v : productDetail.getVariants()) {
                            if (v.getId() == variantId) {
                                selectedVariant = v;
                                break;
                            }
                        }
                    }
                    if (selectedVariant != null) {
                        double price = selectedVariant.getFinalPrice() != null
                                ? selectedVariant.getFinalPrice().doubleValue()
                                : selectedVariant.getPrice().doubleValue();
                        double originalPrice = selectedVariant.getPrice().doubleValue();
                        cart.addProduct(productDetail, (int) selectedVariant.getId(),
                                selectedVariant.getVariantName(), selectedVariant.getSku(),
                                originalPrice, price, quantity);
                    } else {
                        cart.addProduct(productDetail, quantity);
                    }
                } else {
                    cart.addProduct(productDetail, quantity);
                }
                addedCount++;
            }

            // 7. Lưu giỏ hàng vào session
            session.setAttribute("cart", cart);
            session.setAttribute("toastMessage",
                    "Đã thêm " + addedCount + " sản phẩm từ đơn hàng #" + orderId + " vào giỏ hàng!");
            session.setAttribute("toastType", "success");

        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Mã đơn hàng không hợp lệ!");
            session.setAttribute("toastType", "error");
        }

        // 8. Chuyển hướng đến giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
