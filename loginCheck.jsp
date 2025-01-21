<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String dbURL = "jdbc:mysql://localhost:3306/CineReserve";
    String dbUser = "root";
    String dbPass = "1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        
        // Query to check user credentials
        String query = "SELECT userID, username FROM Users WHERE username=? AND password=?";
        PreparedStatement pst = conn.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, password);
        
        ResultSet rs = pst.executeQuery();
        
        if (rs.next()) {
            // Retrieve userID from the result set
            int userID = rs.getInt("userID");
            
            // Valid user, store the userID and username in the session
            session.setAttribute("userID", userID);
            session.setAttribute("username", rs.getString("username"));

            // Create cookies for username and userID
            Cookie userCookie = new Cookie("username", rs.getString("username"));
            Cookie idCookie = new Cookie("userID", String.valueOf(userID));

            userCookie.setMaxAge(604800); // 7 days in seconds
            idCookie.setMaxAge(604800);

            // Add cookies to the response
            response.addCookie(userCookie);
            response.addCookie(idCookie);

            // Redirect to index.jsp or any page you want after login
            response.sendRedirect("index.jsp");
        } else {
            // Invalid user, show an error and redirect back to login page
            out.println("<script type=\"text/javascript\">");
            out.println("alert('User does not exist or incorrect credentials');");
            out.println("location='login.jsp';");
            out.println("</script>");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
