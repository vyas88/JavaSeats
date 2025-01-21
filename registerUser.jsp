<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Confirmation</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        color: #333;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        max-width: 500px;
        width: 100%;
        text-align: center;
    }

    h2 {
        font-size: 24px;
        margin-bottom: 20px;
    }

    .success {
        color: #28a745;
        background-color: #d4edda;
        padding: 10px;
        border: 1px solid #c3e6cb;
        border-radius: 5px;
    }

    .error {
        color: #dc3545;
        background-color: #f8d7da;
        padding: 10px;
        border: 1px solid #f5c6cb;
        border-radius: 5px;
    }

    a {
        color: #007bff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="container">
        <%
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String dbURL = "jdbc:mysql://localhost:3306/CineReserve";
            String dbUser = "root";
            String dbPass = "1234";
            String message = "";
            int result = 0; 

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                String query = "INSERT INTO Users (username, password, email) VALUES (?, ?, ?)";
                PreparedStatement pst = conn.prepareStatement(query);
                pst.setString(1, username);
                pst.setString(2, password);
                pst.setString(3, email);
                
                result = pst.executeUpdate(); 
                
                if (result > 0) {
                    message = "Registration successful! Now you can <a href='login.jsp'>login here</a>.";
                } else {
                    message = "Registration failed! Please try again.";
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                message = "An error occurred. Please try again.";
            }
        %>
        <h2 class="<%= result > 0 ? "success" : "error" %>"><%= message %></h2>
    </div>
</body>
</html>
