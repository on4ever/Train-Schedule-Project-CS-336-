<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
<title>New User</title>
</head>
<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<br/>
<br/>
<br/>
<fieldset>
<legend><b>New User Login</b></legend>
<br/>
<form action="checkNewAccount.jsp" method="POST">
       
       Username (max 45 characters):<br/>
      <input type="text" name="username" size="40" required/><br/>
       Password (max 45 characters):<br/>
       <input type="password" name="password" size="40" required/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br/><div style="color:red">${errorMessage}</div>
</fieldset>
<br/>
<br/>
<p><a href='login.jsp'>Return to home page.</a></p>
</body>
</html>