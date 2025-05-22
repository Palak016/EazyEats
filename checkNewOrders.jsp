<%-- 
    Document   : checkNewOrders
    Created on : 20 May 2025, 12:07:03?pm
    Author     : Msft
--%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    response.setContentType("application/json");

    String adminEmail = (String) session.getAttribute("UserName");
    if (!"admin@canteen.com".equals(adminEmail)) {
        out.print("{\"message\":\"unauthorized\"}");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821");

        String sql = "SELECT OrderID, UserName FROM Orders WHERE Notified = FALSE ORDER BY OrderDate DESC LIMIT 1";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            int orderId = rs.getInt("OrderID");
            String userEmail = rs.getString("UserName");

            // Update to mark it as notified
            PreparedStatement update = conn.prepareStatement("UPDATE Orders SET Notified = TRUE WHERE OrderID = ?");
            update.setInt(1, orderId);
            update.executeUpdate();
            update.close();

            out.print("{\"message\":\"New order from " + userEmail + "\"}");
        } else {
            out.print("{\"message\":\"none\"}");
        }

        rs.close(); stmt.close(); conn.close();
    } catch (Exception e) {
        out.print("{\"message\":\"error\"}");
    }
%>

