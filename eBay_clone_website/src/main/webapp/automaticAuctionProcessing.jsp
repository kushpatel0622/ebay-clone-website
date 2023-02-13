<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ page import = "java.sql.*" %>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
	
	String upperLimitAmount = request.getParameter("upperlimit");
	//System.out.println(upperLimitAmount);
	//Double upperLimitDouble = Double.parseDouble(upperLimitAmount);
	
	String username = (String)session.getAttribute("user1");
	
	String auccID = request.getParameter("auctionID");
	int ID = Integer.parseInt(auccID);
	
	//System.out.println(ID);
	
	ResultSet rs1;
	Statement st = con.createStatement();
	rs1 = st.executeQuery("select * from ongoingAuctions where auctionID="+ID);
	String curHighBid = "";
	
	while(rs1.next()){
		curHighBid = rs1.getString("currentHighestBid");
	}
	
	curHighBid = Double.toString(Double.parseDouble(curHighBid) + 1);
	
	Statement stmt = con.createStatement();
	int temp = stmt.executeUpdate("INSERT INTO bidHistory(auctionID, bidPrice, bidderName, bidType, upperLimit) VALUES ("+ID+","+curHighBid+", '"+username+"', 'auto',"+Double.parseDouble(upperLimitAmount)+")");
	
	Statement st2 = con.createStatement();
	int temp2 = st2.executeUpdate("UPDATE ongoingAuctions SET currentHighestBid = "+curHighBid+" WHERE auctionID ="+ID);
	//
	
	
	ResultSet rs3;
	Statement st3 = con.createStatement();
	rs3 = st3.executeQuery("SELECT count(*) FROM bidHistory WHERE auctionID = "+ID+" and bidType = 'auto'");
	
	String numberOfAutos = "";
	
	while(rs3.next()){
		numberOfAutos = rs3.getString("count(*)");
	}
	
	//System.out.println("Num of autos: " + numberOfAutos);
	
	if(Integer.parseInt(numberOfAutos) > 1){
		
		
	//	System.out.println("more than 1 auto");		
		ResultSet rs4;
		PreparedStatement st4 = con.prepareStatement("SELECT auctionID, bidderName, upperLimit FROM bidHistory WHERE bidType = ? and auctionID = ? and (upperLimit > ?) ORDER BY upperLimit DESC");
		
		st4.setString(1, "auto");
		st4.setString(2, auccID);
		st4.setString(3, curHighBid);
		
		rs4 = st4.executeQuery();
		
		int i = 0;
		
		String arr[][] = new String[2][3];
		
		while(rs4.next() && i < 2){
			
			
			String aucID = rs4.getString("auctionID");
			String bidName = rs4.getString("bidderName");
			String upperLimitNew = rs4.getString("upperLimit");
			
	//		System.out.println(aucID + " " + bidName + " " + upperLimitNew);
			
			
			
			arr[i][0] = aucID;
			arr[i][1] = bidName;
			arr[i][2] = upperLimitNew;
			
			i++;
		}
		
	//	System.out.println(arr[1][2]);
		String val = arr[1][2];
		String newCurHighBid = Double.toString(Double.parseDouble(val) + 1);
		
		String highestBidUser = arr[0][1];
		
		ResultSet rs5;
		Statement st5 = con.createStatement();
		//System.out.println("INSERT INTO bidHistory(auctionID, bidPrice, bidderName, bidType, upperLimit) VALUES (12,"+newCurHighBid+", "+highestBidUser+", 'auto', "+upperLimitAmount+")");
		//int updateBidHistory = st5.executeUpdate("INSERT INTO bidHistory(auctionID, bidPrice, bidderName, bidType, upperLimit) VALUES (37,"+newCurHighBid+", '"+highestBidUser+"', 'auto', "+upperLimitDouble+")");           
		int updateBidHistory = st5.executeUpdate("UPDATE bidHistory SET bidPrice = "+newCurHighBid+" WHERE auctionID = "+ID+" AND bidderName = '"+highestBidUser+"' AND upperLimit = "+Double.parseDouble(upperLimitAmount));
		ResultSet rs6;
		Statement st6 = con.createStatement();
		
		int updateOngoingAuction = st6.executeUpdate("UPDATE ongoingAuctions SET currentHighestBid = "+newCurHighBid+" WHERE auctionID ="+ID);
		
		
		
	}
	else if(Integer.parseInt(numberOfAutos) == 0){
		
		ResultSet rs10;
		Statement st10 = con.createStatement();
		
		rs10 = st10.executeQuery("SELECT currentHighestBid from ongoingAuction WHERE auctionID ="+ID);
		
		String curHighest = "";
		while(rs10.next()){
			curHighest = rs10.getString("currentHighestBid");
		}
		
		String curHighPlusOne = Double.toString(Double.parseDouble(curHighest) + 1);
		int updateBidHistory = st10.executeUpdate("UPDATE bidHistory SET bidPrice = "+curHighest+" WHERE auctionID = "+ID+" AND bidderName = "+username+" AND upperLimit = "+Double.parseDouble(upperLimitAmount));
		
		ResultSet rs6;
		Statement st6 = con.createStatement();
		
		int updateOngoingAuction = st6.executeUpdate("UPDATE ongoingAuctions SET currentHighestBid = "+curHighest+" WHERE auctionID ="+12);
		
		
		
	}
	
	
	out.println("Automatic Auction Successful! <a href='search.jsp'>Search More Auctions</a>");
	
	
	
	
	
%>