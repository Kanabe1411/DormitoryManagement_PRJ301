/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.AccountDAO;
import dal.UserInfoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Account;
import models.UserInfo;

/**
 *
 * @author toanl
 */
public class Register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String repass = request.getParameter("repassword");
        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        AccountDAO dao = new AccountDAO();
        UserInfoDAO infoDAO = new UserInfoDAO();

        // kiểm tra
        if (!pass.equals(repass)) {
            request.setAttribute("error", "Mật khẩu không khớp");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (dao.checkExist(user)) {
            request.setAttribute("error", "Username đã tồn tại");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        dao.register(user, pass);
        Account acc = dao.login(user, pass);
        if (acc == null) {
            request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        UserInfo info = new UserInfo();
        info.setUserId(acc.getId());
        info.setFullName(fullName);
        info.setPhone(phone);
        info.setEmail(email);
        info.setAddress(address);

        infoDAO.insert(info);

        request.setAttribute("success", "Đăng ký thành công!");
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
