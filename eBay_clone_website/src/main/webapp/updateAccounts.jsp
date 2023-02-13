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

			//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj?verifyServerCertificate=false&useSSL=true", "root", "csAdminUser22");
		
	%>
	
	<div>
		<h2>Choose User To Update:</h2>
	</div>
	
	<div>
		<form action="updateAccounts2.jsp" method="POST">
			Username: <input type="text" name="username3" placeholder="Enter Username"><br/> 
			
			<input type="submit" value="Search" >
		</form>
	</div>		
		
	<p></p>
		
		<h1>Account information for all customers: </h1>
		<p>Please Input All Information. Username Cannot Be Changed.</p>
			
	
		<%
		try {
			
			
			ResultSet rs;
				
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("select * from account where account_type= 'customer'");
			while(rs.next()){
				
				
			%>
			
				<p>First Name: <%= rs.getString("first_name") %> </p>
				<p>Last Name: <%= rs.getString("last_name") %> </p>
				<p>Username: <%= rs.getString("username1") %> </p>
				<p>Password: <%= rs.getString("password1") %> </p>
				<p>Email: <%= rs.getString("email") %> </p>
				<p>Address: <%= rs.getString("address") %> </p>
				<p>-------------------------------------------------------------------</p>
			
			<%
			}
		} catch (Exception e) {
			out.println("User not found");
		}
		%>
		
		
</body>
</html>