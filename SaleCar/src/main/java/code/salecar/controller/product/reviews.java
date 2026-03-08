package code.salecar.controller.product;

import code.salecar.model.Reviews;
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
        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        User user = (User) request.getSession().getAttribute("user");

        Reviews reviews = new Reviews();
        reviews.setProductId(productId);
        reviews.setRating(rating);
        reviews.setComment(comment);
        reviews.setUserId(user.getId());

        ReviewsService reviewsService = new ReviewsService();
        reviewsService.addReviews(reviews);
        response.sendRedirect("/product-detail?id=" + productId);

    }
}