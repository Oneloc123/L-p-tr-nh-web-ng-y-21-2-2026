<%@ page contentType="text/html; charset=UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>

        body{
            font-family: 'Inter', sans-serif;
            background:#f8f9fa;
        }

        /* NAVBAR */

        .navbar{
            background:#000;
            padding:14px 0;
        }

        .navbar-brand{
            font-weight:600;
            font-size:22px;
            letter-spacing:1px;
        }

        /* menu */

        .navbar-nav .nav-link{
            color:#fff;
            font-weight:500;
            margin-left:15px;
            transition:0.25s;
        }

        .navbar-nav .nav-link:hover{
            color:#d4af37;
        }

        /* RIGHT AREA */

        .nav-right{
            display:flex;
            align-items:center;
            gap:18px;
        }

        /* CART */

        .cart-btn{
            position:relative;
            font-size:22px;
            color:white;
            transition:0.2s;
        }

        .cart-btn:hover{
            color:#d4af37;
        }

        .cart-count{
            position:absolute;
            top:-6px;
            right:-10px;

            background:#ff3b30;
            color:white;

            font-size:11px;
            font-weight:600;

            min-width:18px;
            height:18px;

            padding:0 4px;

            display:flex;
            align-items:center;
            justify-content:center;

            border-radius:50%;
        }

        /* AUTH */

        .auth a{
            color:white;
            text-decoration:none;
            font-size:14px;
            margin-left:10px;
        }

        .auth a:hover{
            color:#d4af37;
        }

    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">

        <!-- LOGO -->
        <a class="navbar-brand" href="home">LUXCAR</a>

        <!-- MOBILE BUTTON -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- MENU -->
        <div class="collapse navbar-collapse" id="menu">

            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/home">Trang chủ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="/products">Sản phẩm</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="/favorites">Yêu thích</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">Liên hệ</a>
                </li>
            </ul>

            <!-- RIGHT SIDE -->
            <div class="nav-right ms-3">

                <!-- CART -->
                <a href="/cart" class="cart-btn">
                    <i class="bi bi-cart3"></i>
                    <span class="cart-count">
                        ${sessionScope.cart != null ? sessionScope.cart.size : 0}
                    </span>
                </a>

                <!-- AUTH -->
                <div class="auth">

                    <c:choose>

                        <c:when test="${sessionScope.user != null}">
                            <a href="${pageContext.request.contextPath}/profile">Tài khoản</a>
                            <a href="${pageContext.request.contextPath}/logout">Logout</a>
                        </c:when>

                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login">Login</a>
                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

    </div>
</nav>

</body>