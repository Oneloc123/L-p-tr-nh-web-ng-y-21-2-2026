<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/26/2026
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<!-- File: sidebar.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    /* File: sidebar.css */

    /* Reset mặc định cho body và layout */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background-color: #f1f5f9;
        font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        color: #1e293b;
    }

    /* SIDEBAR STYLE - Soft Gray */
    .sidebar {
        width: 280px;
        background-color: #ffffff;
        border-right: 1px solid #e9edf2;
        height: 100vh;
        position: sticky;
        top: 0;
        padding: 2rem 1.2rem;
        transition: all 0.3s;
    }

    .logo {
        font-size: 1.6rem;
        font-weight: 700;
        background: linear-gradient(135deg, #1e2a3a, #2c7da0);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        margin-bottom: 2.5rem;
        letter-spacing: -0.5px;
    }

    .logo i {
        background: none;
        color: #2c7da0;
        -webkit-background-clip: unset;
        background-clip: unset;
    }

    .sidebar nav ul {
        list-style: none;
        padding: 0;
    }

    .sidebar nav ul li {
        margin-bottom: 0.6rem;
    }

    .sidebar nav ul li a {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 12px 18px;
        border-radius: 14px;
        color: #5a6e7c;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s ease;
        font-size: 0.95rem;
    }

    .sidebar nav ul li a i {
        font-size: 1.3rem;
        width: 24px;
    }

    .sidebar nav ul li a:hover,
    .sidebar nav ul li a.active {
        background-color: #f0f9ff;
        color: #2c7da0;
        box-shadow: 0 2px 4px rgba(44,125,160,0.08);
        border-left: 2px solid #2c7da0;
    }

    /* MAIN CONTENT - Cần có để layout hoạt động */
    .main-content {
        flex: 1;
        padding: 2rem 2rem 3rem 2rem;
        background-color: #f1f5f9;
        overflow-y: auto;
    }

    /* responsive cho sidebar khi màn hình nhỏ */
    @media (max-width: 992px) {
        .sidebar {
            width: 80px;
            padding: 1rem 0.5rem;
        }

        .sidebar .logo span {
            display: none;
        }

        .sidebar nav ul li a span {
            display: none;
        }

        .sidebar nav ul li a i {
            font-size: 1.5rem;
        }
    }

</style>

<aside class="sidebar">
    <h2 class="logo">
        <i class="bi bi-car-front-fill me-2"></i>
        <span>LUXCAR Admin</span>
    </h2>
    <nav>
        <ul>

            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="${fn:contains(pageContext.request.requestURI, 'dashboard') ? 'active' : ''}">
                    <i class="bi bi-speedometer2"></i><span> Dashboard</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/products"
                   class="${fn:contains(pageContext.request.requestURI, 'products') || fn:contains(pageContext.request.requestURI, 'product') ? 'active' : ''}">
                    <i class="bi bi-box"></i><span> Sản phẩm</span>
                </a>
            </li>


            <li>
                <a href="${pageContext.request.contextPath}/admin/categories"
                   class="${fn:contains(pageContext.request.requestURI, 'categories') || fn:contains(pageContext.request.requestURI, 'category') ? 'active' : ''}">
                    <i class="bi bi-tags"></i><span> Danh mục</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/brands"
                   class="${fn:contains(pageContext.request.requestURI, 'brands') || fn:contains(pageContext.request.requestURI, 'brand') ? 'active' : ''}">
                    <i class="bi bi-boxes"></i><span> Thương hiệu</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/orderAdmin"
                   class="${fn:contains(pageContext.request.requestURI, 'orders') || fn:contains(pageContext.request.requestURI, 'order') ? 'active' : ''}">
                    <i class="bi bi-cart"></i><span> Đơn hàng</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/payment"
                   class="${fn:contains(pageContext.request.requestURI, 'payment') ? 'active' : ''}">
                    <i class="bi bi-credit-card"></i><span> Thanh toán</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/userAdmin"
                   class="${fn:contains(pageContext.request.requestURI, 'users') || fn:contains(pageContext.request.requestURI, 'user') ? 'active' : ''}">
                    <i class="bi bi-people"></i><span> Người dùng</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/blogs"
                   class="${fn:contains(pageContext.request.requestURI, 'blogs') || fn:contains(pageContext.request.requestURI, 'blog') ? 'active' : ''}">
                    <i class="bi bi-journal-text"></i><span> Blog</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/banners"
                   class="${fn:contains(pageContext.request.requestURI, 'banners') || fn:contains(pageContext.request.requestURI, 'banner') ? 'active' : ''}">
                    <i class="bi bi-image"></i><span> Banner</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/loggout">
                    <i class="bi bi-box-arrow-right"></i><span> Đăng xuất</span>
                </a>
            </li>

        </ul>
    </nav>
</aside>