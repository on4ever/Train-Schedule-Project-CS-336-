<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String askUsername = request.getParameter("c_username");
String askDateTime = request.getParameter("message_datetime");
String formatDate = request.getParameter("formatDate");

session.setAttribute("c_username", askUsername);
session.setAttribute("message_datetime", askDateTime);
session.setAttribute("formatDate", formatDate);

response.sendRedirect("displayQuestion.jsp");

%>
</body>
</html>