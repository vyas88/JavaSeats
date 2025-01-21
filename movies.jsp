<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>JavaSeats - Movies</title>
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
            text-align: center; /* Center align the content */
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
            margin: 20px 0;
            font-size: 32px;
            color: #007bff; /* Blue color for heading */
        }

        /* Movie grid styling */
        .movie-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin: 20px 0;
        }

        /* Movie card styling */
        .movie-card {
            width: 30%;
            margin: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
            background-color: #f8f9fa; /* Light background for movie cards */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .movie-card img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .movie-card h3 {
            margin: 10px 0;
            color: #333333; /* Dark text color for movie title */
        }

        .movie-card p {
            margin: 5px 0;
        }

        .movie-card button {
            background-color: #007bff; /* Blue button color */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .movie-card button:hover {
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
            <a href="index.jsp">Home</a>
            <a href="profile.jsp">Profile</a>
        </div>
    </div>

    <h1>Select a Movie</h1>
    <div class="movie-grid">
        <%
            // Database connection setup
            String dbURL = "jdbc:mysql://localhost:3306/CineReserve";
            String dbUser = "root";
            String dbPass = "1234";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            int theatreID = Integer.parseInt(request.getParameter("theatreID"));
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                stmt = conn.createStatement();
                String query = "SELECT * FROM Movies";
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int movieID = rs.getInt("movieID");
                    String name = rs.getString("name");
                    String genre = rs.getString("genre");
                    int duration = rs.getInt("duration");
                    String showtimes = rs.getString("showtimes");
                    String imageURL = rs.getString("imageURL"); 
                    
                    // Convert showtimes into an array
                    String[] times = showtimes.split(", ");
                    request.setAttribute("showtimesArray", times); // Set the array as a request attribute
        %>
                    <div class="movie-card">
                        <img src="<%= imageURL %>" alt="<%= name %> Poster">
                        <h3><%= name %></h3>
                        <p><strong>Genre:</strong> <%= genre %></p>
                        <p><strong>Duration:</strong> <%= duration %> mins</p>
                        <form action="seatSelection.jsp" method="post">
                        	<input type="hidden" name="theatreID" value="<%= theatreID %>">
                            <input type="hidden" name="movieID" value="<%= movieID %>">
                            <c:forEach var="stime" items="${showtimesArray}"> <!-- Use the request attribute -->
                                <button type="submit" name="showtime" value="${stime}">${stime} PM</button>
                            </c:forEach>
                        </form>
                        <br>
                        <!-- View Details Form -->
                        <form action="movieDetails.jsp" method="get">
                            <input type="hidden" name="movieID" value="<%= movieID %>">
                            <button type="submit">View Details</button>
                        </form>
                    </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>

    <footer>
        <p>&copy; 2024 JavaSeats. All rights reserved.</p>
    </footer>
</body>
</html>
