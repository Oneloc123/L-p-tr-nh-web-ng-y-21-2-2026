package code.salecar.service.product;

import code.salecar.dao.ReviewsDAO;
import code.salecar.model.Reviews;
import code.salecar.model.User;
import code.salecar.service.user.UserService;

import java.util.List;

public class ReviewsService {
    private ReviewsDAO reviewsDAO = new ReviewsDAO();

    public List<Reviews> getReviewsByID(int product_id) {
        List<Reviews> reviews = reviewsDAO.getReviewsByID(product_id);
        UserService userService = new UserService();
        for (Reviews review : reviews){
            String userName = userService.getUserNameById(review.getUserId());
            review.setUserName(userName);
        }
        return  reviews;
    }
    public boolean addReviews(Reviews reviews) {
        if (reviews != null){
            return reviewsDAO.addReviews(reviews);
        }else {
            return false;
        }
    }

    public List<Integer> getRates(int id) {
        return reviewsDAO.getRates( id);
    }

    public List<String> getComments(int id) {
        return reviewsDAO.getComments(id);
    }
}
