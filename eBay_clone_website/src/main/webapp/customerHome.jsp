<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>


<%	
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
%>
		<ul>
		
			<li><a href='customerHome.jsp'>Home</a></li>
			<li><a href='search.jsp'>Search</a></li>
			<li><a href='createAuction.jsp'>Create Auction</a></li>
			<li><a href='contactCenter.jsp'>Contact center</a></li>
			<li><a href='bidHistory.jsp'>Bid History</a></li>
			<li><a href='interestList.jsp'>Interest List</a></li>
			<li><a href='accountSettings.jsp'>Account Settings</a></li>
			<li><a href='logout.jsp'>Logout</a></li>		
			
		</ul>
		<% 
		String username = (String)session.getAttribute("user1"); 	
		
try {
			
			ResultSet rs;	
			
			Statement stmt = con.createStatement();
			//System.out.println(username);
			
			rs = stmt.executeQuery("select * from interestList where username= '"+username+"'");
			while(rs.next()){
				
				
			
				
				
				String make = rs.getString("vehicleMake");
				String model= rs.getString("vehicleModel"); 
				String carType = rs.getString("vehicleType"); 
				String carColor = rs.getString("vehicleColor"); 
				String temp_mileage = rs.getString("vehicleMileage"); 
				String year = rs.getString("vehicleYear"); 
				
				
				
				
				

				ResultSet rs2;
				
				PreparedStatement stmt2 = con.prepareStatement("select * from ongoingAuctions where vehicleType=? and vehicleMake=? and vehicleModel=? and vehicleColor=? and vehicleYear=?");
				stmt2.setString(1,carType);
				stmt2.setString(2,make);
				stmt2.setString(3,model);
				stmt2.setString(4,carColor);
				stmt2.setString(5,year);
				//stmt2.setString(6,temp_mileage);
				
				String mileage = temp_mileage.substring(10,15);
				int m1 = Integer.parseInt(mileage);
				
				//System.out.print
				rs2 = stmt2.executeQuery();
				
				while(rs2.next()){ 
				
					String temp2 = rs2.getString("vehicleMileage");
					String temp3 = temp2.substring(10,15);
					int m2 = Integer.parseInt(temp3);
				
					if(m1 >= m2){
					%>
					<h2>An Item On Your Interest List Has Appeared For Auction</h2>
				
					<p>Make:&nbsp;&nbsp;&nbsp;  <%= rs2.getString("vehicleMake") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Model: &nbsp;&nbsp;&nbsp;<%= rs2.getString("vehicleModel") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Car Type: &nbsp;&nbsp;&nbsp;<%= rs2.getString("vehicleType") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Car Color: &nbsp;&nbsp;&nbsp;<%= rs2.getString("vehicleColor") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Mileage: &nbsp;&nbsp;&nbsp;<%= rs2.getString("vehicleMileage") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Year: &nbsp;&nbsp;&nbsp;<%= rs2.getString("vehicleYear") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Auction Closing Date: &nbsp;&nbsp;&nbsp;<%= rs2.getString("auctionClosingDate") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Auction Closing Time: &nbsp;&nbsp;&nbsp;<%= rs2.getString("auctionClosingTime") %>&nbsp;&nbsp;&nbsp; </p>
					<p>Auction Price: &nbsp;&nbsp;&nbsp;<%= rs2.getString("currentHighestBid") %>&nbsp;&nbsp;&nbsp; </p>
					<p>
					<form action="displayAuction.jsp" method="POST"> 
						
						<input type="hidden" name="auctionID" value="<%= rs.getString("auctionID") %>"/>
						<input type="submit" value="Go To Auction"/>
					</form>				
				 	</p>
					
				<% 	} 
			}%>
				<p>----------------------------------------------------------------------------</p>
		<% 	}
		}catch (Exception e) {
			out.println("Add items to list");
		}
		%>
		
		
		
		
</body>
</html>