package code.salecar.controller.profile;

import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RemoveAddress", value = "/removeAddress")
public class RemoveAddress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            int id = Integer.parseInt(request.getParameter("id"));
            AddressService as = new AddressService();
            as.removeAddressById(id);
            response.sendRedirect("/profileEdit");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}