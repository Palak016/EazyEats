<%-- 
    Document   : myorders
    Created on : 18 May 2025, 10:00:51?pm
    Author     : Msft
--%>

<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
</head>
<body>
    <div style="text-align:right; margin: 10px;">
        <a href="logout.jsp">? Logout</a>
    </div>
    <h2>My Orders</h2>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821");

        String orderQuery = "SELECT * FROM Orders WHERE UserEmail = ?";
        PreparedStatement orderStmt = conn.prepareStatement(orderQuery);
        orderStmt.setString(1, userEmail);
        ResultSet orders = orderStmt.executeQuery();

        while (orders.next()) {
            int orderId = orders.getInt("OrderID");
            Date date = orders.getDate("OrderDate");
            String status = orders.getString("Status");
%>
    <h3>
        Order #<%= orderId %> | Date: <%= new SimpleDateFormat("yyyy-MM-dd").format(date) %> |
        Status: <span style="color:blue;"><%= status %></span>
    </h3>

    <table border="1" cellpadding="8">
        <tr>
            <th>Item</th>
            <th>Quantity</th>
            <th>Price (?)</th>
        </tr>
<%
            String itemQuery = "SELECT m.ItemName, m.Price, oi.Quantity " +
                               "FROM OrderItem oi JOIN Menu m ON oi.MenuID = m.MenuID " +
                               "WHERE oi.OrderID = ?";
            PreparedStatement itemStmt = conn.prepareStatement(itemQuery);
            itemStmt.setInt(1, orderId);
            ResultSet items = itemStmt.executeQuery();

            double total = 0;

            while (items.next()) {
                double price = items.getDouble("Price");
                int qty = items.getInt("Quantity");
                total += price * qty;
%>
        <tr>
            <td><%= items.getString("ItemName") %></td>
            <td><%= qty %></td>
            <td><%= price %></td>
        </tr>
<%
            } // end item loop
%>
        <tr>
            <td colspan="2"><strong>Total</strong></td>
            <td><strong><%= total %></strong></td>
        </tr>
    </table>
    <br><br>
<%
        } // end order loop

        conn.close();
    } catch (Exception e) {
%>
    <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
    }
%>

    <a href="menu.jsp">? Back to Menu</a>
</body>
</html>
