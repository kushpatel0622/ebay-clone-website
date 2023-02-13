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
		<h2>Ask A Question:</h2>
	</div>
	
	<div>
		<form action="askQuestion.jsp" method="POST">
			Username: <input type="text" name="username" placeholder="Enter Username..."><br/>
			Question: <input type="text" name="question" placeholder="Ask Question here..."><br/> 
			
			<input type="submit" value="Submit" >
		</form>
	</div>
	
	
	
	<div>
		<h2>Search Question by keyword</h2>
	</div>
	
	<div>	
		<form action="contactCenter.jsp" method="POST">
			Keyword: <input type="text" name="searchQuestion" placeholder="Enter Keyword"><br/>
			
			<input type="submit" value="Search"> 
		</form>
	</div>		
	
	
			<div>
			<h2>Search Results: </h2>
			
			<%
			try {
				
				ResultSet rs;
				String searchQues = request.getParameter("searchQuestion");	
				
				//out.println(searchQues);
				
				PreparedStatement stmt = con.prepareStatement("select question, answer from questions where question LIKE ?");	
				stmt.setString(1, "%"+searchQues+"%");
				rs = stmt.executeQuery();
				while(rs.next()){
					
					
				%>
				
					<p>Question:&nbsp;&nbsp;&nbsp;  <%= rs.getString("question") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Answer: &nbsp;&nbsp;&nbsp;<%= rs.getString("answer") %>&nbsp;&nbsp;&nbsp; </p>
					<p>----------------------------------------------------------------------------</p>
				
				<%
				}
			} catch (Exception e) {
				out.println("No Searches Found");
			}
			%>
			
			</div>
			
	<% 	
	%>
		
	<div>
		
		<h2>Questions You Asked: </h2>
		
		<%
		try {
			
			String user4 = (String)(session.getAttribute("user1"));
			ResultSet rs;
				
			PreparedStatement stmt = con.prepareStatement("select question, answer from questions where username=?");	
			stmt.setString(1, user4);
			rs = stmt.executeQuery();
			while(rs.next()){
				
				
			%>
			
			<p>Question:&nbsp;&nbsp;&nbsp; <%= rs.getString("question") %>&nbsp;&nbsp;&nbsp; </p>
			<p>Answer:&nbsp;&nbsp;&nbsp; <%= rs.getString("answer") %>&nbsp;&nbsp;&nbsp; </p>
			<p>----------------------------------------------------------------------------</p>	
			
			<%
			}
		} catch (Exception e) {
			out.println("No Questions Asked");
		}
		%>
		
	
	</div>
		
		<div>
		
		<h2>Questions Asked by users: </h2>
		
	
		<%
		try {
			
			
			ResultSet rs;
				
			PreparedStatement stmt = con.prepareStatement("select question, answer from questions");	
		
			rs = stmt.executeQuery();
			while(rs.next()){
				
				
			%>
			
				<p>Question: &nbsp;&nbsp;&nbsp;<%= rs.getString("question") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Answer: &nbsp;&nbsp;&nbsp;<%= rs.getString("answer") %>&nbsp;&nbsp;&nbsp; </p>
				<p>----------------------------------------------------------------------------</p>
			
			<%
			}
		} catch (Exception e) {
			out.println("No Questions Asked");
		}
		%>
		
		</div>
		
</body>
</html>