<!DOCTYPE html>
<html>
<head>
<title>Register</title>

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
h3{
color: #38bdf8;
}
</style>

</head>
<body>

<%
String error = request.getParameter("error");
%>

<% if(error != null){ %>
<div class="alert alert-danger text-center"><%=error%></div>
<% } %>

<div class="container mt-5">
  <div class="card p-4 col-md-4 mx-auto">

    <h3 class="text-center mb-3">Register</h3>

    <input type="text" style="display:none">
    <input type="password" style="display:none">

    <form action="RegisterServlet" method="post" autocomplete="off">

      <input name="username" class="form-control mb-3"
             placeholder="Username" autocomplete="off" required>

      <input type="password" name="password"
             class="form-control mb-3"
             placeholder="Password"
             autocomplete="new-password" required>

      <input name="usn" class="form-control mb-3"
             placeholder="USN" autocomplete="off" required>

      <button class="btn btn-primary w-100"
              onclick="this.innerText='Registering...'">Register</button>

    </form>

    <a href="login.jsp" class="btn btn-link text-light mt-2">Back to Login</a>

  </div>
</div>

<script>
setTimeout(()=>{document.querySelectorAll('.alert').forEach(a=>a.style.display='none');},3000);
if (window.history.replaceState){
  const url=new URL(window.location);
  url.searchParams.delete('error');
  window.history.replaceState({},document.title,url.pathname);
}
</script>

</body>
</html>