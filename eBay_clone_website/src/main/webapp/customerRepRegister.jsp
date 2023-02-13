<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%-- 
<%

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ENTERDATABASENAME", "root", "ENTERCONNECTIONPASSWORD");
%>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>customer rep register</title>
</head>

<body>
	<div>
		<h2>Customer Representative Registration Page:</h2>
	</div>
	
	<div>
		<form action="checkRepRegister.jsp" method="POST">
			First Name: <input type="text" name="first_name" placeholder="Enter First Name"><br/> 
			
			Last Name:<input type="text" name="last_name" placeholder="Enter Last Name"><br/> 
			
			Email:<input type="text" name="email" placeholder="Enter Email"><br/>
			
			Username: <input type="text" name="username" placeholder="Enter Username"><br/> 
			
			Password:<input type="password" name="password" placeholder="Enter Password"><br/> 
			
			Address:<input type="text" name="address" placeholder="Enter Address"><br/>
			
			
			<input type="submit" value="Register" >
		</form>
	</div>			
	
</body>
</html>