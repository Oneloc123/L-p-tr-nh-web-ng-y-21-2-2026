<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000000;
            --gold: #D4AF37;
            --white: #FFFFFF;
            --light-gold: #f5e7b2;
            --dark-gold: #b8960f;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        /* NAVBAR */
        .navbar {
            background: var(--black);
            padding: 8px 0;
            border-bottom: 2px solid var(--gold);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            min-height: 70px;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 26px;
            letter-spacing: 2px;
            background: linear-gradient(135deg, var(--white) 0%, var(--gold) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            transition: 0.3s;
            white-space: nowrap;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        /* MENU */
        .navbar-nav {
            align-items: center;
        }

        .navbar-nav .nav-item {
            margin: 0 2px;
        }

        .navbar-nav .nav-link {
            color: var(--white);
            font-weight: 500;
            font-size: 15px;
            padding: 8px 15px !important;
            position: relative;
            transition: 0.3s;
            white-space: nowrap;
            border-radius: 4px;
        }

        .navbar-nav .nav-link:hover {
            color: var(--gold);
            background: rgba(212, 175, 55, 0.1);
        }

        .navbar-nav .nav-link.active {
            color: var(--gold) !important;
            background: rgba(212, 175, 55, 0.15);
        }

        .navbar-nav .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 10px;
            right: 10px;
            height: 3px;
            background: var(--gold);
            border-radius: 3px 3px 0 0;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                width: 0;
                opacity: 0;
            }
            to {
                width: calc(100% - 20px);
                opacity: 1;
            }
        }

        /* SEARCH BAR */
        .search-wrapper {
            flex: 0 1 400px;
            margin: 0 20px;
        }

        .search-form {
            position: relative;
            width: 100%;
        }

        .search-input {
            width: 100%;
            padding: 8px 45px 8px 20px;
            border: 2px solid rgba(212, 175, 55, 0.3);
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.1);
            color: var(--white);
            font-size: 14px;
            transition: all 0.3s ease;
            height: 40px;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--gold);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
        }

        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.6);
            font-style: italic;
        }

        .search-btn {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--gold);
            font-size: 16px;
            padding: 5px 12px;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-btn:hover {
            color: var(--white);
            transform: translateY(-50%) scale(1.1);
        }

        /* RIGHT AREA */
        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-left: 15px;
        }

        /* CART */
        .cart-btn {
            position: relative;
            font-size: 22px;
            color: var(--white);
            transition: 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 5px;
        }

        .cart-btn:hover {
            color: var(--gold);
            transform: translateY(-2px);
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--gold);
            color: var(--black);
            font-size: 10px;
            font-weight: 700;
            min-width: 18px;
            height: 18px;
            padding: 0 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            border: 2px solid var(--black);
        }

        /* AUTH - DROPDOWN STYLE */
        .auth-dropdown {
            position: relative;
            display: inline-block;
        }

        .auth-dropdown-btn {
            background: transparent;
            border: 2px solid var(--gold);
            color: var(--white);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            padding: 0;
        }

        .auth-dropdown-btn:hover {
            background: var(--gold);
            color: var(--black);
            transform: scale(1.05);
        }

        .auth-dropdown-btn i {
            font-size: 20px;
        }

        .auth-dropdown-content {
            position: absolute;
            right: 0;
            top: 50px;
            background: var(--white);
            min-width: 180px;
            border-radius: 8px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
            z-index: 1000;
            border: 1px solid var(--gold);
            overflow: hidden;
        }

        .auth-dropdown:hover .auth-dropdown-content {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .auth-dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 20px;
            color: var(--black);
            text-decoration: none;
            transition: 0.3s;
            font-size: 14px;
            font-weight: 500;
            border-bottom: 1px solid #eee;
        }

        .auth-dropdown-item:last-child {
            border-bottom: none;
        }

        .auth-dropdown-item:hover {
            background: rgba(212, 175, 55, 0.1);
            color: var(--gold);
        }

        .auth-dropdown-item i {
            color: var(--gold);
            font-size: 16px;
            width: 20px;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--gold), var(--dark-gold));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--black);
            font-weight: 700;
            font-size: 18px;
            border: 2px solid var(--gold);
            cursor: pointer;
            transition: 0.3s;
        }

        .user-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.5);
        }

        /* MOBILE RESPONSIVE */
        @media (max-width: 991px) {
            .navbar-nav .nav-link {
                white-space: normal;
                padding: 10px 15px !important;
            }

            .navbar-nav .nav-link.active::after {
                display: none;
            }

            .navbar-nav .nav-link.active {
                background: rgba(212, 175, 55, 0.2);
                border-radius: 5px;
            }

            .search-wrapper {
                flex: 1;
                margin: 10px 0;
                width: 100%;
            }

            .nav-right {
                margin: 10px 0;
                justify-content: center;
                width: 100%;
            }

            .auth-dropdown-content {
                position: static;
                opacity: 1;
                visibility: visible;
                transform: none;
                box-shadow: none;
                margin-top: 10px;
                width: 100%;
            }

            .auth-dropdown:hover .auth-dropdown-content {
                transform: none;
            }
        }

        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 22px;
            }
        }

        /* ANIMATIONS */
        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(212, 175, 55, 0.4);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(212, 175, 55, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(212, 175, 55, 0);
            }
        }

        .cart-btn:active {
            animation: pulse 0.3s ease;
        }
    </style>
</head>

<body>

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
        <div class="collapse navbar-collapse justify-content-end" id="menu">


            <!-- RIGHT SIDE -->
            <div class="nav-right">


                <!-- AUTH - DROPDOWN STYLE -->
                <div class="auth">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <!-- Logged In User -->
                            <div class="auth-dropdown">
                                <div class="user-avatar">
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

</body>