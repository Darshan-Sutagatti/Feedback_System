package servlet;

import dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String u = req.getParameter("username").trim();
        String p = req.getParameter("password").trim();
        String r = req.getParameter("role").trim().toLowerCase(); // 🔥 fix

        try {
            ResultSet rs = UserDAO.login(u, p, r);

            if (rs != null && rs.next()) {

                HttpSession s = req.getSession();
                s.setAttribute("id", rs.getInt("id"));
                s.setAttribute("role", r);

                res.sendRedirect(r + ".jsp"); // admin.jsp / student.jsp / teacher.jsp

            } else {
                res.sendRedirect("login.jsp?error=Invalid Username or Password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp?error=Something went wrong");
        }
    }
}