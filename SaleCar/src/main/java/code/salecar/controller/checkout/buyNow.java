package code.salecar.controller.checkout;

import code.salecar.dao.ProductDAO;
import code.salecar.model.Cart;
import code.salecar.model.User;

import code.salecar.model.product.entity.Product;
import code.salecar.service.buyNCart.buyNowService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "buyNow", value = "/buy-now")
public class buyNow extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ajax = request.getParameter("ajax");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        if(user == null){
            if ("true".equals(ajax)){
                response.getWriter().print("need_login");
            }
            return;
        }
        int id = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        ProductDAO ps = new ProductDAO();
        Product product = ps.getProductByID(id);

        if(product != null){
            buyNowService buyNowS = new buyNowService();
            Cart buyNowCart = buyNowS.buyNow(product,quantity);

            session.setAttribute("buyNowCart", buyNowCart);

            if("true".equals(ajax)){
                response.getWriter().print("success");
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}