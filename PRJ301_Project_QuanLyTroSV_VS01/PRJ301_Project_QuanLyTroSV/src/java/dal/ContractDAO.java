package dal;

import java.sql.*;
import java.util.*;
import models.Contract;

public class ContractDAO extends DBContext {

    // Lấy tất cả
    public List<Contract> getAll() {
        List<Contract> list = new ArrayList<>();
        String sql = "SELECT * FROM Contracts";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Contract(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("roomId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("status"),
                        rs.getTimestamp("createdAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm hợp đồng
    public void insert(Contract c) {
        String sql = "INSERT INTO Contracts(userId, roomId, startDate, endDate, status) VALUES(?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getUserId());
            ps.setInt(2, c.getRoomId());
            ps.setDate(3, c.getStartDate());
            ps.setDate(4, c.getEndDate());
            ps.setString(5, "Còn hạn");
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Gia hạn
    public void extend(int id, java.sql.Date newEndDate) {
        String sql = "UPDATE Contracts SET endDate=?, status=N'Còn hạn' WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, newEndDate);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Thanh lý
    public void cancel(int id) {
        String sql = "UPDATE Contracts SET status=N'Hủy hợp đồng' WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Contract> getByUserId(int userId) {
        List<Contract> list = new ArrayList<>();
        String sql = "SELECT * FROM Contracts WHERE userId=? ORDER BY createdAt DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Contract(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("roomId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("status"),
                        rs.getTimestamp("createdAt")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Contract getById(int id) {
        String sql = "SELECT * FROM Contracts WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Contract(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("roomId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("status"),
                        rs.getTimestamp("createdAt")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
