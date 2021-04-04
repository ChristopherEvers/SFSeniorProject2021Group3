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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <title>
  		Teacher Dashboard
  	</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  <link type="text/css" rel="stylesheet" href="css/teacherdashboard.css">
  <script src ="js/teacherdashboard.js"></script>
  </head>
<body>
     
	<div class="header">
		<span class="badge rounded-pill align-middle bg-success">Teacher</span>
		<span class="badge rounded-pill bg-warning text-dark">Dashboard</span> 	
	</div>
		
	<button class="tablink" onclick="openPage('Student', this)">Student</button>
	<button class="tablink" onclick="openPage('Grades', this)">Grades</button>
	<button class="tablink" onclick="openPage('Classes', this)">Classes</button>
	<button class="tablink" onclick="openPage('LogOut', this)">Log Out</button>

	<div id="Grades" class="tabcontent">
		<table>
			<tr>
				<td>Student Id</td>
				<td>Class</td>
				<td>Homework</td>
				<td>Test</td>
				<td>Grades</td>
			</tr>

<%
try{
	connection = DriverManager.getConnection(connectionUrl, userid, password);
	statement=connection.createStatement();
	String sql ="select gradeevent.EventId, gradeevent.Homework, gradeevent.Test, gradeevent.Grades, gradejoinstudent.StudentId, classregistration.ClassName, classregistration.ClassId from gradeevent inner join gradejoinstudent on gradeevent.EventId = gradejoinstudent.EventId inner join classregistration on gradejoinstudent.ClassId = classregistration.ClassId;";
	resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
%>
	<tr><td colspan="4">
		<form method="post" action="gradeupdate.jsp" class="inline">
			<input type="text" readonly name="eventid" value="<%=resultSet.getString("EventId") %>" style="display: none;">
			<input type="text" readonly name="classid" value="<%=resultSet.getString("ClassId") %>" style="display: none;">
			<input type="text" name="student" value="<%=resultSet.getString("StudentId") %>" style="width: 75px; margin-right:65px;">
			<input type="text" name="class" value="<%=resultSet.getString("ClassName") %>" style="width: 80px; margin-right:65px;">
			<input type="text" name="homework" value="<%=resultSet.getString("Homework") %>" style="width: 75px; margin-right:68px;">
			<input type="text" name="test" value="<%=resultSet.getString("Test") %>" style="width: 75px; margin-right:68px;">
			<input type="text" name="grades" value="<%=resultSet.getString("Grades") %>" style="width: 75px; margin-right:35px;">
			<input type="submit" value="Update" style="margin-right:15px;">
			Delete
			<input type="checkbox" name="delete" value="Delete">
		</form>
	<br>
	</td></tr>
<%
	}
	connection.close();
	} catch (Exception e) {
	e.printStackTrace();
	}
%>
	<tr><td colspan="4">
		<form method="post" action="gradeupdate.jsp" class="inline">
			<input type="text" readonly name="eventid" style="display: none;">
			<input type="text" name="student" value="1" style="width: 60px; width: 75px; margin-right:65px;"> 
			<input type="text" name="class" value="Math" style="width: 80px; margin-right:65px;">   
			<input type="text" name="homework" value="No" style="width: 75px; margin-right:68px;"> 
			<input type="text" name="test" value="No" style="width: 75px; margin-right:68px;">         
			<input type="text" name="grades" value="0" style="width: 75px; margin-right:35px;">     
			<input type="submit" value="Add">
		</form>
	</td></tr>
</table>
</div>

<div id="Classes" class="tabcontent">
<%
try{
	connection = DriverManager.getConnection(connectionUrl, userid, password);
	statement=connection.createStatement();
	String sql ="select * from classregistration;";
	resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
%>
	<h1><%=resultSet.getString("ClassName") %></h1>
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
 	</div>
</div>

<div id="Student" class="tabcontent">
<table>
<tr>
<td style="width: 60px; clear: both;">Student ID</td>
<td style="width:100px;">Name</td>
<td style="width: 16%;">Present</td>
<td>Absent</td>
</tr>
<%
	try{
	connection = DriverManager.getConnection(connectionUrl, userid, password);
	statement=connection.createStatement();
	String sql ="select * from studentdata;";
	resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
%>
<tr>
<td colspan="4">
		<form method="post" action="attendanceupdate.jsp"  class="inline">
		<input type="number" readonly name="studentid" value="<%=resultSet.getString("StudentId")%>" id="studentid" style="margin-right: 9px;"> 
		<span  style="width: 150px;"><%=resultSet.getString("FirstName")%>
		<%=resultSet.getString("LastName")%></span>
		<input type="number" name="present" min="0" value="<%=resultSet.getString("Present")%>" style="margin-left: 10px;">
		<input type="number" name="absent" min="0" value="<%=resultSet.getString("Absent")%>" style="margin-left: 10px;">
		<input type="submit" value="Update">
		</form>
		</td>
		</tr>
		</table>
	
<%
	}
	connection.close();
	} catch (Exception e) {
	e.printStackTrace();
	}
%>
</div>
</body>
</html>
