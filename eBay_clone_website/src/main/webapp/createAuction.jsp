<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file = "navigation.jsp"%>
<%
			
			Class.forName("com.mysql.jdbc.Driver");

	%>
<meta charset="ISO-8859-1">
<title>Create Auction</title>
</head>
<body>

	<div>
		<h2>Create New Auction</h2>
	</div>
	
<div><form action="checkAndInsertAuction.jsp" method="POST">

	<label for="vehicles">Choose a Vehicle Type:</label>
	<select name="vehicles" id="vehicles">
		<option value="Sedan">Sedan</option>
		<option value="SUV">SUV</option>
		<option value="Truck">Truck</option>
	</select>
	
	<br>
	
	<label for="make">Type the Vehicle Make:</label>
	<input type="text" id="make" name="make" placeholder="Honda">
	
	<br>
	
	<label for="model">Type the Vehicle Model</label>
	<input type="text" id="model" name="model" placeholder="Civic">
	
	<br>
	
	<label for="color">Choose a Color:</label>
	<select name="color" id="color">
		<option value="Black">Black</option>
		<option value="White">White</option>
		<option value="Red">Red</option>
		<option value="blue">Blue</option>
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
			
			&nbsp;&nbsp;&nbsp;&nbsp;
	
	<br>
	
	Year: &nbsp;&nbsp;
	<select name="vehicleYear">
		<option>2010</option>
		<option>2011</option>
		<option>2012</option>
		<option>2013</option>
		<option>2014</option>
		<option>2015</option>
		<option>2016</option>
		<option>2017</option>
		<option>2018</option>
		<option>2019</option>
		<option>2020</option>
		<option>2021</option>
	</select>
	
	<br>
	
	<label for="Closing Date">Closing Date:</label>
	<input type="date" id="closingDate" name="closingDate" placeholder="01/01/2021">
	<small>Format: mm/dd/yyyy</small><br>
	<label for="Closing Time">Closing Time:</label>
	<input type="time" id="time" name="closingTime" min="00:00" max="24:00" placeholder="14:30">
	<small>Range: (00:00 - 23:59) | Format: hh:mm</small>
	
	<br>
	
	<label for="hiddenPrice">Hidden Price (Reserve)</label>
	<input type="number" id="hiddenPrice" name="hiddenPrice" min="0.00" max="100000.00" step="100.00" placeholder="0.00" />
	<small>Default Reserve: $0.00</small>
	
	<br>
	<br>
	
	<input type="submit" value="Create Auction">
</form></div>
	
	
	
	
	

</body>
</html>
</body>
</html>
