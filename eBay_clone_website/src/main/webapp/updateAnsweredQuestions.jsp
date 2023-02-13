<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%

	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	

	String ques = request.getParameter("questionID");
	int ques2 = Integer.parseInt(ques);
	String new_answer = request.getParameter("answer");
	
	//System.out.println(username4);
	
	
	
	//System.out.println("Check 1");
			
	try{
		
		//System.out.println("Check 2");
		/* System.out.println(username4);
		System.out.println(ques);
		System.out.println(new_answer); */
		
		
		Statement stmt = con.createStatement();
		 
		
		
		//System.out.println("Check Check");
		
		stmt.executeUpdate("Update questions set answer= '"+new_answer+"' WHERE questionID="+ques2);
		
		
		out.println("Question Answered successfully <a href='answerQuestion.jsp'>Return to Contact Center</a>");
					
		}catch(Exception e){
					out.println(" Hitting the catch <a href='answerQuestion.jsp'>Try Again</a>");
			}
							

		
	
%>
