<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Current and Past reservations</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

	<%
   //request.setAttribute("user", "philFish");
	  String query = "select distinct origin_departure_datetime, transit_line, c_username, c.name, a.track_number, d.name, b.track_number, total_fare, reserve_num from Reservation, Station c, Station d, Stop a, Stop b where Reservation.origin_departure_datetime = a.departure_datetime && Reservation.origin_station_id = c.station_id && Reservation.destination_arrival_datetime = b.arrival_datetime && Reservation.destination_station_id = d.station_id && Reservation.is_cancelled = 1 && Reservation.c_username = ? && Reservation.origin_departure_datetime >= (SELECT CURRENT_TIMESTAMP) order by Reservation.origin_departure_datetime desc";  
		   
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1,(String)session.getAttribute("user"));
    ResultSet rs = stmt.executeQuery(); 
%>
		<br>
		<br>
		<div style="color:green">${successMessage}</div>
		<TABLE BORDER="1">
		<caption><b>Current</b> Reservations</caption>
            <TR>
                <TH>Departure Time</TH>
                <TH>Transit Line</TH>
                <TH>Customer Username</TH>
                
                <TH>Origin Station</TH>
                
                <TH>Origin Track Number</TH>
                
                <TH>Destination Station</TH>
                
                <TH>Destination Track Number</TH>
                <TH>Fare</TH>
                <TH>Reservation Number</TH>
                
            </TR>
            <% while(rs.next()){           
            
            	String no = (String)session.getAttribute("reserve_num");
            	if (no != null && no.equals(rs.getString("reserve_num")))
            	{
            		%> <tr style="color:green"> <%
            	}
            	else
            	{
            		%> <tr> <%
            	}
            %>
            
                <TD> <%= rs.getString(1) %></td>
                <TD> <%= rs.getString(2) %></TD>
                <TD> <%= rs.getString(3) %></TD>
                <TD> <%= rs.getString(4) %></TD>
                <TD> <%= rs.getString(5) %></TD>
                
                <TD> <%= rs.getString(6) %></TD>
                <TD> <%= rs.getString(7) %></TD>
                
                <TD> <%= rs.getString(8) %></TD>
                <TD> <%= rs.getString(9) %></TD>
                <td>
                	<form action="CancellingReservation.jsp" method="POST">
                		<input type="hidden" name="reservenum" value="<%=rs.getString("reserve_num") %>">
                		<a href="#" onclick="this.parentNode.submit();"> Cancel </a>
                	</form>
                </td>
                
            </TR>
            <% } %>
            
        </TABLE>
        <br>
        <br>
        <br>
        <br>
        <br>
	<%
	
		  String query2 = "select distinct origin_departure_datetime, transit_line, c_username, c.name, a.track_number, d.name, b.track_number, total_fare, reserve_num from Reservation, Station c, Station d, Stop a, Stop b where Reservation.origin_departure_datetime = a.departure_datetime && Reservation.origin_station_id = c.station_id && Reservation.destination_arrival_datetime = b.arrival_datetime && Reservation.destination_station_id = d.station_id && Reservation.is_cancelled = 1 && Reservation.c_username = ? && Reservation.origin_departure_datetime < (SELECT CURRENT_TIMESTAMP) order by Reservation.origin_departure_datetime desc";  
	    PreparedStatement stmt2 = con.prepareStatement(query2);
	    stmt2.setString(1,(String)session.getAttribute("user"));
	    ResultSet rs2 = stmt2.executeQuery(); 
	%>
			<TABLE BORDER="1">
			<caption><b>Past</b> Reservations</caption>
	            <TR>
	                <TH>Departure Time</TH>
	                <TH>Transit Line</TH>
	                <TH>Customer Username</TH>
	                
	                <TH>Origin Station</TH>
	                
	                <TH>Origin Track Number</TH>
	                
	                <TH>Destination Station</TH>
	                
	                <TH>Destination Track Number</TH>
	                <TH>Fare</TH>
	                <TH>Reservation Number</TH>
	                
	            </TR>
	            <% while(rs2.next()){ %>
	            <TR>
	                <TD> <%= rs2.getString(1) %></td>
	                <TD> <%= rs2.getString(2) %></TD>
	                <TD> <%= rs2.getString(3) %></TD>
	                <TD> <%= rs2.getString(4) %></TD>
	                <TD> <%= rs2.getString(5) %></TD>
	                
	                <TD> <%= rs2.getString(6) %></TD>
	                <TD> <%= rs2.getString(7) %></TD>
	                
	                <TD> <%= rs2.getString(8) %></TD>
	                <TD> <%= rs2.getString(9) %></TD>
	                
	            </TR>
	            <% } %>
	            
	        </TABLE>
	        <br>
        <br>
        <br>
        <br>
        <br>
		<%
        String query3 = "select distinct origin_departure_datetime, transit_line, c_username, c.name, a.track_number, d.name, b.track_number, total_fare, reserve_num from Reservation, Station c, Station d, Stop a, Stop b where Reservation.origin_departure_datetime = a.departure_datetime && Reservation.origin_station_id = c.station_id && Reservation.destination_arrival_datetime = b.arrival_datetime && Reservation.destination_station_id = d.station_id && Reservation.is_cancelled = 0 && Reservation.c_username = ?";  
	   	 
	        PreparedStatement stmt3 = con.prepareStatement(query3);
		    stmt3.setString(1,(String)session.getAttribute("user"));
		    ResultSet rs3 = stmt3.executeQuery(); 
		%>
				<TABLE BORDER="1">
				<caption><b>Cancelled</b> Reservations</caption>
		            <TR>
		                <TH>Departure Time</TH>
		                <TH>Transit Line</TH>
		                <TH>Customer Username</TH>
		                
		                <TH>Origin Station</TH>
		                
		                <TH>Origin Track Number</TH>
		                
		                <TH>Destination Station</TH>
		                
		                <TH>Destination Track Number</TH>
		                <TH>Fare</TH>
		                <TH>Reservation Number</TH>
		                
		            </TR>
		            <% while(rs3.next()){ %>
		            <TR>
		                <TD> <%= rs3.getString(1) %></td>
		                <TD> <%= rs3.getString(2) %></TD>
		                <TD> <%= rs3.getString(3) %></TD>
		                <TD> <%= rs3.getString(4) %></TD>
		                <TD> <%= rs3.getString(5) %></TD>
		                
		                <TD> <%= rs3.getString(6) %></TD>
		                <TD> <%= rs3.getString(7) %></TD>
		                
		                <TD> <%= rs3.getString(8) %></TD>
		                <TD> <%= rs3.getString(9) %></TD>
		                
		            </TR>
		            <% } %>
		            
		        </TABLE>
<p><a href='customerHome.jsp'>Back to home page.</a></p>
</body>
</html>