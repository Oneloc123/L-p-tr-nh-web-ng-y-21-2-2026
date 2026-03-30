package code.salecar.controller.checkout;

import code.salecar.dao.AddressDao;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Address;
import code.salecar.model.Cart;
import code.salecar.model.User;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.entity.Product;
import code.salecar.service.buyNCart.buyNowService;

import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "buyNow", value = "/buy-now")
public class buyNow extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ajax = request.getParameter("ajax");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        AddressDao addrDAO = new AddressDao();

        if(user == null){
            if ("true".equals(ajax)){
                response.getWriter().print("need_login");
            }
            return;
        }
        int id = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        ProductService ps = new ProductService();
        ProductDetail product = ps.getProductByID(id);

        if(product != null){
            buyNowService buyNowS = new buyNowService();
            Cart buyNowCart = buyNowS.buyNow(product,quantity);

            session.setAttribute("buyNowCart", buyNowCart);

            if("true".equals(ajax)){
                response.getWriter().print("success");
            }
        }

        List<Address> lstAddress = addrDAO.getListAddressById(user.getId());
        session.setAttribute("listAddress", lstAddress);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}