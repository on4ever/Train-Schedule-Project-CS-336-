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
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
	
	String newFare = request.getParameter("newBaseFare");
	if (!newFare.equals("")) session.setAttribute("base_fare", newFare);
	String oldTrainID = (String)session.getAttribute("train_id");
	String newTrainID = request.getParameter("newTrainID");
	if (!newTrainID.equals("") && Integer.parseInt(newTrainID) <= 10) session.setAttribute("train_id", newTrainID);
	
	String cancellationStatus = request.getParameter("cancellationStatus");
	if (cancellationStatus.equals("1") || cancellationStatus.equals("0")) session.setAttribute("cancellationStatus", cancellationStatus);
	
	
    String query = "update TrainSchedule"
    		+ " set transit_line=?, train_id=?, origin_station_id=?, destination_station_id=?,"
    		+ " origin_departure_datetime=?, destination_arrival_datetime=?, base_fare=?, cancellationStatus=?"
    		+ " where transit_line=? and train_id=?"
    		+ " and origin_station_id=? and destination_station_id=?"
    				+ " and origin_departure_datetime=? and destination_arrival_datetime=?";
    
    
    
  	
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, (String)session.getAttribute("transit_line"));
	stmt.setString(2, (String)session.getAttribute("train_id"));
	stmt.setString(3, (String)session.getAttribute("origin_station_id"));
	stmt.setString(4, (String)session.getAttribute("destination_station_id"));
	stmt.setString(5, (String)session.getAttribute("origin_departure_datetime"));
	stmt.setString(6, (String)session.getAttribute("destination_arrival_datetime"));
	stmt.setString(7, (String)session.getAttribute("base_fare"));
	stmt.setString(8, (String)session.getAttribute("cancellationStatus"));
	
	stmt.setString(9, (String)session.getAttribute("transit_line"));
	stmt.setString(10, oldTrainID);
	stmt.setString(11, (String)session.getAttribute("origin_station_id"));
	stmt.setString(12, (String)session.getAttribute("destination_station_id"));
	stmt.setString(13, (String)session.getAttribute("origin_departure_datetime"));
	stmt.setString(14, (String)session.getAttribute("destination_arrival_datetime"));
	
   	stmt.executeUpdate();
    
    response.sendRedirect("repEditTrainSchedules.jsp");
    
%>
</body>
</html>