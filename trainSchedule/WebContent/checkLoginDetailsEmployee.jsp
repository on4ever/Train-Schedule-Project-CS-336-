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
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    if (userid.length() > 45 || pwd.length() > 45 || userid.length() == 0 || pwd.length() == 0)
    {
    	request.setAttribute("errorMessage", "ERROR: Invalid login information");
       	request.getRequestDispatcher("login.jsp").forward(request, response);
       	return;
    }
    
    String query = "select * from Employee where e_username=? and e_password=?";
    
    
    
  	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, userid);
    stmt.setString(2, pwd);
    ResultSet rs = stmt.executeQuery();
    
    
    
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        
        if (rs.getInt("e_type") == 0)
        {
        	session.setAttribute("session_type", "customer_representative");
        	response.sendRedirect("customerRepHome.jsp");
        }
        else
        {
			session.setAttribute("session_type", "admin");
			response.sendRedirect("Admin/admin.jsp");
        }
    } else {
        //out.println("Invalid password <a href='login.jsp'>try again</a>");
        request.setAttribute("errorMessageEmployee", "ERROR: Invalid login information");
       	request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>
</body>
</html>
