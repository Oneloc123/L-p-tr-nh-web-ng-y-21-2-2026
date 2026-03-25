package code.salecar.controller.admin.user;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
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
        String imgURL = uploads(request);

        String name = request.getParameter("name");
        String street = request.getParameter("street");
        String commune = request.getParameter("commune");
        String province = request.getParameter("province");

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
        UserService us  = new UserService();
        us.register(u);
        u = us.getUserByUsername(username);
        add.setUserId(u.getId());
        as.addAddress(add);
        response.sendRedirect("/userAdmin");
    }
    private String uploads(HttpServletRequest request) throws ServletException, IOException {
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        String fileName = filePart.getSubmittedFileName();
        String lowerName = fileName.toLowerCase();
        if (!(lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") || lowerName.endsWith(".png"))) {
            return null;
        }
        String uploadPath = getServletContext().getRealPath("/uploads/avatar");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        String newFileName = System.currentTimeMillis() + "_" + fileName;
        filePart.write(uploadPath + File.separator + newFileName);
        String avatarUrl = "uploads/avatar/" + newFileName;
        return avatarUrl;
    }
}