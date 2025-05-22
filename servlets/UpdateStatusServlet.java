/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821")) {
                PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE Orders SET Status = ? WHERE OrderID = ?"
                );
                stmt.setString(1, status);
                stmt.setInt(2, orderId);
                stmt.executeUpdate();
            }
            response.sendRedirect("allorders.jsp");

        } catch (IOException | ClassNotFoundException | SQLException e) {
            throw new ServletException("Error updating order status", e);
        }
    }
}
