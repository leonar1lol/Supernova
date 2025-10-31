<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>

<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Contacto - supernova</title>

    <link rel="stylesheet" href="css/style.css">

</head>

<body>

    <jsp:include page="/header.jsp" />



    <main>

        <div class="contact-container">

            <h2>Contáctanos</h2>

            <p>¿Tienes dudas o necesitas ayuda con tu pedido? Escríbenos y te responderemos lo antes posible.</p>



            <%



                String error = (String) session.getAttribute("contactError");

                String success = (String) session.getAttribute("contactSuccess");

                String prevNombre = (String) session.getAttribute("contactNombre");

                String prevEmail = (String) session.getAttribute("contactEmail");

                String prevAsunto = (String) session.getAttribute("contactAsunto");

                String prevMensaje = (String) session.getAttribute("contactMensaje");



                session.removeAttribute("contactError");

                session.removeAttribute("contactSuccess");

                session.removeAttribute("contactNombre");

                session.removeAttribute("contactEmail");

                session.removeAttribute("contactAsunto");

                session.removeAttribute("contactMensaje");

            %>



            <div class="contact-form">

                <% if (error != null) { %>

                    <div class="alert alert-error"><%= error %></div>

                <% } else if (success != null) { %>

                    <div class="alert alert-success"><%= success %></div>

                <% } %>



                <form method="post" action="<%= request.getContextPath() %>/contact-submit">

                    <label for="nombre">Nombre *</label>

                    <input type="text" id="nombre" name="nombre" value="<%= prevNombre != null ? prevNombre : "" %>" required>



                    <label for="email">Email *</label>

                    <input type="email" id="email" name="email" value="<%= prevEmail != null ? prevEmail : "" %>" required>



                    <label for="asunto">Asunto</label>

                    <input type="text" id="asunto" name="asunto" value="<%= prevAsunto != null ? prevAsunto : "" %>">



                    <label for="mensaje">Mensaje *</label>

                    <textarea id="mensaje" name="mensaje" rows="6" required><%= prevMensaje != null ? prevMensaje : "" %></textarea>



                    <button type="submit" class="btn-primary">Enviar</button>

                </form>

            </div>

        </div>

    </main>



    <jsp:include page="/includes/footer.jsp" />

</body>

</html>

