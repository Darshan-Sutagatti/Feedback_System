package servlet;

import dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        boolean ok = UserDAO.register(
            req.getParameter("username").trim(),
            req.getParameter("password").trim(),
            "student",
            req.getParameter("usn").trim(),
            null
        );

        if (ok) {
            res.sendRedirect("login.jsp?msg=Registered Successfully");
        } else {
            res.sendRedirect("register.jsp?error=Username already exists");
        }
    }
}