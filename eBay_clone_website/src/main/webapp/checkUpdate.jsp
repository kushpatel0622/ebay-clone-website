<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%

	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	String username4 = request.getParameter("username");
	String new_password = request.getParameter("new_password");
	String new_email = request.getParameter("new_email");
	String new_address = request.getParameter("new_address");
	
	//System.out.println(username4);
	
	if((new_password == null || new_password.isEmpty()) || (new_email == null || new_email.isEmpty()) || (new_address == null || new_address.isEmpty())){
		out.println(" Please make sure everything is filled out <a href='updateAccounts2.jsp'>try again</a>");
	}
	
	//System.out.println("Check 1");
			
	try{
		
		//System.out.println("Check 2");
		
		
		Statement stmt = con.createStatement();
		stmt.executeUpdate("Update account set password1='"+new_password+"', email='"+new_email+"', address='"+new_address+"' where username1= '"+username4+"'");
		
		out.println("Update Successful! <a href='customerRepHome.jsp'>Return Home</a>");
					
		}catch(Exception e){
					out.println("<a href='updateAccount2.jsp'>Try Again</a>");
			}
							

		
	
%>