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

@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {

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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821")) {
                String sql = "DELETE FROM Menu WHERE MenuID = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, menuId);
                stmt.executeUpdate();
            }
            response.sendRedirect("admin.jsp");

        } catch (IOException | ClassNotFoundException | SQLException e) {
    response.getWriter().println("Error deleting item: " + e.getMessage());
        }
    }
}
