<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Manage Theatres</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            margin-bottom: 20px;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0px 0px 8px #ccc;
            width: 50%;
            margin: 0 auto;
        }
        form input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }
        form input[type="submit"]:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            text-align: left;
            padding: 12px;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        img {
            border-radius: 4px;
        }
        .delete-btn {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 4px;
        }
        .delete-btn:hover {
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
    <h1>Manage Theatres</h1>

    <!-- Form to Add a Theatre -->
    <form action="manageTheatres.jsp" method="post">
        <input type="text" name="name" placeholder="Theatre Name" required /><br>
        <input type="text" name="location" placeholder="Location" required /><br>
        <input type="text" name="photoURL" placeholder="Photo URL" required /><br>
        <input type="text" name="imageURL" placeholder="Image URL" required /><br>
        <input type="submit" value="Add Theatre" />
    </form>
	<a href="admin.jsp" class="back-btn">Go Back</a>
    <!-- Theatre List -->
    <h2>Current Theatres</h2>
    <table>
        <tr><th>ID</th><th>Name</th><th>Location</th><th>Image</th><th>Actions</th></tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                stmt = conn.createStatement();
                String query = "SELECT * FROM theatres";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    int theatreID = rs.getInt("theatreID");
                    String name = rs.getString("name");
                    String location = rs.getString("location");
                    String imageURL = rs.getString("imageURL");
        %>
        <tr>
            <td><%= theatreID %></td>
            <td><%= name %></td>
            <td><%= location %></td>
            <td><img src="<%= imageURL %>" width="50" height="50"></td>
            <td>
                <form action="manageTheatres.jsp" method="post">
                    <input type="hidden" name="theatreID" value="<%= theatreID %>" />
                    <input type="submit" name="delete" class="delete-btn" value="Delete" />
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
    // Handle Add/Delete Actions
    if (request.getMethod().equalsIgnoreCase("post")) {
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String imageURL = request.getParameter("imageURL");

        if (name != null) {
            // Add Theatre
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                String insertQuery = "INSERT INTO theatres (name, location,, imageURL) VALUES (?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, name);
                pstmt.setString(2, location);
                pstmt.setString(3, imageURL);
                pstmt.executeUpdate();
                response.sendRedirect("manageTheatres.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) conn.close();
            }
        } else if (request.getParameter("delete") != null) {
            // Delete Theatre
            int theatreID = Integer.parseInt(request.getParameter("theatreID"));
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                String deleteQuery = "DELETE FROM theatres WHERE theatreID=?";
                PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
                pstmt.setInt(1, theatreID);
                pstmt.executeUpdate();
                response.sendRedirect("manageTheatres.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) conn.close();
            }
        }
    }
%>
