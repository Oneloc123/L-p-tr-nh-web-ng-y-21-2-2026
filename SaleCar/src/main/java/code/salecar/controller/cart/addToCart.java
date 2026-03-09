package code.salecar.controller.cart;

import code.salecar.dao.ProductDAO;
import code.salecar.model.Cart;
import code.salecar.model.Product;
import code.salecar.service.product.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart-add")
public class addToCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductService ps = new ProductService();
        Product product = ps.getProductByID(id);
        if(product == null){
            response.sendRedirect("list-product");
        }

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if(cart == null){ cart = new Cart();}

        cart.addProduct(product, quantity);

        session.setAttribute("cart", cart);

        response.sendRedirect("cart");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    }
