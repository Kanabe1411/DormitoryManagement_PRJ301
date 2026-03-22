/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

/**
 *
 * @author toanl
 */
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        // Cho phép login
        if (uri.contains("Login")
                || uri.contains("Register")
                || uri.contains("index.jsp")
                || uri.contains("error.jsp")) {

            chain.doFilter(request, response);
            return;
        }
        String ctx = req.getContextPath();

        // Chưa login
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(ctx + "/index.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (role == null) {
            res.sendRedirect(ctx + "/index.jsp");
            return;
        }

        // ADMIN có toàn quyền
        if ("ADMIN".equals(role)) {
            chain.doFilter(request, response);
            return;
        }

        // LANDLORD
        if ("LANDLORD".equals(role)) {

            // Không được quản lý user
            if (uri.contains("User")) {
                res.sendRedirect(ctx + "/error.jsp");
                return;
            }

            chain.doFilter(request, response);
            return;
        }

        // STUDENT — chặn một số controller (giữ thanh toán / phòng / hợp đồng theo menu)
        if ("STUDENT".equals(role)) {

            if (uri.contains("TenantController")
                    || uri.contains("DashboardController")) {

                res.sendRedirect(ctx + "/error.jsp");
                return;
            }

            chain.doFilter(request, response);
            return;

        }

        chain.doFilter(request, response);
    }
}
