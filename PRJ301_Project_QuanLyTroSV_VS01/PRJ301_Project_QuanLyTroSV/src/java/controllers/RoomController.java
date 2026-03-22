package controllers;

import dal.RoomDAO;
import models.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class RoomController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        RoomDAO dao = new RoomDAO();

        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("/views/room-add.jsp").forward(request, response);
                break;

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Room room = dao.getById(id);
                if (room == null) {
                    response.sendRedirect(request.getContextPath() + "/RoomController");
                    return;
                }
                request.setAttribute("room", room);
                request.getRequestDispatcher("/views/room-edit.jsp").forward(request, response);
                break;

            case "delete":
                try {
                    dao.delete(Integer.parseInt(request.getParameter("id")));
                } catch (NumberFormatException ignored) { }
                response.sendRedirect(request.getContextPath() + "/RoomController");
                break;

            default:
                List<Room> list = dao.getAll();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/views/room.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        RoomDAO dao = new RoomDAO();

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/RoomController");
            return;
        }

        String number = request.getParameter("roomNumber");
        double price = Double.parseDouble(request.getParameter("price"));
        String status = request.getParameter("status");
        String des = request.getParameter("description");

        if (action.equals("add")) {
            dao.insert(new Room(0, number, price, status, des));
        }

        if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.update(new Room(id, number, price, status, des));
        }

        response.sendRedirect(request.getContextPath() + "/RoomController");
    }
}