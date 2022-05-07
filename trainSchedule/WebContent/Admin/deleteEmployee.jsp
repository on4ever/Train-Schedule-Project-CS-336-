<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
    int ssn = Integer.parseInt(request.getParameter("ssn"));
   
    
    String query = "select * from Employee where ssn=? && e_type=0";
    
    
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setInt(1, ssn);
    ResultSet rs = stmt.executeQuery();
    
    
    
    if (rs.next()) {
        //session.setAttribute("user", userid); // the username will be stored in the session
        String updateQuery = "delete from Employee where ssn=? && e_type=0";
    	PreparedStatement stmt2 = con.prepareStatement(updateQuery);
    	stmt2.setInt(1, ssn);
     	stmt2.executeUpdate();
        response.sendRedirect("Success.jsp");
    } else {

        //out.println("Invalid password <a href='deleteForm.jsp'>try again</a>");
        request.setAttribute("error", "ERROR: this customer representative does not exist");
       	request.getRequestDispatcher("deleteForm.jsp").forward(request, response);
    }
%>
</body>
</html>