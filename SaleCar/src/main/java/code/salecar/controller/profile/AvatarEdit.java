package code.salecar.controller.profile;

import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;


@WebServlet(name = "AvatarEdit", value = "/avatarEdit")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 5 * 1024 * 1024)

public class AvatarEdit extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            request.getRequestDispatcher("/pages/avatar-edit.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("avatarError"," vui lòng chọn file ảnh");
            request.getRequestDispatcher("/avatarEdit").forward(request,response);
            return;
        }
        long fileSize = filePart.getSize();
        long maxFileSize = 4 * 1024 * 1024;
        if (fileSize > maxFileSize) {
            request.setAttribute("avatarError", "Kích thước file không được vượt quá 4MB");
            request.getRequestDispatcher("/avatarEdit").forward(request, response);
            return;
        }
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/uploads/avatar");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        String newFileName = System.currentTimeMillis() + "_" + fileName;
        filePart.write(uploadPath + File.separator + newFileName);

        String avatarUrl = "uploads/avatar/" + newFileName;
        UserService us =new UserService();
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        user.setImgURL(avatarUrl);
        us.UpdateProfile(user);
        request.getSession().setAttribute("user", user);
        response.sendRedirect("/profile");
    }
}