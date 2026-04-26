package dao;

import java.sql.*;

public class UserDAO {

    // 🔥 5-parameter register (IMPORTANT)
    public static boolean register(String username, String password, String role, String usn, String subject) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(username,password,role,usn,subject) VALUES(?,?,?,?,?)"
            );

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setString(4, usn);
            ps.setString(5, subject);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static ResultSet login(String u, String p, String r) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=? AND role=?"
            );

            ps.setString(1, u);
            ps.setString(2, p);
            ps.setString(3, r);

            return ps.executeQuery();

        } catch (Exception e) {
            return null;
        }
    }

    public static ResultSet getTeachers() throws Exception {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM users WHERE role='teacher'"
        );

        return ps.executeQuery();
    }

    public static boolean deleteTeacher(int id) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM users WHERE id=? AND role='teacher'"
            );

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            return false;
        }
    }
}