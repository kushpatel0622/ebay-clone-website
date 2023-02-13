<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	
	//String interestListID = request.getParameter("interestListId");
	
	//int ID = 0;
	//if(interestListID.isEmpty() == false && interestListID != null){
	//	ID = Integer.parseInt(interestListID);
	//}
	 
	
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	
	//if(ID > 0){
		
	//	ResultSet rs;
		
	//	PreparedStatement stmt = con.prepareStatement("DELETE from test2 where interestListId="+ID);	
		
	//	int temp = stmt.executeUpdate();
	//	response.sendRedirect("interestList.jsp");
	//}
	//else{
		
		String make = request.getParameter("make");
		String model = request.getParameter("model");
		String carType = request.getParameter("type");
		String carColor = request.getParameter("color");
		String miles = request.getParameter("mileage");
		
		String year = request.getParameter("year");
		String username = (String)session.getAttribute("user1"); 	
		
		Statement stmt = con.createStatement();
		int temp = stmt.executeUpdate("INSERT INTO interestList(username,vehicleType,vehicleMake,vehicleModel,vehicleColor,vehicleYear,vehicleMileage)values('"+username+"','"+carType+"','"+make+"','"+model+"','"+carColor+"','"+year+"','"+miles+"')");
		
		response.sendRedirect("interestList.jsp");
	//}
	

		
	
%>