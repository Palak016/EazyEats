<%-- 
    Document   : admin
    Created on : 18 May 2025, 10:35:13?pm
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
%>
<!DOCTYPE html>
<html>
<head><title>Admin Panel</title></head>
<body>
    <h2>Welcome Admin</h2>
    <a href="additem.jsp"> Add New Item</a> | 
    <a href="logout.jsp"> Logout</a><br><br>
    <a href="allorders.jsp">View All Orders</a>

    <table border="1" cellpadding="8">
        <tr>
            <th>Item Name</th>
            <th>Description</th>
            <th>Price (?)</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Menu");

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getString("ItemName") %></td>
                        <td><%= rs.getString("Description") %></td>
                        <td><%= rs.getDouble("Price") %></td>
                        <td>
                            <form action="DeleteItemServlet" method="post" style="display:inline;">
                                <input type="hidden" name="menuId" value="<%= rs.getInt("MenuID") %>">
                                <input type="submit" value="Delete">
                            </form>
                                <a href="edititem.jsp?id=<%= rs.getInt("MenuID") %>">Edit</a>
                        </td>
                    </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
    <!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
setInterval(() => {
    fetch("checkNewOrders.jsp")
        .then(res => res.json())
        .then(data => {
            if (data.message && data.message !== "none" && data.message !== "unauthorized") {
                Swal.fire({
                    icon: 'info',
                    title: '? New Order Received!',
                    text: data.message,
                    timer: 4000
                });
            }
        });
}, 10000); // Every 10 seconds
</script>
</body>
</html>

