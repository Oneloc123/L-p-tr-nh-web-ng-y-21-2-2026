package code.salecar.controller.profile;

import code.salecar.dao.OrderDAO;
import code.salecar.model.*;
import code.salecar.model.product.dto.ProductDetail;
import code.salecar.service.address.AddressService;
import code.salecar.service.order.OrderService;
import code.salecar.service.product.FavoritesService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashBoard", value = "/dashboard")
public class DashBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            // User
            User user = (User)session.getAttribute( "user");
            AddressService as = new AddressService();
            request.setAttribute("user",user);
            // Order
            OrderDAO os = new OrderDAO();
            List<Order> listOrder = os.getOrdersByUserId(user.getId());
            int totalOrders = 0;
            double totalSpending = 0;
            for (Order o : listOrder){
                totalOrders++;
                totalSpending+= o.getTotalAmount();
            }
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSpending",totalSpending);
            request.setAttribute("listOrder",listOrder);
            // WishList
            FavoritesService fs = new FavoritesService();
            List<ProductDetail> listWishList = fs.getFavorites(user.getId());
            int countWishList = 0;
            for(ProductDetail p :listWishList){
                countWishList++;
            }
            request.setAttribute("totalFavorites",countWishList);
            // Cart
            Cart cart = (Cart)session.getAttribute("cart");
            if(cart == null){cart = new Cart();}
            session.setAttribute("cart", cart);
            int countCartItem = cart.getTotalQuantity();
            request.setAttribute("cartItemCount",countCartItem);

            request.getRequestDispatcher("/pages/dashBoard.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}