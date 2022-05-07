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
	String newSubject = request.getParameter("subject");
    String newMessage = request.getParameter("message");
	String username = (String)session.getAttribute("user");
	
	if (newSubject.length() >= 100)
	{
		request.setAttribute("forumError", "ERROR: Your subject line was too long.");
	    request.getRequestDispatcher("customerForum.jsp").forward(request, response);
	    return;
	}
	if (newMessage.length() >= 1000)
	{
		request.setAttribute("forumError", "ERROR: Your message was too long.");
	    request.getRequestDispatcher("customerForum.jsp").forward(request, response);
	    return;
	}
		
	
	
	
	java.util.Date utilDate = new java.util.Date();
	
	String updateQuery = "insert into Message(message_datetime, message_content, c_username, message_subject) values(?,?,?,?)";
	
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    
    PreparedStatement stmt = con.prepareStatement(updateQuery);
    stmt.setTimestamp(1, new Timestamp(utilDate.getTime()));
    stmt.setString(2, newMessage);
    stmt.setString(3, username);
    stmt.setString(4, newSubject);
    stmt.executeUpdate();
    
    response.sendRedirect("customerForum.jsp");
	
	
	
%>
</body>
</html>