<%-- 
    Document   : room-edit
    Created on : Mar 22, 2026, 8:51:04 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa Thông Tin Phòng | Dormitory Management</title>
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
                background: linear-gradient(135deg, #2c3e50 0%, #000000 100%); 
                color: white; 
                border-radius: 15px 15px 0 0 !important;
                padding: 25px;
            }
            .form-label { font-weight: 600; font-size: 0.9rem; color: #2c3e50; }
            .form-control, .form-select { 
                border-radius: 10px; 
                padding: 12px; 
                border: 1px solid #d1d3e2;
            }
            .form-control:focus, .form-select:focus {
                border-color: #e67e22;
                box-shadow: 0 0 0 0.25rem rgba(230, 126, 34, 0.1);
            }
            .btn-update { 
                background-color: #e67e22; 
                border: none; 
                padding: 12px 40px; 
                border-radius: 10px; 
                font-weight: 700;
                color: white;
                transition: all 0.3s;
            }
            .btn-update:hover { 
                background-color: #d35400; 
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3);
            }
            .badge-id {
                background: rgba(255, 255, 255, 0.15);
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 0.8rem;
                letter-spacing: 1px;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card shadow-lg">
                        <div class="card-header text-center">
                            <i class="bi bi-pencil-square fs-1 mb-2"></i>
                            <h3 class="fw-bold mb-1">Chỉnh Sửa Phòng</h3>
                            <span class="badge-id">MÃ HỆ THỐNG: ${room.id}</span>
                        </div>
                        
                        <div class="card-body p-4 p-md-5">
                            <form action="RoomController" method="post" class="row g-4">
                                <input type="hidden" name="action" value="edit"/>
                                <input type="hidden" name="id" value="${room.id}"/>

                                <div class="col-md-6">
                                    <label class="form-label">Số phòng</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-hash text-primary"></i></span>
                                        <input type="text" name="roomNumber" class="form-control" value="${room.roomNumber}" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Giá thuê (VNĐ)</label>
                                    <div class="input-group">
                                        <input type="number" name="price" class="form-control" value="${room.price}" min="0" required>
                                        <span class="input-group-text bg-light">₫</span>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Tình trạng phòng</label>
                                    <select name="status" class="form-select">
                                        <option value="Chưa thuê" ${room.status == 'Chưa thuê' ? 'selected' : ''}>🟢 Chưa thuê (Trống)</option>
                                        <option value="Đã thuê" ${room.status == 'Đã thuê' ? 'selected' : ''}>🔴 Đã thuê</option>
                                    </select>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Loại phòng</label>
                                    <select name="description" class="form-select">
                                        <option value="Phòng đơn" ${room.description == 'Phòng đơn' ? 'selected' : ''}>Phòng đơn</option>
                                        <option value="Phòng đôi" ${room.description == 'Phòng đôi' ? 'selected' : ''}>Phòng đôi</option>
                                        <option value="Phòng ba" ${room.description == 'Phòng ba' ? 'selected' : ''}>Phòng ba</option>
                                    </select>
                                </div>

                                <div class="col-12 text-center mt-5">
                                    <button type="submit" class="btn btn-update shadow-sm w-100 mb-3">
                                        <i class="bi bi-save me-2"></i> LƯU THAY ĐỔI
                                    </button>
                                    <a href="RoomController" class="btn btn-link text-muted text-decoration-none small">
                                        <i class="bi bi-arrow-left me-1"></i> Hủy và quay lại danh sách
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
