package code.salecar.controller.admin.voucher;

import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.entity.VoucherScope;
import code.salecar.service.product.VoucherService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/vouchers/create")
public class voucher_create extends HttpServlet {
    private final VoucherService voucherService = new VoucherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Load reference data for scope dropdowns
        request.setAttribute("brands", voucherService.getAllBrands());
        request.setAttribute("categories", voucherService.getAllCategories());
        request.setAttribute("products", voucherService.getAllProducts());
        request.getRequestDispatcher("/admin/voucher/voucher-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String code = request.getParameter("code");
            String valueTypeStr = request.getParameter("valueType");
            String valueStr = request.getParameter("value");
            String maxDiscountStr = request.getParameter("maxDiscount");
            String minOrderValueStr = request.getParameter("minOrderValue");
            String usageLimitStr = request.getParameter("usageLimit");
            String maxUsagePerUserStr = request.getParameter("maxUsagePerUser");
            String startAtStr = request.getParameter("startAt");
            String endAtStr = request.getParameter("endAt");
            String statusStr = request.getParameter("status");

            // Validation
            if (code == null || code.trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Mã voucher không được để trống");
                redirectBack(request, response);
                return;
            }

            if (voucherService.isCodeExists(code.trim(), null)) {
                NotificationUtil.setError(request.getSession(), "Mã voucher '" + code.trim() + "' đã tồn tại");
                redirectBack(request, response);
                return;
            }

            if (valueTypeStr == null || valueTypeStr.isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Loại giá trị giảm giá không được để trống");
                redirectBack(request, response);
                return;
            }

            DiscountValueType valueType;
            try {
                valueType = DiscountValueType.fromString(valueTypeStr);
            } catch (IllegalArgumentException e) {
                NotificationUtil.setError(request.getSession(), "Loại giá trị giảm giá không hợp lệ");
                redirectBack(request, response);
                return;
            }

            BigDecimal value;
            try {
                value = new BigDecimal(valueStr);
                if (value.compareTo(BigDecimal.ZERO) <= 0) {
                    NotificationUtil.setError(request.getSession(), "Giá trị giảm phải lớn hơn 0");
                    redirectBack(request, response);
                    return;
                }
                if (valueType == DiscountValueType.PERCENT && value.compareTo(BigDecimal.valueOf(100)) > 0) {
                    NotificationUtil.setError(request.getSession(), "Phần trăm giảm không được vượt quá 100");
                    redirectBack(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "Giá trị giảm không hợp lệ");
                redirectBack(request, response);
                return;
            }

            BigDecimal maxDiscount = null;
            if (maxDiscountStr != null && !maxDiscountStr.trim().isEmpty()) {
                try {
                    maxDiscount = new BigDecimal(maxDiscountStr.trim());
                } catch (NumberFormatException ignored) {}
            }

            BigDecimal minOrderValue = null;
            if (minOrderValueStr != null && !minOrderValueStr.trim().isEmpty()) {
                try {
                    minOrderValue = new BigDecimal(minOrderValueStr.trim());
                } catch (NumberFormatException ignored) {}
            }

            int usageLimit = 0;
            if (usageLimitStr != null && !usageLimitStr.trim().isEmpty()) {
                try {
                    usageLimit = Integer.parseInt(usageLimitStr.trim());
                    if (usageLimit < 0) usageLimit = 0;
                } catch (NumberFormatException ignored) {}
            }

            int maxUsagePerUser = 1;
            if (maxUsagePerUserStr != null && !maxUsagePerUserStr.trim().isEmpty()) {
                try {
                    maxUsagePerUser = Integer.parseInt(maxUsagePerUserStr.trim());
                    if (maxUsagePerUser < 1) maxUsagePerUser = 1;
                } catch (NumberFormatException ignored) {}
            }

            LocalDateTime startAt = parseDateTime(startAtStr);
            LocalDateTime endAt = parseDateTime(endAtStr);

            if (startAt != null && endAt != null && endAt.isBefore(startAt)) {
                NotificationUtil.setError(request.getSession(), "Ngày kết thúc phải sau ngày bắt đầu");
                redirectBack(request, response);
                return;
            }

            Status status = Status.ACTIVE;
            if (statusStr != null) {
                status = Status.fromString(statusStr);
            }

            // Build voucher
            Voucher voucher = Voucher.builder()
                    .code(code.trim())
                    .valueType(valueType)
                    .value(value)
                    .maxDiscount(maxDiscount)
                    .minOrderValue(minOrderValue)
                    .usageLimit(usageLimit)
                    .maxUsagePerUser(maxUsagePerUser)
                    .startAt(startAt)
                    .endAt(endAt)
                    .status(status)
                    .build();

            long newId = voucherService.createVoucher(voucher);

            if (newId > 0) {
                // Save scopes
                List<VoucherScope> scopes = parseScopes(request);
                voucherService.saveScopes(newId, scopes);

                NotificationUtil.setSuccess(request.getSession(), "Tạo voucher '" + code.trim() + "' thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể tạo voucher");
                redirectBack(request, response);
            }

        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi tạo voucher: " + e.getMessage());
            redirectBack(request, response);
        }
    }

    private List<VoucherScope> parseScopes(HttpServletRequest request) {
        List<VoucherScope> scopes = new ArrayList<>();
        String[] entityTypes = request.getParameterValues("scopeType");
        String[] entityIds = request.getParameterValues("scopeEntityId");

        if (entityTypes != null) {
            for (int i = 0; i < entityTypes.length; i++) {
                String type = entityTypes[i];
                if (type == null || type.isEmpty() || "none".equals(type)) continue;

                if ("order".equals(type)) {
                    VoucherScope scope = new VoucherScope();
                    scope.setEntityType("order");
                    scope.setEntityId(0);
                    scopes.add(scope);
                } else {
                    if (entityIds != null && i < entityIds.length) {
                        try {
                            long entityId = Long.parseLong(entityIds[i]);
                            if (entityId > 0) {
                                VoucherScope scope = new VoucherScope();
                                scope.setEntityType(type);
                                scope.setEntityId(entityId);
                                scopes.add(scope);
                            }
                        } catch (NumberFormatException ignored) {}
                    }
                }
            }
        }
        return scopes;
    }

    private LocalDateTime parseDateTime(String str) {
        if (str == null || str.trim().isEmpty()) return null;
        try {
            // Try ISO format first (from datetime-local input: "yyyy-MM-dd'T'HH:mm")
            return LocalDateTime.parse(str.trim(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        } catch (DateTimeParseException e) {
            try {
                // Try with space separator
                return LocalDateTime.parse(str.trim().replace("T", " "), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            } catch (DateTimeParseException e2) {
                return null;
            }
        }
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/admin/vouchers/create");
    }
}
