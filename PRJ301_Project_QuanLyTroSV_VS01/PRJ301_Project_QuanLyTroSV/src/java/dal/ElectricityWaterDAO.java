package dal;

import models.ElectricityWater;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ElectricityWaterDAO extends DBContext {

    public List<ElectricityWater> getAll() {
        List<ElectricityWater> list = new ArrayList<>();
        String sql = "SELECT ew.*, r.roomNumber FROM ElectricityWater ew INNER JOIN Rooms r ON ew.roomId = r.id ORDER BY ew.year DESC, ew.month DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ElectricityWater ew = mapRow(rs);
                ew.setRoomNumber(rs.getNString("roomNumber"));
                list.add(ew);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<ElectricityWater> getByRoomId(int roomId) {
        List<ElectricityWater> list = new ArrayList<>();
        String sql = "SELECT ew.*, r.roomNumber FROM ElectricityWater ew INNER JOIN Rooms r ON ew.roomId = r.id WHERE ew.roomId = ? ORDER BY ew.year DESC, ew.month DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ElectricityWater ew = mapRow(rs);
                ew.setRoomNumber(rs.getNString("roomNumber"));
                list.add(ew);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public ElectricityWater getById(int id) {
        String sql = "SELECT ew.*, r.roomNumber FROM ElectricityWater ew INNER JOIN Rooms r ON ew.roomId = r.id WHERE ew.id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ElectricityWater ew = mapRow(rs);
                ew.setRoomNumber(rs.getNString("roomNumber"));
                return ew;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public ElectricityWater getByRoomMonthYear(int roomId, int month, int year) {
        String sql = "SELECT * FROM ElectricityWater WHERE roomId=? AND month=? AND year=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public ElectricityWater getPreviousReading(int roomId, int month, int year) {
        String sql = "SELECT TOP 1 * FROM ElectricityWater WHERE roomId=? AND (year < ? OR (year = ? AND month < ?)) ORDER BY year DESC, month DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, year);
            ps.setInt(3, year);
            ps.setInt(4, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(ElectricityWater ew) {
        String sql = "INSERT INTO ElectricityWater(roomId, month, year, electricPrevious, electricCurrent, waterPrevious, waterCurrent, electricUnitPrice, waterUnitPrice) VALUES (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, ew.getRoomId());
            ps.setInt(2, ew.getMonth());
            ps.setInt(3, ew.getYear());
            ps.setInt(4, ew.getElectricPrevious());
            ps.setInt(5, ew.getElectricCurrent());
            ps.setInt(6, ew.getWaterPrevious());
            ps.setInt(7, ew.getWaterCurrent());
            ps.setDouble(8, ew.getElectricUnitPrice());
            ps.setDouble(9, ew.getWaterUnitPrice());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(ElectricityWater ew) {
        String sql = "UPDATE ElectricityWater SET electricPrevious=?, electricCurrent=?, waterPrevious=?, waterCurrent=?, electricUnitPrice=?, waterUnitPrice=? WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, ew.getElectricPrevious());
            ps.setInt(2, ew.getElectricCurrent());
            ps.setInt(3, ew.getWaterPrevious());
            ps.setInt(4, ew.getWaterCurrent());
            ps.setDouble(5, ew.getElectricUnitPrice());
            ps.setDouble(6, ew.getWaterUnitPrice());
            ps.setInt(7, ew.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        String sql = "DELETE FROM ElectricityWater WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private ElectricityWater mapRow(ResultSet rs) throws SQLException {
        return new ElectricityWater(
                rs.getInt("id"),
                rs.getInt("roomId"),
                rs.getInt("month"),
                rs.getInt("year"),
                rs.getInt("electricPrevious"),
                rs.getInt("electricCurrent"),
                rs.getInt("waterPrevious"),
                rs.getInt("waterCurrent"),
                rs.getDouble("electricUnitPrice"),
                rs.getDouble("waterUnitPrice"),
                rs.getTimestamp("createdAt")
        );
    }
}
