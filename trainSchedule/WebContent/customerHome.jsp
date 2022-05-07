<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../CSS/loginStyles.css" type="text/css">
<meta charset="UTF-8">
<title>Customer Home</title>
</head>
<body bgcolor = "#e6f2ff">
<strong style="font-size:30px">
	GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<br/>
<br/>

<br/>
<fieldset>
<legend><b>Customer Actions</b></legend>

<table>
	<tr>
		<td>
			<form action="searchSched.jsp">
				<input type="submit" value="Make a Reservation">
			</form>
		</td> 
		<td>
			<form action="ReservationList.jsp">
				<input type="submit" value="See/Cancel Reservations">
			</form>
		</td> 
		<td>
			<form action="customerForum.jsp">
				<input type="submit" value="Go to Forum">
			</form>
		</td>
	</tr>
</table>


</fieldset>
<p><a href='logout.jsp'>Log out</a></p>
</body>
</html>