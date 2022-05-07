<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>displaySearchedSched</title>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
	"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");

PreparedStatement stmt;
ResultSet rs;

%>

<body bgcolor = "#e6f2ff">
	<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
	</strong>
	
	<br/>
	<br/>
	<br/>
	
	<fieldset>
	<legend><b>Search Train Schedules</b></legend>
	<br>
	
	<form action="checkForSched.jsp" id="searchForm" method="get">     
     	<input type="text" id="searchedSched" name="searchedSched" value="<%=request.getParameter("searchedSched")%>" size="60"/>
     	
     	<label for="options"> search by:</label>
			<select name="options" id="options" form="searchForm">
				<option selected="<%=request.getParameter("options")%>"><%=request.getParameter("options")%></option>
				<%
				if(!request.getParameter("options").equals("name")) 
				{
					%><option value="name">name</option><%
				}
				if(!request.getParameter("options").equals("origin")) 
				{
					%><option value="origin">origin</option><%
				}
				if(!request.getParameter("options").equals("destination")) 
				{
					%><option value="destination">destination</option><%
				}
				%>
			</select>
     	
     	<input type="submit" value="Search"/>	
   		<br><br>
   
		<label for="dateTravel"> filter by Travel Dates: </label>
			<select name="dateTravel" id="dateTravel" form="searchForm">
				<%
					String dateOption = request.getParameter("dateTravel");
					
					if(!dateOption.equals("none"))
					{
						%><option selected="<%=request.getParameter("dateTravel")%>"><%=request.getParameter("dateTravel")%></option><%
					}
					
					%><option value="none">select date</option><%
					
				%>
				
				<%
		        String dateFormat = "%b %D, %Y";
		        String query = "select date_format(origin_departure_datetime, '" + dateFormat + "') Date from TrainSchedule";
		        
		        try
		        {
		        	stmt = con.prepareStatement(query);
		        	rs = stmt.executeQuery(query);
		       		//System.out.println(thing);
		        	while(rs.next())
		    		{ 
		        		if(!rs.getString("Date").equals(dateOption))
		        		{
		        			//System.out.println(rs.getString("Date"));
		        			%><option value="<%=rs.getString("Date")%>"><%=rs.getString("Date")%></option><% 
		        		}	
		    		} 
		        }
		        catch(Exception e)
		        {
		        	//something went wrong fetching available dates
		        }
				%>
			</select>
		
	
	
   	<br><br>
    <div style="color:red">${errorMessage}</div>
	
	
	<h1 align="center">Available Train Schedules<strong></strong></h1>
	<p style="text-align:center;">Click on a transit line to view more information
	<br>
	Currently sorted by:
		<%
		if(request.getParameter("sortBy").equals("DepartureTime"))
		{
			%>Origin Departure Time<%
		}
		else if(request.getParameter("sortBy").equals("ArrivalTime"))
		{
			%>Destination Arrival Time<%
		}
		else
		{
			%>Transit Name<%
		}
		%>
	<br><br>
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

	<%
	String userSearch = request.getParameter("searchedSched");
	String searchBy = request.getParameter("options");
	String date = request.getParameter("dateTravel");
	String groupBy = request.getParameter("sortBy");
	System.out.println(groupBy);
	query = null;
	//System.out.println(searchBy);
	//System.out.println(date);
	
	//System.out.println("User searched for: '" + userSearch + "' by: '" + searchBy + "'");
	
	if (userSearch.length() == 0 && date == null && groupBy.equals("none"))
    {
		request.setAttribute("errorMessage", "Please select a criteria to sort by or enter a search term");
       	request.getRequestDispatcher("searchSched.jsp").forward(request, response);
       	return;
    }
	if (userSearch.length() > 60 && date == null)
    {
    	request.setAttribute("errorMessage", "Your search is too long. Please shorten it and try again");
       	request.getRequestDispatcher("searchSched.jsp").forward(request, response);
       	return;
    }
	
	if(groupBy.equals("none"))
	{
		groupBy = "Name";
	}
	
	//String query = "select * from TrainSchedule where transit_line like '?%'";
   	//query = "select * from TrainSchedule where transit_line like '" + userSearch + "%'";
	String queryBase = "select TS.transit_line Name, TS.origin_departure_datetime, TS.destination_arrival_datetime, TS.origin_station_id, TS.destination_station_id, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, date_format(TS.origin_departure_datetime, '%h:%i%p') DepartureTime, date_format(TS.destination_arrival_datetime, '%h:%i%p') ArrivalTime, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id";

    if(searchBy.equals("name"))
    {
    	if(date.equals("none"))
    	{
    		%><p style="text-align:center;"><%out.println("Showing results: " + userSearch);%><p><%
        	query = queryBase + " where TS.transit_line like '" + userSearch + "%' order by " + groupBy;
    	}
    	else
    	{	
    		%><p style="text-align:center;"><%out.println("Showing results: " + userSearch + " on " + date);%><p><%
    		//query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id where TS.transit_line like '" + userSearch + "%' and date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by Name";	
    		query = queryBase + " where TS.transit_line like '" + userSearch + "%' and date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by " + groupBy;
    	}
    }
    else if(searchBy.equals("origin"))
    {
    	if(date.equals("none"))
    	{
    		%><p style="text-align:center;"><%out.println("Showing results: " + userSearch);%><p><%
        	//query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id where O.name like '" + userSearch + "%' order by Name";	
    		query = queryBase + " where O.name like '" + userSearch + "%' order by " + groupBy;
    	}
    	else
    	{
    		%><p style="text-align:center;"><%out.println("Showing results: " + userSearch + " on " + date);%><p><%
        	//query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id where O.name like '" + userSearch + "%' and date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by Name";
    		query = queryBase + " where O.name like '" + userSearch + "%' and date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by " + groupBy;
    	}
    }
    else if(searchBy.equals("destination"))
    {
    	if(date.equals("none"))
    	{
    		%><p style="text-align:center;"><%out.println("Showing results: " + userSearch);%><p><%
        	//query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id where D.name like '" + userSearch + "%' order by Name";	
    		query = queryBase + " where D.name like '" + userSearch + "%' order by " + groupBy;
    	}
    	else
    	{
    		%><p style="text-align:center;"><%out.println("Showing results: " + userSearch + " on " + date);%><p><%
        	//query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id where D.name like '" + userSearch + "%' and date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by Name";
    		query = queryBase + " where D.name like '" + userSearch + "%' and date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by " + groupBy;
    	}
    }
    else if(!date.equals("none"))
    {
    	//query = "select TS.transit_line Name, O.name Origin, D.name Destination, date_format(TS.origin_departure_datetime, '%b %D, %Y') TravelDate, TS.base_fare Fare, TS.cancellationStatus Running from (TrainSchedule TS left join Station O on TS.origin_station_id = O.station_id) left join Station D on TS.destination_station_id = D.station_id where date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by Name";
   		query = queryBase + " where date_format(TS.origin_departure_datetime, '%b %D, %Y') = '" + date + "' order by " + groupBy;
    }
    else if(userSearch.isEmpty())
    {
    	query = queryBase + " order by " + groupBy;
    }
    
   	
	%>
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
		<td><b>Origin Departure Time</b></td>
		<td><b>Destination Arrival Time</b></td>
		<td><b>Base Fare</b></td>
		<td><b>Running?</b></td>
	</tr>
	
	<% 
    try
    {
       	stmt = con.prepareStatement(query);
        rs = stmt.executeQuery(query);
        
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
	            			<a href="#" onclick="this.parentNode.submit();"> Reserve </a>
	            		</form>
	            	</td>
   
            	</tr> 

            	<%
        			
        	} while(rs.next());
        }
        else
        {
        	if(date.equals("none"))
        	{
        		request.setAttribute("errorMessage", "Could not find any results: " + userSearch);
        	}
        	else
        	{
        		request.setAttribute("errorMessage", "Could not find any results for: '" + userSearch + "' on " + date);
        	}
           	//request.getRequestDispatcher("searchSched.jsp").forward(request, response);
        }
    } catch(Exception e) 
	{
    	request.setAttribute("errorMessage", "Something went wrong with your search");
       	request.getRequestDispatcher("searchSched.jsp").forward(request, response);
	}
     
      	
        //request.setAttribute("errorMessage", "Could not find any such schedules");
       	//request.getRequestDispatcher("searchSched.jsp").forward(request, response);
    //}
    //catch (Exception e)
    //{
    	//request.setAttribute("errorMessage", "Something went wrong with your search");
       	//request.getRequestDispatcher("searchSched.jsp").forward(request, response);
    //}
	
        //session.setAttribute("searched", userSearch); // the username will be stored in the session
        //response.sendRedirect("displayScheds.jsp");
        //out.println("Invalid password <a href='login.jsp'>try again</a>");
   	
	%>
</table>
<p><a href='customerHome.jsp'>Back to home page.</a></p>
</body>
</html>