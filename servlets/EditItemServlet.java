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

@WebServlet("/EditItemServlet")
public class EditItemServlet extends HttpServlet {

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

        int menuId = Integer.parseInt(request.getParameter("menuId"));
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821")) {
                PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE Menu SET ItemName = ?, Description = ?, Price = ? WHERE MenuID = ?"
                );
                stmt.setString(1, itemName);
                stmt.setString(2, description);
                stmt.setDouble(3, price);
                stmt.setInt(4, menuId);
                
                stmt.executeUpdate();
            }

            response.sendRedirect("admin.jsp");

        } catch (IOException | ClassNotFoundException | SQLException e) {
            throw new ServletException("Error updating item", e);
        }
    }
}
