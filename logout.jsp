<%@ page language="java" %>
<%
    // Invalidate the session to log the user out
    if (session != null) {
        session.invalidate();
    }

    // Redirect to the login page after logout
    response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
</head>
<body>
    <h1>You have successfully logged out!</h1>
    <p>Click <a href="login.jsp">here</a> to log in again.</p>
</body>
</html>
