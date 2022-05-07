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
    String userid = request.getParameter("e_username");  
	boolean error = false;
    String pwd = request.getParameter("e_password");  
    int ssn = Integer.parseInt(request.getParameter("ssn"));
    String first_name = request.getParameter("e_first_name");   
    String last_name = request.getParameter("e_last_name"); 
    if (userid.length() == 0 || pwd.length() == 0)
    {
    	error=true;
    	request.setAttribute("errorMessage", "ERROR: all fields must be filled in");
       	request.getRequestDispatcher("addForm.jsp").forward(request, response);
    }
    if (userid.length() > 45 || pwd.length() > 45)
    {
    	error=true;
    	request.setAttribute("errorMessage", "ERROR: all fields must be filled in");
       	request.getRequestDispatcher("addForm.jsp").forward(request, response);
    }
    if (first_name.length() == 0 || last_name.length() == 0)
    {
    	error=true;
    	request.setAttribute("errorMessage", "ERROR: all fields must be filled in");
       	request.getRequestDispatcher("addForm.jsp").forward(request, response);
    }
    if (first_name.length() > 30 || last_name.length() > 30)
    {
    	error=true;
    	request.setAttribute("errorMessage", "ERROR: all fields must be filled in");
       	request.getRequestDispatcher("addForm.jsp").forward(request, response);
    }
    if(!error){
    String query = "select * from Employee where ssn=? and e_type=0";
    
    
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    		"jdbc:mysql://trainschedule36.cs9to86ym4fs.us-east-2.rds.amazonaws.com:3306/trainSchedule", "admin", "cs336group36");
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setInt(1, ssn);
    ResultSet rs = stmt.executeQuery();
    
    
    if (!(rs.next())) {
    	//session.setAttribute("user", userid); // the username will be stored in the session
    	
    	String updateQuery = "insert into Employee(ssn, e_last_name, e_first_name, e_username, e_password, e_type) values(?,?,?,?,?,?)";
    	PreparedStatement stmt2 = con.prepareStatement(updateQuery);
    	stmt2.setInt(1, ssn);
    	stmt2.setString(2, last_name);
    	stmt2.setString(3, first_name);
    	stmt2.setString(4, userid);
    	stmt2.setString(5, pwd);
        stmt2.setInt(6, 0);
     	stmt2.executeUpdate();
     	response.sendRedirect("Success.jsp");
    } 
    
    else {
        //out.println("Invalid password <a href='addForm.jsp'>try again</a>");
        request.setAttribute("error", "ERROR: This customer representative already exists");
       	request.getRequestDispatcher("addForm.jsp").forward(request, response);
    }
    }
%>
</body>
</html>