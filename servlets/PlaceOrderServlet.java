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

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userEmail = (String) request.getSession().getAttribute("userEmail");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Step 1: Insert order into Orders table
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821")) {
                // Step 1: Insert order into Orders table
                PreparedStatement orderStmt = conn.prepareStatement(
                        "INSERT INTO Orders (UserEmail, OrderDate) VALUES (?, CURDATE())",
                        Statement.RETURN_GENERATED_KEYS
                );
                orderStmt.setString(1, userEmail);
                orderStmt.executeUpdate();
                
                ResultSet rs = orderStmt.getGeneratedKeys();
                int orderId = -1;
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
                
                // Step 2: Insert each selected item into OrderItem table
                String[] selectedItems = request.getParameterValues("menuItem");
                if (selectedItems != null && orderId != -1) {
                    PreparedStatement itemStmt = conn.prepareStatement(
                            "INSERT INTO OrderItem (OrderID, MenuID, Quantity) VALUES (?, ?, ?)"
                    );
                    
                    for (String itemIdStr : selectedItems) {
                        int menuId = Integer.parseInt(itemIdStr);
                        int qty = Integer.parseInt(request.getParameter("qty_" + menuId));
                        
                        itemStmt.setInt(1, orderId);
                        itemStmt.setInt(2, menuId);
                        itemStmt.setInt(3, qty);
                        itemStmt.executeUpdate();
                    }
                }
            }
            response.getWriter().println("Order placed successfully!");

        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            throw new ServletException("Order processing failed: " + e.getMessage(), e);
        }
    }
}
