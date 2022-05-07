<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Monthly Sales Report</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

	<%
    
    String query = "select month(reserve_datetime) as Month, year(reserve_datetime) as Year, sum(total_fare) as total_sale from Reservation where is_cancelled=1 group by Month, Year order by Year desc, Month asc";  
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    ResultSet rs = stmt.executeQuery();
    
   
%>
<p>Top 5 transit lines</p>
		<TABLE BORDER="1">
		<caption>Sales Report by Month</caption>
            <TR>
                <TH>Month</TH>
                <TH>Year</TH>
                <TH>Total sale</TH>
            </TR>
            <% while(rs.next()){ %>
            <TR>
                <TD> <%= rs.getString(1) %></td>
                <TD> <%= rs.getString(2) %></TD>
                <TD> <%= rs.getString(3) %></TD>
                
            </TR>
            <% } %>
        </TABLE>
         <p>
        </p>
<a href='admin.jsp'>Return to admin page</a>
</body>
</html>