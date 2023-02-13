<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index page</title>
</head>
<body>
	<%
		
			response.sendRedirect("login.jsp");
		
	
			/* Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj?verifyServerCertificate=false&useSSL=true", "root", "csAdminUser22");
			
			String userName = request.getParameter("username");
			String password = request.getParameter("password");
			
			ResultSet rs;
			Statement stmt = con.createStatement();
				
				
			rs = stmt.executeQuery("select username1, password1, account_type from account");
			
			while(rs.next()){
					
				String user = rs.getString("username1");
				String pass = rs.getString("password1");
				String type = rs.getString("account_type");
				
				try{
					if(userName.equals(user) && password.equals(pass)){
					
						if(type.equals("admin")){
							response.sendRedirect("adminHome.jsp");
							break;
						}
					}
				}catch(Exception e){
					
					out.println("An unexpected error has occurred (most likely null pointer exception)...<a href='logout.jsp'>try again</a>");
				}
			}
	 */
	%>
	
	
	
	
</body>
</html>