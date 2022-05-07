<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Revenue by transit line</title>
</head>
<body bgcolor = "#e6f2ff">

<strong style="font-size:30px">
GROUP 36 TRAIN SCHEDULING SYSTEM
</strong>

	<%
    
    String query = "select transit_line, sum(total_fare) from Reservation where is_cancelled=1 group by transit_line";  
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    ResultSet rs = stmt.executeQuery();
    
   
%>
		<TABLE BORDER="1">
		<caption>Revenue by Transit Line</caption>
            <TR>
                <TH>Transit Line</TH>
                <TH>Amount earned</TH>
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