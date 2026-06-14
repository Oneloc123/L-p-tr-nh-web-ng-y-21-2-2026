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


@WebServlet(name = "FilterUser", value = "/filterUser")
public class FilterUser extends HttpServlet {

    private static final int DEFAULT_PAGE_SIZE = 20;

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

        UserFilter filter = buildFilterFromRequest(request);

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
        request.setAttribute("currentPage", filter.getPage());
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);

        // Echo filter values back so the form can repopulate.
        request.setAttribute("keyword", filter.getKeyword());
        request.setAttribute("role", filter.getRole());
        request.setAttribute("status", request.getParameter("status"));
        request.setAttribute("dateFrom", filter.getDateFrom());
        request.setAttribute("dateTo", filter.getDateTo());
        request.setAttribute("sortBy", filter.getSortBy());
        request.setAttribute("sortDir", filter.getSortDir());

        request.getRequestDispatcher("/admin/user-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Keep behaviour consistent: treat POST the same as GET.
        doGet(request, response);
    }

    private UserFilter buildFilterFromRequest(HttpServletRequest request) {
        UserFilter filter = new UserFilter();

        filter.setKeyword(trimToNull(request.getParameter("keyword")));
        filter.setRole(trimToNull(request.getParameter("role")));

        String status = request.getParameter("status");
        if (status != null && !status.trim().isEmpty()) {
            filter.setStatus("true".equalsIgnoreCase(status.trim()));
        } else {
            filter.setStatus(null);
        }

        filter.setDateFrom(trimToNull(request.getParameter("dateFrom")));
        filter.setDateTo(trimToNull(request.getParameter("dateTo")));

        String sortBy = request.getParameter("sortBy");
        filter.setSortBy("fullname".equalsIgnoreCase(sortBy) ? "fullname" : "id");
        String sortDir = request.getParameter("sortDir");
        filter.setSortDir("asc".equalsIgnoreCase(sortDir) ? "asc" : "desc");

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
        filter.setPage(page);
        filter.setPageSize(DEFAULT_PAGE_SIZE);
        return filter;
    }

    private String trimToNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }
}
