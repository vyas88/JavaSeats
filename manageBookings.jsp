<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Manage Bookings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            transition: background-color 0.3s ease;
        }

        h1 {
            color: #333;
            text-align: center;
            animation: fadeIn 1s ease;
        }

        h2 {
            color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        table:hover {
            transform: scale(1.01);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
            transition: background-color 0.3s;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        input[type="submit"] {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #c82333;
        }

        form {
            display: inline;
        }

        /* Animation for header */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
    <h1>Manage Bookings</h1>
<a href="admin.jsp" class="back-btn">Go Back</a>
    <!-- Display Bookings -->
    <h2>Current Bookings</h2>
    <table>
        <tr>
            <th>Booking ID</th>
            <th>User ID</th>
            <th>Movie ID</th>
            <th>Theatre ID</th>
            <th>Seat</th>
            <th>Showtime</th>
            <th>Payment Status</th>
            <th>Actions</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                stmt = conn.createStatement();
                String query = "SELECT * FROM bookings";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    int bookingID = rs.getInt("bookingID");
                    int userID = rs.getInt("userID");
                    int movieID = rs.getInt("movieID");
                    int theatreID = rs.getInt("theatreID");
                    String seat = rs.getString("seat");
                    Time showtime = rs.getTime("showtime");
                    String paymentStatus = rs.getString("payment_status");
        %>
        <tr>
            <td><%= bookingID %></td>
            <td><%= userID %></td>
            <td><%= movieID %></td>
            <td><%= theatreID %></td>
            <td><%= seat %></td>
            <td><%= showtime %></td>
            <td><%= paymentStatus %></td>
            <td>
                <form action="manageBookings.jsp" method="post">
                    <input type="hidden" name="bookingID" value="<%= bookingID %>" />
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

    <%
        // Handle Delete Action
        if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("delete") != null) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                String deleteQuery = "DELETE FROM bookings WHERE bookingID=?";
                PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
                pstmt.setInt(1, bookingID);
                pstmt.executeUpdate();
                response.sendRedirect("manageBookings.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
