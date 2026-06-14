package code.salecar.controller.admin.user;

import code.salecar.model.Addresses;
import code.salecar.model.User;
import code.salecar.model.UserFilter;
import code.salecar.service.address.AddressesService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserAdmin", value = "/userAdmin")
public class UserAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.getRole().equals("admin")) {
            response.sendRedirect("/login");
            return;
        }

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        UserFilter filter = new UserFilter();
        filter.setSortBy("id");
        filter.setSortDir("desc");
        filter.setPage(page);
        filter.setPageSize(20);

        UserService us = new UserService();

        List<User> listUser = us.searchUsers(filter);

        int totalUsers = us.countUsers(filter);
        int totalPages = (int) Math.ceil((double) totalUsers / filter.getPageSize());
        if (totalPages < 1) {
            totalPages = 1;
        }

        AddressesService as = new AddressesService();
        List<Addresses> listAddress = as.getListAddress();

        request.setAttribute("listAddress", listAddress);
        request.setAttribute("listUser", listUser);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/admin/user-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}