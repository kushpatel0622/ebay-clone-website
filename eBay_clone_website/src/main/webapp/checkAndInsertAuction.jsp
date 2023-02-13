<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.regex.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%
	class localDate implements Comparable<localDate>{
	
	    private int year;
	    private int month;
	    private int day;
	
	    public localDate(String date){
	
	        StringTokenizer tok = new StringTokenizer(date, "/");
	        int counter = 0;
	
	        while(tok.hasMoreTokens()){
	
	            if(counter == 0) {
	                this.month = Integer.parseInt(tok.nextToken());
	            }
	            else if(counter == 1) {
	                this.day = Integer.parseInt(tok.nextToken());
	            }
	            else if(counter == 2){
	                this.year = Integer.parseInt(tok.nextToken());
	            }
	
	            counter++;
	
	        }
	
	    }
	    
	    public localDate(){
	    	
	    	int currentYear = Calendar.getInstance().get(Calendar.YEAR);
	        int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
	        int currentDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
	        
	        this.year = currentYear;
	        this.month = currentMonth;
	        this.day = currentDay;
	        
	    }
	
	    public String toString(){
	
	        final int MAX_DIGITS = 2;
	
	        int monthDigits = String.valueOf(month).length();
	        int dayDigits = String.valueOf(day).length();
	
	        if(monthDigits == 1 && dayDigits == 1){
	            return "0" + month + "/0" + day + "/" + year;
	        }
	        else if(monthDigits == 1 && dayDigits == MAX_DIGITS){
	            return "0" + month + "/" + day + "/" + year;
	        }
	        else if(monthDigits == MAX_DIGITS && dayDigits == 1){
	            return month + "/0" + day + "/" + year;
	        }
	        else{
	            return month + "/" + day + "/" + year;
	        }
	
	    }
	
	    public boolean isValid(){
	
	        final int QUADRENNIAL = 4;
	        final int CENTENNIAL = 100;
	        final int QUATERCENTENNIAL = 400;
	
	        final int JAN = 1;
	        final int MAR = 3;
	        final int APR = 4;
	        final int MAY = 5;
	        final int JUN = 6;
	        final int JUL = 7;
	        final int AUG = 8;
	        final int SEP = 9;
	        final int OCT = 10;
	        final int NOV = 11;
	        final int DEC = 12;
	
	        final int expectedMonthDaysOdd = 31;
	        final int expectedMonthDaysEven = 30;
	        final int expectedNonLeapFebDays = 28;
	        final int expectedLeapFebDays = 29;
	
	        boolean isLeapYear = false;
	
	        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
	        int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
	        int currentDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
	
	        
	        if(this.year < currentYear){
	            return false;
	        }
	        
	
	        if(this.month < 1 || this.month > DEC){
	            return false;
	        }
	
	        
	        if(this.month < currentMonth && this.year == currentYear){
	            return false;
	        }
	
	        if(this.month == currentMonth && this.year == currentYear){
	            if(this.day < currentDay){
	                return false;
	            }
	        }
	        
	
	        if(this.month == JAN || this.month == MAR || this.month == MAY || this.month == JUL
	                || this.month == AUG || this.month == OCT || this.month == DEC){
	            if(this.day < 1 || this.day > expectedMonthDaysOdd){
	                return false;
	            }
	            else{
	                return true;
	            }
	        }
	
	        else if(this.month == APR || this.month == JUN || this.month == SEP || this.month == NOV){
	            if(this.day < 1 || this.day > expectedMonthDaysEven){
	                return false;
	            }
	            else{
	                return true;
	            }
	        }
	
	        if(this.year % QUADRENNIAL != 0){
	            isLeapYear = false;
	        }
	        else if(this.year % CENTENNIAL != 0){
	            isLeapYear = true;
	        }
	        else if(this.year % QUATERCENTENNIAL != 0){
	            isLeapYear = false;
	        }
	        else{
	            isLeapYear = true;
	        }
	
	        if(isLeapYear == false){
	            if(this.day < 1 || this.day > expectedNonLeapFebDays){
	                return false;
	            }
	        }
	        else if(isLeapYear == true){
	            if(this.day < 1 || this.day > expectedLeapFebDays){
	                return false;
	            }
	        }
	
	        return true;
	
	    }
	
	    @Override
	    public int compareTo(localDate date){
	
	        if(year < date.year){
	            return -1;
	        }
	        else if(year == date.year){
	            if(month < date.month){
	                return -1;
	            }
	            else if(month == date.month){
	                if(day < date.day){
	                    return -1;
	                }
	                else if(day == date.day){
	                    return 0;
	                }
	            }
	        }
	
	        return 1;
	
	    }
	
	
	}
	
	
	String vehicleType = request.getParameter("vehicles");
	String vehicleMake = request.getParameter("make");
	String vehicleModel = request.getParameter("model");
	String vehicleColor = request.getParameter("color");
	String vehicleMileage = request.getParameter("mileage");
	String vehicleYear = request.getParameter("vehicleYear");
	String closingDate = request.getParameter("closingDate");
	String closingTime = request.getParameter("closingTime");
	String reservePrice = request.getParameter("hiddenPrice");
	
	if(vehicleMake.isEmpty() || vehicleModel.isEmpty() || closingDate.isEmpty() || closingTime.isEmpty() || reservePrice.isEmpty()){
		out.println("ERROR: One or More Fields are Invalid! <a href='createAuction.jsp'Back</a>");
		out.println("\n");
	}
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection con = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336proj", "root", "csAdminUser22");
		//System.out.println("Connected!"); // You can delete this later also
	} catch(SQLException ex){
		throw new Error("Error ", ex);
	}
	
	// Used for testing, you can delete these whenever
	/* System.out.println("Vehicle Type: " + vehicleType);
	System.out.println("Vehicle Make: " + vehicleMake);
	System.out.println("Vehicle Model: " + vehicleModel);
	System.out.println("Vehicle Color: " + vehicleColor);
	System.out.println("Vehicle Mileage: " + vehicleMileage);
	System.out.println("Vehicle Year: " + vehicleYear);
	System.out.println("Closing Date: " + closingDate);
	System.out.println("Closing Time: " + closingTime);
	System.out.println("Reserve Price: " + reservePrice); */
	
	localDate closeDate = new localDate(closingDate);
	
	if(!closeDate.isValid()){
		//System.out.println(closeDate.toString());
		out.println("Incorrect <b>Date<b> Field. <a href='createAuction.jsp'>try again");
		out.println("\n");
	}
	
	String regex = "([01]?[0-9]|2[0-3]):[0-5][0-9]";
	Pattern p = Pattern.compile(regex);
	Matcher m = p.matcher(closingTime);
	if(!m.matches()){
		out.println("Incorrect <b>Time<b> Field. <a href='createAuction.jsp'>try again");
		out.println("\n");
	}
	
	// if inputted date is equal to today, check if time is less than right now
	
	int curHour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
	int curMin = Calendar.getInstance().get(Calendar.MINUTE);
	if(closingDate.equals(new localDate().toString())){
		if(closingTime.substring(0,1).equals(Integer.toString(curHour))){
			if(Integer.parseInt(closingTime.substring(2,3)) < curMin){
				out.println("Invalid <b>Time<b> Field. <a href='createAuction.jsp'>try again");
				out.println("\n");
			}
		}
	}
	
	try{
		Statement state = con.createStatement();
		int temp = state.executeUpdate("INSERT INTO ongoingAuctions(vehicleType, vehicleMake, vehicleModel, vehicleColor, vehicleYear, vehicleMileage, auctionClosingDate, auctionClosingTime, auctionHiddenPrice, currentHighestBid) VALUES ('"+vehicleType+"','"+vehicleMake+"','"+vehicleModel+"','"+vehicleColor+"','"+vehicleYear+"','"+vehicleMileage+"','"+closingDate+"','"+closingTime+"','"+reservePrice+"','"+0+"')");
		out.println("Auction Created Successfully! <a href='createAuction.jsp'>Go Back To Create Auction</a>");
	}catch(Exception e){
		System.out.println(e);
		out.println("ERROR: Probable SQL Execution Failure! <a href='createAuction.jsp'>Back</a>");
		out.println("\n");
	}
	
	
	// Look through all of the ongoing auctions and see if they are still valid
	// Don't need to check the auction just created since it will be ongoing anyway
	// If an auction is invalidated, add it to closed and remove it from ongoing
	// 
	// The auctionID for closed auctions will come from ongoing (foreign key)
	// First, populate the auctionWinner (current session host)
	// Second, populate winningBidPrice (comes from currentHighestBid in ongoing) (foreign key)
	
	
	ResultSet rs;
	Statement stmt = con.createStatement();
			
	//rs = stmt.executeQuery("SELECT auctionID, vehicleClosingDate, vehicleClosingTime, currentHighestBid, vehicleType, vehicleMake, vehicleModel, auctionHiddenPrice FROM ongoingAuctions");
	rs = stmt.executeQuery("SELECT * FROM ongoingAuctions");
	
	while(rs.next()){
		
		//System.out.println("ENTERED 1");
		int aucID = rs.getInt("auctionID");
		
		String close_date = rs.getString("auctionClosingDate");
		String close_time = rs.getString("auctionClosingTime");
		String curHighestBid = rs.getString("currentHighestBid");
		String lowestSellPrice = rs.getString("auctionHiddenPrice");
		
		int currentHour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
		int currentMin = Calendar.getInstance().get(Calendar.MINUTE);
		//System.out.println(aucID + " | " + close_date + " | " + close_time.substring(0,2) + " | " + close_time.substring(3,5) + " | " + (new localDate().toString()) + " | " + currentHour + " | " + currentMin);
		if(close_date.equals(new localDate().toString())){
			//System.out.println("after 1");
			if(close_time.substring(0,2).equals(Integer.toString(currentHour)) || Integer.parseInt(close_time.substring(0,2)) < currentHour){
				//System.out.println("after 2");
				if(Integer.parseInt(close_time.substring(3,5)) < currentMin){
					
					//System.out.println("ENTERED 2");
					if(Double.parseDouble(curHighestBid) >= Double.parseDouble(lowestSellPrice) && Double.parseDouble(lowestSellPrice) != 0.0){
						// winner is achieved and also closed auction
						//System.out.println("winner is achieved");
						int closedAucID = aucID;
						
						ResultSet rs2;
						Statement state = con.createStatement();
						rs2 = state.executeQuery("SELECT bh.bidderName, bh.bidPrice, oa.currentHighestBid, oa.vehicleType, oa.vehicleMake, oa.vehicleModel FROM bidHistory bh, ongoingAuctions oa WHERE bh.bidPrice = oa.currentHighestBid and oa.auctionID = "+closedAucID+" and bh.auctionID = "+closedAucID);
						
						String auctionWinner = null;
						String winningBidPrice = null;
						String vType = null; 
						String vMake = null;
						String vModel = null;
					
						while(rs2.next()){
							//System.out.println("ENTERED 3");
							auctionWinner = rs2.getString("bh.bidderName");
							winningBidPrice = rs2.getString("oa.currentHighestBid");
							vType = rs2.getString("oa.vehicleType");
							vMake = rs2.getString("oa.vehicleMake");
							vModel = rs2.getString("oa.vehicleModel");
						}
						
						try{
							Statement closeState = con.createStatement();
						//	System.out.println("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
							int temp = state.executeUpdate("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
						}catch(Exception e){
							System.out.println("ERROR: Insertion to closedAuctions invalid | " + e);
						}
						
						// Now delete that auction from ongoingAuctions
						try{
							ResultSet rs3;
							Statement deleteState = con.createStatement();
						//	System.out.println("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
							int temp2 = state.executeUpdate("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
						}catch(Exception e){
							System.out.println("ERROR: Unable to delete table from ongoingAuctions | " + e);
						}
						
					}
					
					else{
						//System.out.println("no winner");
						// no winner but closed auction
						// so, auctionWinner is null and winningBidPrice is null
						
						
							// winner is achieved and also closed auction
							int closedAucID = aucID;
							
							ResultSet rs2;
							Statement state = con.createStatement();
							rs2 = state.executeQuery("SELECT bh.bidderName, bh.bidPrice, oa.currentHighestBid, oa.vehicleType, oa.vehicleMake, oa.vehicleModel FROM bidHistory bh, ongoingAuctions oa WHERE bh.bidPrice = oa.currentHighestBid and oa.auctionID = "+closedAucID+" and bh.auctionID = "+closedAucID);
							
							String auctionWinner = null;
							String winningBidPrice = null;
							String vType = null; 
							String vMake = null;
							String vModel = null;
						
							while(rs2.next()){
						//		System.out.println("ENTERED 3");
								vType = rs2.getString("oa.vehicleType");
								vMake = rs2.getString("oa.vehicleMake");
								vModel = rs2.getString("oa.vehicleModel");
							}
							
							try{
								Statement closeState = con.createStatement();
						//		System.out.println("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
								int temp = state.executeUpdate("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
							}catch(Exception e){
								System.out.println("ERROR: Insertion to closedAuctions invalid | " + e);
							}
							
							// Now delete that auction from ongoingAuctions
							try{
								ResultSet rs3;
								Statement deleteState = con.createStatement();
						//		System.out.println("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
								int temp2 = state.executeUpdate("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
							}catch(Exception e){
								System.out.println("ERROR: Unable to delete table from ongoingAuctions | " + e);
							}
						
						
						
						
					
					
				}
				
			}
			else if(Integer.parseInt(close_time.substring(0,2)) < currentHour){
	//			System.out.println("second else");
				if(Double.parseDouble(curHighestBid) >= Double.parseDouble(lowestSellPrice) && Double.parseDouble(lowestSellPrice) != 0.0){
					// winner is achieved and also closed auction
	//				System.out.println("winner is achieved");
					int closedAucID = aucID;
					
					ResultSet rs2;
					Statement state = con.createStatement();
					rs2 = state.executeQuery("SELECT bh.bidderName, bh.bidPrice, oa.currentHighestBid, oa.vehicleType, oa.vehicleMake, oa.vehicleModel FROM bidHistory bh, ongoingAuctions oa WHERE bh.bidPrice = oa.currentHighestBid and oa.auctionID = "+closedAucID+" and bh.auctionID = "+closedAucID);
					
					String auctionWinner = null;
					String winningBidPrice = null;
					String vType = null; 
					String vMake = null;
					String vModel = null;
				
					while(rs2.next()){
	//					System.out.println("ENTERED 3");
						auctionWinner = rs2.getString("bh.bidderName");
						winningBidPrice = rs2.getString("oa.currentHighestBid");
						vType = rs2.getString("oa.vehicleType");
						vMake = rs2.getString("oa.vehicleMake");
						vModel = rs2.getString("oa.vehicleModel");
					}
					
					try{
						Statement closeState = con.createStatement();
	//					System.out.println("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
						int temp = state.executeUpdate("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
					}catch(Exception e){
						System.out.println("ERROR: Insertion to closedAuctions invalid | " + e);
					}
					
					// Now delete that auction from ongoingAuctions
					try{
						ResultSet rs3;
						Statement deleteState = con.createStatement();
	//					System.out.println("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
						int temp2 = state.executeUpdate("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
					}catch(Exception e){
						System.out.println("ERROR: Unable to delete table from ongoingAuctions | " + e);
					}
					
				}
				
				else{
					// no winner but closed auction
					// so, auctionWinner is null and winningBidPrice is null
					
	//					System.out.println("no winner");
						// winner is achieved and also closed auction
						int closedAucID = aucID;
						
						ResultSet rs2;
						Statement state = con.createStatement();
						rs2 = state.executeQuery("SELECT bh.bidderName, bh.bidPrice, oa.currentHighestBid, oa.vehicleType, oa.vehicleMake, oa.vehicleModel FROM bidHistory bh, ongoingAuctions oa WHERE bh.bidPrice = oa.currentHighestBid and oa.auctionID = "+closedAucID+" and bh.auctionID = "+closedAucID);
						
						String auctionWinner = null;
						String winningBidPrice = null;
						String vType = null; 
						String vMake = null;
						String vModel = null;
					
						while(rs2.next()){
	//						System.out.println("ENTERED 3");
							vType = rs2.getString("oa.vehicleType");
							vMake = rs2.getString("oa.vehicleMake");
							vModel = rs2.getString("oa.vehicleModel");
						}
						
						try{
							Statement closeState = con.createStatement();
	//						System.out.println("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
							int temp = state.executeUpdate("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
						}catch(Exception e){
							System.out.println("ERROR: Insertion to closedAuctions invalid | " + e);
						}
						
						// Now delete that auction from ongoingAuctions
						try{
							ResultSet rs3;
							Statement deleteState = con.createStatement();
	//						System.out.println("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
							int temp2 = state.executeUpdate("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
						}catch(Exception e){
							System.out.println("ERROR: Unable to delete table from ongoingAuctions | " + e);
						}
					
					
					
					
				
				
				}
				
				
			
			}
	
			
				
			
		}
		
		else if(new localDate(close_date).compareTo(new localDate()) == -1){
	//		System.out.println("third else");
			if(Double.parseDouble(curHighestBid) >= Double.parseDouble(lowestSellPrice) && Double.parseDouble(lowestSellPrice) != 0.0){
				// winner is achieved and also closed auction
	//			System.out.println("winner is achieved");
				int closedAucID = aucID;
				
				ResultSet rs2;
				Statement state = con.createStatement();
				rs2 = state.executeQuery("SELECT bh.bidderName, bh.bidPrice, oa.currentHighestBid, oa.vehicleType, oa.vehicleMake, oa.vehicleModel FROM bidHistory bh, ongoingAuctions oa WHERE bh.bidPrice = oa.currentHighestBid and oa.auctionID = "+closedAucID+" and bh.auctionID = "+closedAucID);
				
				String auctionWinner = null;
				String winningBidPrice = null;
				String vType = null; 
				String vMake = null;
				String vModel = null;
			
				while(rs2.next()){
	//				System.out.println("ENTERED 3");
					auctionWinner = rs2.getString("bh.bidderName");
					winningBidPrice = rs2.getString("oa.currentHighestBid");
					vType = rs2.getString("oa.vehicleType");
					vMake = rs2.getString("oa.vehicleMake");
					vModel = rs2.getString("oa.vehicleModel");
				}
				
				try{
					Statement closeState = con.createStatement();
	//				System.out.println("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
					int temp = state.executeUpdate("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
				}catch(Exception e){
					System.out.println("ERROR: Insertion to closedAuctions invalid | " + e);
				}
				
				// Now delete that auction from ongoingAuctions
				try{
					ResultSet rs3;
					Statement deleteState = con.createStatement();
	//				System.out.println("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
					int temp2 = state.executeUpdate("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
				}catch(Exception e){
					System.out.println("ERROR: Unable to delete table from ongoingAuctions | " + e);
				}
				
			}
			
			else{
				// no winner but closed auction
				// so, auctionWinner is null and winningBidPrice is null
				
					System.out.println("no winner");
				
					// winner is achieved and also closed auction
					int closedAucID = aucID;
					
					ResultSet rs2;
					Statement state = con.createStatement();
					rs2 = state.executeQuery("SELECT bh.bidderName, bh.bidPrice, oa.currentHighestBid, oa.vehicleType, oa.vehicleMake, oa.vehicleModel FROM bidHistory bh, ongoingAuctions oa WHERE bh.bidPrice = oa.currentHighestBid and oa.auctionID = "+closedAucID+" and bh.auctionID = "+closedAucID);
					
					String auctionWinner = null;
					String winningBidPrice = null;
					String vType = null; 
					String vMake = null;
					String vModel = null;
				
					while(rs2.next()){
	//					System.out.println("ENTERED 3");
						vType = rs2.getString("oa.vehicleType");
						vMake = rs2.getString("oa.vehicleMake");
						vModel = rs2.getString("oa.vehicleModel");
					}
					
					try{
						Statement closeState = con.createStatement();
	//					System.out.println("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
						int temp = state.executeUpdate("INSERT INTO closedAuctions(auctionID, auctionWinner, winningBidPrice, vehicleType, vehicleMake, vehicleModel) VALUES ('"+aucID+"','"+auctionWinner+"','"+winningBidPrice+"','"+vType+"','"+vMake+"','"+vModel+"')");
					}catch(Exception e){
						System.out.println("ERROR: Insertion to closedAuctions invalid | " + e);
					}
					
					// Now delete that auction from ongoingAuctions
					try{
						ResultSet rs3;
						Statement deleteState = con.createStatement();
	//					System.out.println("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
						int temp2 = state.executeUpdate("DELETE FROM ongoingAuctions WHERE auctionID = "+closedAucID);
					}catch(Exception e){
						System.out.println("ERROR: Unable to delete table from ongoingAuctions | " + e);
					}
				
				
				
				
			
			
			}
			
	
		
		}
		
		
	}
		
}
	
		
		
	
	
	
	
	
	
	
	
%>