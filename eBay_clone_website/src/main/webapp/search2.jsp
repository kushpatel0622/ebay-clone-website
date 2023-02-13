<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Auction</title>
</head>


<%@ include file = "navigation.jsp"%>
<%
			
			Class.forName("com.mysql.jdbc.Driver");

	%>
<body>
	
	<div><h2>Search for Cars On Auction:</h2></div>	
	
	<div>
	
		<form action="search2.jsp" method="POST"> 
			
			Make: <input type="text" name="make" placeholder="Enter Make">&nbsp;&nbsp;<br/> 
			
			Model:<input type="text" name="model" placeholder="Enter Model">&nbsp;&nbsp;<br/>
			
			<p></p>	
			Car type: </br>
			
			Car type:&nbsp;&nbsp; 
			
			<select name = "type" >
				
				<option>Choose Car Type</option>
				<option>sedan</option>
				<option>suv</option>
				<option>truck</option>			
				
			</select>
			</br>
			<p></p>	
			
			Car Color: &nbsp;&nbsp;
			
			<select name = "color">
				
				<option>Choose Car Color</option>
				<option>black</option>
				<option>white</option>
				<option>red</option>
				<option>blue</option>
							
			</select>
			</br>
			<p></p>	
			
			
			Mileage: &nbsp;&nbsp;
			<select name="mileage" >       
				
				<option>Choose Mileage</option>	       
				<option>less than 10000</option>       
				<option>less than 20000</option>   
				<option>less than 30000</option> 
				<option>less than 40000</option>
				<option>less than 50000</option>
				<option>less than 60000</option>
				<option>less than 70000</option>
				<option>less than 80000</option>
				<option>less than 90000</option>
				<option>less than 99999</option>
			</select>
			
			
			Year: &nbsp;&nbsp;
			<select name="year">       
				
				<option>Choose Car Year</option>
				<option>2010</option>       
				<option>2011</option>       
				<option>2012</option>   
				<option>2013</option> 
				<option>2014</option>
				<option>2015</option>
				<option>2016</option>
				<option>2016</option>
				<option>2017</option>
				<option>2018</option>
				<option>2019</option>
				<option>2020</option>
				<option>2021</option>
			</select>  
			   
			<p></p>	
		<div>
				<input type="submit"/>
		</div>
		 
		</form>
		
			
		<h2>Car Auction's Found That Match Search:</h2>
		
		<%
			
				String make = request.getParameter("make");
				String model = request.getParameter("model");
				String carType = request.getParameter("type");
				String carColor = request.getParameter("color");
				String year = request.getParameter("year");
				String mileage = request.getParameter("mileage");
				
				int makeTrigger = 0;
				int modelTrigger = 0;
				int colorTrigger = 0;
				int yearTrigger = 0;
				int mileageTrigger = 0;
				int typeTrigger = 0;
				
					
					try{
					
					String tempClause = "select * from ongoingAuctions where vehicleType='"+carType+"' and vehicleMake='"+make+"' and vehicleModel='"+model+"' and vehicleColor='"+carColor+"' and vehicleYear='"+year+"' ";
					
					if(make.isEmpty() || make == null){
						//System.out.println("this clause is working properly");
						tempClause = tempClause.replaceAll("and vehicleMake='"+make+"' ","");
						makeTrigger = 1;
					}
					//check make
					//System.out.println(tempClause);
					
					if(model.isEmpty() || model == null){
						
						tempClause = tempClause.replaceAll("and vehicleModel='"+model+"' ","");
						modelTrigger = 1;
					}
					//check model
					//System.out.println(tempClause);
					
					if(year.equals("Choose Car Year")){
						
						tempClause = tempClause.replaceAll("and vehicleYear='"+year+"' ","");
						yearTrigger = 1;;
					}
					//check car year
					//System.out.println(tempClause);
					
					if(mileage.equals("Choose Mileage")){
						
						tempClause = tempClause.replaceAll("and vehicleMileage='"+mileage+"'","");
						mileageTrigger = 1;
					}
					
					//System.out.println(tempClause);
					
					
					if(carColor.equals("Choose Car Color")){
						
						tempClause = tempClause.replaceAll("and vehicleColor='"+carColor+"' ","");
						colorTrigger = 1;
					}
					
					//System.out.println(tempClause);
					
					if(carType.equals("Choose Car Type") && (makeTrigger == 0 || modelTrigger == 0 || yearTrigger == 0 || colorTrigger == 0)){
						
						tempClause = tempClause.replaceAll("vehicleType='"+carType+"' and ","");
						typeTrigger = 1;
						
					}
					else if(carType.equals("Choose Car Type")){
						tempClause = tempClause.replaceAll("vehicleType='"+carType+"'","");
						typeTrigger = 1;
					}
					
					//System.out.println(tempClause);
					
					if(makeTrigger == 1 && modelTrigger == 1 && yearTrigger == 1 && colorTrigger == 1 && typeTrigger == 1){
						tempClause = tempClause.replaceAll(" where ","");
					}
					
					int m1 = 0;
					if(mileageTrigger == 0){
						String mileage2 = mileage.substring(10,15);
						m1 = Integer.parseInt(mileage2);
					}
					
					//System.out.println(tempClause);
					//System.out.println(m1);
					//System.out.println(mileageTrigger);
					
					ResultSet rs;
					
					
			
					Statement stmt = con.createStatement();
					rs = stmt.executeQuery(tempClause);
					
					
					while(rs.next()){
						
						String vMile = rs.getString("vehicleMileage");
						//System.out.println(vMile);
						String vvMile = vMile.substring(10, 15);
						int m2 = Integer.parseInt(vvMile);
						
						//System.out.println(m2);
						
					if((m2 <= m1 && mileageTrigger == 0) || mileageTrigger == 1){
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
						<form action="displayAuction.jsp" method="POST"> 
						
							<input type="hidden" name="auctionID" value="<%= rs.getString("auctionID") %>"/>
							<input type="submit" value="Go To Auction"/>
						</form>				
				 	</p>
					<p>----------------------------------------------------------------------------</p>
					
					<%
					}
					else if(m2>m1 && mileageTrigger == 0){ %>
						<p>No Valid Items Fit The Search</p>
				<% 	}
					
					}
			} catch (Exception e) {
				out.println("No Auctions That Match Results");
				}
	 		
				
				%>
	
		
		</div>
			
	

	
	
</body>
</html>