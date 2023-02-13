<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Sales report</title>
</head>

<%@ include file = "navigation.jsp"%>
	
	<%
			
			Class.forName("com.mysql.jdbc.Driver");

	%>
<body>
	
	<div> <h3>Choose Which Sales Report You Would Like:</h3> </div>
	
	<div>
	
		<form action="salesReport.jsp" method="POST"> 
			
			<select name="salesReportType" >       
				
				<option>Total Earnings</option>       
				<option>Earnings per item</option>       
				<option>Earnings per item type</option>   
				<option>Earnings from each user</option> 
				<option>Best-Selling Item</option>
				<option>Best Buyers</option>
		
			</select>    
	
		<div>
				<input type="submit"/>
		</div>
		 
		</form>
	
	</div>
	<% 
	String report = request.getParameter("salesReportType");
	
	try{
		
		ResultSet rs;
		
		if(report.equals("Total Earnings")){
			Statement stmt = con.createStatement();	
		
			rs = stmt.executeQuery("select sum(winningBidPrice) from closedAuctions");
			
			%>
			<h1>Total Earnings:</h1>
			
			<% 
			while(rs.next()){
			%>
			
				<p>Total Earnings: &nbsp;&nbsp;&nbsp; <%= rs.getString("sum(winningBidPrice)") %> </p>	
		<% } 
			
			 
			
		}
		else if(report.equals("Earnings per item")){
			Statement stmt = con.createStatement();	
			
			rs = stmt.executeQuery("select vehicleMake, vehicleModel, sum(winningBidPrice) from closedAuctions group by vehicleMake, vehicleModel");
			
			%>
			<h1>Earnings per Item:</h1>
			
			<%
			while(rs.next()){
			%>
				
				<p>Make:&nbsp;&nbsp;&nbsp; <%= rs.getString("vehicleMake") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Model:&nbsp;&nbsp;&nbsp; <%= rs.getString("vehicleModel") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Total Earnings:&nbsp;&nbsp;&nbsp; <%= rs.getString("sum(winningBidPrice)") %></p>
				
			<% }
			
		}
		else if(report.equals("Earnings per item type")){
			Statement stmt = con.createStatement();
			
			
			rs = stmt.executeQuery("select vehicleType, sum(winningBidPrice) from closedAuctions group by vehicleType");
			
			%>
			<h1>Earnings per Type:</h1>
			
			<%
			while(rs.next()){
			%>
			
				<p> Vehicle Type:&nbsp;&nbsp;&nbsp; <%= rs.getString("vehicleType") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Total Earnings:&nbsp;&nbsp;&nbsp; <%= rs.getString("sum(winningBidPrice)") %></p>
			
			<% 
			}
			
		}
		else if(report.equals("Earnings from each user")){
			Statement stmt = con.createStatement();	
			
			rs = stmt.executeQuery("select auctionWinner, sum(winningBidPrice) from closedAuctions group by auctionWinner");
			
			%>
			<h1>Earnings For Each User:</h1>
			
			<%
			while(rs.next()){
			%>
			
				<p> Username:&nbsp;&nbsp;&nbsp; <%= rs.getString("auctionWinner") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Total Earnings:&nbsp;&nbsp;&nbsp; <%= rs.getString("sum(winningBidPrice)") %></p>
			
			<% 
			}
		}
		else if(report.equals("Best-Selling Item")){
			Statement stmt = con.createStatement();
			
			rs = stmt.executeQuery("select vehicleMake, vehicleModel, sum(winningBidPrice), count(*) from closedAuctions group by vehicleMake , vehicleModel order by count(*) DESC");
			
			%>
			<h1>Best Selling Items:</h1>
			
			<%
			int bsi = 0;
			while(bsi < 3 && rs.next()){
				bsi++;
			%>
			
				<p> Make:&nbsp;&nbsp;&nbsp; <%= rs.getString("vehicleMake") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Model:&nbsp;&nbsp;&nbsp; <%= rs.getString("vehicleModel") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Total Earnings:&nbsp;&nbsp;&nbsp; <%= rs.getString("sum(winningBidPrice)") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Items Sold:&nbsp;&nbsp;&nbsp; <%= rs.getString("count(*)") %></p>
			
			<% 
			}
			
		}
		else if(report.equals("Best Buyers")){
			Statement stmt = con.createStatement(); 	
			
			rs = stmt.executeQuery("select auctionWinner, sum(winningBidPrice), count(*) from closedAuctions group by auctionWinner order by count(*) DESC");
			
			%>
			<h1>Best Buyers:</h1>
			
			<%
			int bi = 0;
			while(bi < 3 && rs.next()){
				bi++;
			%>
			
				<p> Username:&nbsp;&nbsp;&nbsp; <%= rs.getString("auctionWinner") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Total Earnings:&nbsp;&nbsp;&nbsp; <%= rs.getString("sum(winningBidPrice)") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Items Bought :&nbsp;&nbsp;&nbsp; <%= rs.getString("count(*)") %></p>
			 
			<% 
			}
			
		}
		else{
			%>
			<h3>Please Choose of the Sales Report Choices</h3>
			<% 
		}
		
	} catch (Exception e){
		
		out.println("Please Choose a Sales Report");
	}
	%>
</body>
</html>