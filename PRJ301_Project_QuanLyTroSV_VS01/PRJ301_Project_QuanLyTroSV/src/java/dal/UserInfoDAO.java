/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.UserInfo;
import java.sql.*;

/**
 *
 * @author toanl
 */
public class UserInfoDAO extends DBContext {

    public void insert(UserInfo u) {
        String sql = "INSERT INTO UserInfo(userId, fullName, phone, email, address) VALUES (?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, u.getUserId());
            ps.setString(2, u.getFullName());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getAddress());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(UserInfo u) {
        String sql = "UPDATE UserInfo SET fullName=?, phone=?, email=?, address=? WHERE userId=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getPhone());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getAddress());
            ps.setInt(5, u.getUserId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public UserInfo getByUserId(int userId) {
        String sql = "SELECT * FROM UserInfo WHERE userId=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserInfo u = new UserInfo();
                u.setUserId(userId);
                u.setFullName(rs.getString("fullName"));
                u.setPhone(rs.getString("phone"));
                u.setEmail(rs.getString("email"));
                u.setAddress(rs.getString("address"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
