<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-88512-1">
<title>Bid</title>
</head>

<%@ include file = "navigation.jsp"%>
<%
			
			Class.forName("com.mysql.jdbc.Driver");

	%>

<body>

		<%	
			String username = (String)session.getAttribute("user1");
			
			String aucID = request.getParameter("auctionID");
			//System.out.println(aucID);
			int ID = Integer.parseInt(aucID);
			
			ResultSet rs;
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("select * from ongoingAuctions where auctionID="+ID);
			while(rs.next()){
		%>

			<h2>Auction Information:</h2>

				<p>AuctionID:&nbsp;&nbsp;&nbsp; <%= rs.getString("auctionID") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Make:&nbsp;&nbsp;&nbsp;  <%= rs.getString("vehicleMake") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Model: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleModel") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Car Type: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleType") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Car Color: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleColor") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Mileage: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleMileage") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Year: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleYear") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Auction Current Highest Bid: &nbsp;&nbsp;&nbsp;<%= rs.getString("currentHighestBid") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Auction Closing Date: &nbsp;&nbsp;&nbsp;<%= rs.getString("auctionClosingDate") %>&nbsp;&nbsp;&nbsp; </p>

				<p>Auction Closing Time: &nbsp;&nbsp;&nbsp;<%= rs.getString("auctionClosingTime") %>&nbsp;&nbsp;&nbsp; </p>

		<p></p>	

		<% } %>

			Type of Bidding: </br>

			

			<input type = "radio" name="type" value="Automatic"/>Automatic

			</br>

			<input type = "radio" name="type" value="Manual"/>Manual

			</br>

			<p></p>	

			

			<h4>If manual</h4>

			<div>

				<form action="manualAuctionProcessing.jsp" method="POST">

					Bid: <input type="text" name="bid" placeholder="Enter Bid Amount"><br/> 
					
					<input type="hidden" name="auctionID" value="<%=request.getParameter("auctionID") %>"/>
			
					<input type="submit" value="Submit Bid" >

				</form>
				
				
			</div>

			

			<h4>If Automatic</h4>

			<div>

				<form action="automaticAuctionProcessing.jsp" method="POST">

					Bid: <input type="text" name="upperlimit" placeholder="Enter Upper Limit Amount"><br/> 
					
					<input type="hidden" name="auctionID" value="<%=request.getParameter("auctionID") %>"/>
					<input type="submit" value="Submit Upper Limit" >

				</form>

			</div>




</body>
</html>
