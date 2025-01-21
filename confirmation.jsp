<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <style>
        /* Reset and basic body style */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f9;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        /* Blurred background image using ::before */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('hatta.jpeg') no-repeat center center fixed; /* Add your background image URL */
            background-size: cover;
            filter: blur(8px); /* Apply blur to the background */
            z-index: -1; /* Ensure it's behind the content */
        }

        /* Container for booking confirmation */
        .confirmation {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1; /* Ensure the content is above the blurred background */
            animation: fadeIn 1s ease-in;
            position: relative;
        }

        /* Movie details section */
        .confirmation h2 {
            color: #007bff;
            font-size: 28px;
        }

        /* Movie poster styling */
        .movie-poster {
            float: left;
            margin-right: 20px;
        }

        .movie-poster img {
            width: 240px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Button styling */
        .btn {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            margin-top: 20px;
            display: inline-block;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

        /* Fade-in animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        /* Clearfix for floating elements */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }
    </style>
</head>
<body>

    <%
        // Retrieving data from the request
        String movieID = request.getParameter("movieID");
        String showtime = request.getParameter("time");
        String[] selectedSeats = request.getParameterValues("seat");

        // Database connection to fetch movie details
        String movieName = "";
        String movieImage = ""; // For movie poster
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");

            // Query to get the movie name and poster image
            String query = "SELECT name, imageURL FROM Movies WHERE movieID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(movieID));
            rs = stmt.executeQuery();

            if (rs.next()) {
                movieName = rs.getString("name");
                movieImage = rs.getString("imageURL"); // Movie poster URL or path
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <div class="confirmation-wrapper">
        <div class="confirmation clearfix">
            <!-- Movie poster -->
            <div class="movie-poster">
                <img src="<%= movieImage %>" alt="Movie Poster">
            </div>
            <br><br><br><br><br><br><br><br><br><br>
            

            <!-- Movie booking details -->
            <div>
                <h2>Your Booking Details</h2>
                <p><strong>Movie:</strong> <%= movieName %></p>
                <p><strong>Showtime:</strong> <%= showtime %> pm</p>

                <p><strong>Selected Seats:</strong>
                <ul>
                    <%
                        if (selectedSeats != null) {
                            for (String seat : selectedSeats) {
                    %>
                                <li><%= seat %></li>
                    <%
                            }
                        } else {
                    %>
                            <li>No seats selected.</li>
                    <%
                        }
                    %>
                </ul>
                </p>
                
            </div>

            <!-- Book Tickets Button -->
            <form action="payment.jsp" method="post">
                <input type="hidden" name="movieName" value="<%= movieName %>">
                <input type="hidden" name="movieID" value="<%= movieID %>">
                <input type="hidden" name="showtime" value="<%= showtime %>">
                <%
                    if (selectedSeats != null) {
                        for (String seat : selectedSeats) {
                %>
                            <input type="hidden" name="selectedSeats" value="<%= seat %>">
                <%
                        }
                    }
                %>
                <input type="hidden" name="movieImage" value="<%= movieImage %>">
                <button type="submit" class="btn">Proceed to Payment</button>
            </form>
        </div>
    </div>
</body>
</html>