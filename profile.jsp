<%@page import="java.sql.*" %>
<%@ page session="true" %>
<%
    // Retrieve the userID from session (assuming the user is logged in and userID is stored in session)
    Integer userID = (Integer) session.getAttribute("userID");
    
    if (userID == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
    }
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    String url = "jdbc:mysql://localhost:3306/CineReserve"; // Replace with your DB details
    String dbUser = "root"; // Replace with your DB username
    String dbPassword = "1234"; // Replace with your DB password

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // Query to get user's bookings along with movie and theatre details
        String query = "SELECT b.bookingID, m.name AS movieName, m.genre, m.duration, t.name AS theatreName, " +
                       "b.seat, b.showtime, b.payment_status " +
                       "FROM bookings b " +
                       "JOIN movies m ON b.movieID = m.movieID " +
                       "JOIN theatres t ON b.theatreID = t.theatreID " +
                       "WHERE b.userID = ?";
                       
        ps = con.prepareStatement(query);
        ps.setInt(1, userID);
        rs = ps.executeQuery();
%>

<html>
<head>
    <title>User Profile</title>
    <style>
        /* Background styling */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f9;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
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

        /* Table container */
        .table-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            max-width: 1000px;
            width: 100%;
            animation: fadeIn 1.5s ease-in-out;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        /* Row hover effect */
        tr:hover {
            background-color: #f2f2f2;
            transition: background-color 0.3s ease;
        }

        /* Welcome message */
        h2 {
            color: #007bff;
            font-size: 28px;
            text-align: center;
        }

        h3 {
            font-size: 22px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Fade-in animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Scrollable table */
        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }

        /* Button styling */
        .button-container {
            text-align: center;
            
        }

        .btn {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

    </style>
</head>
<body>
    <div class="table-container">
        <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
        <h3>Your Bookings:</h3>

        <table>
            <tr>
                <th>Booking ID</th>
                <th>Movie Name</th>
                <th>Genre</th>
                <th>Duration</th>
                <th>Theatre Name</th>
                <th>Seat</th>
                <th>Showtime</th>
                <th>Payment Status</th>
            </tr>
            
            <%
                while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("bookingID") %></td>
                <td><%= rs.getString("movieName") %></td>
                <td><%= rs.getString("genre") %></td>
                <td><%= rs.getInt("duration") %> minutes</td>
                <td><%= rs.getString("theatreName") %></td>
                <td><%= rs.getString("seat") %></td>
                <td><%= rs.getTime("showtime") %></td>
                <td><%= rs.getString("payment_status") %></td>
            </tr>
            <%
                }
            %>
        </table>

        <!-- Button section -->
        <div class="button-container">
            <form action="index.jsp" method="get">
                <button class="btn">Go to Home Page</button>
            </form>
            <form action="logout.jsp" method="post">
                <button class="btn">Logout</button>
            </form>
        </div>
    </div>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
    }
%>
