<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View All Auctions</title>
</head>
<body>

<%@ include file = "navigation.jsp"%>
<%
			
			Class.forName("com.mysql.jdbc.Driver");

	%>
	<h2>All Ongoing Auctions:</h2>
		
		<%
		try {
			
			ResultSet rs;
			
			
			Statement stmt = con.createStatement();

			rs = stmt.executeQuery("select * from ongoingAuctions");
			while(rs.next()){
				
				
			%>
				
				
				<p>Make:&nbsp;&nbsp;&nbsp;  <%= rs.getString("vehicleMake") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Model: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleModel") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Car Type: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleType") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Car Color: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleColor") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Mileage: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleMileage") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Year: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleYear") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Auction Price: &nbsp;&nbsp;&nbsp;<%= rs.getString("currentHighestBid") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Auction Closing Date: &nbsp;&nbsp;&nbsp;<%= rs.getString("auctionClosingDate") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Auction Closing Time: &nbsp;&nbsp;&nbsp;<%= rs.getString("auctionClosingTime") %>&nbsp;&nbsp;&nbsp; </p>

				<p>
					<form action="deleteAuction.jsp" method="POST"> 
						
						<input type="hidden" name="auctionID" value="<%= rs.getString("auctionID") %>"/>
						<input type="submit" value="Delete Auction"/>
					</form>				
				 </p>
				<p>----------------------------------------------------------------------------</p>
			
			<%
			}
		} catch (Exception e) {
			out.println("Add items to list");
		}
		%>
</body>
</html>