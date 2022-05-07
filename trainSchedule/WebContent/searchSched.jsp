<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
	
<title>searchSchedules</title>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
	"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");

PreparedStatement stmt;
ResultSet rs;

%>

<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">GROUP 36 TRAIN SCHEDULING SYSTEM</strong>

<br>
<br>
<br>
	
	<fieldset>
	<legend><b>Search Train Schedules</b></legend>
	<br>

	<form action="checkForSched.jsp" id="searchForm" method="get">     
     	<input type="text" id="searchedSched" name="searchedSched" size="60"/>
     	
     	<label for="options"> search by:</label>
			<select name="options" id="options" form="searchForm">
				<option value="name">name</option>
				<option value="origin">origin</option>
				<option value="destination">destination</option>
			</select>
     	
     	<input type="submit" value="Search"/>	
   		<br><br>
   
		<label for="dateTravel"> filter by Travel Dates: </label>
			<select name="dateTravel" id="dateTravel" form="searchForm">
				<option value="none" selected hidden>select date</option>
				<%
		        String dateFormat = "%b %D, %Y";
		        String query = "select date_format(origin_departure_datetime, '" + dateFormat + "') Date from TrainSchedule";
		        try
		        {
		        	stmt = con.prepareStatement(query);
		        	rs = stmt.executeQuery(query);
		       
		        	while(rs.next())
		    		{ 
		    			%><option value="<%=rs.getString("Date")%>"><%=rs.getString("Date")%></option><% 
		    		} 
		        }
		        catch(Exception e)
		        {
		        	
		        }
				%>
			</select>

   	<br><br>
    <div style="color:red">${errorMessage}</div>
    <br>
    
    
    <h1 align="center">Available Train Schedules<strong></strong></h1>
	<p style="text-align:center;">Click on a transit line to view more information<p>
	<p style="text-align:center;">
	
	<label for="sortBy">sort by:</label>
		<select name="sortBy" id="sortBy" form="searchForm">
			<option value="none" selected hidden></option>
			<option value="Name">Transit Name</option>
			<option value="DepartureTime">Origin Departure Time</option>
			<option value="ArrivalTime">Destination Arrival Time</option>
			<option value="Fare">Fare</option>
		</select>
	<input type="submit" value="Sort"/>	
	
	<p>
	</form>
    </fieldset>
	
</head>
<body>
	
	

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
		<td><b>Transit Line</b></td>
		<td><b>Origin</b></td>
		<td><b>Destination</b></td>
		<td><b>Travel Date</b></td>
		<td><b>Origin Departure Time</b>
		<td><b>Destination Arrival Time</b>
		<td><b>Base Fare</b></td>
		<td><b>Running?</b></td>
	</tr>
	<% 
	//String query = "select * from TrainSchedule";
	dateFormat = "%b %D, %Y";
	String timeFormat = "%h:%i%p";
	String dateTimeFormat = "%h:%i%p %b %D, %Y";
	query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id order by Name";
	String query2 = "select TS.transit_line Name, TS.origin_departure_datetime, TS.destination_arrival_datetime, TS.origin_station_id, TS.destination_station_id, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, date_format(TS.origin_departure_datetime, '%h:%i%p') DepartureTime, date_format(TS.destination_arrival_datetime, '%h:%i%p') ArrivalTime, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id order by Name";

    try
    {
        stmt = con.prepareStatement(query2);
        rs = stmt.executeQuery(query2);
        
        //display results in a table format
        if(rs.next())
        {
        	do 
        	{
        		%>
  				
            	<tr>
	            	<td>
		            	<fieldset>
		  				<form action="displaySchedInfo.jsp" method="POST">
		  					<input type="hidden" name="Name" value = "<%=rs.getString("Name") %>"/>
		  					<input type="hidden" name="Origin" value = "<%=rs.getString("Origin")%>"/>
		  					<input type="hidden" name="Destination" value = "<%=rs.getString("Destination")%>"/>
		  					<input type="hidden" name="DepartureTime" value = "<%=rs.getString("DepartureTime")%>"/>
		  					<input type="hidden" name="ArrivalTime" value = "<%=rs.getString("ArrivalTime")%>"/>
		  					<input type="hidden" name="Fare" value = "<%=rs.getString("Fare")%>"/>
		  					<input type="hidden" name="Running" value = "<%=rs.getString("Running")%>"/>
		  					<a href="#" onclick="this.parentNode.submit();">
		  					<%out.println(rs.getString("Name")); %></a>
		  				</form>
		  				</fieldset>
	            
	            	</td>
	            	<td><%=rs.getString("Origin") %></td>
	            	<td><%=rs.getString("Destination") %></td>
	            	<td><%=rs.getString("TravelDate") %></td>
	            	<td><%=rs.getString("DepartureTime") %></td>
	            	<td><%=rs.getString("ArrivalTime") %></td>
	            	<td><%="$" + rs.getString("Fare") %></td>
	            	<td>
	            	<% 
	            	if(rs.getString("Running").equals("1"))
	            	{
	            		out.println("Yes");
	            	} else { out.println("No"); }	
	            	%>
	            	</td>
	            	
	            	<td>
	            		<form action="CreatingReservation.jsp" method="POST">
	            			<input type="hidden" name="transit_line" value = "<%=rs.getString("Name")%>"/>
	            			<input type="hidden" name="origin_departure_datetime" value = "<%=rs.getString("TS.origin_departure_datetime")%>"/>
	            			<input type="hidden" name="destination_arrival_datetime" value = "<%=rs.getString("TS.destination_arrival_datetime")%>"/>
	            			<input type="hidden" name="origin_station_id" value = "<%=rs.getString("TS.origin_station_id")%>"/>
	            			<input type="hidden" name="destination_station_id" value = "<%=rs.getString("TS.destination_station_id")%>"/>
	            			<input type="hidden" name="base_fare" value = "<%=rs.getString("Fare")%>"/>
	            			<a href="#" onclick="this.parentNode.submit();"> Reserve </a>
	            		</form>
	            	</td>
   
            	</tr> 
            	<% 
            	
        			
        	} while(rs.next());
        }
        else
        {
        	out.println("No Train Schedules available");
        }
    } catch(Exception e) 
	{
    	out.println("Something wrong with fetching Train Schedules");
	}%>
	</table>
	<br><br>
<p><a href='customerHome.jsp'>Back to home page.</a></p>
</body>
</html>