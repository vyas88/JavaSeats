<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Error</h1>
        <p><%= request.getParameter("message") != null ? request.getParameter("message") : "An unexpected error occurred." %></p>
        <a href="index.jsp">Go to Home</a>
    </div>
</body>
</html>
