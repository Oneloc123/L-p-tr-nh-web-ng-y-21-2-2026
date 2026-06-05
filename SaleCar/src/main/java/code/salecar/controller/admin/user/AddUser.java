package code.salecar.controller.admin.user;

import code.salecar.config.AppConfig;
import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import code.salecar.util.FileUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddUser", value = "/addUser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 5 * 1024 * 1024)
public class AddUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect("/login");
            return;
        }
        request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect("/login");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String description = request.getParameter("description");
        String phone = request.getParameter("phoneNumber");
        String role = request.getParameter("role");
        String statusStr = request.getParameter("status");

        request.setAttribute("oldUsername", username);
        request.setAttribute("oldFullname", fullname);
        request.setAttribute("oldEmail", email);
        request.setAttribute("oldPassword", password);
        request.setAttribute("oldPhone", phone);
        request.setAttribute("oldDescription", description);
        request.setAttribute("oldRole", role);
        request.setAttribute("oldStatus", statusStr);

        String fullnameError = UserInvalidate.checkFullname(fullname);
        if (!"true".equals(fullnameError)) {
            request.setAttribute("fullnameError", fullnameError);
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }
        String usernameError = UserInvalidate.checkUsername(username);
        if (!"true".equals(usernameError)) {
            request.setAttribute("usernameError", usernameError);
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }
        String emailError = UserInvalidate.checkEmail(email);
        if (!"true".equals(emailError)) {
            request.setAttribute("emailError", emailError);
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }
        String passwordError = UserInvalidate.checkPassword(password);
        if (!"true".equals(passwordError)) {
            request.setAttribute("passwordError", passwordError);
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }
        String phoneError = UserInvalidate.checkPhonenumber(phone);
        if (!"true".equals(phoneError)) {
            request.setAttribute("phonenumberError", phoneError);
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }

        UserService us = new UserService();
        User existingUser = us.getUserByUsername(username);
        if (existingUser != null) {
            request.setAttribute("usernameError", "Tên đăng nhập đã tồn tại");
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }

        String avatarLink = "";
        try {
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    String fileName = Paths.get(submittedFileName).getFileName().toString();
                    String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
                    if (!ext.matches("jpg|jpeg|png|webp")) {
                        request.setAttribute("avatarError", "Chỉ chấp nhận file JPG, PNG, WEBP");
                        request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
                        return;
                    }
                    String newFileName = FileUtil.generateFileName(fileName);
                    String baseDir = AppConfig.get("upload.base-dir");
                    if (baseDir == null || baseDir.isEmpty()) {
                        throw new RuntimeException("upload.base-dir not configured");
                    }
                    java.nio.file.Path uploadPath = Paths.get(baseDir, "users");
                    Files.createDirectories(uploadPath);
                    java.nio.file.Path filePath = uploadPath.resolve(newFileName);
                    filePart.write(filePath.toString());
                    avatarLink = "/uploads/users/" + newFileName;
                }
            }
        } catch (ServletException | IOException e) {
            request.setAttribute("avatarError", "Lỗi upload ảnh: " + e.getMessage());
            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request, response);
            return;
        }
        boolean status = "true".equals(statusStr);

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setFullname(fullname);
        newUser.setEmail(email);
        newUser.setDescription(description);
        newUser.setPhonenumber(phone);
        newUser.setRole(role);
        newUser.setStatus(status);
        newUser.setImgURL(avatarLink);
        newUser.setCreatedat(new Date(System.currentTimeMillis()));
        newUser.setUpdatedat(new Date(System.currentTimeMillis()));

        us.register(newUser);

        response.sendRedirect("/userAdmin");
    }
}