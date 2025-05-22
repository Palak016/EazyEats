/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/checkStatus")
public class CheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            out.print("{\"status\":\"none\"}");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821")) {
                String sql = "SELECT OrderID, Status, OrderTime FROM Orders WHERE UserEmail=? ORDER BY OrderID DESC LIMIT 1";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, userEmail);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    int orderId = rs.getInt("OrderID");
                    String status = rs.getString("Status");
                    Timestamp orderTime = rs.getTimestamp("OrderTime");
                    
                    long minutes = (System.currentTimeMillis() - orderTime.getTime()) / 60000;
                    String updatedStatus = status;
                    
                    if (minutes >= 10) updatedStatus = "Delivered";
                    else if (minutes >= 5) updatedStatus = "Ready";
                    else if (minutes >= 2) updatedStatus = "Preparing";
                    
                    if (!status.equals(updatedStatus)) {
                        try (PreparedStatement updateStmt = conn.prepareStatement(
                                "UPDATE Orders SET Status=? WHERE OrderID=?")) {
                            updateStmt.setString(1, updatedStatus);
                            updateStmt.setInt(2, orderId);
                            updateStmt.executeUpdate();
                        }
                    }
                    
                    out.print("{\"status\":\"" + updatedStatus + "\"}");
                } else {
                    out.print("{\"status\":\"none\"}");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.print("{\"status\":\"error\"}");
        }
    }
}

