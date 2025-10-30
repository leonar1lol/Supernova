package tienda.supernova.servlets;

import tienda.supernova.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        if (email == null || pass == null || email.trim().isEmpty() || pass.trim().isEmpty()) {
            response.sendRedirect("Login.jsp?error=1");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", rs.getString("nombre"));

                String role = "user";
                try {
                    java.sql.ResultSetMetaData md = rs.getMetaData();
                    int cols = md.getColumnCount();
                    for (int i = 1; i <= cols; i++) {
                        String col = md.getColumnLabel(i);
                        if (col.equalsIgnoreCase("rol") || col.equalsIgnoreCase("role")) {
                            String r = rs.getString(col);
                            if (r != null && r.equalsIgnoreCase("admin")) {
                                role = "admin";
                                break;
                            }
                        } else if (col.equalsIgnoreCase("is_admin") || col.equalsIgnoreCase("admin")) {
                            try {
                                boolean isAdmin = rs.getBoolean(col);
                                if (isAdmin) {
                                    role = "admin";
                                    break;
                                }
                            } catch (Exception ignore) {
                            }
                        }
                    }
                } catch (Exception ignore) {

                }

                session.setAttribute("role", role);
                if ("admin".equals(role)) {

                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect("Index.jsp");
                }
            } else {
                response.sendRedirect("Login.jsp?error=1");
            }
        } catch (SQLException e) {
            throw new ServletException("Database connection problem.", e);
        }
    }
}
