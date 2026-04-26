package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

//@WebServlet("/ViewFeedbackServlet")
public class ViewFeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String[]> feedbackList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/your_db_name", "root", "password");

            String query = "SELECT t.name, t.subject, f.feedback " +
                           "FROM feedback f " +
                           "JOIN teacher t ON f.teacher_id = t.id";

            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String subject = rs.getString("subject");
                String feedback = rs.getString("feedback");

                feedbackList.add(new String[]{name, subject, feedback});
            }

            request.setAttribute("feedbackList", feedbackList);
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("student.jsp").forward(request, response);
    }
}