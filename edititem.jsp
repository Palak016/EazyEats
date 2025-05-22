<%-- 
    Document   : edititem
    Created on : 18 May 2025, 11:16:40?pm
    Author     : Msft
--%>

<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("userEmail");
    if (email == null || !email.equals("admin@canteen.com")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int menuId = Integer.parseInt(request.getParameter("id"));
    String name = "", desc = "";
    double price = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821");

        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Menu WHERE MenuID = ?");
        stmt.setInt(1, menuId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("ItemName");
            desc = rs.getString("Description");
            price = rs.getDouble("Price");
        }

        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Menu Item</title>
</head>
<body>
    <h2>Edit Item</h2>
    <form action="EditItemServlet" method="post">
        <input type="hidden" name="menuId" value="<%= menuId %>">
        Item Name: <input type="text" name="itemName" value="<%= name %>" required><br><br>
        Description: <input type="text" name="description" value="<%= desc %>" required><br><br>
        Price (?): <input type="number" name="price" value="<%= price %>" step="0.01" required><br><br>
        <input type="submit" value="Update Item">
    </form>
    <br>
    <a href="admin.jsp">? Back to Admin Panel</a>
</body>
</html>
