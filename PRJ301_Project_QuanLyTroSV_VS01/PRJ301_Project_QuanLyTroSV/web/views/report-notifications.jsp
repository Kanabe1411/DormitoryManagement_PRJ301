<%-- Danh sách thông báo --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông báo | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
            .notif-item { border-left: 4px solid #e67e22; padding: 15px; margin-bottom: 10px; background: #fff; border-radius: 8px; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="mb-4"><a href="ReportController" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Quay lại</a></div>
            <h2 class="fw-bold mb-4"><i class="bi bi-envelope-fill me-2"></i>Thông báo</h2>

            <div class="card shadow-sm">
                <div class="card-body">
                    <c:forEach items="${list}" var="n">
                        <div class="notif-item">
                            <h6 class="fw-bold">${n.title}</h6>
                            <p class="text-muted mb-1 small">${n.content}</p>
                            <small class="text-muted"><fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                        </div>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <div class="text-center py-5">
                            <i class="bi bi-inbox display-1 text-light"></i>
                            <p class="text-muted mt-3">Chưa có thông báo nào.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
