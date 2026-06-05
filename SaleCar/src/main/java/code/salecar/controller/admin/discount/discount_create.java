package code.salecar.controller.admin.discount;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Discount;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.DiscountService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/admin/discounts/create")
public class discount_create extends HttpServlet {
    private final DiscountService discountService = new DiscountService();
    private final BrandService brandService = new BrandService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /** Load danh sách brands, categories cho dropdown entity */
        List<Brand> brands = brandService.getBrands();
        List<Category> categories = categoryService.getCategory();

        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);

        /** Set ngày mặc định cho form */
        LocalDate today = LocalDate.now();
        request.setAttribute("today", today.toString());
        request.setAttribute("thirtyDaysLater", today.plusDays(30).toString());

        request.getRequestDispatcher("/admin/discount/discount-create.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /** Đọc tham số */
        String nameParam = request.getParameter("name");
        String valueTypeParam = request.getParameter("valueType");
        String valueParam = request.getParameter("value");
        String entityTypeParam = request.getParameter("entityType");
        String entityIdParam = request.getParameter("entityId");
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");
        String statusParam = request.getParameter("status");

        /** Validation cơ bản */
        if (nameParam == null || nameParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Tên discount không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        if (valueParam == null || valueParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Giá trị discount không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        BigDecimal value;
        try {
            value = new BigDecimal(valueParam.trim());
            if (value.compareTo(BigDecimal.ZERO) <= 0) {
                NotificationUtil.setError(request.getSession(), "Giá trị discount phải lớn hơn 0");
                response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
                return;
            }
            if ("PERCENT".equalsIgnoreCase(valueTypeParam) && value.compareTo(BigDecimal.valueOf(100)) > 0) {
                NotificationUtil.setError(request.getSession(), "Phần trăm giảm không được vượt quá 100");
                response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
                return;
            }
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "Giá trị discount không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        DiscountValueType valueType;
        try {
            valueType = DiscountValueType.fromString(valueTypeParam);
        } catch (IllegalArgumentException e) {
            NotificationUtil.setError(request.getSession(), "Loại discount không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        DiscountEntityType entityType;
        try {
            entityType = DiscountEntityType.fromString(entityTypeParam);
        } catch (IllegalArgumentException e) {
            NotificationUtil.setError(request.getSession(), "Loại đối tượng áp dụng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        if (entityIdParam == null || entityIdParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Vui lòng chọn đối tượng áp dụng discount");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        long entityId;
        try {
            entityId = Long.parseLong(entityIdParam.trim());
            if (entityId <= 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID đối tượng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        /** Phân tích ngày tháng */
        LocalDateTime startAt = LocalDateTime.now();
        if (startDateParam != null && !startDateParam.trim().isEmpty()) {
            try {
                LocalDate startDate = LocalDate.parse(startDateParam);
                startAt = startDate.atStartOfDay();
            } catch (DateTimeParseException e) {
                NotificationUtil.setError(request.getSession(), "Ngày bắt đầu không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
                return;
            }
        }

        LocalDateTime endAt = LocalDateTime.now().plusDays(30);
        if (endDateParam != null && !endDateParam.trim().isEmpty()) {
            try {
                LocalDate endDate = LocalDate.parse(endDateParam);
                endAt = endDate.atTime(LocalTime.MAX);
            } catch (DateTimeParseException e) {
                NotificationUtil.setError(request.getSession(), "Ngày kết thúc không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
                return;
            }
        }

        if (endAt.isBefore(startAt)) {
            NotificationUtil.setError(request.getSession(), "Ngày kết thúc phải sau ngày bắt đầu");
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            return;
        }

        /** Xác định status */
        Status status = Status.ACTIVE;
        if (statusParam != null && "inactive".equalsIgnoreCase(statusParam)) {
            status = Status.INACTIVE;
        }

        /** Tạo Discount object */
        Discount discount = Discount.builder()
                .name(nameParam.trim())
                .valueType(valueType)
                .value(value)
                .entityType(entityType)
                .entityId(entityId)
                .status(status)
                .startAt(startAt)
                .endAt(endAt)
                .build();

        /** Lưu vào DB */
        try {
            int discountId = discountService.createProductDiscount(discount);
            if (discountId > 0) {
                NotificationUtil.setSuccess(request.getSession(), "Tạo discount thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/discounts");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể tạo discount");
                response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
            }
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi tạo discount: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/discounts/create");
        }
    }
}
