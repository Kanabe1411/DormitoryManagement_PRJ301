<%-- Hỗ trợ người dùng - Form gửi phản hồi/khiếu nại --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hỗ trợ người dùng | Dormitory Management</title>
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
                    <h5 class="mb-0"><i class="bi bi-headset me-2"></i>Hỗ trợ người dùng</h5>
                    <p class="mb-0 small opacity-75">Gửi phản hồi, khiếu nại hoặc yêu cầu hỗ trợ</p>
                </div>
                <div class="card-body p-4">
                    <form action="ReportController" method="post" class="row g-4">
                        <input type="hidden" name="action" value="sendFeedback"/>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Loại</label>
                            <select name="type" class="form-select" required>
                                <option value="Phản hồi">Phản hồi</option>
                                <option value="Khiếu nại">Khiếu nại</option>
                                <option value="Hỗ trợ">Hỗ trợ</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Hợp đồng (tùy chọn)</label>
                            <select name="contractId" class="form-select">
                                <option value="">— Không liên quan —</option>
                                <c:forEach items="${contracts}" var="c">
                                    <option value="${c.id}">HĐ #${c.id}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Tiêu đề</label>
                            <input type="text" name="subject" class="form-control" placeholder="Tiêu đề ngắn gọn" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Nội dung chi tiết</label>
                            <textarea name="content" class="form-control" rows="5" placeholder="Mô tả vấn đề hoặc góp ý của bạn..." required></textarea>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-submit btn-primary">
                                <i class="bi bi-send me-2"></i>Gửi yêu cầu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
