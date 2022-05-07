<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin account</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>
<p></p>
<strong>
	ADMIN SYSTEM HOME PAGE
</strong>
<div style="color:red">${errorMessage}</div>
<p><a href='addForm.jsp'>Add a customer representative</a></p>

<p><a href='deleteForm.jsp'>Delete a customer representative</a></p>

<p><a href='editForm.jsp'>Edit a customer representative</a></p>

<p><a href='report.jsp'>Sales report per month</a></p>

<p><a href='reservationsTL.jsp'>List of reservations by transit line</a></p>

<p><a href='reservationsCN.jsp'>List of reservations by customer</a></p>

<p><a href='revenueTL.jsp'>Listing of revenue per transit line</a></p>

<p><a href='revenueCN.jsp'>Listing of revenue per customer</a></p>

<p><a href='checkBest.jsp'>Best customer</a></p>

<p><a href='checkTopFive.jsp'>Top 5 transit lines</a></p>

<p><a href='logout.jsp'>Log out</a></p>
</body>
</html>