<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông báo - LUXCAR</title>

    <%-- Include header --%>
    <%@ include file="/common/header.jsp" %>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }

        /* Main layout & Sidebar (Giống dashboard/profile) */
        .profile-wrapper { display: flex; align-items: flex-start; min-height: 100vh; }
        .sidebar-menu { width: 280px; background-color: #000000; color: #ffffff; padding: 30px 0; position: sticky; top: 0; height: 100vh; overflow-y: auto; z-index: 1000; flex-shrink: 0; }
        .menu-items { padding: 20px 0; }
        .menu-item { display: flex; align-items: center; padding: 12px 25px; color: #ffffff; text-decoration: none; transition: all 0.3s; margin: 5px 10px; border-radius: 8px; }
        .menu-item i { width: 25px; margin-right: 12px; font-size: 18px; }
        .menu-item span { font-size: 15px; font-weight: 500; }
        .menu-item:hover { background-color: #333333; color: #ffffff; }
        .menu-item.active { background-color: #ffffff; color: #000000; }
        .menu-item.active i { color: #000000; }
        .menu-divider { height: 1px; background-color: #333333; margin: 15px 20px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; background-color: #f8f9fa; min-height: 100vh; }
        .content-header { margin-bottom: 25px; }
        .content-header h2 { font-size: 28px; font-weight: 600; color: #000; margin-bottom: 15px; }

        /* Custom Tabs */
        .custom-tabs {
            display: flex;
            background: #fff;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #eee;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
            overflow: hidden;
        }
        .custom-tab {
            padding: 16px 35px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            color: #777;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .custom-tab:hover { color: #111; background: #fafafa; }
        .custom-tab.active {
            color: #000;
            border-bottom-color: #000;
            background: #fff;
        }

        /* Notification Card */
        .noti-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #eee;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 15px;
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            align-items: flex-start;
            padding: 20px;
        }
        .noti-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        }
        .noti-card.unread {
            background-color: #f4f9ff;
            border-color: #dbeafe;
        }

        .icon-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            margin-right: 20px;
        }
        .bg-success-light { background-color: #d1e7dd; color: #0f5132; }
        .bg-info-light { background-color: #cff4fc; color: #055160; }
        .bg-indigo-light { background-color: #e0cffc; color: #4b0082; }
        .bg-danger-light { background-color: #f8d7da; color: #842029; }
        .bg-secondary-light { background-color: #e2e3e5; color: #41464b; }

        .noti-content { flex-grow: 1; padding-right: 20px; }
        .noti-title { font-size: 15px; font-weight: 600; color: #222; margin-bottom: 5px; }
        .noti-message { font-size: 14px; color: #666; margin-bottom: 0; line-height: 1.5; }

        .noti-meta { text-align: right; min-width: 100px; display: flex; flex-direction: column; align-items: flex-end; }
        .noti-time { font-size: 13px; color: #888; margin-bottom: 8px; }
        .unread-dot { width: 10px; height: 10px; background-color: #dc3545; border-radius: 50%; display: inline-block; }

        .empty-state { text-align: center; padding: 60px 20px; color: #999; }
        .empty-state i { font-size: 50px; margin-bottom: 15px; color: #ddd; }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f1f1f1; }
        ::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <%-- SIDEBAR --%>
    <div class="sidebar-menu">
        <div class="menu-items">
            <a href="${pageContext.request.contextPath}/dashboard" class="menu-item"><i class="fas fa-chart-pie"></i><span>Bảng điều khiển</span></a>
            <a href="${pageContext.request.contextPath}/profile" class="menu-item"><i class="fas fa-user-circle"></i><span>Thông tin cá nhân</span></a>
            <a href="${pageContext.request.contextPath}/profileEdit" class="menu-item"><i class="fas fa-user-edit"></i><span>Chỉnh sửa thông tin</span></a>
            <a href="${pageContext.request.contextPath}/changePassword" class="menu-item"><i class="fas fa-lock"></i><span>Đổi mật khẩu</span></a>
            <a href="${pageContext.request.contextPath}/order" class="menu-item"><i class="fas fa-shopping-bag"></i><span>Đơn hàng của tôi</span></a>
            <a href="${pageContext.request.contextPath}/cart" class="menu-item"><i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span></a>
            <a href="${pageContext.request.contextPath}/favorites" class="menu-item"><i class="fas fa-heart"></i><span>Sản phẩm yêu thích</span></a>
            <a href="${pageContext.request.contextPath}/notifications" class="menu-item active"><i class="fas fa-bell"></i><span>Thông báo</span></a>
            <div class="menu-divider"></div>
            <a href="${pageContext.request.contextPath}/loggout" class="menu-item"><i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span></a>
        </div>
    </div>

    <%-- MAIN CONTENT --%>
    <div class="main-content">
        <div class="content-header d-flex justify-content-between align-items-center">
            <h2>Thông báo</h2>
            <button class="btn btn-outline-secondary btn-sm" onclick="markAllReadFromPage()" style="border-radius: 20px;">
                <i class="bi bi-check2-all me-1"></i> Đánh dấu đã đọc
            </button>
        </div>

        <%-- TABS --%>
        <div class="custom-tabs">
            <div class="custom-tab active" onclick="filterNoti('all', this)">Tất cả</div>
            <div class="custom-tab" onclick="filterNoti('unread', this)">Chưa đọc</div>
        </div>

        <%-- DANH SÁCH THÔNG BÁO --%>
        <div class="noti-list-container">
            <c:choose>
                <c:when test="${empty notifications}">
                    <div class="empty-state">
                        <i class="bi bi-bell-slash"></i>
                        <h5>Bạn chưa có thông báo nào</h5>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="noti" items="${notifications}">

                        <%-- XỬ LÝ LOGIC CHỌN ICON VÀ MÀU SẮC DỰA TRÊN NỘI DUNG TIN NHẮN --%>
                        <c:set var="iconClass" value="bi-bell-fill" />
                        <c:set var="bgClass" value="bg-secondary-light" />

                        <c:choose>
                            <c:when test="${fn:containsIgnoreCase(noti.message, 'thành công') || fn:containsIgnoreCase(noti.message, 'hoàn tất')}">
                                <c:set var="iconClass" value="bi-check-circle-fill" />
                                <c:set var="bgClass" value="bg-success-light" />
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(noti.message, 'xác nhận')}">
                                <c:set var="iconClass" value="bi-box-seam" />
                                <c:set var="bgClass" value="bg-info-light" />
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(noti.message, 'vận chuyển') || fn:containsIgnoreCase(noti.message, 'đvvc')}">
                                <c:set var="iconClass" value="bi-truck" />
                                <c:set var="bgClass" value="bg-indigo-light" />
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(noti.message, 'hủy')}">
                                <c:set var="iconClass" value="bi-x-circle-fill" />
                                <c:set var="bgClass" value="bg-danger-light" />
                            </c:when>
                        </c:choose>

                        <%-- RENDER CARD --%>
                        <div class="noti-card noti-item ${noti.isRead ? 'read' : 'unread'}" data-status="${noti.isRead ? 'read' : 'unread'}">

                            <div class="icon-circle ${bgClass}">
                                <i class="bi ${iconClass} fs-5"></i>
                            </div>

                            <div class="noti-content">
                                <div class="noti-title">Cập nhật đơn hàng</div>
                                <p class="noti-message">${noti.message}</p>
                            </div>

                            <div class="noti-meta">
                                <span class="noti-time"><fmt:formatDate value="${noti.createdAt}" pattern="HH:mm dd/MM/yyyy"/></span>
                                <c:if test="${!noti.isRead}">
                                    <span class="unread-dot"></span>
                                </c:if>
                            </div>

                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script>
    // JS Lọc Tab Thông báo
    function filterNoti(status, clickedTab) {
        // Cập nhật giao diện tab active
        document.querySelectorAll('.custom-tab').forEach(tab => tab.classList.remove('active'));
        clickedTab.classList.add('active');

        // Lọc Card
        document.querySelectorAll('.noti-item').forEach(card => {
            const cardStatus = card.getAttribute('data-status');
            if (status === 'all' || cardStatus === status) {
                card.style.display = 'flex'; // Dùng flex để giữ bố cục ngang
            } else {
                card.style.display = 'none';
            }
        });
    }

    // JS Đánh dấu đã đọc
    function markAllReadFromPage() {
        fetch('${pageContext.request.contextPath}/api/notifications?action=markRead')
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    // Cập nhật giao diện UI
                    document.querySelectorAll('.noti-item').forEach(card => {
                        card.classList.remove('unread');
                        card.classList.add('read');
                        card.setAttribute('data-status', 'read');
                        const dot = card.querySelector('.unread-dot');
                        if(dot) dot.style.display = 'none';
                    });

                    // Tắt luôn chấm đỏ trên Header nếu có
                    const headerBadge = document.getElementById('notification-count');
                    if (headerBadge) headerBadge.style.display = 'none';
                }
            })
            .catch(err => console.log('Mark read error:', err));
    }
</script>

</body>
</html>