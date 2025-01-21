<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Manage Movies</title>
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            animation: fadeIn 0.8s ease-in-out;
        }

        h1 {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px 0;
            margin: 0;
            font-size: 36px;
            animation: slideDown 0.6s ease;
        }

        form {
            margin: 20px auto;
            width: 50%;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            animation: fadeInForm 0.8s ease-in-out;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 25px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #218838;
            transform: scale(1.05);
        }

        table {
            margin: 20px auto;
            width: 80%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            animation: fadeInTable 0.8s ease-in-out;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 15px;
            text-align: center;
            font-size: 16px;
        }

        th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }

        img {
            width: 60px;
            height: 60px;
            border-radius: 5px;
        }

        td form {
            margin: 0;
        }

        td form input[type="submit"] {
            background-color: #dc3545;
            padding: 8px 15px;
            font-size: 14px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        td form input[type="submit"]:hover {
            background-color: #c82333;
            transform: scale(1.05);
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes fadeInForm {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInTable {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideDown {
            from {
                transform: translateY(-50px);
            }
            to {
                transform: translateY(0);
            }
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
    </style>
</head>
<body>
    <h1>Manage Movies</h1>

    <!-- Form to Add a Movie -->
    <form action="manageMovies.jsp" method="post">
        <input type="text" name="name" placeholder="Movie Name" required /><br>
        <input type="text" name="genre" placeholder="Genre" required /><br>
        <input type="number" name="duration" placeholder="Duration (minutes)" required /><br>
        <input type="text" name="showtimes" placeholder="Showtimes (comma-separated)" required /><br>
        <input type="text" name="imageURL" placeholder="Image URL" required /><br>
        <input type="submit" value="Add Movie" />
        
    </form>
    <a href="admin.jsp" class="back-btn">Go Back</a>

    <!-- Movie List -->
    <h2 style="text-align:center; margin: 20px 0;">Current Movies</h2>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Genre</th><th>Duration</th><th>Showtimes</th><th>Image</th><th>Actions</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                stmt = conn.createStatement();
                String query = "SELECT * FROM movies";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    int movieID = rs.getInt("movieID");
                    String name = rs.getString("name");
                    String genre = rs.getString("genre");
                    int duration = rs.getInt("duration");
                    String showtimes = rs.getString("showtimes");
                    String imageURL = rs.getString("imageURL");
        %>
        <tr>
            <td><%= movieID %></td>
            <td><%= name %></td>
            <td><%= genre %></td>
            <td><%= duration %></td>
            <td><%= showtimes %></td>
            <td><img src="<%= imageURL %>" alt="<%= name %>"></td>
            <td>
                <form action="manageMovies.jsp" method="post">
                    <input type="hidden" name="movieID" value="<%= movieID %>" />
                    <input type="submit" name="delete" value="Remove" />
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
</body>
</html>
