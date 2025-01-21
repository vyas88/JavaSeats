<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        /* General styles */
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            color: #333;
            text-align: center;
            font-size: 36px;
            margin-bottom: 30px;
        }

        /* Navigation styles */
        nav {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            animation: slideIn 0.8s ease;
        }

        nav a {
            background-color: #007BFF;
            color: white;
            padding: 15px 25px;
            margin: 10px 0;
            text-decoration: none;
            border-radius: 50px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            font-size: 18px;
            width: 100%;
            text-align: center;
        }

        nav a:hover {
            background-color: #0056b3;
            transform: scale(1.05); /* Button enlarges slightly */
        }

        /* Animation keyframes */
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            0% {
                transform: translateY(50px);
                opacity: 0;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    
    <nav>
    	<h1>Admin Dashboard</h1>
        <a href="manageMovies.jsp">Manage Movies</a>
        <a href="manageBookings.jsp">Manage Bookings</a>
        <a href="manageTheatres.jsp">Manage Theatres</a>
        <a href="manageUsers.jsp">Manage Users</a>
    </nav>
</body>
</html>
