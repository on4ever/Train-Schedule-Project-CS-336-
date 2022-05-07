<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
<title>Login Form</title>
</head>
<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<br/>
<br/>
<br/>
<%
	 session.setAttribute("transit_line", request.getParameter("transit_line"));
	session.setAttribute("origin_departure_datetime", request.getParameter("origin_departure_datetime"));
 	session.setAttribute("destination_arrival_datetime", request.getParameter("destination_arrival_datetime"));
 	session.setAttribute("origin_station_id", request.getParameter("origin_station_id"));
 	session.setAttribute("destination_station_id", request.getParameter("destination_station_id"));
	 session.setAttribute("base_fare", request.getParameter("base_fare"));
	System.out.println(request.getParameter("base_fare"));
%>
<fieldset>
<legend><b>Questions</b></legend>
<br/>
<form action="Reservations.jsp" method="POST">
       
       Would you like to reserve a round trip or a one-way trip?<br/>
       <div>
  <input type="radio" id="trip_type" name="triptype" value=1 required>
  <label for="trip_type">Round Trip</label><br>
  
  <input type="radio" id="trip_type" name="triptype" value=0 required>
  <label for="trip_type">One-way Trip</label><br><br>
</div>
<!-- Child, senior or disabled? (have a check box for if disabled and in code if box is checked off, then add disable discount -->
      	This reservation is for a(n) ...<br/>
      	<div>
      	<input type="radio" id="user" name="userage" value="Child" required>
  Child</label><br>
  <input type="radio" id="user" name="userage" value="Senior" required>
  Senior</label><br>
  	<input type="radio" id="user" name="userage" value="Adult" required>
  Adult</label><br>
  </div>
  <br>
   <input type="checkbox" id="disabled" name="disabled" value="1">
  <label for="disabled">Check here if you are disabled.</label><br><br>
  
       <input type="submit" value="Submit"/>
     </form>
     <br/><div style="color:red">${selectError}</div>
</fieldset>
<br/>
<br/>
<p><a href='searchSched.jsp'>Back to schedules</a></p>
</body>
</html>
