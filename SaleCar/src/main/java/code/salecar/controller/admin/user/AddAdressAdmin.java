package code.salecar.controller.admin.user;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AddAdressAdmin", value = "/addAdressAdmin")
public class AddAdressAdmin extends HttpServlet {
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
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String street = request.getParameter("street");
        String commune = request.getParameter("commune");
        String province = request.getParameter("province");
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        AddressService as = new AddressService();
        Address address = new Address(id,street,commune,province,type,name);
        as.addAddress(address);
        response.sendRedirect("/updateUser?id="+id);
    }
}