package code.salecar.controller.cart;

import code.salecar.model.Cart;
import code.salecar.model.Product;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "removeItem", value = "/cart-remove")
public class removeItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));



        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if(cart == null){cart = new Cart();}

        cart.delItem(id);

        session.setAttribute("cart",cart);
        response.sendRedirect("cart");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}