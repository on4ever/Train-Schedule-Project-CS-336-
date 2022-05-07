<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
<title>Login Form</title>
</head>
<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<br/>
<br/>
<br/>
<fieldset>
<legend><b>Customer Login</b></legend>
<br/>

<form action="checkLoginDetails.jsp" method="POST">
       Username:<br/>
      <input type="text" name="username" size="40" required/><br/>
       Password:<br/>
       <input type="password" name="password" size="40" required/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <p>Don't have an account? <a href='createAccount.jsp'>Create one here.</a></p>
    <div style="color:red">${errorMessage}</div>
</fieldset>

<br/>
<br/>
<br/>
<br/>
<br/>
<fieldset>
<legend><b>Employee Login</b></legend>
<br/>
<form action="checkLoginDetailsEmployee.jsp" method="POST">
       
       Username:<br/>
      <input type="text" name="username" size="40" required/><br/>
       Password:<br/>
       <input type="password" name="password" size="40" required/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br/><div style="color:red">${errorMessageEmployee}</div>
</fieldset>
<br/>
<br/>
</body>
</html>
