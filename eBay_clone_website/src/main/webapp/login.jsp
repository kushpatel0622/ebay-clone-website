<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>

<head>
	<title>Login</title>
</head>
<body>

	<div>
		<h2>Login:</h2>
	</div>
	
	<div>
		<form action="checkLogin.jsp" method="POST">
			Username: <input type="text" name="username" placeholder="Enter Username"><br/> 
			
			Password:<input type="password" name="password" placeholder="Enter Password"><br/> 
			
			<input type="submit" value="Login" >
		</form>
	</div>		
		
		<div>Don't Have Account? <a href='register.jsp'>Create An Account</a> For Free Today!</div>	
			

	
</body>
</html>