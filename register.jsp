<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>JavaSeats - Register</title>
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
        h2 {
            margin: 20px 0;
            font-size: 32px;
            color: #007bff; /* Blue color for heading */
        }

        /* Form styling */
        form {
            max-width: 400px; /* Limit form width */
            margin: 0 auto; /* Center the form */
            background-color: #f8f9fa; /* Light background for form */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input[type="email"],
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        button[type="submit"] {
            background-color: #007bff; /* Blue button color */
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            width: 100%;
        }

        button[type="submit"]:hover {
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

        /* Link to login */
        a {
            display: block;
            margin-top: 10px;
            color: #007bff; /* Blue color for links */
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>

    <div class="navbar">
        <!-- Site Name / Logo -->
        <div class="logo">JavaSeats</div>

        <!-- Navigation Links -->
        
    </div>

    <h2>Register</h2>
    <form action="registerUser.jsp" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        
        <button type="submit">Register</button>
    </form>
    <a href="login.jsp">Already have an account? Login here</a>

    <footer>
        <p>&copy; 2024 JavaSeats. All rights reserved.</p>
    </footer>
</body>
</html>
