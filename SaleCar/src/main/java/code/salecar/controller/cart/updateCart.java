package code.salecar.controller.cart;

import code.salecar.model.Cart;
import code.salecar.model.CartItem;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "updateCart", value = "/update-cart")
public class updateCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String valueStr = request.getParameter("value");

        if (idStr == null || valueStr == null || idStr.isEmpty() || valueStr.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        int id, value;
        try {
            id = Integer.parseInt(idStr);
            value = Integer.parseInt(valueStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("cart");
            return;
        }

        ProductService ps = new ProductService();
        ProductDetailDTO product = ps.getProductByID(id);
        if(product == null){
            response.sendRedirect("list-product");
            return;
        }

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if(cart == null){cart = new Cart();}


        CartItem item = cart.getItemById(id);
        if (item == null) {
            response.sendRedirect("cart");
            return;
        }
        if(value + item.getQuantity() <= 0){
            cart.delItem(id);
            response.sendRedirect("cart");
            return;
        }
        cart.updateItem(product,value + item.getQuantity());


        session.setAttribute("cart", cart);
        response.sendRedirect("cart");


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}