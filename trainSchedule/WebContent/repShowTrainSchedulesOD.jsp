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
		String search_origin_id = request.getParameter("origin_station_id");
		String search_destination_id = request.getParameter("destination_station_id");
		
		String query = "select * from TrainSchedule where origin_station_id=? and destination_station_id=?";
		
		
		
		
		String query2 = "select name from Station where station_id=?";
    
  		Class.forName("com.mysql.jdbc.Driver");
    	Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    	PreparedStatement stmt = con.prepareStatement(query);
    	stmt.setString(1, search_origin_id);
    	stmt.setString(2, search_destination_id);
    	ResultSet rs = stmt.executeQuery();
    	
    	PreparedStatement origin = con.prepareStatement(query2);
    	PreparedStatement destination = con.prepareStatement(query2);
    	
    	%>
    	<form action="repShowTrainSchedulesOD.jsp">
    		Origin Station ID:<input type="number" name="origin_station_id" required>
    		Destination Station ID:<input type="number" name="destination_station_id" required>
    		<input type="submit" value="search">
    	</form>
    	<form action="repShowTrainSchedules.jsp">
    		<input type="submit" value="show all">
    	</form>
		<TABLE style="display: inline-block;" BORDER="1">
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
            	String status = "";
            	if (rs.getString("cancellationStatus").equals("0"))
            	{
            		status = "CANCELLED";
            	}
            	else
            	{
            		status = "ON SCHEDULE";
            	}
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
                <td> <%= status %></td>
                <td> 
                	<form action="repCheckTrainSchedules.jsp" method="post">
    				<input type="hidden" name="transit_line" value="<%=rs.getString("transit_line")%>"/>
    				<input type="hidden" name="train_id" value="<%=rs.getString("train_id")%>"/>
    				<input type="hidden" name="origin_station_id" value="<%=rs.getString("origin_station_id")%>"/>
    				<input type="hidden" name="destination_station_id" value="<%=rs.getString("destination_station_id")%>"/>
    				<input type="hidden" name="origin_departure_datetime" value="<%=rs.getString("origin_departure_datetime")%>"/>
    				<input type="hidden" name="destination_arrival_datetime" value="<%=rs.getString("destination_arrival_datetime")%>"/>
    				<a href="#" onclick="this.parentNode.submit();">Edit</a>
    				</form>		
                </td>
            </TR>
            <% } %>
        </TABLE>
        <%
			String stationQuery = "select * from Station";
			PreparedStatement stQuery = con.prepareStatement(stationQuery);
			ResultSet st = stQuery.executeQuery();
		%>
		<table border="1" style="float: right;">
		<tr>
			<th>Station</th>
			<th>ID</th>
		</tr>
		<% 
while(st.next())
{
	%>
	<tr>
		<td><%=st.getString("name")%></td>
		<td><%=st.getString("station_id")%></td>
	</tr>
	<% 
}
%>

<p><a href='customerRepHome.jsp'>Go to home page</a></p>
</body>
</html>