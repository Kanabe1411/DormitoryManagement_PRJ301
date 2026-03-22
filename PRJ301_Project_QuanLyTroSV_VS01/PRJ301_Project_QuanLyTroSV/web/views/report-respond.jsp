<%-- Phản hồi khiếu nại --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phản hồi | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
            .btn-submit { background-color: #e67e22; border: none; font-weight: 700; }
            .btn-submit:hover { background-color: #d35400; color: white; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="mb-4"><a href="ReportController?action=feedback" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Quay lại</a></div>

            <div class="card shadow-sm mb-4">
                <div class="card-header bg-light">
                    <strong>${feedback.fullName}</strong> - ${feedback.type} - <span class="badge bg-secondary">${feedback.status}</span>
                </div>
                <div class="card-body">
                    <p><strong>Tiêu đề:</strong> ${feedback.subject}</p>
                    <p><strong>Nội dung:</strong> ${feedback.content}</p>
                    <small class="text-muted"><fmt:formatDate value="${feedback.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                    <c:if test="${not empty feedback.response}">
                        <hr>
                        <p class="text-success"><strong>Phản hồi trước:</strong> ${feedback.response}</p>
                    </c:if>
                </div>
            </div>

            <div class="card shadow-lg">
                <div class="card-header py-3" style="background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color: white; border-radius: 15px 15px 0 0;">
                    <h5 class="mb-0">Phản hồi / Cập nhật trạng thái</h5>
                </div>
                <div class="card-body p-4">
                    <form action="ReportController" method="post">
                        <input type="hidden" name="action" value="respond"/>
                        <input type="hidden" name="id" value="${feedback.id}"/>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Trạng thái</label>
                            <select name="status" class="form-select" required>
                                <option value="Chờ xử lý" ${feedback.status == 'Chờ xử lý' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="Đang xử lý" ${feedback.status == 'Đang xử lý' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="Đã xử lý" ${feedback.status == 'Đã xử lý' ? 'selected' : ''}>Đã xử lý</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nội dung phản hồi</label>
                            <textarea name="response" class="form-control" rows="4" placeholder="Nội dung phản hồi tới người gửi...">${feedback.response}</textarea>
                        </div>
                        <button type="submit" class="btn btn-submit btn-primary"><i class="bi bi-send me-2"></i>Gửi phản hồi</button>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
