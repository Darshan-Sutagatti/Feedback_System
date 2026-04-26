<%@page import="java.sql.*,dao.*"%>
<%
if(session.getAttribute("role") == null || !session.getAttribute("role").equals("student")){
    response.sendRedirect("login.jsp?error=Please login first");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Student</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background: linear-gradient(135deg,#1e293b,#0f172a); color:#fff; }
.card { background:rgb(255, 110, 110); border-radius:15px; }
h4 { color: rgb(64, 0, 0); }
h1 {
    color: rgb(255, 110, 110);
    text-align: center;
    text-decoration: underline;
    text-shadow: 2px 2px 4px #000000;
}
</style>
</head>

<body>

<div class="container mt-4">
<h1>FEEDBACK FORM</h1>

<div class="text-end mb-3">
    <a href="LogoutServlet" class="btn btn-danger">Logout</a>
</div>

<%
String msg = request.getParameter("msg");
String error = request.getParameter("error");
%>

<% if(msg != null){ %>
<div class="alert alert-success text-center"><%=msg%></div>
<% } %>

<% if(error != null){ %>
<div class="alert alert-danger text-center"><%=error%></div>
<% } %>

<!-- GIVE FEEDBACK -->
<div class="card p-4 mb-4">
<h4>Give Feedback</h4>

<form action="AddFeedbackServlet" method="post">

<select name="teacher" class="form-control mb-2">
<%
ResultSet t = UserDAO.getTeachers();
while(t.next()){
%>
<option value="<%=t.getInt("id")%>">
    <%=t.getString("username")%> - <%=t.getString("subject")%>
</option>
<%
}
%>
</select>

<input name="review" class="form-control mb-2" placeholder="Review" required>

<select name="rating" class="form-control mb-2">
<option value="5">5 * * * * *</option>
<option value="4">4 * * * *</option>
<option value="3">3 * * *</option>
<option value="2">2 * *</option>
<option value="1">1 *</option>
</select>

<button class="btn btn-success" onclick="this.innerText='Processing...'">Submit</button>

</form>
</div>

<!-- VIEW FEEDBACK -->
<div class="card p-4">
<h4>Your Feedback</h4>

<%
ResultSet f = null;

try {
    f = FeedbackDAO.getStudentFeedback((int)session.getAttribute("id"));

    if(f != null){
        while(f.next()){
%>

<div class="card p-2 mb-2">
    <b>Teacher:</b> <%=f.getString("teacher_name")%><br>
    <b>Subject:</b> <%=f.getString("subject")%><br>
    <b>Review:</b> <%=f.getString("review")%><br>
    <b>Rating:</b> <%=f.getInt("rating")%>

    <br>

    <a href="DeleteFeedbackServlet?id=<%=f.getInt("id")%>"
       class="btn btn-danger btn-sm"
       onclick="return confirm('Delete this review?')">Delete</a>
</div>

<%
        }
    } else {
%>
<p>No feedback available</p>
<%
    }

} catch(Exception e) {
%>
<p style="color:red;">Error: <%=e.getMessage()%></p>
<%
}
%>

</div>

</div>

<script>
setTimeout(()=>{
    document.querySelectorAll('.alert').forEach(a=>a.style.display='none');
},3000);

if (window.history.replaceState){
  const url=new URL(window.location);
  url.searchParams.delete('msg');
  url.searchParams.delete('error');
  window.history.replaceState({},document.title,url.pathname);
}
</script>

</body>
</html>