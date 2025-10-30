<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registro - supernova</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="register-body">
    <div class="register-container">
        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if (success != null && success.equals("1")) {
                out.println("<p style='color:green; text-align:center;'>Registro completado. Ya puedes iniciar sesión.</p>");
            } else if (error != null) {
                if (error.equals("email_exists")) {
                    out.println("<p style='color:red; text-align:center;'>Error en el registro. <br>El correo electrónico ya existe.</p>");
                } else if (error.equals("insert_failed")) {
                    out.println("<p style='color:red; text-align:center;'>No se pudo crear la cuenta. Inténtalo de nuevo más tarde.</p>");
                } else {
                    out.println("<p style='color:red; text-align:center;'>Error en el registro. Inténtalo de nuevo.</p>");
                }
            }
        %>
        <h2>Crear Cuenta</h2>
        <form action="RegistroServlet" method="post">
            <input type="text" name="nombre" placeholder="Nombre" required>
            <input type="text" name="apellidos" placeholder="Apellidos" required>
            <input type="email" name="email" placeholder="Correo Electrónico" required>
            <input type="password" name="password" placeholder="Crea una contraseña" required>
            <input type="date" name="fecha_nacimiento" placeholder="Fecha de Nacimiento" required>
            <input type="submit" value="Registrarse">
        </form>
        <div class="login-link">
            <p>¿Ya tienes una cuenta? <a href="Login.jsp">Inicia Sesión</a></p>
        </div>
        <div class="back-to-index-link">
            <p><a href="Index.jsp">Volver al Inicio</a></p>
        </div>
    </div>
</body>
</html>