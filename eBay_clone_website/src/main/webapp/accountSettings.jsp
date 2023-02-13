<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Settings</title>
</head>
<body>
	
	<%@ include file = "navigation.jsp"%>

	<%
	
		Class.forName("com.mysql.jdbc.Driver");

		//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj, "root", "csAdminUser22");
	%>
	<h1>Account Information</h1>
	
			
		<%
		try {
			
			String user2 = (String)session.getAttribute("user1");
			
			ResultSet rs;
			Statement stmt = con.createStatement();	
			
			rs = stmt.executeQuery("select * from account where username1= '"+user2+"'");
			while(rs.next()){
			 
				
			%>
			
				<p>First Name: <%= rs.getString("first_name") %></p> 
				<p>Last Name: <%= rs.getString("last_name") %></p>
				<p>Username: <%= rs.getString("username1") %></p> 
				<p>Password: <%= rs.getString("password1") %></p> 
				<p>Email: <%= rs.getString("email") %></p> 
				<p>Address: <%= rs.getString("address") %> </p>
			
		
			<%
			}
		} catch (Exception e) {
			out.println("User not found");
		}
		%>
	
		<p></p>	
	
		<div><a href='deleteAccount.jsp'>Delete Account</a> If you click Delete Account it will be lost!!</div>	


</body>
</html>