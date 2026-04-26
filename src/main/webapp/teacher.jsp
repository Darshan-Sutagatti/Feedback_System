<%@page import="java.sql.*,dao.*"%>
<%
if(session.getAttribute("role") == null || !session.getAttribute("role").equals("teacher")){
    response.sendRedirect("login.jsp?error=Please login first");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Teacher</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background: linear-gradient(135deg,#1e293b,#0f172a); color:#fff; }
.card { background:#1e293b; border-radius:15px; }
.table { background:#fff; color:#000; }
h4{
color:#38bdf8;
}
</style>
</head>
<body>

<div class="container mt-4">
  <div class="text-end mb-3">
    <a href="LogoutServlet" class="btn btn-danger">Logout</a>
  </div>

  <div class="card p-4">
    <h4>Your Feedback</h4>
    <table class="table">
      <tr><th>Review</th><th>Rating</th></tr>
      <%
      ResultSet rs = FeedbackDAO.getTeacherFeedback((int)session.getAttribute("id"));
      while(rs.next()){
      %>
      <tr>
        <td><%=rs.getString("review")%></td>
        <td>* <%=rs.getInt("rating")%></td>
      </tr>
      <% } %>
    </table>
  </div>
</div>

</body>
</html>