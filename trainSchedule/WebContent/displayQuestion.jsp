<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
<title>Forum</title>
</head>
<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<br/>
<br/>
<div style="color:red">${responseError}</div>
<br/>
<%
	String askUsername = (String)session.getAttribute("c_username");
	String askDateTime = (String)session.getAttribute("message_datetime");
	String formatDate = (String)session.getAttribute("formatDate");
%>
<fieldset>
<legend><b><% out.println(askUsername);%></b><% out.println(" posted on " + formatDate);%></legend>
<% Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    
   
    
    String question = "select message_content from Message where c_username = '" + askUsername 
    		+ "' and message_datetime = '" + askDateTime + "'";
    
    Statement stmt = con.createStatement();
   
    ResultSet rs = stmt.executeQuery(question);
    
    while (rs.next())
    {
    	out.println(rs.getString("message_content"));
    }  
    
    
%>
</fieldset>
<br>
<br>
<%
	String responds = "select r_username, date_format(response_datetime, '%b %D, %Y') formatDate, response_datetime, response_content from Response where originalPoster = '" 
						+ askUsername + "' and originalDatetime = '" + askDateTime + "' order by response_datetime asc";

	Statement stmt2 = con.createStatement();
	ResultSet rs2 = stmt2.executeQuery(responds);
	
	while(rs2.next())
	{
		%>
			<fieldset><legend><b><%out.println(rs2.getString("r_username"));%></b> <%out.println(" replied on " + 
		rs2.getString("formatDate")); %></legend>
			<% 
				out.println(rs2.getString("response_content"));
			%>
			</fieldset>
			
		<% 
	}
%>
<form action="postResponse.jsp" method="POST">
      Reply (max 500 characters):<br>
      <input type="hidden" name="c_username" value="<%=askUsername%>">
      <input type="hidden" name="message_datetime" value="<%=askDateTime%>">
	<textarea name="response" rows="10" cols="100" required></textarea>
	<br>
	<input type="submit">
</form>
<p><a href='customerForum.jsp'>Back to discussions</a></p>
</body>
</html>