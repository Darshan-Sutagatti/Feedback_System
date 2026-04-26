package servlet;

import dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

//@WebServlet("/DeleteTeacherServlet")
public class DeleteTeacherServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        boolean ok = UserDAO.deleteTeacher(id);

        if(ok)
            res.sendRedirect("admin.jsp?msg=Teacher Deleted Successfully");
        else
            res.sendRedirect("admin.jsp?error=Delete Failed");
    }
}