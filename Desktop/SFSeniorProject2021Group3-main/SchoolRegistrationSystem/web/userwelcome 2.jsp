<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <title>User Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  </head>
<body>
     <div class="d-flex flex-row bd-highlight justify-content-end p-5">
       <label class="btn btn-outline-danger m-1 text-danger" for="btncheck1"><a href="login.jsp">Log Out</a></label>
 	 </div>
 <div class="container">
 <div class="card">
  <div class="card-body">
    <%
  String username = request.getParameter("user");
  out.println("Hello user: " + username);
 %>
  </div>
</div></div>
</body>
</html>