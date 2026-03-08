    package code.salecar.controller.profile;

    import code.salecar.model.Address;
    import code.salecar.model.User;
    import code.salecar.service.address.AddressService;
    import jakarta.servlet.*;
    import jakarta.servlet.http.*;
    import jakarta.servlet.annotation.*;

    import java.io.IOException;

    @WebServlet(name = "AddAddress", value = "/addAddress")
    public class AddAddress extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String street = request.getParameter("street");
            String commune = request.getParameter("commune");
            String province = request.getParameter("province");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int id = user.getId();
            AddressService as = new AddressService();
            Address address = new Address(id,street,commune,province,type,name);
            as.addAddress(address);
            System.out.println(name+type+street+commune+province+id);
            response.sendRedirect("/profileEdit");
        }
    }