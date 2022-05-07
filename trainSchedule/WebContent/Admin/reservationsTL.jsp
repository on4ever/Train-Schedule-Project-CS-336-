<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservations by transit line</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

	<%
    
	 String query = "select distinct transit_line, c_username, origin_departure_datetime, c.name, a.track_number, d.name, b.track_number, total_fare, reserve_num from Reservation, Station c, Station d, Stop a, Stop b where Reservation.origin_departure_datetime = a.departure_datetime && Reservation.origin_station_id = c.station_id && Reservation.destination_arrival_datetime = b.arrival_datetime && Reservation.destination_station_id = d.station_id && Reservation.is_cancelled = 1 order by Reservation.transit_line";  
	   
	  	Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
	    PreparedStatement stmt = con.prepareStatement(query);
	    ResultSet rs = stmt.executeQuery(); 
	%>
			<TABLE BORDER="1">
			<caption>Reservations by Transit Line</caption>
	            <TR>
	                <TH>Transit Line</TH>
	                <TH>Customer Username</TH>
	                
	                <TH>Departure Time</TH>
	                <TH>Origin Station</TH>
	                
	                <TH>Origin Track Number</TH>
	                
	                <TH>Destination Station</TH>
	                
	                <TH>Destination Track Number</TH>
	                <TH>Fare</TH>
	                <TH>Reservation Number</TH>
	                
	            </TR>
	            <% while(rs.next()){ %>
	            <TR>
	                <TD> <%= rs.getString(1) %></td>
	                <TD> <%= rs.getString(2) %></TD>
	                <TD> <%= rs.getString(3) %></TD>
	                <TD> <%= rs.getString(4) %></TD>
	                <TD> <%= rs.getString(5) %></TD>
	                
	                <TD> <%= rs.getString(6) %></TD>
	                <TD> <%= rs.getString(7) %></TD>
	                
	                <TD> <%= rs.getString(8) %></TD>
	                <TD> <%= rs.getString(9) %></TD>
	                
	            </TR>
	            <% } %>
	            
	        </TABLE>
         <p>
        </p>
<a href='admin.jsp'>Return to admin page</a>
</body>
</html>