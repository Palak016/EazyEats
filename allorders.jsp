<%-- 
    Document   : allorders
    Created on : 18 May 2025, 11:25:14?pm
    Author     : Msft
--%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("userEmail");
    if (email == null || !email.equals("admin@canteen.com")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Orders - Admin View</title>
</head>
<body>
    <div style="text-align:right; margin: 10px;">
        <a href="logout.jsp">? Logout</a>
    </div>

    <h2>All Orders (Admin)</h2>
    <a href="admin.jsp">? Back to Admin Panel</a><br><br>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821");

        String orderQuery = "SELECT * FROM Orders ORDER BY OrderDate DESC";
        Statement orderStmt = conn.createStatement();
        ResultSet orders = orderStmt.executeQuery(orderQuery);

        while (orders.next()) {
            int orderId = orders.getInt("OrderID");
            String userEmail = orders.getString("UserEmail");
            Date date = orders.getDate("OrderDate");
            String status = orders.getString("Status");
%>
    <h3>
        Order #<%= orderId %> | Date: <%= new SimpleDateFormat("yyyy-MM-dd").format(date) %> |
        User: <%= userEmail %> |
        Status: <strong><%= status %></strong>
    </h3>

    <!-- Status Update Form -->
    <form action="UpdateStatusServlet" method="post" style="margin-bottom: 10px;">
        <input type="hidden" name="orderId" value="<%= orderId %>">
        <label>Change Status:</label>
        <select name="status">
            <option<%= status.equals("Pending") ? " selected" : "" %>>Pending</option>
            <option<%= status.equals("Preparing") ? " selected" : "" %>>Preparing</option>
            <option<%= status.equals("Delivered") ? " selected" : "" %>>Delivered</option>
            <option<%= status.equals("Cancelled") ? " selected" : "" %>>Cancelled</option>
        </select>
        <input type="submit" value="Update">
    </form>

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
            }
%>
        <tr>
            <td colspan="2"><strong>Total</strong></td>
            <td><strong><%= total %></strong></td>
        </tr>
    </table>
    <br><br>
<%
        } // end of orders loop

        conn.close();
    } catch (Exception e) {
%>
    <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
    }
%>
</body>
</html>
