<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Success</title>
</head>
<body bgcolor = "#e6f2ff">
	<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<p></p>
<p></p>
<p></p>
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome, <%=session.getAttribute("user")%>!
<p></p>
<p></p>
<p></p>
<p><a href='logout.jsp'>Log out</a></p>
<%
    }
%>
</body>
</html>