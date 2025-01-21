<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Confirmation</title>
    <style>
            body{
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
        .payment-container {
            width: 100%;
            max-width: 700px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: slideUp 1s ease-in-out;
        }
        h1 {
            font-size: 30px;
            color: #28a745;
        }
        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        .movie-poster img {
            width: 250px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        ul li {
            font-size: 18px;
            color: #555;
        }
        .btn {
            padding: 12px 24px;
            background-color: #28a745;
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
            background-color: #218838;
            transform: translateY(-3px);
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <h1>Payment Successful!</h1>
        <h2>Your Booking Details</h2>

        <%
    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        session = request.getSession();
        String showtime = request.getParameter("showtime");
        String[] selectedSeats = request.getParameterValues("selectedSeats");
        String movieImage = request.getParameter("movieImage");
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            out.println("Error: User ID is missing. Please login.");
            return;
        }

        String theatreID = "1"; // Hardcoded
        String movieIDParam = request.getParameter("movieID");

        if (movieIDParam == null || movieIDParam.isEmpty()) {
            out.println("Error: Movie ID is missing.");
            return;
        }

        if (theatreID == null || theatreID.isEmpty()) {
            out.println("Error: Theatre ID is missing.");
            return;
        }

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");

        String sql = "INSERT INTO bookings (userID, movieID, theatreID, seat, showtime, payment_status) VALUES (?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);

        for (String seat : selectedSeats) {
            stmt.setInt(1, userID);
            stmt.setInt(2, Integer.parseInt(movieIDParam));
            stmt.setInt(3, Integer.parseInt(theatreID));
            stmt.setString(4, seat);
            stmt.setString(5, showtime);
            stmt.setString(6, "Paid");
            stmt.executeUpdate();
        }

        out.println("Payment successful! Your seats have been booked.");
    } catch (ClassNotFoundException cnfEx) {
        cnfEx.printStackTrace();
        out.println("Driver not found: " + cnfEx.getMessage());
    } catch (SQLException sqlEx) {
        sqlEx.printStackTrace();
        out.println("SQL Error: " + sqlEx.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error processing your booking. Please try again.");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>

        
        <p>Thank you for your booking! Enjoy the show.</p>

        <!-- Button to go back to homepage -->
        <button class="btn" onclick="window.location.href='index.jsp';">Go to Homepage</button>
    </div>
</body>
</html>
