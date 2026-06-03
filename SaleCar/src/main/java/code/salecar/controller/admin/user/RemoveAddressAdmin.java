package code.salecar.controller.admin.user;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RemoveAddressAdmin", value = "/admin/removeAddress")
public class RemoveAddressAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            AddressService as = new AddressService();
            as.removeAddressById(id);
            response.sendRedirect("/updateUser?id="+userId);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}