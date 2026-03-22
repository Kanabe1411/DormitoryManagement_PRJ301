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
import java.util.List;
import models.Account;
import models.UserInfo;

/**
 *
 * @author toanl
 */
public class AccountController extends HttpServlet {

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
            out.println("<title>Servlet AccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountController at " + request.getContextPath() + "</h1>");
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

        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();
        UserInfoDAO infoDAO = new UserInfoDAO();

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                request.getRequestDispatcher("/views/account-add.jsp").forward(request, response);
                break;

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Account a = dao.getById(id);
                if (a == null) {
                    response.sendRedirect(request.getContextPath() + "/AccountController");
                    return;
                }
                UserInfo info = infoDAO.getByUserId(id);
                request.setAttribute("info", info);
                request.setAttribute("acc", a);
                request.getRequestDispatcher("/views/account-edit.jsp").forward(request, response);
                break;

            case "delete":
                int did = Integer.parseInt(request.getParameter("id"));
                dao.delete(did);
                response.sendRedirect(request.getContextPath() + "/AccountController");
                break;

            default: // list
                List<Object[]> list = dao.getAllWithInfo();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/views/account.jsp").forward(request, response);
        }
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

        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/AccountController");
            return;
        }

        if (action.equals("add")) {
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            String role = request.getParameter("role");

            AccountDAO accDAO = new AccountDAO();
            UserInfoDAO infoDAO = new UserInfoDAO();

            accDAO.insert(new Account(0, user, pass, role));

            Account acc = accDAO.login(user, pass);
            if (acc == null) {
                response.sendRedirect(request.getContextPath() + "/AccountController");
                return;
            }

            String fullName = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            UserInfo info = new UserInfo();
            info.setUserId(acc.getId());
            info.setFullName(fullName);
            info.setPhone(phone);
            info.setEmail(email);
            info.setAddress(address);

            infoDAO.insert(info);
        }

        if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            String role = request.getParameter("role");

            UserInfoDAO infoDAO = new UserInfoDAO();

            String fullName = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            UserInfo info = new UserInfo();
            info.setUserId(id);
            info.setFullName(fullName);
            info.setPhone(phone);
            info.setEmail(email);
            info.setAddress(address);

            infoDAO.update(info);
        }

        response.sendRedirect(request.getContextPath() + "/AccountController");
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
