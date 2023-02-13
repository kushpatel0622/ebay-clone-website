<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<% 
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	//System.out.println("username: " + userName + " | pass: " + password);
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection con = null;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj","root","csAdminUser22");
		//System.out.println("Connected!");
	} catch(SQLException ex){
		throw new Error("Error ", ex);
	}
	
	ResultSet rs;
	Statement stmt = con.createStatement();
	
	
	if(userName == null || password == null){
		out.println(" Please fill out both username and password. <a href='login.jsp'>try again</a>");
	}
	
	
	rs = stmt.executeQuery("select username1, password1, account_type from account");
	boolean isSuccess = false;
	while(rs.next()){
	
		String user = rs.getString("username1");
		String pass = rs.getString("password1");
		String type = rs.getString("account_type");
		
		try{
			if(userName.equals(user) && password.equals(pass)){
				session.setAttribute("user1", userName); 
				
					if(type.equals("admin")){
						response.sendRedirect("adminHome.jsp");
						isSuccess = true;
						break;
					}
					else if(type.equals("customer rep")){
						response.sendRedirect("customerRepHome.jsp");
						isSuccess = true;
						break;	
					}
					else if(type.equals("customer")){
						response.sendRedirect("customerHome.jsp");
						isSuccess = true;
						break;	
					}
			}
		}catch(Exception e){
			
			out.println("An unexpected error has occurred (most likely null pointer exception)...<a href='logout.jsp'>try again</a>");
			
		}
		
		
	}
	
	if(isSuccess == false){
		out.println("Login Failed. Make sure the username and password are entered correctly... <a href='login.jsp'>try again</a>");
	}
	
			
			
		/*
		boolean isValid = false;
		try{
			if(userName.equals(user) && password.equals(pass)){
				out.println("Success! You have been logged in."); 
				out.println("<a href='logout.jsp'>Log out</a>");
				isValid = true;
				break;
			}
		}catch(Exception e){
			System.out.println("error occurred in verification... <a href='login.jsp'>try again</a>");
		}
		
		if(isValid == true){
			isSuccess = true;
			break;
		}	
		 
	}
	
	if(isSuccess == false){
		out.println("Login Failed. Make sure the username and password are entered correctly... <a href='login.jsp'>try again</a>");
	}
	*/
	
%>
	