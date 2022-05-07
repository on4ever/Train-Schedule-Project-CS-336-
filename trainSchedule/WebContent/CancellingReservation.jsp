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
	int reservenum = Integer.parseInt(request.getParameter("reservenum"));
	
	/* if (reservenum == 0){
		request.setAttribute("errorMessage", "ERROR: Please enter reservation you are cancelling");
   		request.getRequestDispatcher("CancellingReservation.jsp").forward(request, response);
   		return;
   	} */


	//String reseverationquery = "select transit_line, c_username, reserve_datetime, total_fare, reserve_num, trip_type, origin_departure_datetime, destination_arrival_datetime, origin_station_id, destination_station_id from Reservation where is_cancelled = 1 order by transit_line";
    String query = "select * from Reservation where reserve_num=? && is_cancelled=1 && c_username=?";
    
    
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setInt(1, reservenum);
    stmt.setString(2, (String)session.getAttribute("user"));
    ResultSet rs = stmt.executeQuery();
	
    if (rs.next()) {
    //1) ask user if they would like to cancel or make a new reservation
	// is_cancelled = 0 to cancel reservation

	//2) ask user where they are (origin) and where they are heading to (destination)
	// that is the origin_departure_datetime, destination_arrival_datetime, origin_station_id, destination_station_id
	
		String updateQuery = "update Reservation set is_cancelled=0 where reserve_num=? && is_cancelled=1 && c_username=? ";
		PreparedStatement stmt2 = con.prepareStatement(updateQuery);
		stmt2.setInt(1, reservenum);
	    stmt2.setString(2,(String)session.getAttribute("user"));
		stmt2.executeUpdate();
		response.sendRedirect("ReservationList.jsp");
		return;
	
    }
    else {
        // out.println("Invalid password <a href='editForm.jsp'>try again</a>");
         request.setAttribute("error", "ERROR: could not cancel");
        request.getRequestDispatcher("ReservationList.jsp").forward(request, response);
     }
	
   
%>

</body>
</html>
