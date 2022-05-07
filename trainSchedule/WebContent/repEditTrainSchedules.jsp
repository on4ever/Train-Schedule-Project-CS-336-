<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
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
<br/>
<%
	String query = "select * from TrainSchedule where transit_line=? and train_id=?" +
			" and origin_station_id=? and destination_station_id=?"
					+ " and origin_departure_datetime=? and destination_arrival_datetime=?";
	String query2 = "select name from Station where station_id=?";
    
  		Class.forName("com.mysql.jdbc.Driver");
    	Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    	PreparedStatement stmt = con.prepareStatement(query);
    	stmt.setString(1, (String)session.getAttribute("transit_line"));
    	stmt.setString(2, (String)session.getAttribute("train_id"));
    	stmt.setString(3, (String)session.getAttribute("origin_station_id"));
    	stmt.setString(4, (String)session.getAttribute("destination_station_id"));
    	stmt.setString(5, (String)session.getAttribute("origin_departure_datetime"));
    	stmt.setString(6, (String)session.getAttribute("destination_arrival_datetime"));
    	ResultSet rs = stmt.executeQuery();
    	
    	PreparedStatement origin = con.prepareStatement(query2);
    	PreparedStatement destination = con.prepareStatement(query2);
    	
    	%>
		<TABLE BORDER="1">
            <TR>
                <TH>Transit Line</TH>
                <TH>Train ID</TH>
                <th>Origin</th>
                <th>Origin Track Number</th>
                <th>Destination</th>
                <th>Destination Track Number</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Base Fare</th>
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
            	
            	session.setAttribute("base_fare", rs.getString("base_fare"));
            	
            	String status = "";
            	if (rs.getString("cancellationStatus").equals("0"))
            	{
            		status = "CANCELLED";
            	}
            	else
            	{
            		status = "ON SCHEDULE";
            	}
            	session.setAttribute("cancellationStatus", rs.getString("cancellationStatus"));
            %>
            <TR>
                <TD> <%= rs.getString("transit_line") %></td>
                <TD> <%= rs.getString("train_id") %></TD>
                <TD> <%= originName + " (" + rs.getString("origin_station_id") + ")"%></TD>
                <TD> <%= rs.getString("origin_track_number") %></TD>
                <TD> <%= destinationName + " (" + rs.getString("destination_station_id") + ")"%></TD>
                <TD> <%= rs.getString("destination_track_number") %></TD>
                <TD> <%= rs.getString("origin_departure_datetime") %></TD>
                <TD> <%= rs.getString("destination_arrival_datetime") %></TD>
                <TD> <%= rs.getString("base_fare") %></TD>
                <td><%=status %></td>
                
                
            </TR>
            <% } %>
        </TABLE>
<fieldset>
<legend>Options</legend>
<form action="repMakeTrainChange.jsp">
	Set Train ID:<input type="number" name="newTrainID"><br>
	Set Base Fare:<input type="number" name="newBaseFare"><br>
	Set Status (0 if cancelled, 1 if on schedule):<input type="number" name="cancellationStatus"><br>
	<input type="submit">
</form>
</fieldset>
<p><a href='repShowTrainSchedules.jsp'>Go to Train Schedules</a></p>
</body>
</html>