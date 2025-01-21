<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException, java.sql.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Details</title>
    <style>
    /* General styles */
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        color: #333;
    }

    h1 {
        color: #007bff; /* Blue heading color */
        font-size: 36px;
        text-align: center;
        margin-top: 20px;
    }

    /* Navbar styles */
    .navbar {
        background-color: #f8f9fa; /* Light gray */
        color: #333;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .logo {
        font-size: 24px;
        font-weight: bold;
        color: #007bff; /* Blue logo */
    }

    .nav-links a {
        color: #333;
        text-decoration: none;
        padding: 0 15px;
        transition: color 0.3s ease;
    }

    .nav-links a:hover {
        color: #007bff; /* Blue hover effect */
    }

    /* Movie details container */
    .movie-details {
        max-width: 800px;
        margin: 30px auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .movie-details p {
        font-size: 18px;
        line-height: 1.6;
    }

    .movie-details strong {
        color: #333;
    }

    iframe {
        display: block;
        margin: 20px auto;
        border-radius: 8px;
        transition: transform 0.3s ease;
    }

    iframe:hover {
        transform: scale(1.05); /* Zoom-in effect on hover */
    }

    /* Go Back button styles */
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

    /* Footer styles */
    footer {
        background-color: #333;
        color: #fff;
        text-align: center;
        padding: 20px;
        position: fixed;
        bottom: 0;
        width: 100%;
        font-size: 14px;
    }

    /* Animations */
    @keyframes fadeInUp {
        0% {
            opacity: 0;
            transform: translateY(20px);
        }
        100% {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .movie-details {
        animation: fadeInUp 1s ease-in-out;
    }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">JavaSeats</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="profile.jsp">Profile</a>
        </div>
    </div>

    <div class="movie-details">
        <%
            String dbURL = "jdbc:mysql://localhost:3306/CineReserve";
            String dbUser = "root";
            String dbPass = "1234";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                stmt = conn.createStatement();
                String query = "SELECT m.name, m.genre, m.duration, d.description, d.trailerUrl, d.releaseDate, d.director " +
                               "FROM Movies m " +
                               "JOIN MovieDetails d ON m.movieID = d.movieID " +
                               "WHERE m.movieID = " + movieID;
                rs = stmt.executeQuery(query);

                if (rs.next()) {
                    String name = rs.getString("name");
                    String genre = rs.getString("genre");
                    int duration = rs.getInt("duration");
                    String description = rs.getString("description");
                    String trailerUrl = rs.getString("trailerUrl");
                    java.sql.Date releaseDate = rs.getDate("releaseDate");
                    String director = rs.getString("director");
        %>
                    <h1><%= name %> Details</h1>
                    <p><strong>Genre:</strong> <%= genre %></p>
                    <p><strong>Duration:</strong> <%= duration %> mins</p>
                    <p><strong>Director:</strong> <%= director %></p>
                    <p><strong>Release Date:</strong> <%= releaseDate %></p>
                    <p><strong>Description:</strong> <%= description %></p>
                    <iframe width="560" height="315" src="<%= trailerUrl %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

                    <!-- Go Back Button -->
                    <a href="theatres.jsp" class="back-btn">Go Back</a>
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
