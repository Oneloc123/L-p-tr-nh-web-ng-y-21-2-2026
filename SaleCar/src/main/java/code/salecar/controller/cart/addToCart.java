package code.salecar.controller.cart;

import code.salecar.dao.AddressDao;
import code.salecar.model.Address;
import code.salecar.model.Cart;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.User;
import code.salecar.service.product.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/cart-add")
public class addToCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idStr = request.getParameter("productId");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("home");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
            return;
        }
        String quantitypr = request.getParameter("quantity");

        String action = request.getParameter("action");
        AddressDao AddrDAO = new AddressDao();

        int quantity = 1;
        if (quantitypr != null) {
            try {
                quantity = Integer.parseInt(quantitypr);
                if (quantity < 1) quantity = 1;
            } catch (NumberFormatException e) {
                quantity = 1;
            }
        }

        ProductService ps = new ProductService();
        ProductDetailDTO productDT = ps.getProductByID(id);
        if (productDT == null) {
            response.sendRedirect("list-product");
            return;
        }

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");



        String ajax = request.getParameter("ajax");



            //mua ngay va them vao gio hang


            if (cart == null) {
                cart = new Cart();
            }




            cart.addProduct(productDT, quantity);
            session.setAttribute("cart", cart);



            if(user != null){
                int userId = user.getId();
                List<Address> lstAddress = AddrDAO.getListAddressById(userId);
                session.setAttribute("listAddress", lstAddress);
            }




            // ajax(huy)
            if("true".equals(ajax)){
                response.getWriter().print("success");
                return;
            }

            if ("addCart".equals(action)) {
                // Lấy tên sản phẩm từ database
                String productName = productDT.getProduct().getName();

                // Redirect với tham số thông báo
                String encodedProductName = URLEncoder.encode(productName, "UTF-8");
                //alert
                response.sendRedirect("products?cartSuccess=true&productName=" + encodedProductName);
            } else if ("buyNow".equals(action)) {
                response.sendRedirect("checkout");
            } else {
                String referer = request.getHeader("referer");
                if(referer != null){
                    response.sendRedirect(referer);
                } else
                    response.sendRedirect("home");

            }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

}
