<%@page import="java.sql.*,dao.*"%>

<%
if(session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")){
    response.sendRedirect("login.jsp?error=Please login first");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg,#1e293b,#0f172a);
    color: white;
}
.card {
    border-radius: 15px;
}
.table {
    background: white;
    color: black;
}
.form-control {
    background-color: #0f172a;
    color: white;
    border: 1px solid #334155;
}
.form-control::placeholder {
    color: #94a3b8;
}
</style>

</head>

<body>

<!-- 🔴 LOGOUT -->
<div class="container mt-4">
  <div class="text-end mb-3">
    <a href="LogoutServlet" class="btn btn-danger">Logout</a>
  </div>
</div>

<!-- 🔔 ALERT -->
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

<div class="container mt-3">

<h2 class="text-center mb-4">Admin Dashboard</h2>

<!-- ✅ ADD TEACHER -->
<div class="card p-4 mb-4">

<h4>Add Teacher</h4>

<form action="AddTeacherServlet" method="post" class="row g-3" autocomplete="off">

<input type="text" style="display:none">
<input type="password" style="display:none">

<div class="col-md-4">
<input name="username" class="form-control" placeholder="Username" autocomplete="off" required>
</div>

<div class="col-md-3">
<input name="password" class="form-control" placeholder="Password" autocomplete="new-password" required>
</div>

<div class="col-md-3">
<input name="subject" class="form-control" placeholder="Subject" autocomplete="off" required>
</div>

<div class="col-md-2">
<button class="btn btn-success w-100" onclick="this.innerText='Adding...'">Add</button>
</div>

</form>

</div>

<!-- 👨‍🏫 MANAGE TEACHERS -->
<div class="card p-3 mb-4">

<h4>Manage Teachers</h4>

<table class="table table-bordered table-hover">

<tr>
<th>Username</th>
<th>Subject</th>
<th>Action</th>
</tr>

<%
ResultSet teachers = UserDAO.getTeachers();

while(teachers.next()){
%>

<tr>
<td><%=teachers.getString("username")%></td>
<td><%=teachers.getString("subject")%></td>

<td>
<a href="DeleteTeacherServlet?id=<%=teachers.getInt("id")%>"
   class="btn btn-danger btn-sm"
   onclick="return confirm('Delete this teacher?')">
   Delete
</a>
</td>

</tr>

<% } %>

</table>

</div>

<!-- 🔍 SEARCH + SORT -->
<div class="card p-3 mb-4">

<form method="get" class="row g-3">

<div class="col-md-5">
<input name="search" class="form-control" placeholder="Search review / teacher / subject">
</div>

<div class="col-md-3">
<select name="sort" class="form-control">
<option value="">Sort By</option>
<option value="name">Teacher Name</option>
<option value="rating">Rating</option>
<option value="subject">Subject</option>
</select>
</div>

<div class="col-md-2">
<button class="btn btn-info w-100">Apply</button>
</div>

</form>

</div>

<!-- 📋 ALL REVIEWS -->
<div class="card p-3 mb-4">

<h4>All Reviews</h4>

<table class="table table-bordered table-hover">

<tr>
<th>Teacher</th>
<th>Subject</th>
<th>Review</th>
<th>Rating</th>
</tr>

<%
String search = request.getParameter("search");
String sort = request.getParameter("sort");

ResultSet rs = FeedbackDAO.getAllFeedback(search, sort);

while(rs.next()){
%>

<tr>
<td><%=rs.getString("username")%></td>
<td><%=rs.getString("subject")%></td>
<td><%=rs.getString("review")%></td>
<td>*<%=rs.getInt("rating")%></td>
</tr>

<% } %>

</table>

</div>

<!-- ⭐ AVERAGE RATING -->
<div class="card p-3">

<h4>Top Teachers (Average Rating)</h4>

<table class="table table-bordered">

<tr>
<th>Teacher</th>
<th>Subject</th>
<th>Avg Rating</th>
</tr>

<%
ResultSet avg = FeedbackDAO.getAverageRatings();

while(avg.next()){
%>

<tr>
<td><%=avg.getString("username")%></td>
<td><%=avg.getString("subject")%></td>
<td>*<%=String.format("%.2f", avg.getDouble("avg_rating"))%></td>
</tr>

<% } %>

</table>

</div>

</div>

<!-- ⚡ SCRIPT -->
<script>
setTimeout(() => {
    document.querySelectorAll('.alert').forEach(a => a.style.display='none');
}, 3000);

if (window.history.replaceState) {
    const url = new URL(window.location);
    url.searchParams.delete('msg');
    url.searchParams.delete('error');
    window.history.replaceState({}, document.title, url.pathname);
}
</script>

</body>
</html>