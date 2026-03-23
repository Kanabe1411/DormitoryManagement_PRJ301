<%-- 
    Document   : header
    Created on : Feb 24, 2026, 4:30:54 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .site-header {
        background-color: #ffffff;
        border-bottom: 1px solid #dee2e6;
        padding: 12px 0;
    }
    .site-header__brand {
        font-weight: 800;
        color: #2c3e50;
        letter-spacing: -0.3px;
    }
    .site-header__subtitle {
        color: #6c757d;
        font-size: 0.9rem;
        margin-left: 12px;
    }
</style>

<header class="site-header">
    <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <span class="site-header__brand">
                <i class="bi bi-house-heart-fill me-2"></i>Dormitory Management System
            </span>
            <span class="site-header__subtitle d-none d-md-inline">Quản lý trọ sinh viên</span>
        </div>
        <div class="text-muted small d-none d-md-block">
            <i class="bi bi-shield-check me-1"></i>Vận hành ổn định
        </div>
    </div>
    </header>