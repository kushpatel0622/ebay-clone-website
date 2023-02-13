<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	
	String auctionid = request.getParameter("auctionID");
	
	
	int ID = Integer.parseInt(auctionid);
	
	//System.out.println(ID); 
	
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	
	
		
		ResultSet rs;
		
		Statement stmt = con.createStatement();	
		int temp = stmt.executeUpdate("DELETE from ongoingAuctions where auctionID="+ID);
		response.sendRedirect("viewAuctions.jsp");
		%>