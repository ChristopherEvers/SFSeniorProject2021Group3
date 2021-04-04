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
String EventId=request.getParameter("eventid");
String Student=request.getParameter("student");
String Class=request.getParameter("class");
String Homework=request.getParameter("homework");
String Test=request.getParameter("test");
String Grades=request.getParameter("grades");
String Delete=request.getParameter("delete");

String ClassId = null;

try{
Connection conn = DriverManager.getConnection(connectionUrl, userid, password);
Statement st=conn.createStatement();

	ResultSet rs = st.executeQuery("select ClassId from classregistration where ClassName = '"+Class+"';");
	while (rs.next()) {
		  ClassId = rs.getString("ClassId");
		  }

if (Test.contentEquals(Homework)) {
	out.println("Test and Homework can't be the same value.");
	out.println("Grade was not changed.");
} else if (ClassId == null) {
	out.println("Invalid Class Name.");
	out.println(" Class was either misspelled or does not exist.");
	out.println("Contact Admin for details on getting classes added.");
} else{
	
if (EventId != "" && Delete == null) {
int i=st.executeUpdate("update gradeevent set Homework = '"+Homework+"', Test = '"+Test+"', Grades = '"+Grades+"' where EventId = " +EventId+ ";");
int j=st.executeUpdate("update gradejoinstudent set StudentId = '"+Student+"', ClassId = '"+ClassId+"', EventId = '"+EventId+"' where EventId = " +EventId+ ";");

out.println(Class +"  "+ClassId);
out.println("Grade is successfully updated!");
} else if (Delete == null) {
	int i=st.executeUpdate("insert into gradeevent (Homework, Test, Grades) values ('"+Homework+"', '"+Test+"', '"+Grades+"');");
	rs = st.executeQuery("select last_insert_id() as EventId");
	while (rs.next()) {
		  EventId = rs.getString("EventId");
	}
	out.println(Student + " " +ClassId +" "+ EventId);
	int j=st.executeUpdate("insert into gradejoinstudent (StudentId, ClassId, EventId) values ('"+Student+"', '"+ClassId+"', '"+EventId+"');");
	out.println("Grade is successfully added!");
} else {
	int i=st.executeUpdate("delete from gradeevent where EventId = "+EventId+";");
	int j=st.executeUpdate("delete from gradejoinstudent where EventId = "+EventId+";");
	out.println("Grade is successfully deleted!");
}
}
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
