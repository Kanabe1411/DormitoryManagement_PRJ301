<%-- 
    Document   : electricity-water-edit
    Sửa chỉ số điện nước
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa Chỉ số Điện Nước | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
            .card-header { background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color: white; border-radius: 15px 15px 0 0 !important; padding: 20px; }
            .form-label { font-weight: 600; font-size: 0.9rem; color: #2c3e50; }
            .form-control { border-radius: 10px; padding: 10px 15px; border: 1px solid #d1d3e2; }
            .btn-update { background-color: #e67e22; border: none; padding: 12px 40px; border-radius: 10px; font-weight: 700; color: white; transition: all 0.3s; }
            .btn-update:hover { background-color: #d35400; transform: translateY(-2px); }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow-lg">
                        <div class="card-header text-center">
                            <i class="bi bi-pencil-square fs-1 mb-2"></i>
                            <h3 class="fw-bold mb-0">Sửa Chỉ số Điện Nước</h3>
                            <span class="badge bg-light text-dark mt-2">Phòng ${ew.roomNumber} - ${ew.month}/${ew.year}</span>
                        </div>
                        <div class="card-body p-4 p-md-5">
                            <form action="ElectricityWaterController" method="post" class="row g-4">
                                <input type="hidden" name="action" value="edit"/>
                                <input type="hidden" name="id" value="${ew.id}"/>

                                <div class="col-md-6">
                                    <label class="form-label">Điện kỳ trước</label>
                                    <input type="number" name="electricPrevious" class="form-control" value="${ew.electricPrevious}" min="0" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Điện kỳ này</label>
                                    <input type="number" name="electricCurrent" class="form-control" value="${ew.electricCurrent}" min="0" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Nước kỳ trước (m³)</label>
                                    <input type="number" name="waterPrevious" class="form-control" value="${ew.waterPrevious}" min="0" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Nước kỳ này (m³)</label>
                                    <input type="number" name="waterCurrent" class="form-control" value="${ew.waterCurrent}" min="0" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Đơn giá điện (VNĐ/kWh)</label>
                                    <input type="number" name="electricUnitPrice" class="form-control" value="${ew.electricUnitPrice}" min="0" step="100">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Đơn giá nước (VNĐ/m³)</label>
                                    <input type="number" name="waterUnitPrice" class="form-control" value="${ew.waterUnitPrice}" min="0" step="1000">
                                </div>

                                <div class="col-12 text-center mt-5">
                                    <button type="submit" class="btn btn-update shadow-sm w-100 mb-3">
                                        <i class="bi bi-save me-2"></i> LƯU THAY ĐỔI
                                    </button>
                                    <a href="ElectricityWaterController" class="text-decoration-none small text-muted"><i class="bi bi-arrow-left me-1"></i> Quay lại</a>
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
