<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
  Lấy đường dẫn gốc:
  - Nếu request được forward từ servlet → dùng jakarta.servlet.forward.servlet_path (vd: /dashboard, /order, /profile)
  - Nếu request trực tiếp đến JSP → dùng requestURI (vd: /SaleCar/pages/dashBoard.jsp)
  Chuyển sang lowercase để so sánh không phân biệt hoa thường.
--%>
<c:set var="forwardPath" value="${requestScope['jakarta.servlet.forward.servlet_path']}" />
<c:set var="raw" value="${not empty forwardPath ? forwardPath : pageContext.request.requestURI}" />
<c:set var="cur" value="${fn:toLowerCase(raw)}" />

<div class="sidebar-menu">
    <div class="menu-items">
        <a href="${pageContext.request.contextPath}/dashboard"
           class="menu-item ${fn:contains(cur, 'dashboard') and !fn:contains(cur, '/admin') ? 'active' : ''}">
            <i class="bi bi-speedometer2"></i><span>Bảng điều khiển</span>
        </a>
        <a href="${pageContext.request.contextPath}/profile"
           class="menu-item ${fn:contains(cur, '/profile') and !fn:contains(cur, 'edit') and !fn:contains(cur, 'avatar') and !fn:contains(cur, 'changepassword') ? 'active' : ''}">
            <i class="bi bi-person-circle"></i><span>Thông tin cá nhân</span>
        </a>
        <a href="${pageContext.request.contextPath}/profileEdit"
           class="menu-item ${fn:contains(cur, 'profileedit') or fn:contains(cur, 'avatar') or fn:contains(cur, 'changepassword') ? 'active' : ''}">
            <i class="bi bi-person-gear"></i><span>Chỉnh sửa thông tin</span>
        </a>
        <a href="${pageContext.request.contextPath}/order"
           class="menu-item ${(fn:contains(cur, '/order') or fn:contains(cur, 'order-detail')) and !fn:contains(cur, '/admin') ? 'active' : ''}">
            <i class="bi bi-bag"></i><span>Đơn hàng của tôi</span>
        </a>
        <a href="${pageContext.request.contextPath}/cart"
           class="menu-item ${fn:contains(cur, '/cart') and !fn:contains(cur, 'checkout') ? 'active' : ''}">
            <i class="bi bi-cart3"></i><span>Giỏ hàng</span>
        </a>
        <a href="${pageContext.request.contextPath}/favorites"
           class="menu-item ${fn:contains(cur, 'favorites') ? 'active' : ''}">
            <i class="bi bi-heart"></i><span>Sản phẩm yêu thích</span>
        </a>
        <a href="${pageContext.request.contextPath}/notifications"
           class="menu-item ${fn:contains(cur, 'notifications') ? 'active' : ''}">
            <i class="bi bi-bell"></i><span>Thông báo</span>
        </a>
        <div class="menu-divider"></div>
        <a href="${pageContext.request.contextPath}/loggout" class="menu-item">
            <i class="bi bi-box-arrow-right"></i><span>Đăng xuất</span>
        </a>
    </div>
</div>
