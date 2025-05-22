<%-- 
    Document   : additem
    Created on : 18 May 2025, 10:45:58?pm
    Author     : Msft
--%>
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
<head><title>Add New Item</title></head>
<body>
    <h2>Add New Menu Item</h2>
    <form action="AddItemServlet" method="post">
        Item Name: <input type="text" name="itemName" required><br><br>
        Description: <input type="text" name="description" required><br><br>
        Price (?): <input type="number" name="price" step="0.01" required><br><br>
        <input type="submit" value="Add Item">
    </form>
    <br>
    <a href="admin.jsp">? Back to Admin Panel</a>
</body>
</html>

