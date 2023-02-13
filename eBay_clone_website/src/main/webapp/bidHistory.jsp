<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import = "java.sql.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bid History</title>
</head>
<%@ include file = "navigation.jsp"%>
<%
			
			Class.forName("com.mysql.jdbc.Driver");
			String username = (String)session.getAttribute("user1");
	%>
<body>

	<h2>Auctions You Have Won</h2>
	
		<%
		ResultSet rs;
		
		Statement stmt = con.createStatement();
		rs = stmt.executeQuery("select * from closedAuctions where auctionWinner='"+username+"'");
		while(rs.next()){
			
			
		%>
			
			
			<p>Vehicle Make:&nbsp;&nbsp;&nbsp;  <%= rs.getString("VehicleMake") %>&nbsp;&nbsp;&nbsp; </p>
			<p>Vehicle Model: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleModel") %>&nbsp;&nbsp;&nbsp; </p>
			<p>Vehicle Type: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleType") %>&nbsp;&nbsp;&nbsp; </p>
			<p> Winning Price: &nbsp;&nbsp;&nbsp;<%= rs.getString("winningBidPrice") %>&nbsp;&nbsp;&nbsp; </p>
			<p>------------------------------------------------------------------------------------</p>	
		
	<% } %>
		
	

	
	
	<h2> History of your Bids: </h2>	
		
		
			<% 
			ResultSet rs2;
			
			Statement stmt2 = con.createStatement();

			rs2 = stmt2.executeQuery("select * from bidHistory where bidderName='"+username+"'");
			while(rs2.next()){
				
			%>	
				
				
				<p>Auction Number:&nbsp;&nbsp;&nbsp;  <%= rs2.getString("auctionID") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Bid Price: &nbsp;&nbsp;&nbsp;<%= rs2.getString("bidPrice") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Bid Type: &nbsp;&nbsp;&nbsp;<%= rs2.getString("bidType") %>&nbsp;&nbsp;&nbsp; </p>
				<p>------------------------------------------------------------------------------------</p>	
			
		<% } %>
	
</body>
</html>