<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Revenue by customer</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

	<%
    
    String query = "select c_username, sum(total_fare) from Reservation where is_cancelled=1 group by c_username";  
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    ResultSet rs = stmt.executeQuery();
    
   
%>
		<TABLE BORDER="1">
		<caption>Revenue by Customer</caption>
            <TR>
                <TH>Customer username</TH>
                <TH>Amount spent</TH>
            </TR>
            <% while(rs.next()){ %>
            <TR>
                <TD> <%= rs.getString(1) %></td>
                <TD> <%= rs.getString(2) %></TD>
                
            </TR>
            <% } %>
        </TABLE>
         <p>
        </p>
<a href='admin.jsp'>Return to admin page</a>
</body>
</html>