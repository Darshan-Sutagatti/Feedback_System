package servlet;

import dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddTeacherServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        boolean ok = UserDAO.register(
            req.getParameter("username"),
            req.getParameter("password"),
            "teacher",
            null,
            req.getParameter("subject")
        );

        res.sendRedirect("admin.jsp?msg=" + (ok ? "Added" : "Error"));
    }
}