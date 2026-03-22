package controllers;

import dal.ServiceDAO;
import dal.RoomDAO;
import models.Service;
import models.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        ServiceDAO sDao = new ServiceDAO();
        RoomDAO rDao = new RoomDAO();

        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/views/service-add.jsp").forward(req, res);
                break;

            case "edit":
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Service s = sDao.getById(id);
                    if (s == null) {
                        res.sendRedirect(req.getContextPath() + "/ServiceController");
                        return;
                    }
                    req.setAttribute("service", s);
                    req.getRequestDispatcher("/views/service-edit.jsp").forward(req, res);
                } catch (NumberFormatException e) {
                    res.sendRedirect(req.getContextPath() + "/ServiceController");
                }
                break;

            case "assign":
                try {
                    int roomId = Integer.parseInt(req.getParameter("roomId"));
                    Room room = rDao.getById(roomId);
                    if (room == null) {
                        res.sendRedirect(req.getContextPath() + "/RoomController");
                        return;
                    }
                    List<Service> allServices = sDao.getAll();
                    List<Service> roomServices = sDao.getByRoomId(roomId);
                    req.setAttribute("room", room);
                    req.setAttribute("allServices", allServices);
                    req.setAttribute("roomServices", roomServices);
                    req.getRequestDispatcher("/views/service-assign.jsp").forward(req, res);
                } catch (NumberFormatException e) {
                    res.sendRedirect(req.getContextPath() + "/RoomController");
                }
                break;

            case "delete":
                try {
                    sDao.delete(Integer.parseInt(req.getParameter("id")));
                } catch (NumberFormatException ignored) {}
                res.sendRedirect(req.getContextPath() + "/ServiceController");
                break;

            default:
                List<Service> list = sDao.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/views/service.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        ServiceDAO dao = new ServiceDAO();

        if (action == null) {
            res.sendRedirect(req.getContextPath() + "/ServiceController");
            return;
        }

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            String unit = req.getParameter("unit");
            String desc = req.getParameter("description");
            dao.insert(new Service(0, name, price, unit, desc));
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            String unit = req.getParameter("unit");
            String desc = req.getParameter("description");
            dao.update(new Service(id, name, price, unit, desc));
        } else if ("assign".equals(action)) {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int serviceId = Integer.parseInt(req.getParameter("serviceId"));
            dao.assignToRoom(roomId, serviceId);
            res.sendRedirect(req.getContextPath() + "/ServiceController?action=assign&roomId=" + roomId);
            return;
        } else if ("unassign".equals(action)) {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int serviceId = Integer.parseInt(req.getParameter("serviceId"));
            dao.unassignFromRoom(roomId, serviceId);
            res.sendRedirect(req.getContextPath() + "/ServiceController?action=assign&roomId=" + roomId);
            return;
        }

        res.sendRedirect(req.getContextPath() + "/ServiceController");
    }
}
