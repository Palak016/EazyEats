/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/canteen_db", "root", "palak@351821")) {
                String sql = "SELECT * FROM User WHERE Email = ? AND Password = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("userEmail", email);

                    if (email.equals("admin@canteen.com")) {
                        response.sendRedirect("admin.jsp"); // Go to admin panel
                    } else {
                        response.sendRedirect("menu.jsp"); // Normal user
                    }

                } else {
                    // Login failed
                    request.setAttribute("errorMessage", "Invalid email or password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Login failed", e);
        }
    }
}
