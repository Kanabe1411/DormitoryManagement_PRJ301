package controllers;
import dal.PaymentDAO;
import dal.ContractDAO;
import models.Payment;
import models.Contract;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            String id = req.getParameter("id");
            if (id != null && !id.isBlank()) {
                try {
                    new PaymentDAO().delete(Integer.parseInt(id));
                } catch (NumberFormatException ignored) { }
            }
            res.sendRedirect(req.getContextPath() + "/PaymentController");
            return;
        }
        if ("export".equals(action)) {
            exportReport(req, res);
            return;
        }
        List<Payment> list = new PaymentDAO().getAll();
        String role = (String) req.getSession().getAttribute("role");
        Object acc = req.getSession().getAttribute("account");
        if ("STUDENT".equals(role) && acc instanceof models.Account) {
            int userId = ((models.Account) acc).getId();
            List<Contract> myContracts = new ContractDAO().getByUserId(userId);
            java.util.Set<Integer> myContractIds = new java.util.HashSet<>();
            for (Contract c : myContracts) myContractIds.add(c.getId());
            list = list.stream().filter(p -> p.getContractId() != null && myContractIds.contains(p.getContractId())).collect(Collectors.toList());
        }
        req.setAttribute("list", list);
        req.setAttribute("contracts", new ContractDAO().getAll());
        req.setAttribute("canAdd", Boolean.valueOf("ADMIN".equals(role) || "LANDLORD".equals(role)));
        req.getRequestDispatcher("/views/payment.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            String contractIdStr = req.getParameter("contractId");
            String dateStr = req.getParameter("date");
            String amountStr = req.getParameter("amount");
            String paymentType = req.getParameter("paymentType");
            if (contractIdStr != null && !contractIdStr.isBlank()
                    && dateStr != null && !dateStr.isBlank()
                    && amountStr != null && !amountStr.isBlank()) {
                Integer contractId = Integer.parseInt(contractIdStr);
                Payment p = new Payment();
                p.setContractId(contractId);
                p.setContractIdStr(contractIdStr);
                p.setDate(Date.valueOf(dateStr));
                p.setAmount(Double.parseDouble(amountStr));
                p.setStatus(req.getParameter("status"));
                p.setPaymentType(paymentType != null ? paymentType : "Tiền trọ");
                p.setDescription(req.getParameter("description"));
                new PaymentDAO().insert(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        res.sendRedirect(req.getContextPath() + "/PaymentController");
    }

    private void exportReport(HttpServletRequest req, HttpServletResponse res) throws IOException {
        List<Payment> list = new PaymentDAO().getAll();
        res.setContentType("text/csv;charset=UTF-8");
        res.setHeader("Content-Disposition", "attachment; filename=\"bao-cao-thanh-toan.csv\"");
        PrintWriter out = res.getWriter();
        out.print("\uFEFF");
        out.println("ID,Hợp đồng,Ngày,Số tiền,Loại,Trạng thái");
        for (Payment p : list) {
            out.printf("%d,%s,%s,%.0f,%s,%s%n",
                    p.getId(),
                    p.getContractIdStr(),
                    p.getDate(),
                    p.getAmount(),
                    p.getPaymentType() != null ? p.getPaymentType() : "Tiền trọ",
                    p.getStatus());
        }
        out.flush();
    }
}
