package dal;

import models.Service;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO extends DBContext {

    public List<Service> getAll() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Services ORDER BY name";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Service(
                        rs.getInt("id"),
                        rs.getNString("name"),
                        rs.getDouble("price"),
                        rs.getNString("unit"),
                        rs.getNString("description")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Service getById(int id) {
        String sql = "SELECT * FROM Services WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Service(
                        rs.getInt("id"),
                        rs.getNString("name"),
                        rs.getDouble("price"),
                        rs.getNString("unit"),
                        rs.getNString("description")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(Service s) {
        String sql = "INSERT INTO Services(name, price, unit, description) VALUES (?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, s.getName());
            ps.setDouble(2, s.getPrice());
            ps.setNString(3, s.getUnit() != null ? s.getUnit() : "Tháng");
            ps.setNString(4, s.getDescription());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Service s) {
        String sql = "UPDATE Services SET name=?, price=?, unit=?, description=? WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, s.getName());
            ps.setDouble(2, s.getPrice());
            ps.setNString(3, s.getUnit() != null ? s.getUnit() : "Tháng");
            ps.setNString(4, s.getDescription());
            ps.setInt(5, s.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try {
            PreparedStatement ps = connection.prepareStatement("DELETE FROM RoomService WHERE serviceId=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            ps = connection.prepareStatement("DELETE FROM Services WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Service> getByRoomId(int roomId) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT s.* FROM Services s INNER JOIN RoomService rs ON s.id = rs.serviceId WHERE rs.roomId = ? ORDER BY s.name";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Service(
                        rs.getInt("id"),
                        rs.getNString("name"),
                        rs.getDouble("price"),
                        rs.getNString("unit"),
                        rs.getNString("description")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void assignToRoom(int roomId, int serviceId) {
        String sql = "INSERT INTO RoomService(roomId, serviceId) VALUES (?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, serviceId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void unassignFromRoom(int roomId, int serviceId) {
        String sql = "DELETE FROM RoomService WHERE roomId=? AND serviceId=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, serviceId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public double getTotalServicePriceByRoom(int roomId) {
        String sql = "SELECT ISNULL(SUM(s.price), 0) FROM Services s INNER JOIN RoomService rs ON s.id = rs.serviceId WHERE rs.roomId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
