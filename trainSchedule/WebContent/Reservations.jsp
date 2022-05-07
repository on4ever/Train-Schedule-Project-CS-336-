<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create A Reservation</title>
</head>
<body>

<%
    //int triptype = document.getElementById("trip_type").value;
	String triptype = request.getParameter("triptype");
	System.out.println(triptype);	
	
	if (triptype == null)
	{
		request.setAttribute("selectError", "ERROR: Please select a trip type.");
		request.getRequestDispatcher("CreatingReservation.jsp").forward(request, response);
		return;
	}
	
	String childorsenior = request.getParameter("userage");
	String disabled = request.getParameter("disabled");
	
	if (childorsenior == null)
	{
		request.setAttribute("selectError", "ERROR: Please select an age group.");
		request.getRequestDispatcher("CreatingReservation.jsp").forward(request, response);
		return;
	}
	
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
	
    java.util.Date utilDate = new java.util.Date();
	
	String reserveNum = "select max(reserve_num) from Reservation";
	int no = 50;
	PreparedStatement getNum = con.prepareStatement(reserveNum);
	ResultSet numSet = getNum.executeQuery();
	if (numSet.next())
	{
		no = Integer.parseInt(numSet.getString("max(reserve_num)")) + 1;
	}
	System.out.println(no);
	session.setAttribute("reserve_num", ""+no);
	
	
    String reseverationquery = "insert into Reservation(reserve_num, reserve_datetime, total_fare, trip_type, c_username, transit_line, origin_departure_datetime, destination_arrival_datetime, origin_station_id, destination_station_id, is_cancelled) values(?,?,?,?,?,?,?,?,?,?,?)";
    
    PreparedStatement stmt = con.prepareStatement(reseverationquery);
    
    double total_fare = (double)Integer.parseInt((String)session.getAttribute("base_fare"));
    
    if (triptype.equals("1"))
    {
    	total_fare *=2;
    }
   	if (childorsenior.equals("Child")) 
   	{
   		total_fare *= 0.75;
   	}
   	if (childorsenior.equals("Senior")) 
   	{
   		total_fare *= 0.65;
   	}
   	if (disabled != null) 
   	{
   		total_fare *= 0.5;
   	}
    
    stmt.setInt(1, no);
    stmt.setTimestamp(2, new Timestamp(utilDate.getTime()));
    stmt.setInt(3, (int)total_fare);
    stmt.setString(4, triptype);
    stmt.setString(5, (String)session.getAttribute("user"));
    stmt.setString(6, (String)session.getAttribute("transit_line"));
    stmt.setString(7, (String)session.getAttribute("origin_departure_datetime"));
    stmt.setString(8, (String)session.getAttribute("destination_arrival_datetime"));
    stmt.setString(9, (String)session.getAttribute("origin_station_id"));
    stmt.setString(10, (String)session.getAttribute("destination_station_id"));
    stmt.setString(11, "1");
    
    
    
    stmt.executeUpdate();
    
    request.setAttribute("successMessage", "Success! Your reservation has been entered.");
    request.getRequestDispatcher("ReservationList.jsp").forward(request, response);
	//double totalfare = Double.parseDouble(request.getParameter("total_fare"));
    
	
   // if (rs.next()) {
    //1) ask user if they would like to cancel or make a new reservation
	// is_cancelled = 1 to make reservation so we creating it now

	//2) ask user where they are (origin) and where they are heading to (destination)
	//that is the origin_departure_datetime, destination_arrival_datetime, origin_station_id, destination_station_id

	//3) ask user if the trip is round or one-way (1=round; 0=one-way)
  		/* if (triptype_value == 1){ //Round trip tickets have double fare
  			//total_fare = total_fare * 2;
  			String updateQuery = "insert into Reservation(total_fare) values (total_fare * 2)";
  		}
		
		//4) ask user if they are kids, senior, or disabled
		if (childorsenior_value.equals("Child")){// kids have 25% discount
			totalfare = totalfare - (totalfare * 0.25); 
  			String updateQuery = "insert into Reservation(total_fare) values (total_fare - (total_fare * 0.25))";
		}
		else if (childorsenior_value.equals("Senior")){// seniors have 35% discount
			totalfare = totalfare - (totalfare * 0.35); 
  			String updateQuery = "insert into Reservation(total_fare) values (total_fare - (total_fare * 0.35))";
		}
// 		else if (childorsenior_value.equals("Adult")){//comment out as this wouldn't really make a differnce 
// 			totalfare = totalfare; 
//   			String updateQuery = "insert into Reservation(total_fare) values (total_fare)";
// 		}
		else if (checkbox != null){// if box was checked, its disabled (or if the checkbox.length != empty as it would have something in array if disabled was checked on) //disabled have 50% discount
			totalfare = totalfare - (totalfare * 0.50);
			String updateQuery = "insert into Reservation(total_fare) values (total_fare - (total_fare * 0.50))";
		
		} */
			
		//5) caluculate total fare according to info from user and print it out (make user even put card details if you want)
		//System.out.println("Your total fare: " + totalfare);
		
  //  }
	
   
    
    
%>
</body>
</html>
