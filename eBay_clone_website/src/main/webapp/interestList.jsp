<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Interest List</title>
</head>


<%@ include file = "navigation.jsp"%>
<%
			
			Class.forName("com.mysql.jdbc.Driver");

	%>
<body>
	
	<div><h2>Enter Desired Criteria into Interest List:</h2></div>	
	
	<div>
	
		<form action="interestListSettings.jsp" method="POST"> 
			
			Make: <input type="text" name="make" placeholder="Enter Make">&nbsp;&nbsp;<br/> 
			
			Model:<input type="text" name="model" placeholder="Enter Model">&nbsp;&nbsp;<br/>
			
			<p></p>	
			Car type: </br>
			
			<input type = "radio" name="type" value="sedan"/>Sedan
			</br>
			<input type = "radio" name="type" value="suv"/>SUV
			</br>
			<input type = "radio" name="type" value="truck"/>Truck
			</br>
			<p></p>	
			
			Car Color:
			 </br>
			
			<input type = "radio" name="color" value ="red"/>red
			</br>
			<input type = "radio" name="color" value="white"/>white
			</br>
			<input type = "radio" name="color" value="blue"/>blue
			</br>
			<input type = "radio" name="color" value="black"/>black
			</br>
			<p></p>	
			
			
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
			
			
			Year: &nbsp;&nbsp;
			<select name="year">       
				
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
		
			
		<h2>Interest List: </h2>
		
		<%
		try {
			
			ResultSet rs;
			String username = (String)session.getAttribute("user1");	
			
			Statement stmt = con.createStatement();
			
			rs = stmt.executeQuery("select * from interestList where username = '"+username+"'");
			while(rs.next()){
				
				
			%>
				
				
				<p>Make:&nbsp;&nbsp;&nbsp;  <%= rs.getString("vehicleMake") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Model: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleModel") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Car Type: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleType") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Car Color: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleColor") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Mileage: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleMileage") %>&nbsp;&nbsp;&nbsp; </p>
				<p>Year: &nbsp;&nbsp;&nbsp;<%= rs.getString("vehicleYear") %>&nbsp;&nbsp;&nbsp; </p>

				<p>
					<form action="deleteFromInterestList.jsp" method="POST"> 
						
						<input type="hidden" name="interestListId" value="<%= rs.getString("interestListId") %>"/>
						<input type="submit" value="Remove"/>
					</form>				
				 </p>
				<p>----------------------------------------------------------------------------</p>
			
			<%
			}
		} catch (Exception e) {
			out.println("Add items to list");
		}
		%>
		
		</div>
			
	

	
	
</body>
</html>














