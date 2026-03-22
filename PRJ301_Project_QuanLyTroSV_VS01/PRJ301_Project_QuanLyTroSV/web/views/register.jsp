<%-- 
    Document   : register
    Created on : Mar 22, 2026, 4:25:25 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
Chào Kana, tôi đã ghi nhớ kỹ: chúng ta đang xây dựng Dormitory Management System (Hệ thống Quản lý Trọ).

Trang Đăng ký (Register) là "cánh cửa" đầu tiên để cư dân hoặc chủ trọ tiềm năng tiếp cận hệ thống. Với tư cách là cố vấn chiến lược, tôi sẽ thiết kế trang này theo phong cách Account Portal — sạch sẽ, tập trung và tạo cảm giác an tâm khi người dùng nhập thông tin cá nhân.

Tôi đã loại bỏ bảng (<table>) và thay bằng hệ thống Grid của Bootstrap để đảm bảo tính hiện đại và dễ sử dụng trên điện thoại.

📄 Mã nguồn JSP Đăng Ký (Format Professional Portal)
Bạn hãy thay thế toàn bộ mã nguồn cũ bằng bản thiết kế chuẩn mực dưới đây:

Java
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký Thành viên | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            body { 
                font-family: 'Inter', sans-serif; 
                background: linear-gradient(135deg, #f8f9fc 0%, #e2e8f0 100%); 
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            .register-container { margin-top: 50px; margin-bottom: 50px; }
            .card { border: none; border-radius: 20px; }
            .card-header { 
                background: #2c3e50; 
                color: white; 
                border-radius: 20px 20px 0 0 !important;
                padding: 30px;
            }
            .brand-logo { color: #e67e22; font-size: 1.5rem; font-weight: 800; }
            .form-label { font-weight: 600; font-size: 0.85rem; color: #4a5568; }
            .form-control { 
                padding: 10px 15px; 
                border-radius: 10px; 
                border: 1px solid #cbd5e0;
                transition: all 0.2s;
            }
            .form-control:focus {
                border-color: #e67e22;
                box-shadow: 0 0 0 0.25rem rgba(230, 126, 34, 0.1);
            }
            .btn-register { 
                background-color: #e67e22; 
                border: none; 
                padding: 12px; 
                border-radius: 10px; 
                font-weight: 700;
                transition: transform 0.2s;
            }
            .btn-register:hover { background-color: #d35400; transform: translateY(-2px); }
            .input-group-text { background: transparent; border-right: none; color: #a0aec0; }
            .has-icon .form-control { border-left: none; }
        </style>
    </head>
    <body>
        <%-- Nếu trang Register nằm trong app thì include, nếu là trang ngoài thì có thể bỏ qua --%>
        <%-- <jsp:include page="header.jsp" /> --%>

        <div class="container register-container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-md-10">
                    <div class="card shadow-lg">
                        <div class="card-header text-center">
                            <div class="brand-logo mb-2">
                                <i class="bi bi-house-door-fill"></i> DORMITORY
                            </div>
                            <h4 class="fw-bold mb-0">Tạo tài khoản mới</h4>
                            <p class="small opacity-75 mb-0">Tham gia cộng đồng quản lý trọ thông minh</p>
                        </div>
                        
                        <div class="card-body p-4 p-md-5">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger border-0 shadow-sm small py-2 mb-4">
                                    <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                                </div>
                            </c:if>
                            <c:if test="${not empty success}">
                                <div class="alert alert-success border-0 shadow-sm small py-2 mb-4">
                                    <i class="bi bi-check-circle-fill me-2"></i> ${success}
                                </div>
                            </c:if>

                            <form action="Register" method="post" class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                                    <div class="input-group has-icon">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text" name="username" class="form-control" placeholder="Ví dụ: kana123" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <div class="input-group has-icon">
                                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                        <input type="email" name="email" class="form-control" placeholder="name@gmail.com">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                    <div class="input-group has-icon">
                                        <span class="input-group-text"><i class="bi bi-key"></i></span>
                                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                    <div class="input-group has-icon">
                                        <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                                        <input type="password" name="repassword" class="form-control" placeholder="••••••••" required>
                                    </div>
                                </div>

                                <hr class="my-4 opacity-25">

                                <div class="col-md-7">
                                    <label class="form-label">Họ và tên</label>
                                    <input type="text" name="fullname" class="form-control" placeholder="Nguyễn Văn A">
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" name="phone" class="form-control" placeholder="0123 456 789">
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Địa chỉ thường trú</label>
                                    <input type="text" name="address" class="form-control" placeholder="Số nhà, đường, quận/huyện...">
                                </div>

                                <div class="col-12 mt-5">
                                    <button type="submit" class="btn btn-register btn-primary w-100 text-white mb-3">
                                        ĐĂNG KÝ NGAY
                                    </button>
                                    <div class="text-center">
                                        <span class="small text-muted">Đã có tài khoản?</span>
                                        <a href="index.jsp" class="small fw-bold text-decoration-none ms-1" style="color: #e67e22;">
                                            Đăng nhập tại đây
                                        </a>
                                    </div>
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
