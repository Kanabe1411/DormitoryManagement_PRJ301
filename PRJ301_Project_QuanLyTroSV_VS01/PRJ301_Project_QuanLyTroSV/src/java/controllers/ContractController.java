package controllers;

import dal.ContractDAO;
import dal.RoomDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import models.Contract;
import models.Room;

public class ContractController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("create".equals(action)) {
            request.getRequestDispatcher("/views/contract-create.jsp").forward(request, response);
            return;
        }

        ContractDAO dao = new ContractDAO();
        request.setAttribute("list", dao.getAll());
        request.getRequestDispatcher("/views/contract.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ContractDAO dao = new ContractDAO();
        RoomDAO roomDAO = new RoomDAO();

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/ContractController");
            return;
        }

        if ("create".equals(action)) {

            int userId = Integer.parseInt(request.getParameter("userId"));
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            Date start = Date.valueOf(request.getParameter("startDate"));
            Date end = Date.valueOf(request.getParameter("endDate"));

            Room room = roomDAO.getById(roomId);
            if (room == null) {
                request.setAttribute("error", "Không tìm thấy phòng.");
                request.getRequestDispatcher("/views/contract-create.jsp").forward(request, response);
                return;
            }
            if (!"Chưa thuê".equals(room.getStatus())) {
                request.setAttribute("error", "Phòng đã được thuê!");
                request.getRequestDispatcher("/views/contract-create.jsp").forward(request, response);
                return;
            }

            dao.insert(new Contract(0, userId, roomId, start, end, "Còn hạn", null));

            roomDAO.updateStatus(roomId, "Đã thuê");

            response.sendRedirect(request.getContextPath() + "/ContractController");
            return;

        } else if ("extend".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            Date end = Date.valueOf(request.getParameter("endDate"));

            dao.extend(id, end);

            response.sendRedirect(request.getContextPath() + "/ContractController");
            return;

        } else if ("cancel".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            Contract c = dao.getById(id);
            if (c != null) {
                dao.cancel(id);
                roomDAO.updateStatus(c.getRoomId(), "Chưa thuê");
            }

            response.sendRedirect(request.getContextPath() + "/ContractController");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/ContractController");
    }
}
