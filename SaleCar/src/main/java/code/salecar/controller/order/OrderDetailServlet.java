package code.salecar.controller.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import code.salecar.model.User;
import code.salecar.service.product.ReviewsService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "order-detail", value = "/order-detail")
public class OrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);
            OrderDAO orderDAO = new OrderDAO();

            Order order = orderDAO.getOrderById(orderId);

            if (order != null) {


                List<OrderItem> items = orderDAO.getOrderItemsByOrderId(orderId);
                order.setItems(items);

                // Kiểm tra sản phẩm nào đã được user đánh giá
                User user = (User) request.getSession().getAttribute("user");
                if (user != null) {
                    ReviewsService reviewsService = new ReviewsService();
                    Set<Integer> reviewedProductIds = new HashSet<>();
                    for (OrderItem item : items) {
                        if (reviewsService.hasUserReviewedProduct(user.getId(), item.getProductId())) {
                            reviewedProductIds.add(item.getProductId());
                        }
                    }
                    request.setAttribute("reviewedProductIds", reviewedProductIds);
                }

                request.setAttribute("order", order);
                request.getRequestDispatcher("/pages/order-detail.jsp").forward(request, response);
            } else {

                response.sendRedirect(request.getContextPath() + "/order");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/order");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}