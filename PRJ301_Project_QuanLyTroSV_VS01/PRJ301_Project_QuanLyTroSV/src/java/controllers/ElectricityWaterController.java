package controllers;

import dal.ElectricityWaterDAO;
import dal.RoomDAO;
import models.ElectricityWater;
import models.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ElectricityWaterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        ElectricityWaterDAO ewDao = new ElectricityWaterDAO();
        RoomDAO rDao = new RoomDAO();

        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.setAttribute("rooms", rDao.getAll());
                req.getRequestDispatcher("/views/electricity-water-add.jsp").forward(req, res);
                break;

            case "edit":
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    ElectricityWater ew = ewDao.getById(id);
                    if (ew == null) {
                        res.sendRedirect(req.getContextPath() + "/ElectricityWaterController");
                        return;
                    }
                    req.setAttribute("ew", ew);
                    req.setAttribute("rooms", rDao.getAll());
                    req.getRequestDispatcher("/views/electricity-water-edit.jsp").forward(req, res);
                } catch (NumberFormatException e) {
                    res.sendRedirect(req.getContextPath() + "/ElectricityWaterController");
                }
                break;

            case "delete":
                try {
                    ewDao.delete(Integer.parseInt(req.getParameter("id")));
                } catch (NumberFormatException ignored) {}
                res.sendRedirect(req.getContextPath() + "/ElectricityWaterController");
                break;

            case "room":
                try {
                    int roomId = Integer.parseInt(req.getParameter("roomId"));
                    List<ElectricityWater> list = ewDao.getByRoomId(roomId);
                    Room room = rDao.getById(roomId);
                    req.setAttribute("list", list);
                    req.setAttribute("room", room);
                    req.getRequestDispatcher("/views/electricity-water-room.jsp").forward(req, res);
                } catch (NumberFormatException e) {
                    res.sendRedirect(req.getContextPath() + "/ElectricityWaterController");
                }
                break;

            default:
                req.setAttribute("list", ewDao.getAll());
                req.getRequestDispatcher("/views/electricity-water.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        ElectricityWaterDAO dao = new ElectricityWaterDAO();

        if (action == null) {
            res.sendRedirect(req.getContextPath() + "/ElectricityWaterController");
            return;
        }

        if ("add".equals(action)) {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int month = Integer.parseInt(req.getParameter("month"));
            int year = Integer.parseInt(req.getParameter("year"));
            int electricCurrent = Integer.parseInt(req.getParameter("electricCurrent"));
            int waterCurrent = Integer.parseInt(req.getParameter("waterCurrent"));
            double electricPrice = Double.parseDouble(req.getParameter("electricUnitPrice"));
            double waterPrice = Double.parseDouble(req.getParameter("waterUnitPrice"));

            ElectricityWater prev = dao.getPreviousReading(roomId, month, year);
            int electricPrev = prev != null ? prev.getElectricCurrent() : 0;
            int waterPrev = prev != null ? prev.getWaterCurrent() : 0;

            ElectricityWater ew = new ElectricityWater(0, roomId, month, year, electricPrev, electricCurrent, waterPrev, waterCurrent, electricPrice, waterPrice, null);
            dao.insert(ew);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int electricPrev = Integer.parseInt(req.getParameter("electricPrevious"));
            int electricCurr = Integer.parseInt(req.getParameter("electricCurrent"));
            int waterPrev = Integer.parseInt(req.getParameter("waterPrevious"));
            int waterCurr = Integer.parseInt(req.getParameter("waterCurrent"));
            double electricPrice = Double.parseDouble(req.getParameter("electricUnitPrice"));
            double waterPrice = Double.parseDouble(req.getParameter("waterUnitPrice"));

            ElectricityWater ew = dao.getById(id);
            if (ew != null) {
                ew.setElectricPrevious(electricPrev);
                ew.setElectricCurrent(electricCurr);
                ew.setWaterPrevious(waterPrev);
                ew.setWaterCurrent(waterCurr);
                ew.setElectricUnitPrice(electricPrice);
                ew.setWaterUnitPrice(waterPrice);
                dao.update(ew);
            }
        }

        res.sendRedirect(req.getContextPath() + "/ElectricityWaterController");
    }
}
