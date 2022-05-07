<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete form</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

<p></p>
<p></p>
<p></p>
<div style="color:red">${error}</div>
<p>Enter information for customer representative</p>
<form action="deleteEmployee.jsp" method="POST">
        ssn: <input type="text" name="ssn"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
<p>
<a href='admin.jsp'>Return to admin page</a>
</p>
</body>
</html>