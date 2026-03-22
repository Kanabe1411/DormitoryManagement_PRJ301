package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Thiết lập mã hóa để hiển thị đúng tiếng Việt có dấu
        response.setContentType("text/html;charset=UTF-8");
        
        // Truyền thông điệp đúng với dự án
        request.setAttribute("message", "Chào mừng bạn đến với Hệ thống Quản lý Trọ Sinh viên");
        
        // Điều hướng tới trang giao diện Dashboard
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Trả về luồng doGet trong trường hợp có request POST nhầm tới đường dẫn này
        doGet(request, response);
    }
}