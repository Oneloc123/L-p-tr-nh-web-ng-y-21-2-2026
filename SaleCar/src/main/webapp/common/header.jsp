<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/common/all.css">
    <link rel="stylesheet" href="/common/assets/alert.css">



</head>

<body>
<div id="alertContainer"></div>

<nav class="navbar navbar-expand-lg">
    <div class="container">

        <!-- LOGO -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-gem me-2" style="color: var(--gold);"></i>LUXCAR
        </a>

        <!-- MOBILE BUTTON -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu"
                style="border-color: var(--gold);">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>

        <!-- MENU -->
        <div class="collapse navbar-collapse" id="menu">

            <!-- SEARCH BAR -->
            <div class="search-wrapper mx-auto">
                <form action="${pageContext.request.contextPath}/products" method="GET" class="search-form">
                    <input type="text"
                           name="keyword"
                           class="search-input"
                           placeholder="Tìm mô hình kiếm xe sang..."
                           value="${param.keyword}"
                           autocomplete="off">
                    <button type="submit" class="search-btn">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <!-- MENU ITEMS -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('home') || pageContext.request.requestURI eq '/' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i>Trang chủ
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('products') ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/products">
                        <i class="bi bi-grid me-1"></i>Sản phẩm
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('favorites') ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/favorites">
                        <i class="bi bi-heart me-1"></i>Yêu thích
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('contact') ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/contact">
                        <i class="bi bi-envelope me-1"></i>Liên hệ
                    </a>
                </li>
            </ul>

            <!-- RIGHT SIDE -->
            <div class="nav-right">

                <!-- CART -->
                <a href="${pageContext.request.contextPath}/cart" class="cart-btn">
                    <i class="bi bi-cart3"></i>
                    <span id="cart-count" class="cart-count">
                        <c:out value="${sessionScope.cart != null ? fn:length(sessionScope.cart.items) : 0}"/>
                    </span>
                </a>

                <!-- AUTH - DROPDOWN STYLE -->
                <div class="auth">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <!-- Logged In User -->
                            <div class="auth-dropdown">
                                <div class="user-avatar">
                                    <img src="${empty user.imgURL
                                        ? pageContext.request.contextPath.concat('/assets/img/default-avatar.png')
                                        : pageContext.request.contextPath.concat('/').concat(user.imgURL)}"
                                         class="profile-img"
                                         alt="Avatar">
                                </div>
                                <div class="auth-dropdown-content">
                                    <a href="${pageContext.request.contextPath}/profile" class="auth-dropdown-item">
                                        <i class="bi bi-person-circle"></i>
                                        <span>Tài khoản của tôi</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/order" class="auth-dropdown-item">
                                        <i class="bi bi-box"></i>
                                        <span>Đơn hàng</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/settings" class="auth-dropdown-item">
                                        <i class="bi bi-gear"></i>
                                        <span>Cài đặt</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/loggout" class="auth-dropdown-item">
                                        <i class="bi bi-box-arrow-right"></i>
                                        <span>Đăng xuất</span>
                                    </a>
                                </div>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <!-- Not Logged In -->
                            <div class="auth-dropdown">
                                <button class="auth-dropdown-btn">
                                    <i class="bi bi-person"></i>
                                </button>
                                <div class="auth-dropdown-content">
                                    <a href="${pageContext.request.contextPath}/login" class="auth-dropdown-item">
                                        <i class="bi bi-box-arrow-in-right"></i>
                                        <span>Đăng nhập</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/register" class="auth-dropdown-item">
                                        <i class="bi bi-person-plus"></i>
                                        <span>Đăng ký</span>
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>

        </div>

    </div>

</nav>

<!-- JavaScript for Bootstrap and additional functionality -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Fix for white screen issue - ensure body has content
        if (document.body.children.length === 1) {
            console.log('Page loaded successfully');
        }

        // Handle active menu item
        const currentPath = window.location.pathname;
        const contextPath = '${pageContext.request.contextPath}';
        const navLinks = document.querySelectorAll('.navbar-nav .nav-link');

        navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href && currentPath.includes(href.replace(contextPath, '')) && href !== '${pageContext.request.contextPath}/home') {
                link.classList.add('active');
            } else if (currentPath === contextPath + '/' || currentPath === contextPath + '/home') {
                if (link.getAttribute('href').includes('home')) {
                    link.classList.add('active');
                }
            }
        });
    });


</script>

<!-- Add JSTL function taglib for string manipulation -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

