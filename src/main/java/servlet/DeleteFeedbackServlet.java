package servlet;

import dao.FeedbackDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteFeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int sid = (int) req.getSession().getAttribute("id");
        int fid = Integer.parseInt(req.getParameter("id"));

        boolean ok = FeedbackDAO.deleteFeedback(fid, sid);

        if (ok) {
            res.sendRedirect("student.jsp?msg=Feedback Deleted Successfully");
        } else {
            res.sendRedirect("student.jsp?error=Delete Failed");
        }
    }
}