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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/common/dark-theme.css">
    <style>

        .noti-card {
            background: var(--bg-surface);
            border-radius: var(--radius-md);
            border: 1px solid var(--border-subtle);
            box-shadow: var(--shadow-card);
            margin-bottom: 15px;
            transition: transform var(--transition-base), box-shadow var(--transition-base);
            display: flex;
            align-items: flex-start;
            padding: 20px;
        }
        .noti-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
            border-color: var(--border-gold);
        }
        .noti-card.unread {
            background: var(--bg-elevated);
            border-color: var(--border-gold);
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
        .bg-success-light { background: rgba(46, 204, 113, 0.12); color: #2ecc71; }
        .bg-info-light { background: rgba(23, 162, 184, 0.12); color: #17a2b8; }
        .bg-indigo-light { background: rgba(105, 0, 199, 0.12); color: #6900c7; }
        .bg-danger-light { background: rgba(231, 76, 60, 0.12); color: #e74c3c; }
        .bg-secondary-light { background: rgba(255, 255, 255, 0.06); color: var(--text-secondary); }

        .noti-content { flex-grow: 1; padding-right: 20px; }
        .noti-title { font-size: 15px; font-weight: 600; color: var(--text-primary); margin-bottom: 5px; }
        .noti-message { font-size: 14px; color: var(--text-secondary); margin-bottom: 0; line-height: 1.5; }

        .noti-meta { text-align: right; min-width: 100px; display: flex; flex-direction: column; align-items: flex-end; }
        .noti-time { font-size: 13px; color: var(--text-muted); margin-bottom: 8px; }
        .unread-dot { width: 10px; height: 10px; background-color: var(--gold); border-radius: 50%; display: inline-block; box-shadow: 0 0 6px rgba(212, 175, 55, 0.4); }

        .empty-state { text-align: center; padding: 60px 20px; color: var(--text-muted); }
        .empty-state i { font-size: 50px; margin-bottom: 15px; color: rgba(255,255,255,0.08); }
        .empty-state h5 { color: var(--text-primary); margin-bottom: 8px; }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(212, 175, 55, 0.15); border-radius: 10px; }

        .btn-outline-secondary {
            color: var(--text-secondary);
            border: 1.5px solid var(--border-subtle);
            background: transparent;
            border-radius: 40px;
            padding: 8px 20px;
            font-size: 13px;
            font-weight: 500;
            transition: all var(--transition-base);
        }
        .btn-outline-secondary:hover {
            background: rgba(212, 175, 55, 0.1);
            border-color: var(--gold);
            color: var(--gold);
        }
    </style>
</head>
<body>
<div class="profile-wrapper">

    <%-- SIDEBAR --%>
    <!-- Sidebar chung -->
    <%@ include file="/common/user-sidebar.jsp" %>

    <%-- MAIN CONTENT --%>
    <div class="main-content">
        <div class="content-header d-flex justify-content-between align-items-center">
            <h2>Thông báo</h2>
            <button class="btn btn-outline-secondary btn-sm" onclick="markAllReadFromPage()" style="border-radius: 20px;">
                <i class="bi bi-check2-all me-1"></i> Đánh dấu đã đọc
            </button>
        </div>

        <%-- DANH SÁCH THÔNG BÁO (đã xóa tabs, thêm link điều hướng) --%>
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

                        <%-- RENDER CARD (bọc trong <a> để điều hướng) --%>
                        <c:choose>
                            <c:when test="${noti.orderId > 0}">
                                <a href="${pageContext.request.contextPath}/order-detail?id=${noti.orderId}" class="text-decoration-none">
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/notifications" class="text-decoration-none" onclick="event.preventDefault();">
                            </c:otherwise>
                        </c:choose>
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
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script>
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