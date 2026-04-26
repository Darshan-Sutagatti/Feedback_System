<!DOCTYPE html>
<html>
<head>
<title>Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background: linear-gradient(135deg,#1e293b,#0f172a); color:#fff; }
.card { background:#1e293b; border-radius:15px; }

/* 🔥 FIX INPUT COLORS */
.form-control {
    background-color: #0f172a;
    color: white;
    border: 1px solid #334155;
}
.form-control::placeholder {
    color: #94a3b8;
}
.form-control:focus {
    background-color: #0f172a;
    color: white;
    border-color: #38bdf8;
    box-shadow: none;
}
select {
    background-color: #0f172a !important;
    color: white !important;
}
h3{
color: #38bdf8;
}

#new{
color: #38bdf8;
}
</style>

</head>
<body>

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

<div class="container mt-5">
  <div class="card p-4 col-md-4 mx-auto">

    <h3 class="text-center mb-3">Login</h3>

    <input type="text" style="display:none">
    <input type="password" style="display:none">

    <form action="LoginServlet" method="post" autocomplete="off">

      <input name="username" class="form-control mb-3"
             placeholder="Username" autocomplete="off" required>

      <input type="password" name="password"
             class="form-control mb-3"
             placeholder="Password"
             autocomplete="new-password" required>

      <select name="role" class="form-control mb-3">
        <option value="admin">Admin</option>
        <option value="teacher">Teacher</option>
        <option value="student">Student</option>
      </select>

      <button class="btn btn-success w-100 mb-3"
              onclick="this.innerText='Please wait...'">Login</button>
    </form>

    <div class="text-center">
      <p id="new">New here?</p>
      <a href="register.jsp" class="btn btn-outline-light w-100">Create Account</a>
    </div>

  </div>
</div>

<script>
setTimeout(()=>{document.querySelectorAll('.alert').forEach(a=>a.style.display='none');},3000);
if (window.history.replaceState){
  const url=new URL(window.location);
  url.searchParams.delete('msg'); url.searchParams.delete('error');
  window.history.replaceState({},document.title,url.pathname);
}
</script>

</body>
</html>