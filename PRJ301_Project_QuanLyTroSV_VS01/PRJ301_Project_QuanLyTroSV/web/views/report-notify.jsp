<%-- Gửi thông báo --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gửi thông báo | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
            .card-header { background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color: white; border-radius: 15px 15px 0 0 !important; }
            .btn-submit { background-color: #e67e22; border: none; font-weight: 700; }
            .btn-submit:hover { background-color: #d35400; color: white; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="mb-4"><a href="ReportController" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Quay lại</a></div>

            <div class="card shadow-lg">
                <div class="card-header py-3">
                    <h5 class="mb-0"><i class="bi bi-bell-fill me-2"></i>Gửi thông báo</h5>
                </div>
                <div class="card-body p-4">
                    <form action="ReportController" method="post" class="row g-4">
                        <input type="hidden" name="action" value="sendNotify"/>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Tiêu đề</label>
                            <input type="text" name="title" class="form-control" placeholder="Tiêu đề thông báo" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Nội dung</label>
                            <textarea name="content" class="form-control" rows="5" placeholder="Nội dung chi tiết..." required></textarea>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Gửi đến</label>
                            <select name="userId" class="form-select">
                                <option value="">Tất cả cư dân</option>
                                <c:forEach items="${users}" var="u">
                                    <option value="${u.id}">${u.username} (${u.role})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-submit btn-primary">
                                <i class="bi bi-send me-2"></i>Gửi thông báo
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
