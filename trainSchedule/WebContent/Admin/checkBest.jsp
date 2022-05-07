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

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

	<%
	
    
    
    String query = "select c_username, count(*) as num from Reservation where is_cancelled=1 group by c_username having num >= all (select count(*) from Reservation where is_cancelled = 1 group by c_username)";
    
    
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    ResultSet rs = stmt.executeQuery();
    
    
    
    if (rs.next()) {
        session.setAttribute("best", rs.getString("c_username")); // the username will be stored in the session
      	session.setAttribute("bestNum", rs.getInt("num"));
        response.sendRedirect("theBest.jsp");
    } else {
        //out.println("Invalid password <a href='login.jsp'>try again</a>");
        request.setAttribute("errorMessage", "ERROR: no reservations");
       	request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
%>

</body>
</html>