<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
<title>Listing</title>
</head>
<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<br/>
<br/>
<form action="repShowCustomerReservationsTL.jsp">
	Search by Transit Line:<input type="text" name="transitLine" required> <input type="submit" value="search">
</form>
<form action="repShowCustomerReservationsD.jsp">
	Search by Departure Date (yyyy-mm-dd):<input type="text" name="date" required> <input type="submit" value="search">
</form>
<form action="repShowCustomerReservations.jsp">
	<input type="submit" value="Show all Reservations">
</form>
<br/>
<%

	
		

		String query = "select * from Reservation where date(origin_departure_datetime)='" + request.getParameter("date") + "'";
		String query3 = "select * from Reservation";
		

		String query2 = "select name from Station where station_id=?";
    
  		Class.forName("com.mysql.jdbc.Driver");
    	Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    	
    	PreparedStatement stmt;
    	SimpleDateFormat sdfrmt = new SimpleDateFormat("yyyy-MM-dd");
    	sdfrmt.setLenient(false);
    	/* Create Date object
     	* parse the string into date 
         */
    	try
    	{	
        	Date javaDate = sdfrmt.parse(request.getParameter("date")); 
        	stmt = con.prepareStatement(query);
    	}
    	/* Date format is invalid */
    	catch (ParseException e)
    	{
    		stmt = con.prepareStatement(query3);
        	
    	}
    	
    	ResultSet rs = stmt.executeQuery();
    	
    	PreparedStatement origin = con.prepareStatement(query2);
    	PreparedStatement destination = con.prepareStatement(query2);
    	
    	%>
		<TABLE BORDER="1">
            <TR>
                <TH>Customer Username</TH>
                <TH>Transit Line</TH>
                <th>Origin</th>
                <th>Destination</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Cancellation Status</th>
            </TR>
            <% while(rs.next()){ 
            	origin.setString(1, rs.getString("origin_station_id"));
            	destination.setString(1, rs.getString("destination_station_id"));
            	ResultSet rsOrigin = origin.executeQuery();
            	ResultSet rsDestination = destination.executeQuery();
            	String originName = "";
            	String destinationName = "";
            	
            	while (rsOrigin.next())
            	{
            		originName = rsOrigin.getString("name");
            	}
            	while (rsDestination.next())
            	{
            		destinationName = rsDestination.getString("name");
            	} 
            	String status = "";
            	if (rs.getString("is_cancelled").equals("0"))
            	{
            		status = "CANCELLED";
            	}
            	else
            	{
            		status = "RESERVED";
            	}
            %>
            <TR>
                <TD> <%= rs.getString("c_username") %></td>
                <TD> <%= rs.getString("transit_line") %></TD>
                <TD> <%= originName %></TD>
                <TD> <%= destinationName %></TD>
                <TD> <%= rs.getString("origin_departure_datetime") %></TD>
                <TD> <%= rs.getString("destination_arrival_datetime") %></TD>
                <TD> <%= status %></TD>
                
            </TR>
            <% } %>
        </TABLE>
        <p><a href='customerRepHome.jsp'>Go to home page</a></p>
</body>
</html>