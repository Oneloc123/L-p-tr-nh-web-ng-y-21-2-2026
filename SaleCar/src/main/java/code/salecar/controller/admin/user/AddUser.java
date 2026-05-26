package code.salecar.controller.admin.user;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import code.salecar.util.UploadUserImageUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AddUser", value = "/addUser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 5 * 1024 * 1024)
public class AddUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String description = request.getParameter("description");
        String phone = request.getParameter("phonenumber");
        String role = request.getParameter("role");
        String statusStr = request.getParameter("status");

        String imgURL = null;
        try {
            imgURL = UploadUserImageUtil.uploadImage(request, "avatar", "avatar");
        } catch (IllegalArgumentException e) {
            request.setAttribute("fullnameError", e.getMessage());
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request, response);
            return;
        }

        String name = request.getParameter("name");
        String street = request.getParameter("street");
        String commune = request.getParameter("commune");
        String province = request.getParameter("province");

        String fullnameError = UserInvalidate.checkFullname(fullname);
        if(!fullnameError.equals("true")){
            request.setAttribute("fullnameError",fullnameError);
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String usernameError = UserInvalidate.checkUsername(username);
        if(!usernameError.equals("true")){
            request.setAttribute("usernameError",usernameError);
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String emailError = UserInvalidate.checkEmail(email);
        if(!emailError.equals("true")){
            request.setAttribute("emailError",emailError);
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String passwordError = UserInvalidate.checkPassword(password);
        if(!passwordError.equals("true")){
            request.setAttribute("passwordError",passwordError);
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String phonenumberError = UserInvalidate.checkPhonenumber(phone);
        if(!phonenumberError.equals("true")){
            request.setAttribute("phonenumberError",phonenumberError);
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        UserService us = new UserService();
        User user = us.getUserByUsername(username);
        if(user!=null){
            request.setAttribute("usernameError","tên đăng nhập đã tồn tại");
            request.setAttribute("openAddUserModal", "true");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        AddressService as = new AddressService();
        Address add = new Address();
        add.setName(name);
        add.setStreet(street);
        add.setCommune(commune);
        add.setProvince(province);
        add.setType("main");
        boolean status = true;
        if(statusStr.equals("false")){
            status = false;
        }
        User u = new User();
        u.setUsername(username);
        u.setPassword(password);
        u.setFullname(fullname);
        u.setEmail(email);
        u.setDescription(description);
        u.setPhonenumber(phone);
        u.setRole(role);
        u.setStatus(status);
        u.setImgURL(imgURL);
        u.setCreatedat(new Date(System.currentTimeMillis()));
        u.setUpdatedat(new Date(System.currentTimeMillis()));
        us.register(u);
        u = us.getUserByUsername(username);
        add.setUserId(u.getId());
        as.addAddress(add);

        //alert
        request.getSession().setAttribute("toastMessage", "Thêm User thành công");
        request.getSession().setAttribute("toastType", "success");

        response.sendRedirect("/userAdmin");
    }
}