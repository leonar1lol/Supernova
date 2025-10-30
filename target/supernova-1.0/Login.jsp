<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - supernova</title>
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body class="login-body">
    <div class="login-container">
        <h2>Login</h2>
        <form action="login" method="post">
            
            <input type="text" name="email" placeholder="Correo Electrónico" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <input type="submit" value="Ingresar">
        </form>
        <div class="register-link">
            <p>¿No tienes una cuenta? <a href="Registro.jsp">Regístrate aquí</a></p>
        </div>
        <div class="back-to-index-link">
            <p><a href="Index.jsp">Volver al Inicio</a></p>
        </div>
    </div>
</body>
</html>