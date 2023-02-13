<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Center</title>
</head>
<body>
	
	<%@ include file = "navigation.jsp"%>
	
	<%
			
			Class.forName("com.mysql.jdbc.Driver");

			//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
		
	%>
	
	<div>
		<h2>Answer Question:</h2>
	</div>
	
	<div>
		<form action="updateAnsweredQuestions.jsp" method="POST">
			Question ID: <input type="text" name="questionID" placeholder="Enter Question ID"> 
			Answer: <input type="text" name="answer" placeholder="Answer Question here..."><br/>
			
			<input type="submit" value="Submit" >
		</form>
	</div>		
		
	<div>
		
		<h2>Questions Asked: </h2>
		
		<%
		try {
			
			String user4 = (String)(session.getAttribute("user1"));
			ResultSet rs;
				
			
			Statement stmt = con.createStatement();	
			rs = stmt.executeQuery("select * from questions where answer= 'This Question will be answered by a Customer Rep shortly'");
			while(rs.next()){
				
				
			%>
				<p>QuestionID:&nbsp;&nbsp;&nbsp; <%= rs.getString("questionID") %>&nbsp;&nbsp;&nbsp; Username:&nbsp;&nbsp;&nbsp; <%= rs.getString("username") %></p>
				
				<p> Question:&nbsp;&nbsp;&nbsp; <%= rs.getString("question") %> </p>
				<p> Answer:&nbsp;&nbsp;&nbsp; <%= rs.getString("answer") %> </p>
				<p>----------------------------------------------------------------------------</p>	
		
			<%
			}
		} catch (Exception e) {
			out.println("No Questions Need To Be Answered");
		}
		%>
	
		</div>
		
</body>
</html>