package controllers;

import dal.NotificationDAO;
import dal.FeedbackDAO;
import dal.AccountDAO;
import models.Notification;
import models.Feedback;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ReportController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String role = (String) req.getSession().getAttribute("role");
        Integer userId = null;
        Object acc = req.getSession().getAttribute("account");
        if (acc instanceof models.Account) {
            userId = ((models.Account) acc).getId();
        }

        NotificationDAO nDao = new NotificationDAO();
        FeedbackDAO fDao = new FeedbackDAO();
        AccountDAO aDao = new AccountDAO();

        if (action == null) action = "dashboard";

        switch (action) {
            case "notify":
                if ("ADMIN".equals(role) || "LANDLORD".equals(role)) {
                    req.setAttribute("users", aDao.getAll());
                    req.getRequestDispatcher("/views/report-notify.jsp").forward(req, res);
                } else {
                    res.sendRedirect(req.getContextPath() + "/ReportController");
                }
                break;

            case "feedback":
                if ("ADMIN".equals(role) || "LANDLORD".equals(role)) {
                    req.setAttribute("list", fDao.getAll());
                    req.getRequestDispatcher("/views/report-feedback.jsp").forward(req, res);
                } else {
                    req.setAttribute("list", userId != null ? fDao.getByUserId(userId) : List.of());
                    req.getRequestDispatcher("/views/report-feedback-my.jsp").forward(req, res);
                }
                break;

            case "support":
                dal.ContractDAO cDao = new dal.ContractDAO();
                req.setAttribute("contracts", (userId != null && "STUDENT".equals(role)) ? cDao.getByUserId(userId) : cDao.getAll());
                req.getRequestDispatcher("/views/report-support.jsp").forward(req, res);
                break;

            case "notifications":
                req.setAttribute("list", userId != null ? nDao.getByUserId(userId) : nDao.getAll());
                req.getRequestDispatcher("/views/report-notifications.jsp").forward(req, res);
                break;

            case "respond":
                if ("ADMIN".equals(role) || "LANDLORD".equals(role)) {
                    try {
                        int id = Integer.parseInt(req.getParameter("id"));
                        Feedback fb = fDao.getById(id);
                        if (fb != null) {
                            req.setAttribute("feedback", fb);
                            req.getRequestDispatcher("/views/report-respond.jsp").forward(req, res);
                            return;
                        }
                    } catch (NumberFormatException ignored) {}
                }
                res.sendRedirect(req.getContextPath() + "/ReportController?action=feedback");
                break;

            default:
                req.setAttribute("notifications", userId != null ? nDao.getByUserId(userId) : nDao.getAll());
                req.getRequestDispatcher("/views/report.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String role = (String) req.getSession().getAttribute("role");

        if ("sendNotify".equals(action) && ("ADMIN".equals(role) || "LANDLORD".equals(role))) {
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            String uid = req.getParameter("userId");
            Integer userId = (uid == null || uid.isBlank()) ? null : Integer.parseInt(uid);
            Notification n = new Notification(0, title, content, userId, null, false);
            new NotificationDAO().insert(n);
            res.sendRedirect(req.getContextPath() + "/ReportController?action=notifications");
            return;
        }

        if ("sendFeedback".equals(action)) {
            Object accObj = req.getSession().getAttribute("account");
            if (!(accObj instanceof models.Account)) {
                res.sendRedirect(req.getContextPath() + "/Login");
                return;
            }
            int userId = ((models.Account) accObj).getId();
            String type = req.getParameter("type");
            String subject = req.getParameter("subject");
            String content = req.getParameter("content");
            String cid = req.getParameter("contractId");
            Integer contractId = (cid == null || cid.isBlank()) ? null : Integer.parseInt(cid);

            Feedback f = new Feedback();
            f.setUserId(userId);
            f.setContractId(contractId);
            f.setType(type != null ? type : "Hỗ trợ");
            f.setSubject(subject);
            f.setContent(content);
            f.setStatus("Chờ xử lý");
            new FeedbackDAO().insert(f);
            res.sendRedirect(req.getContextPath() + "/ReportController?action=feedback");
            return;
        }

        if ("respond".equals(action) && ("ADMIN".equals(role) || "LANDLORD".equals(role))) {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            String response = req.getParameter("response");
            new FeedbackDAO().updateStatus(id, status, response);
            res.sendRedirect(req.getContextPath() + "/ReportController?action=feedback");
            return;
        }

        res.sendRedirect(req.getContextPath() + "/ReportController");
    }
}
