<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
    String transit_line = request.getParameter("transit_line");
    String train_id = request.getParameter("train_id");
    String origin_station_id = request.getParameter("origin_station_id");
    String destination_station_id = request.getParameter("destination_station_id");
    String origin_departure_datetime = request.getParameter("origin_departure_datetime");
    String destination_arrival_datetime = request.getParameter("destination_arrival_datetime");
    
    session.setAttribute("transit_line", transit_line);
	session.setAttribute("train_id", train_id);
	session.setAttribute("origin_station_id", origin_station_id);
	session.setAttribute("destination_station_id", destination_station_id);
	session.setAttribute("origin_departure_datetime", origin_departure_datetime);
	session.setAttribute("destination_arrival_datetime", destination_arrival_datetime);
	
	response.sendRedirect("repEditTrainSchedules.jsp");
    

%>
</body>
</html>