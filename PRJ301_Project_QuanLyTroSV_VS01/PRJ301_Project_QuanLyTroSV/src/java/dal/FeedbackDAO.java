package dal;

import models.Feedback;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {

    public List<Feedback> getAll() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, uf.fullName FROM Feedback f LEFT JOIN UserInfo uf ON f.userId = uf.userId ORDER BY f.createdAt DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = mapRow(rs);
                fb.setFullName(rs.getNString("fullName"));
                list.add(fb);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Feedback> getByUserId(int userId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, uf.fullName FROM Feedback f LEFT JOIN UserInfo uf ON f.userId = uf.userId WHERE f.userId = ? ORDER BY f.createdAt DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = mapRow(rs);
                fb.setFullName(rs.getNString("fullName"));
                list.add(fb);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Feedback getById(int id) {
        String sql = "SELECT f.*, uf.fullName FROM Feedback f LEFT JOIN UserInfo uf ON f.userId = uf.userId WHERE f.id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Feedback fb = mapRow(rs);
                fb.setFullName(rs.getNString("fullName"));
                return fb;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(Feedback f) {
        String sql = "INSERT INTO Feedback(userId, contractId, type, subject, content, status) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, f.getUserId());
            ps.setObject(2, f.getContractId());
            ps.setNString(3, f.getType());
            ps.setNString(4, f.getSubject());
            ps.setNString(5, f.getContent());
            ps.setNString(6, f.getStatus() != null ? f.getStatus() : "Chờ xử lý");
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void updateStatus(int id, String status, String response) {
        String sql = "UPDATE Feedback SET status=?, response=?, respondedAt=GETDATE() WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, status);
            ps.setNString(2, response);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private Feedback mapRow(ResultSet rs) throws SQLException {
        Feedback f = new Feedback();
        f.setId(rs.getInt("id"));
        f.setUserId(rs.getInt("userId"));
        f.setContractId(rs.getObject("contractId") != null ? rs.getInt("contractId") : null);
        f.setType(rs.getNString("type"));
        f.setSubject(rs.getNString("subject"));
        f.setContent(rs.getNString("content"));
        f.setStatus(rs.getNString("status"));
        f.setCreatedAt(rs.getTimestamp("createdAt"));
        f.setResponse(rs.getNString("response"));
        f.setRespondedAt(rs.getTimestamp("respondedAt"));
        return f;
    }
}
