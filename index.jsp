<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>JavaSeats - Home</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #ffffff; /* White background */
            color: #333333; /* Dark text color for readability */
            line-height: 1.6;
        }

        /* Navigation bar styling */
        .navbar {
            background-color: #f8f9fa; /* Light gray for navbar */
            overflow: hidden;
            position: relative;
            width: 100%;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* Logo (site name) styling */
        .navbar .logo {
            float: left;
            padding: 14px 20px;
            font-size: 28px;
            color: #007bff; /* Blue color for logo */
            font-weight: bold;
            text-transform: none; /* Changed to title case */
        }

        /* Navigation links */
        .navbar .nav-links {
            float: right;
        }

        .navbar .nav-links a {
            float: left;
            display: block;
            color: #333333; /* Dark text color for links */
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .navbar .nav-links a:hover {
            background-color: #007bff; /* Blue color on hover */
            color: #ffffff;
        }

        /* Clear floats */
        .navbar::after {
            content: "";
            display: table;
            clear: both;
        }

        /* Main heading styling */
        h1 {
            text-align: center;
            margin: 20px 0;
            font-size: 36px;
            color: #007bff; /* Blue color for heading */
        }

        /* Subtitle styling */
        p {
            text-align: center;
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* Location grid styling */
        .location-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 0 20px;
        }

        /* Location card styling */
        .location-card {
            background-color: #f8f9fa; /* Light card background */
            width: 300px;
            margin: 15px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }

        .location-card:hover {
            transform: translateY(-5px);
            background-color: #e9ecef; /* Highlight on hover */
        }

        .location-card img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .location-card h3 {
            margin: 10px 0;
            font-size: 24px;
            color: #007bff; /* Blue color for card heading */
        }

        .location-card button {
            background-color: #007bff; /* Blue button color */
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .location-card button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        /* Footer styling */
        footer {
            text-align: center;
            padding: 10px 0;
            background-color: #f8f9fa;
            color: #333333;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <!-- Site Name / Logo -->
        <div class="logo">JavaSeats</div>

        <!-- Navigation Links -->
        <div class="nav-links">
            <a href="profile.jsp">Profile</a>
            <a href="admin.jsp">Admin</a>
        </div>
    </div>

    <h1>Welcome to JavaSeats</h1>
    <p>Your go-to place for booking movie tickets! Choose your preferred location:</p>

    <div class="location-grid">
        <% 
            String dbURL = "jdbc:mysql://localhost:3306/CineReserve";
            String dbUser = "root";
            String dbPass = "1234";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                String query = "SELECT * FROM Theatres";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int theatreID = rs.getInt("theatreID");
                    String name = rs.getString("name");
                    String imageURL = rs.getString("imageURL");
        %>
                    <div class="location-card">
                        <img src="<%= imageURL %>" alt="<%= name %> Theatre">
                        <h3><%= name %></h3>
                        <form action="movies.jsp" method="post">
                            <input type="hidden" name="theatreID" value="<%= theatreID %>">
                            <button type="submit">Select Theatre</button>
                        </form>
                    </div>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>

    <footer>
        <p>&copy; 2024 JavaSeats. All rights reserved.</p>
    </footer>
</body>
</html>
