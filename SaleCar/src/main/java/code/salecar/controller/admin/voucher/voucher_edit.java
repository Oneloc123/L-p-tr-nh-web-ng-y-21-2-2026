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

@WebServlet("/admin/vouchers/edit")
public class voucher_edit extends HttpServlet {
    private final VoucherService voucherService = new VoucherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Thiếu ID voucher");
            response.sendRedirect(request.getContextPath() + "/admin/vouchers");
            return;
        }

        try {
            long id = Long.parseLong(idParam.trim());
            Voucher voucher = voucherService.getVoucher(id);
            if (voucher == null) {
                NotificationUtil.setError(request.getSession(), "Không tìm thấy voucher");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers");
                return;
            }

            List<VoucherScope> scopes = voucherService.getScopes(id);

            request.setAttribute("voucher", voucher);
            request.setAttribute("scopes", scopes);
            request.setAttribute("brands", voucherService.getAllBrands());
            request.setAttribute("categories", voucherService.getAllCategories());
            request.setAttribute("products", voucherService.getAllProducts());
            request.getRequestDispatcher("/admin/voucher/voucher-edit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID voucher không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/vouchers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Thiếu ID voucher");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers");
                return;
            }

            long id = Long.parseLong(idParam.trim());
            Voucher existing = voucherService.getVoucher(id);
            if (existing == null) {
                NotificationUtil.setError(request.getSession(), "Không tìm thấy voucher");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers");
                return;
            }

            String code = request.getParameter("code");
            if (code == null || code.trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Mã voucher không được để trống");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                return;
            }

            if (!code.trim().equalsIgnoreCase(existing.getCode()) && voucherService.isCodeExists(code.trim(), id)) {
                NotificationUtil.setError(request.getSession(), "Mã voucher '" + code.trim() + "' đã tồn tại");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                return;
            }

            String valueTypeStr = request.getParameter("valueType");
            DiscountValueType valueType;
            try {
                valueType = DiscountValueType.fromString(valueTypeStr);
            } catch (IllegalArgumentException e) {
                NotificationUtil.setError(request.getSession(), "Loại giá trị giảm giá không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                return;
            }

            BigDecimal value;
            try {
                value = new BigDecimal(request.getParameter("value"));
                if (value.compareTo(BigDecimal.ZERO) <= 0) {
                    NotificationUtil.setError(request.getSession(), "Giá trị giảm phải lớn hơn 0");
                    response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                    return;
                }
                if (valueType == DiscountValueType.PERCENT && value.compareTo(BigDecimal.valueOf(100)) > 0) {
                    NotificationUtil.setError(request.getSession(), "Phần trăm giảm không được vượt quá 100");
                    response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                    return;
                }
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "Giá trị giảm không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                return;
            }

            BigDecimal maxDiscount = parseBigDecimal(request.getParameter("maxDiscount"));
            BigDecimal minOrderValue = parseBigDecimal(request.getParameter("minOrderValue"));

            int usageLimit = parseInt(request.getParameter("usageLimit"), 0);
            int maxUsagePerUser = parseInt(request.getParameter("maxUsagePerUser"), 1);
            if (maxUsagePerUser < 1) maxUsagePerUser = 1;

            LocalDateTime startAt = parseDateTime(request.getParameter("startAt"));
            LocalDateTime endAt = parseDateTime(request.getParameter("endAt"));

            if (startAt != null && endAt != null && endAt.isBefore(startAt)) {
                NotificationUtil.setError(request.getSession(), "Ngày kết thúc phải sau ngày bắt đầu");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
                return;
            }

            Status status = Status.fromString(request.getParameter("status"));

            existing.setCode(code.trim());
            existing.setValueType(valueType);
            existing.setValue(value);
            existing.setMaxDiscount(maxDiscount);
            existing.setMinOrderValue(minOrderValue);
            existing.setUsageLimit(usageLimit);
            existing.setMaxUsagePerUser(maxUsagePerUser);
            existing.setStartAt(startAt);
            existing.setEndAt(endAt);
            existing.setStatus(status);

            boolean updated = voucherService.updateVoucher(existing);

            if (updated) {
                List<VoucherScope> scopes = parseScopes(request);
                voucherService.saveScopes(id, scopes);
                NotificationUtil.setSuccess(request.getSession(), "Cập nhật voucher '" + code.trim() + "' thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể cập nhật voucher");
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + id);
            }

        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi cập nhật voucher: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/vouchers");
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

    private BigDecimal parseBigDecimal(String str) {
        if (str == null || str.trim().isEmpty()) return null;
        try { return new BigDecimal(str.trim()); } catch (NumberFormatException e) { return null; }
    }

    private int parseInt(String str, int defaultValue) {
        if (str == null || str.trim().isEmpty()) return defaultValue;
        try { return Integer.parseInt(str.trim()); } catch (NumberFormatException e) { return defaultValue; }
    }

    private LocalDateTime parseDateTime(String str) {
        if (str == null || str.trim().isEmpty()) return null;
        try {
            return LocalDateTime.parse(str.trim(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        } catch (DateTimeParseException e) {
            try {
                return LocalDateTime.parse(str.trim().replace("T", " "),
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            } catch (DateTimeParseException e2) { return null; }
        }
    }
}
