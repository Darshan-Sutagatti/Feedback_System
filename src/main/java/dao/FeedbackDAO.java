package dao;

import java.sql.*;

public class FeedbackDAO {

    // ✅ ADD FEEDBACK
    public static boolean addFeedback(int sid, int tid, String review, int rating) {
        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO feedback (student_id, teacher_id, review, rating) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, sid);
            ps.setInt(2, tid);
            ps.setString(3, review);
            ps.setInt(4, rating);

            int rows = ps.executeUpdate();

            System.out.println("Inserted rows: " + rows); // debug

            return rows > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ DELETE FEEDBACK
    public static boolean deleteFeedback(int id, int sid) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM feedback WHERE id=? AND student_id=?"
            );

            ps.setInt(1, id);
            ps.setInt(2, sid);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ TEACHER VIEW FEEDBACK
    public static ResultSet getTeacherFeedback(int tid) throws Exception {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM feedback WHERE teacher_id=?"
        );

        ps.setInt(1, tid);
        return ps.executeQuery();
    }

    // ✅ STUDENT VIEW FEEDBACK (🔥 FIXED JOIN)
    public static ResultSet getStudentFeedback(int studentId) {
        ResultSet rs = null;
        try {
            Connection con = DBConnection.getConnection();

            String query =
                "SELECT f.id, f.review, f.rating, " +
                "u.username AS teacher_name, u.subject " +
                "FROM feedback f " +
                "JOIN users u ON f.teacher_id = u.id " +   // ✅ FIXED
                "WHERE f.student_id = ?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, studentId);

            rs = ps.executeQuery();

        } catch(Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    // ✅ ADMIN: ALL FEEDBACK
    public static ResultSet getAllFeedback(String search, String sort) throws Exception {

        Connection con = DBConnection.getConnection();

        String query =
        "SELECT u.username, u.subject, f.review, f.rating " +
        "FROM feedback f JOIN users u ON f.teacher_id = u.id ";

        // SEARCH
        if (search != null && !search.isEmpty()) {
            query += "WHERE f.review LIKE ? OR u.username LIKE ? OR u.subject LIKE ? ";
        }

        // SORT
        if (sort != null) {
            switch (sort) {
                case "name":
                    query += "ORDER BY u.username";
                    break;
                case "rating":
                    query += "ORDER BY f.rating DESC";
                    break;
                case "subject":
                    query += "ORDER BY u.subject";
                    break;
            }
        }

        PreparedStatement ps = con.prepareStatement(query);

        if (search != null && !search.isEmpty()) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
        }

        return ps.executeQuery();
    }

    // ✅ ADMIN: AVERAGE RATINGS
    public static ResultSet getAverageRatings() throws Exception {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT u.username, u.subject, AVG(f.rating) AS avg_rating " +
            "FROM feedback f JOIN users u ON f.teacher_id = u.id " +
            "GROUP BY u.id ORDER BY avg_rating DESC"
        );

        return ps.executeQuery();
    }
}