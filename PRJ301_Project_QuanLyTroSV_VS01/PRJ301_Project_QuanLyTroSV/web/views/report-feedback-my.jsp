<%-- Phản hồi của tôi - Sinh viên xem --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phản hồi của tôi | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="mb-4"><a href="ReportController" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Quay lại</a></div>
            <h2 class="fw-bold mb-4"><i class="bi bi-chat-left-text me-2"></i>Phản hồi của tôi</h2>

            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Loại</th>
                                    <th>Tiêu đề</th>
                                    <th>Nội dung</th>
                                    <th>Trạng thái</th>
                                    <th>Phản hồi</th>
                                    <th>Ngày</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="fb">
                                    <tr>
                                        <td><span class="badge bg-secondary">${fb.type}</span></td>
                                        <td>${fb.subject}</td>
                                        <td>${fb.content}</td>
                                        <td>${fb.status}</td>
                                        <td class="small">${fb.response}</td>
                                        <td><fmt:formatDate value="${fb.createdAt}" pattern="dd/MM/yyyy"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <c:if test="${empty list}">
                <div class="text-center py-5 bg-white rounded shadow-sm">
                    <i class="bi bi-chat display-1 text-light"></i>
                    <p class="text-muted mt-3">Bạn chưa gửi phản hồi nào.</p>
                    <a href="ReportController?action=support" class="btn btn-primary" style="background-color:#e67e22;border:none;">Gửi phản hồi</a>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
