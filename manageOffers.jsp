<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Manage Offers</title>
</head>
<body>
    <h1>Manage Offers</h1>

    <!-- Form to Add Offer -->
    <h2>Add New Offer</h2>
    <form action="manageOffers.jsp" method="post">
        <input type="text" name="description" placeholder="Offer Description" required /><br>
        <input type="number" name="discount" step="0.01" placeholder="Discount Percentage" required /><br>
        <label for="valid_from">Valid From:</label>
        <input type="date" name="valid_from" required /><br>
        <label for="valid_until">Valid Until:</label>
        <input type="date" name="valid_until" required /><br>
        <input type="submit" value="Add Offer" />
    </form>

    <!-- Offer List -->
    <h2>Current Offers</h2>
    <table border="1">
        <tr><th>Offer ID</th><th>Description</th><th>Discount (%)</th><th>Valid From</th><th>Valid Until</th><th>Actions</th></tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                stmt = conn.createStatement();
                String query = "SELECT * FROM offers";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    int offerID = rs.getInt("offerID");
                    String description = rs.getString("description");
                    double discount = rs.getDouble("discount");
                    Date validFrom = rs.getDate("valid_from");
                    Date validUntil = rs.getDate("valid_until");
        %>
        <tr>
            <td><%= offerID %></td>
            <td><%= description %></td>
            <td><%= discount %></td>
            <td><%= validFrom %></td>
            <td><%= validUntil %></td>
            <td>
                <form action="manageOffers.jsp" method="post">
                    <input type="hidden" name="offerID" value="<%= offerID %>" />
                    <input type="submit" name="delete" value="Delete" />
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

<%
    // Handle Add/Delete Actions
    if (request.getMethod().equalsIgnoreCase("post")) {
        String description = request.getParameter("description");
        String discount = request.getParameter("discount");
        String validFrom = request.getParameter("valid_from");
        String validUntil = request.getParameter("valid_until");

        if (description != null && discount != null && validFrom != null && validUntil != null) {
            // Add Offer
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                String insertQuery = "INSERT INTO offers (description, discount, valid_from, valid_until) VALUES (?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, description);
                pstmt.setBigDecimal(2, new java.math.BigDecimal(discount));
                pstmt.setDate(3, Date.valueOf(validFrom));
                pstmt.setDate(4, Date.valueOf(validUntil));
                pstmt.executeUpdate();
                response.sendRedirect("manageOffers.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) conn.close();
            }
        } else if (request.getParameter("delete") != null) {
            // Delete Offer
            int offerID = Integer.parseInt(request.getParameter("offerID"));
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CineReserve", "root", "1234");
                String deleteQuery = "DELETE FROM offers WHERE offerID=?";
                PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
                pstmt.setInt(1, offerID);
                pstmt.executeUpdate();
                response.sendRedirect("manageOffers.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) conn.close();
            }
        }
    }
%>
