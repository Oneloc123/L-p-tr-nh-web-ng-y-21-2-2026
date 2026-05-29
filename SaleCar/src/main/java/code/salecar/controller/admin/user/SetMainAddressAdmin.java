package code.salecar.controller.admin.user;

import code.salecar.model.Addresses;
import code.salecar.model.User;
import code.salecar.service.address.AddressesService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SetMainAddressAdmin", value = "/admin/setMainAddress")
public class SetMainAddressAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }

        int addressId = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("uId"));
        AddressesService as = new AddressesService();
        as.setMainAddress(addressId, userId);

        response.sendRedirect("/updateUser?id="+userId);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}