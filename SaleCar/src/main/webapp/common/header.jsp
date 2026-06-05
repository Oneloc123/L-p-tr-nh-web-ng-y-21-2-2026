<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <fmt:setLocale value="vi_VN"/>

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

<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link ${pageContext.request.requestURI.contains('contact') ? 'active' : ''}"--%>
<%--                       href="${pageContext.request.contextPath}/contact">--%>
<%--                        <i class="bi bi-envelope me-1"></i>Liên hệ--%>
<%--                    </a>--%>
<%--                </li>--%>
            </ul>

            <!-- RIGHT SIDE -->
            <div class="nav-right">

                <!-- NOTIFICATION BELL (only for logged-in users) -->
                <c:if test="${sessionScope.user != null}">
                    <div class="dropdown notification-dropdown" id="notificationDropdown">
                        <a href="#" class="cart-btn notification-bell" role="button" data-bs-toggle="dropdown" aria-expanded="false" id="notificationBell">
                            <i class="bi bi-bell"></i>
                            <span id="notification-count" class="cart-count notification-badge" style="display:none;">0</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end notification-menu" aria-labelledby="notificationBell">
                            <div class="notification-header">
                                <span class="fw-bold">Thông báo</span>
                                <span id="notification-header-count" class="badge bg-danger rounded-pill ms-2">0</span>
                            </div>
                            <div class="notification-divider"></div>
                            <ul id="notification-list" class="list-unstyled mb-0">
                                <li class="notification-empty text-center text-muted py-3">
                                    <i class="bi bi-bell-slash"></i> Không có thông báo
                                </li>
                            </ul>
                            <div class="notification-divider"></div>
                            <div class="notification-footer">
                                <a href="${pageContext.request.contextPath}/notifications" class="notification-view-all">
                                    <i class="bi bi-eye"></i> Xem tất cả
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>

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
                                    <img src="${pageContext.request.contextPath}${sessionScope.user.imgURL}"
                                         alt="Avatar"
                                         style="width: 100%; height: 100%; object-fit: cover;" />
                                </div>
                                <div class="auth-dropdown-content">
                                    <a href="${pageContext.request.contextPath}/notifications" class="auth-dropdown-item">
                                        <i class="bi bi-bell"></i>
                                        <span>Thông báo</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/dashboard" class="auth-dropdown-item">
                                        <i class="bi bi-person-circle"></i>
                                        <span>Tài khoản của tôi</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/order" class="auth-dropdown-item">
                                        <i class="bi bi-box"></i>
                                        <span>Đơn hàng</span>
                                    </a>
<%--                                    <a href="${pageContext.request.contextPath}/settings" class="auth-dropdown-item">--%>
<%--                                        <i class="bi bi-gear"></i>--%>
<%--                                        <span>Cài đặt</span>--%>
<%--                                    </a>--%>
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

    // ========================
    // NOTIFICATION SYSTEM
    // ========================
    (function() {
        const isLoggedIn = ${sessionScope.user != null};
        if (!isLoggedIn) return;

        const notifCountEl = document.getElementById('notification-count');
        const notifListEl = document.getElementById('notification-list');
        const notifHeaderCount = document.getElementById('notification-header-count');
        const bellIcon = document.querySelector('.notification-bell i');

        function loadNotifications() {
            fetch('${pageContext.request.contextPath}/api/notifications?action=summary')
                .then(function(res) {
                    if (!res.ok) throw new Error('Unauthorized');
                    return res.json();
                })
                .then(function(data) {
                    // Update badge count
                    var count = data.count || 0;
                    if (notifCountEl) {
                        if (count > 0) {
                            notifCountEl.textContent = count > 99 ? '99+' : count;
                            notifCountEl.style.display = 'flex';
                            if (bellIcon) bellIcon.closest('.notification-bell')?.classList.add('has-unread');
                        } else {
                            notifCountEl.style.display = 'none';
                            if (bellIcon) bellIcon.closest('.notification-bell')?.classList.remove('has-unread');
                        }
                    }
                    if (notifHeaderCount) {
                        notifHeaderCount.textContent = count;
                        notifHeaderCount.style.display = count > 0 ? 'inline-block' : 'none';
                    }

                    // Render notification list
                    if (notifListEl) {
                        var notifs = data.notifications || [];
                        if (notifs.length === 0) {
                            notifListEl.innerHTML = '<li class="notification-empty text-center text-muted py-3">' +
                                '<i class="bi bi-bell-slash"></i> Không có thông báo</li>';
                        } else {
                            var html = '';
                            for (var i = 0; i < notifs.length; i++) {
                                var n = notifs[i];
                                var unreadClass = n.isRead ? '' : 'unread';
                                html += '<li class="notification-item ' + unreadClass + '">' +
                                    '<div class="noti-icon"><i class="bi ' + (n.isRead ? 'bi-bell' : 'bi-bell-fill') + '"></i></div>' +
                                    '<div class="noti-content">' +
                                        '<div class="noti-message">' + escapeHtml(n.message) + '</div>' +
                                        '<small class="noti-time"><i class="bi bi-clock"></i> ' + escapeHtml(n.createdAt) + '</small>' +
                                    '</div>' +
                                '</li>';
                            }
                            notifListEl.innerHTML = html;
                        }
                    }
                })
                .catch(function(err) {
                    console.log('Notification load error:', err);
                });
        }

        function markAllRead() {
            fetch('${pageContext.request.contextPath}/api/notifications?action=markRead')
                .then(function(res) { return res.json(); })
                .then(function(data) {
                    if (data.success) {
                        if (notifCountEl) notifCountEl.style.display = 'none';
                        if (notifHeaderCount) notifHeaderCount.style.display = 'none';
                        if (bellIcon) bellIcon.closest('.notification-bell')?.classList.remove('has-unread');
                        // Update all items to read style
                        var items = notifListEl ? notifListEl.querySelectorAll('.notification-item') : [];
                        for (var i = 0; i < items.length; i++) {
                            items[i].classList.remove('unread');
                            var icon = items[i].querySelector('.noti-icon i');
                            if (icon) {
                                icon.className = 'bi bi-bell';
                            }
                        }
                    }
                })
                .catch(function(err) {
                    console.log('Mark read error:', err);
                });
        }

        function escapeHtml(text) {
            if (!text) return '';
            var div = document.createElement('div');
            div.appendChild(document.createTextNode(text));
            return div.innerHTML;
        }

        // Load on page load
        loadNotifications();

        // Mark all as read when dropdown is opened
        var dropdownEl = document.getElementById('notificationDropdown');
        if (dropdownEl) {
            dropdownEl.addEventListener('shown.bs.dropdown', function () {
                markAllRead();
                // Reload notifications to update UI
                setTimeout(loadNotifications, 500);
            });
        }

        // Refresh every 60 seconds
        setInterval(loadNotifications, 60000);
    })();

</script>

<!-- Add JSTL function taglib for string manipulation -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

