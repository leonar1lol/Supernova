package tienda.supernova.servlets;

import tienda.supernova.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String fechaNacimiento = request.getParameter("fecha_nacimiento");

        try (Connection con = DBConnection.getConnection()) {
            String checkSql = "SELECT COUNT(*) AS cnt FROM usuarios WHERE email = ?";
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setString(1, email);
                try (java.sql.ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next() && rs.getInt("cnt") > 0) {

                        response.sendRedirect("Registro.jsp?error=email_exists");
                        return;
                    }
                }
            }

            String sql = "INSERT INTO usuarios (nombre, apellidos, email, password, fecha_nacimiento) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, nombre);
                ps.setString(2, apellidos);
                ps.setString(3, email);
                ps.setString(4, pass);
                ps.setString(5, fechaNacimiento);
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("Login.jsp?success=1");
                } else {
                    response.sendRedirect("Registro.jsp?error=insert_failed");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            String message = e.getMessage() == null ? "" : e.getMessage().toLowerCase();
            if (message.contains("duplicate") || message.contains("unique")) {
                response.sendRedirect("Registro.jsp?error=email_exists");
            } else {
                response.sendRedirect("Registro.jsp?error=1");
            }
        }
    }
}
