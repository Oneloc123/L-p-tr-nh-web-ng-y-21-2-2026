package code.salecar.controller.product;

import code.salecar.model.Cart;
import code.salecar.service.product.VoucherService;
import jakarta.mail.Session;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "voucher", value = "/voucher")
public class voucher extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String type = request.getParameter("type");

        Cart cart = null;
        if("buynow".equals(type)){
            cart = (Cart) session.getAttribute("buyNowCart");
        } else {
            cart = (Cart) session.getAttribute("cart");
        }
        if(cart != null){
            String voucherId = request.getParameter("voucherId");
            VoucherService voucherService = new VoucherService();
            voucherService.getFinalPrice(Integer.parseInt(voucherId),cart);


            response.setContentType("text/plain");
            response.getWriter().write(String.valueOf(cart.getFinalTotal()));

        }   else {
                response.getWriter().print("0");
        }

    }
}