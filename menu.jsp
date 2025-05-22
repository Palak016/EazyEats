<%-- 
    Document   : menu
    Created on : 18 May 2025, 6:51:01?pm
    Author     : Msft
--%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("userEmail");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>EazyEats | Menu</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f8f9fa;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            color: white;
            padding: 1rem 2rem;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
        }

        .nav-item {
            margin-left: 1.5rem;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            transition: color 0.3s;
        }

        .nav-link:hover {
            color: #ffc107;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .section-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #333;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }

        .menu-item {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .menu-item:hover {
            transform: translateY(-5px);
        }

        .menu-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .menu-content {
            padding: 1rem;
            text-align: center;
        }

        .menu-title {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .menu-price {
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 1rem;
        }

        .menu-btn {
            display: inline-block;
            background-color: #ffc107;
            color: #333;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .menu-btn:hover {
            background-color: #e0a800;
        }

        /* Responsive styles */
        @media (max-width: 992px) {
            .menu-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <a href="#" class="navbar-brand">EazyEats</a>
        <ul class="navbar-nav">
            <li class="nav-item"><a href="menu.jsp" class="nav-link">Menu</a></li>
            <li class="nav-item"><a href="myorders.jsp" class="nav-link">My Orders</a></li>
            <li class="nav-item"><a href="logout.jsp" class="nav-link">Logout</a></li>
        </ul>
    </nav>

    <!-- Menu Grid -->
    <div class="container">
        <h2 class="section-title">Our Delicious Menu</h2>
        <div class="menu-grid">

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Menu");

                while (rs.next()) {
                    String name = rs.getString("ItemName");
                    String img = rs.getString("ImagePath");
                    double price = rs.getDouble("Price");
        %>
            <div class="menu-item">
                <img src="<%= img %>" alt="<%= name %>" class="menu-img">
                <div class="menu-content">
                    <h3 class="menu-title"><%= name %></h3>
                    <p class="menu-price">?<%= String.format("%.2f", price) %></p>
                    <a href="detail.jsp?id=<%= rs.getInt("MenuID") %>" class="menu-btn">View Details</a>
                </div>
            </div>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>

        </div>
    </div>

</body>
</html>
