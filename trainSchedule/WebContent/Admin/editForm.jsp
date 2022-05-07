<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit form</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

<p></p>
<p></p>
<p></p>
<div style="color:red">${error}</div>
<p>Input information for customer representative
</p>
<form action="editEmployee.jsp" method="POST">
       ssn: <input type="text" name="ssn"/> <br/>
       last name:<input type="text" name="e_last_name"/> <br/>
       
       first name: <input type="text" name="e_first_name"/> <br/>
       username:<input type="text" name="e_username"/> <br/>
       
       password: <input type="password" name="e_password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <p>
<a href='admin.jsp'>Return to admin page</a>
</p>
</body>
</html>