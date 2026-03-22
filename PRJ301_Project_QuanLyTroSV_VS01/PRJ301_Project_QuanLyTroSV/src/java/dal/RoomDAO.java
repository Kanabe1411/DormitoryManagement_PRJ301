package dal;

import java.sql.*;
import java.util.*;
import models.Room;

public class RoomDAO extends DBContext {

    public List<Room> getAll() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM Rooms";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Room(
                        rs.getInt("id"),
                        rs.getString("roomNumber"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Room getById(int id) {
        String sql = "SELECT * FROM Rooms WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Room(
                        rs.getInt("id"),
                        rs.getString("roomNumber"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("description")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(Room r) {
        String sql = "INSERT INTO Rooms(roomNumber, price, status, description) VALUES (?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRoomNumber());
            ps.setDouble(2, r.getPrice());
            ps.setString(3, r.getStatus());
            ps.setString(4, r.getDescription());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Room r) {
        String sql = "UPDATE Rooms SET roomNumber=?, price=?, status=?, description=? WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRoomNumber());
            ps.setDouble(2, r.getPrice());
            ps.setString(3, r.getStatus());
            ps.setString(4, r.getDescription());
            ps.setInt(5, r.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Rooms WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateStatus(int roomId, String status) {
    String sql = "UPDATE Rooms SET status=? WHERE id=?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, roomId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
}