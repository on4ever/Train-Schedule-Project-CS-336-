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
	String originalPoster = request.getParameter("c_username");
    String originalDatetime = request.getParameter("message_datetime");
	String username = (String)session.getAttribute("user");
	String newResponse = request.getParameter("response");
	
	if (newResponse.length() >= 1000)
	{
		request.setAttribute("responseError", "ERROR: Your reply was too long.");
	    request.getRequestDispatcher("displayQuestion.jsp").forward(request, response);
	    return;
	}
	
	
	
	java.util.Date utilDate = new java.util.Date();
	
	String updateQuery = "insert into Response(r_username, response_datetime, response_content, originalPoster, originalDatetime) values(?,?,?,?,?)";
	
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    
    PreparedStatement stmt = con.prepareStatement(updateQuery);
    
    stmt.setString(1, username);
    stmt.setTimestamp(2, new Timestamp(utilDate.getTime()));
    stmt.setString(3, newResponse);
    stmt.setString(4, originalPoster);
    stmt.setString(5, originalDatetime);
    stmt.executeUpdate();
    
    response.sendRedirect("displayQuestion.jsp");
%>


</body>
</html>