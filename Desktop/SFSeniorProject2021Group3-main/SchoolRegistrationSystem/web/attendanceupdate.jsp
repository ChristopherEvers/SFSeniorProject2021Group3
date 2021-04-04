<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>

<%
String StudentId=request.getParameter("studentid");
String Present=request.getParameter("present");
String Absent=request.getParameter("absent");

try{
Connection conn = DriverManager.getConnection(connectionUrl, userid, password);
Statement st=conn.createStatement();
int i=st.executeUpdate("update studentdata set Present = '"+Present+"', Absent = '"+Absent+"' where StudentId = "+StudentId+";");
out.println("Attendance is successfully updated!");
}
catch(Exception e)
{
out.println(e);
System.out.print(e);
e.printStackTrace();
}
%>
<br>
<button type="button" name="back" onclick="location.href = 'teacherdashboard.jsp'">Back to Dashboard</button>
<div id="LogOut" class="tabcontent">
<div class="d-flex flex-row bd-highlight justify-content-end p-5">
       <label class="btn btn-outline-danger m-1 text-danger" for="btncheck1"><a href="login.jsp">Log Out</a></label>
 	 </div></div>
