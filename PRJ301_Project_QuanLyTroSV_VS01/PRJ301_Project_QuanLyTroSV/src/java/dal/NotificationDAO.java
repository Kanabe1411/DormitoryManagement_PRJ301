package dal;

import models.Notification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO extends DBContext {

    public List<Notification> getAll() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications ORDER BY createdAt DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Notification(
                        rs.getInt("id"),
                        rs.getNString("title"),
                        rs.getNString("content"),
                        rs.getObject("userId") != null ? rs.getInt("userId") : null,
                        rs.getTimestamp("createdAt"),
                        rs.getBoolean("isRead")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Notification> getByUserId(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications WHERE userId IS NULL OR userId = ? ORDER BY createdAt DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Notification(
                        rs.getInt("id"),
                        rs.getNString("title"),
                        rs.getNString("content"),
                        rs.getObject("userId") != null ? rs.getInt("userId") : null,
                        rs.getTimestamp("createdAt"),
                        rs.getBoolean("isRead")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void insert(Notification n) {
        String sql = "INSERT INTO Notifications(title, content, userId) VALUES (?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, n.getTitle());
            ps.setNString(2, n.getContent());
            ps.setObject(3, n.getUserId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void markRead(int id) {
        String sql = "UPDATE Notifications SET isRead=1 WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Notifications WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
