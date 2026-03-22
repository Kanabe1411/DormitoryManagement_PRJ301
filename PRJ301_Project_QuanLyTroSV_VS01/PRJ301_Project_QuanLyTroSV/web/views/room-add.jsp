<%-- 
    Document   : room-add
    Created on : Mar 22, 2026, 8:50:26 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Phòng Mới | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            body { 
                font-family: 'Inter', sans-serif; 
                background-color: #f8f9fc; 
            }
            .card { border: none; border-radius: 15px; }
            .card-header { 
                background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); 
                color: white; 
                border-radius: 15px 15px 0 0 !important;
                padding: 20px;
            }
            .form-label { font-weight: 600; font-size: 0.9rem; color: #2c3e50; }
            .form-control, .form-select { 
                border-radius: 10px; 
                padding: 10px 15px; 
                border: 1px solid #d1d3e2;
            }
            .form-control:focus, .form-select:focus {
                border-color: #e67e22;
                box-shadow: 0 0 0 0.25rem rgba(230, 126, 34, 0.1);
            }
            .btn-submit { 
                background-color: #e67e22; 
                border: none; 
                padding: 12px 30px; 
                border-radius: 10px; 
                font-weight: 700;
                color: white;
                transition: all 0.3s;
            }
            .btn-submit:hover { 
                background-color: #d35400; 
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3);
            }
            .input-group-text { background-color: #f8f9fc; color: #e67e22; border-radius: 10px 0 0 10px; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8">
                    <div class="card shadow-lg">
                        <div class="card-header text-center">
                            <i class="bi bi-door-open-fill fs-1 mb-2"></i>
                            <h3 class="fw-bold mb-0">Thêm Phòng Mới</h3>
                            <p class="small opacity-75 mb-0">Cập nhật tài nguyên phòng cho hệ thống</p>
                        </div>
                        
                        <div class="card-body p-4 p-md-5">
                            <form action="RoomController" method="post" class="row g-4">
                                <input type="hidden" name="action" value="add"/>

                                <div class="col-md-12">
                                    <label class="form-label">Số phòng (Room Number)</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-hash"></i></span>
                                        <input type="text" name="roomNumber" class="form-control" placeholder="Ví dụ: P.301" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Giá thuê (VNĐ/Tháng)</label>
                                    <div class="input-group">
                                        <input type="number" name="price" class="form-control" placeholder="0" min="0" required>
                                        <span class="input-group-text">₫</span>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Trạng thái ban đầu</label>
                                    <select name="status" class="form-select">
                                        <option value="Chưa thuê">Chưa thuê (Trống)</option>
                                        <option value="Đã thuê">Đã thuê</option>
                                    </select>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Loại phòng</label>
                                    <select name="description" class="form-select">
                                        <option value="Phòng đơn">Phòng đơn</option>
                                        <option value="Phòng đôi">Phòng đôi</option>
                                        <option value="Phòng ba">Phòng ba</option>
                                    </select>
                                </div>

                                <div class="col-12 text-center mt-5">
                                    <button type="submit" class="btn btn-submit shadow-sm w-100 mb-3">
                                        <i class="bi bi-plus-circle me-2"></i> XÁC NHẬN THÊM PHÒNG
                                    </button>
                                    <a href="RoomController" class="text-decoration-none small text-muted">
                                        <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách phòng
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
