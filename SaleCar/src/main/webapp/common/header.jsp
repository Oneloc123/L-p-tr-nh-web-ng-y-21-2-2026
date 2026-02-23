<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2/23/2026
  Time: 7:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<header>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600&family=Poppins:wght@300;400;500&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }

        .navbar {
            background-color: #000;
        }

        .navbar a {
            color: #fff !important;
        }


    </style>

</header>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">LUXCAR</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="menu">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/index.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="/pages/products.jsp">Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Yêu thích</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Liên hệ</a></li>
                </ul>
            </div>
            <div class="auth  ">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        Xin chào ${sessionScope.user.name}
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">Login</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>


</body>
