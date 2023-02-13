<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<div class ="navigation">
		
		<ul>
			
			<% 
						
				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
				
				try{
					 
					String user3 = (String)session.getAttribute("user1");
					
					ResultSet rs;
						
					//System.out.println(user3);
					
					Statement stmt = con.createStatement();
					
					rs = stmt.executeQuery("select * from account where username1= '"+user3+"'");
					
					
					while(rs.next()){
						
						String type = rs.getString("account_type");
						//System.out.println(type);
						
						if(type.equals("admin")){ %>
							<li><a href='adminHome.jsp'>Home</a></li>
							<%
							break;
						}
						else if(type.equals("customer rep")){ %>
							<li><a href='customerRepHome.jsp'>Home</a></li>
							<% 
							break;
						}
						else if(type.equals("customer")){ %>
							<li><a href='customerHome.jsp'>Home</a></li>
							<%
							break;
						}
					}
					
				} catch(Exception e){
					
				}
			%>
			
			<li><a href='search.jsp'>Search Auction</a></li>
			<li><a href='interestList.jsp'>Interest List</a></li>
			<li><a href='contactCenter.jsp'>Contact Center</a></li>
			<li><a href='logout.jsp'>Logout</a></li>
			
		</ul>
	</div>
</body>
</html>