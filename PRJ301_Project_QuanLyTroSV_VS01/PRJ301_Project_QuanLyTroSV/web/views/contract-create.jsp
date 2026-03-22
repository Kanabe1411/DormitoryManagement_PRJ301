<%-- 
    Document   : contract-create
    Created on : Mar 22, 2026, 12:40:27 PM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo Hợp Đồng Mới | Money Flow</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f7f6;
            }
            .card {
                border-radius: 20px;
                border: none;
            }
            .card-header {
                background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
                border-radius: 20px 20px 0 0 !important;
            }
            .form-label {
                font-weight: 600;
                font-size: 0.85rem;
                color: #4e73df;
                text-transform: uppercase;
                margin-bottom: 8px;
            }
            .form-control {
                border-radius: 10px;
                padding: 12px;
                border: 1px solid #d1d3e2;
            }
            .form-control:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.1);
            }
            .input-group-text {
                background-color: #f8f9fc;
                border-radius: 10px 0 0 10px;
                border: 1px solid #d1d3e2;
                color: #4e73df;
            }
            .btn-create {
                background: #4e73df;
                border: none;
                padding: 12px 30px;
                border-radius: 10px;
                font-weight: 700;
                transition: all 0.3s;
            }
            .btn-create:hover {
                background: #224abe;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(78, 115, 223, 0.3);
            }
            .contract-stepper {
                border-left: 2px dashed #d1d3e2;
                padding-left: 25px;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow-lg">
                        <div class="card-header text-white py-4 text-center">
                            <i class="bi bi-file-earmark-text fs-1"></i>
                            <h3 class="fw-bold mt-2 mb-0">Thiết Lập Hợp Đồng</h3>
                            <p class="small opacity-75 mb-0">Khởi tạo thỏa thuận thuê phòng mới</p>
                        </div>
                        
                        <div class="card-body p-4 p-md-5">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger d-flex align-items-center mb-4" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/ContractController" method="post" class="contract-stepper">
                                <input type="hidden" name="action" value="create">

                                <div class="mb-4">
                                    <label class="form-label">Mã người thuê (User ID)</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person-hash"></i></span>
                                        <input type="number" name="userId" class="form-control" placeholder="Nhập ID khách hàng" required>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Mã phòng (Room ID)</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-door-open"></i></span>
                                        <input type="number" name="roomId" class="form-control" placeholder="Nhập ID phòng thuê" required>
                                    </div>
                                </div>

                                <hr class="my-4 opacity-25">

                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label class="form-label">Ngày bắt đầu</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-calendar-event"></i></span>
                                            <input type="date" name="startDate" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label class="form-label">Ngày kết thúc</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-calendar-check"></i></span>
                                            <input type="date" name="endDate" class="form-control" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 mt-4">
                                    <button type="submit" class="btn btn-create text-white">
                                        <i class="bi bi-file-earmark-plus me-2"></i> XÁC NHẬN TẠO HỢP ĐỒNG
                                    </button>
                                    <a href="ContractController" class="btn btn-link text-muted text-decoration-none small">
                                        <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>