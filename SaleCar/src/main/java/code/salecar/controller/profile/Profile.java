package code.salecar.controller.profile;

import code.salecar.model.Address;
import code.salecar.model.Addresses;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import code.salecar.service.address.AddressesService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Profile", value = "/profile")
public class Profile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            User user = (User)session.getAttribute("user");
            AddressesService as = new AddressesService();
            List<Addresses> listAddress = as.getListAddressById(user.getId());
            request.setAttribute("listAddress",listAddress);
            request.setAttribute("user",user);
            request.getRequestDispatcher("/pages/profile.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}