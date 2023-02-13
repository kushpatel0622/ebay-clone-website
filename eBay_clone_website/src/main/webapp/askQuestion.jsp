<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%

	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	String username4 = request.getParameter("username");
	String new_question = request.getParameter("question");
	
	//System.out.println(username4);
	
	if((username4 == null && username4.isEmpty()) || (new_question == null && new_question.isEmpty())){
		out.println(" Please make sure everything is filled out <a href='contactCenter.jsp'>try again</a>");
	}
	
	//System.out.println("Check 1");
			
		
		//System.out.println("Check 2");
		String string = "This Question will be answered by a Customer Rep shortly";
		
		Statement stmt = con.createStatement();
		int temp = stmt.executeUpdate("INSERT INTO questions(username,question,answer)values('"+username4+"','"+new_question+"','"+string+"')");
		
		response.sendRedirect("contactCenter.jsp");
		
	

		
	
%>