<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%

	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	String firstName = request.getParameter("first_name");
	String lastName = request.getParameter("last_name");
	String email2 = request.getParameter("email");
	String address2 = request.getParameter("address");
	String type = "customer rep";
	
	if((userName == null || userName.isEmpty()) || (password == null || password.isEmpty()) || (firstName == null || firstName.isEmpty()) || (lastName == null || lastName.isEmpty()) || (email2 == null || email2.isEmpty()) || (address2 == null || address2.isEmpty())){
		out.println(" Please make sure everything is filled out <a href='register.jsp'>try again</a>");
	}
	
	
		
	ResultSet rs;
	Statement stmt = con.createStatement();
		
		
	rs = stmt.executeQuery("select username1, password1, email from account");
	
	while(rs.next()){
			
		String user = rs.getString("username1");
		String pass = rs.getString("password1");
		String em = rs.getString("email");
		
			if(userName.equals(user) && password.equals(pass) && email2.equals(em)){
				out.println("Registration Failed. This account exists please login... <a href='login.jsp'>Login</a>");
			}
			else if(userName.equals(user)){
				out.println("This username is already in use. Please try another username... <a href='register.jsp'>Try Again</a>");
			}
			else if(email2.equals(em)){
				out.println("This email is already in use. Please try another email... <a href='register.jsp'Try Again</a>");
			}
			else{
				try{
					Statement state = con.createStatement();
					
					int temp = state.executeUpdate("INSERT INTO account(first_name,last_name,username1,password1,email,address,account_type)values('"+firstName+"','"+lastName+"','"+userName+"','"+password+"','"+email2+"','"+address2+"','"+type+"')");
					out.println("Registration Successful! <a href='adminHome.jsp'Go Back To Home</a>");
					
				}catch(Exception e){
					out.println("Login <a href='adminHome.jsp'Go Back To Home</a>");
					break;
				}
			}				
	
			
	}
	
		
	
%>