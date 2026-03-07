package code.salecar.controller.profile;

import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "ProfileEdit", value = "/profileEdit")
public class ProfileEdit extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            User user = (User)session.getAttribute("user");
            request.setAttribute("user",user);
            request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname").toString();
        String email = request.getParameter("email").toString();
        String phoneNumber = request.getParameter("phoneNumber").toString();
        String description = request.getParameter("description").toString();
        String statuss = request.getParameter("status");
        boolean status= false;
        if(statuss.equals("active")){
            status = true;
        }
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPhonenumber(phoneNumber);
        user.setDescription(description);
        user.setStatus(status);
        user.setUpdatedat(new Date(System.currentTimeMillis()));
        UserService us = new UserService();
        us.UpdateProfile(user);

        if(addressId!=0){
            AddressService as = new AddressService();
            as.setMainAddress(addressId,user.getId());
        }
        request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
    }
}