<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	
	String interestListID = request.getParameter("interestListId");
	
	
	int ID = Integer.parseInt(interestListID);
	
	 
	
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	
	
		
		ResultSet rs;
		
		Statement stmt = con.createStatement();	
		
		int temp = stmt.executeUpdate("DELETE from interestList where interestListId="+ID);
		response.sendRedirect("interestList.jsp");
	%>