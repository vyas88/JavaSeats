<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Manage Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            background-color: #fff;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        input[type="submit"] {
            background-color: #ff4d4d;
            border: none;
            color: white;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #d63a3a;
        }
        .back-btn {
        display: block;
        width: 200px;
        margin: 20px auto;
        padding: 10px 20px;
        background-color: #007bff; /* Blue button color */
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 18px;
        cursor: pointer;
        text-align: center;
        text-decoration: none; /* Remove underline */
        transition: background-color 0.3s ease;
    }

    .back-btn:hover {
        background-color: #0056b3; /* Darker blue on hover */
    }
    </style>
</head>
<body>
    <h1>Manage Users</h1>
<a href="admin.jsp" class="back-btn">Go Back</a>
    <!-- Display Users -->
    <h2>Current Users</h2>
    <table>
        <tr><th>User ID</th><th>Username</th><th>Email</th><th>Actions</th></tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                stmt = conn.createStatement();
                String query = "SELECT * FROM users";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    int userID = rs.getInt("userID");
                    String username = rs.getString("username");
                    String email = rs.getString("email");
        %>
        <tr>
            <td><%= userID %></td>
            <td><%= username %></td>
            <td><%= email %></td>
            <td>
                <form action="manageUsers.jsp" method="post">
                    <input type="hidden" name="userID" value="<%= userID %>" />
                    <input type="submit" name="delete" value="Delete" />
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>

<%
    // Handle Delete Action
    if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("delete") != null) {
        int userID = Integer.parseInt(request.getParameter("userID"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
            String deleteQuery = "DELETE FROM users WHERE userID=?";
            PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
            pstmt.setInt(1, userID);
            pstmt.executeUpdate();
            response.sendRedirect("manageUsers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) conn.close();
        }
    }
%>
