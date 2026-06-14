package code.salecar.controller.product;

import code.salecar.model.product.entity.Review;
import code.salecar.model.User;
import code.salecar.service.product.ReviewsService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "reviews", value = "/reviews")
public class reviews extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long productId = Long.parseLong(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");


        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        Review reviews = new Review();
        reviews.setProductId(productId);
        reviews.setRating(rating);
        reviews.setComment(comment);

        reviews.setUserId(user.getId());

        ReviewsService reviewsService = new ReviewsService();
        reviewsService.addReviews(reviews);

        // Set toast thông báo thành công
        request.getSession().setAttribute("toastMessage", "Cảm ơn bạn! Đánh giá sản phẩm đã được gửi thành công.");
        request.getSession().setAttribute("toastType", "success");

        // Nếu có orderId, redirect về order-detail, ngược lại về product-detail
        String orderId = request.getParameter("orderId");
        if (orderId != null && !orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order-detail?id=" + orderId);
        } else {
            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId);
        }

    }
}