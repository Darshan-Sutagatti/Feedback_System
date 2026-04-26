package servlet;

import dao.FeedbackDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddFeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int sid = (int) req.getSession().getAttribute("id");
        int tid = Integer.parseInt(req.getParameter("teacher"));
        String review = req.getParameter("review").trim();
        int rating = Integer.parseInt(req.getParameter("rating"));

        boolean ok = FeedbackDAO.addFeedback(sid, tid, review, rating);

        if (!ok) {
            res.sendRedirect("student.jsp?error=You already gave feedback for this teacher");
        } else {
            res.sendRedirect("student.jsp?msg=Feedback Added Successfully");
        }
    }
}