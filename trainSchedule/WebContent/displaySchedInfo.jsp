<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>displaySchedInfo</title>
</head>

<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

<br/>
<br/>
<br/>
	
<%
	String transitName = request.getParameter("Name");
	String Origin = request.getParameter("Origin");
	String Destination = request.getParameter("Destination");
	String DepartureTime = request.getParameter("DepartureTime");
	String ArrivalTime = request.getParameter("ArrivalTime");
	String Fare = request.getParameter("Fare");
	String Status = request.getParameter("Running");
	
	if(transitName != null && Origin != null && Destination != null)
	{
		System.out.println("Got the transit: " + transitName);
		System.out.println("Got the Origin: " + Origin);
		System.out.println("Got the Destination: " + Destination);
		System.out.println("Got the DepartureTime: " + DepartureTime);
		System.out.println("Got the ArrivalTime: " + ArrivalTime);
		
	}
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(
		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
	PreparedStatement stmt;
	ResultSet rs;
	String originDestQuery = null;
	String stationQuery = null;
%>
	
	<h1 align="center"><legend><b><%out.println(transitName);%></b></legend></h1>
	<br>
	<h2>Train Schedule Information</h2>
	
	<table align="center" border="1" style="width:95%">
		<tr>
			<td><h3>Origin</h3></td>
			<td><h3>Destination</h3></td>
			<td><h3>Base Fare</h3></td>
			<td><h3>Status</h3></td>
		</tr>
		<tr>
			<td>
				<b><%out.println(Origin);%></b>
				<br>
				<p><%out.println(DepartureTime);%> 
				<br>
				Departure Time<p>
			</td>
			<td>
				<b><%out.println(Destination);%></b>
				<br>
				<p><%out.println(ArrivalTime);%> 
				<br>
				Arrival Time<p>
			</td>
			<td>
				<b><%out.println("$" + Fare);%></b>
			</td>
			<td>
				<%
				if(Status.equals("1"))
				{
					%><p style="text-align:center;"><b>In Operation</b><p><%
				}
				else
				{
					%><p style="text-align:center;"><b>NOTE: Not in operation</b><p><%
				}
				%>
			</td>
		</tr>
		
	</table>
	<br>
	<h2>Stop Information</h2>
	
<style>
table 
{
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th 
{
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) 
{
  background-color: #dddddd;
}
</style>

	<table align="center" border="1" style="width:95%">
	<tr>
		<td><b>Station</b></td>
		<td><b>State</b></td>
		<td><b>Transit Line</b></td>
		<td><b>Arrival Time</b></td>
		<td><b>Departure Time</b></td>
		<td><b>Track Number</b></td>
	</tr>
	
	<% 
	stationQuery = "select distinct S.name Station, S.state State, HS.transit_line Transit, date_format(HS.stop_arrival_datetime, '%h:%i%p %b %D, %Y') ArrivalTime, date_format(HS.stop_departure_datetime, '%h:%i%p %b %D, %Y') DepartureTime, HS.stop_track_number TrackNumber from HasStop HS, TrainSchedule TS, Station S where HS.origin_departure_datetime = TS.origin_departure_datetime and HS.stop_station_id = S.station_id and HS.transit_line = '" + transitName + "' and date_format(HS.origin_departure_datetime, '%h:%i%p') = '" + DepartureTime + "' and date_format(HS.destination_arrival_datetime, '%h:%i%p') = '" + ArrivalTime + "' order by ArrivalTime";
	
	try
	{
		stmt = con.prepareStatement(stationQuery);
        rs = stmt.executeQuery(stationQuery);
        
        if(rs.next())
        {
        	do
    		{
    			%>
    			<tr>
    				<td><%=rs.getString("Station") %></td>
    	        	<td><%=rs.getString("State") %></td>
    	        	<td><%=rs.getString("Transit") %></td>
    	        	<td><%=rs.getString("ArrivalTime") %></td> 
    	        	<td><%=rs.getString("DepartureTime") %></td>
    	        	<td><%=rs.getString("TrackNumber") %></td>
            	</tr>
            	<%
            
    		} while(rs.next());
        }
	}
	catch(Exception e) 
	{
		
		
	}
	
	%>
<table>
<br>
<br>
	<tr>
		<a href='searchSched.jsp'>Back to schedules</a>
	</tr>
</table>

</body>
</html>