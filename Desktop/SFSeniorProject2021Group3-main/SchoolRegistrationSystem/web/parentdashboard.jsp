<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/schoolregistrationsystem";
String userid = "root";
String password = "admin";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%String username = request.getParameter("user"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <title>
  		Parent Dashboard
  	</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  <link rel="stylesheet" href="css/parentdashboard.css">
  <script src ="js/parentdashboard.js"></script>
  </head>
<body>
     
		<div class="header"><span class="badge rounded-pill align-middle bg-success">Parent</span>
				<span class="badge rounded-pill bg-warning text-dark">Dashboard</span> 	
		</div>
		
<button class="tablink" onclick="openPage('Student', this)">Student</button>
<button class="tablink" onclick="openPage('Grades', this)">Grades</button>
<button class="tablink" onclick="openPage('Attendance', this)">Attendance</button>
<button class="tablink" onclick="openPage('LogOut', this)">Log Out</button>

<div id="Grades" class="tabcontent">
<table>
<tr>
<td>AssignmentId</td>
<td>Homework</td>
<td>Test</td>
<td>Grades</td>
</tr>

<%
try{
connection = DriverManager.getConnection(connectionUrl, userid, password);
statement=connection.createStatement();
String sql ="select * from gradeevent join gradejoinstudent on gradeevent.EventId = gradejoinstudent.EventId join registrationuser on gradejoinstudent.StudentId = registrationuser.StudentId and registrationuser.Email = '" + username + "';";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr><td colspan="4">
<form>
<input type="text" readonly value="<%=resultSet.getString("EventId") %>">
<input type="text" readonly value="<%=resultSet.getString("Homework") %>">
<input type="text" readonly value="<%=resultSet.getString("Test") %>">
<input type="text" readonly value="<%=resultSet.getString("Grades") %>">
</form>
<br></td></tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table></div>

<div id="Attendance" class="tabcontent">
  <%
try{
connection = DriverManager.getConnection(connectionUrl, userid, password);
statement=connection.createStatement();
String sql ="select * from studentdata join registrationuser on studentdata.StudentId = registrationuser.StudentId and registrationuser.Email = '" + username + "';";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<p>Present: <%=resultSet.getString("Present")%></p>
<p>Absent: <%=resultSet.getString("Absent")%></p>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</div>

<div id="LogOut" class="tabcontent">
<div class="d-flex flex-row bd-highlight justify-content-end p-5">
       <label class="btn btn-outline-danger m-1 text-danger" for="btncheck1"><a href="login.jsp">Log Out</a></label>
 	 </div></div>

<div id="Student" class="tabcontent">
<table>
<tr>
<td>Student Id</td>
<td>First Name </td>
<td>Last Name</td>
</tr>
<%
try{
connection = DriverManager.getConnection(connectionUrl, userid, password);
statement=connection.createStatement();
String sql ="select * from studentdata join registrationuser on studentdata.StudentId = registrationuser.StudentId and registrationuser.Email = '" + username + "';";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("StudentId")%></td>
<td><%=resultSet.getString("FirstName")%></td>
<td><%=resultSet.getString("LastName")%></td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</div>

</body>
</html>
