package code.salecar.controller.checkout;

import code.salecar.dao.AddressDao;
import code.salecar.model.Address;
import code.salecar.model.Cart;
import code.salecar.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet (name = "checkout", value= "/checkout")
public class checkout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("redirectUrl", "checkout");
            response.sendRedirect("login");
            return;
        }


        Cart checkoutCart;
        if ("buynow".equals(type)) {
            checkoutCart = (Cart) session.getAttribute("buyNowCart");
        } else {
            checkoutCart = (Cart) session.getAttribute("cart");
        }

        if (checkoutCart == null || checkoutCart.getItems().isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        request.setAttribute("checkoutCart", checkoutCart);


        AddressDao addrDAO = new AddressDao();
        List<Address> lstAddress = addrDAO.getListAddressById(user.getId());
        request.setAttribute("listAddress", lstAddress);

        request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
