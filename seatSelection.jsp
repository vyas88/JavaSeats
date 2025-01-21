<%@ page import="java.sql.*" %>
<html lang="en">
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineReserve - Seat Selection</title>
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
            color: #007bff;
        }

        /* Form heading */
        h2 {
            text-align: center;
            margin: 20px 0;
            font-size: 24px;
            color: #007bff;
        }
        
        .centered {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px; /* Add some space below the dropdown */
        }
        
        .centered select {
            padding: 10px;
            font-size: 16px;
            margin-top: 10px; /* Space between label and dropdown */
        }

        /* Seat grid styling */
        .seat-grid {
            display: grid;
            grid-template-columns: repeat(10, 1fr);
            gap: 10px;
            margin: 20px auto;
            max-width: 800px;
        }

        .seat {
            padding: 15px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .seat.selected {
            background-color: #4CAF50;
            color: white;
        }

        .seat input {
            display: none;
        }

        /* Screen styling */
        .screen {
            margin: 20px auto;
            width: 80%;
            height: 30px;
            background-color: #999;
            text-align: center;
            color: white;
            font-weight: bold;
            line-height: 30px;
            border-radius: 5px;
            max-width: 800px;
        }

        /* Button styling */
        button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Footer styling */
        footer {
            text-align: center;
            padding: 10px 0;
            background-color: #f8f9fa;
            color: #333333;
            position: relative;
            width: 100%;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="logo">JavaSeats</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="movies.jsp">Movies</a>
            <a href="profile.jsp">Profile</a>
        </div>
    </div>

    <h1>Select Your Seats</h1>

    <%
        String movieIDParam = request.getParameter("movieID");
        String time = request.getParameter("showtime");
        int theatreID = Integer.parseInt(request.getParameter("theatreID"));
        int movieID = -1;
        ArrayList<String> bookedseats = new ArrayList<>();

        if (movieIDParam != null && !movieIDParam.isEmpty()) {
            try {
                movieID = Integer.parseInt(movieIDParam);
            } catch (NumberFormatException e) {
                out.println("<p style='color:red;'>Invalid movie selection. Please try again.</p>");
                return;
            }
        } else {
            out.println("<p style='color:red;'>No movie selected. Please go back and select a movie.</p>");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");

            String query = "SELECT seat FROM bookings WHERE movieID = ? AND showtime = ? AND theatreID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, movieID);
            stmt.setString(2, time);
            stmt.setInt(3, theatreID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                bookedseats.add(rs.getString(1));
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Error retrieving booked seats. Please try again later.</p>");
            return;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <h2>Showtime : <%= time %> pm</h2>
    <form action="confirmation.jsp" method="post">
        <input type="hidden" name="movieID" value="<%= movieID %>">
        <input type="hidden" name="time" value="<%= time %>">

        <h2>Select Your Seats</h2>
        <div class="seat-grid">
            <%
                for (int i = 1; i <= 50; i++) {
                    if (bookedseats.contains("Seat " + i)) {
            %>
                <div class="seat" style="background-color: #e0e0e0; color: #a0a0a0; cursor: not-allowed;">
    			<input type="checkbox" disabled name="seat" value="Seat <%= i %>">
    			A <%= i %>
				</div>

            <%
                    } else {
            %>
                <div class="seat" onclick="toggleSeat(this)">
                    <input type="checkbox" name="seat" value="Seat <%= i %>">
                    A <%= i %>
                </div>
            <%
                    }
                }
            %>
        </div>

        <!-- Screen indicator -->
        <div class="screen">SCREEN</div>

        <button type="submit">Proceed to Book</button>
    </form>

    <footer>
        <p>&copy; 2024 JavaSeats. All rights reserved.</p>
    </footer>

    <script>
        function toggleSeat(seat) {
            seat.classList.toggle('selected');
            const checkbox = seat.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
        }
    </script>
</body>
</html>