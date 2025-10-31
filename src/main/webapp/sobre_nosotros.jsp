<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre Nosotros - supernova</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .about-container {max-width:1100px;margin:40px auto;padding:20px}
        .about-hero {display:flex;gap:24px;align-items:center}
        .about-hero img{max-width:360px;border-radius:8px}
        .section {margin-top:28px}
        .section h2{margin-bottom:12px}
        .contact-card{background:#f7f7f8;padding:16px;border-radius:8px}
        .values-list{display:flex;gap:12px;flex-wrap:wrap}
        .value{flex:1;min-width:180px;padding:12px;border-radius:8px;background:#fff;border:1px solid #eee}
    </style>
</head>
<body>
    <jsp:include page="/header.jsp" />

    <main class="about-container">
        <div class="about-hero">
            <div>
                <h1>Sobre supernova</h1>
                <p>supernova es una tienda especializada en componentes de alto rendimiento para PC. Nos dedicamos a ofrecer productos de calidad, soporte técnico y asesoramiento personalizado para entusiastas, profesionales y gamers.</p>
                <p class="meta">Dirección: Av. Tecnología 123, Ciudad | Teléfono: +51 987 654 321 | Email: soporte@supernova.com</p>
            </div>
            <div>
                <img src="images/Publicidad index/about-us.png" alt="supernova - Sobre Nosotros">
            </div>
        </div>

        <div class="section">
            <h2>Misión</h2>
            <p>Proveer componentes y soluciones tecnológicas de alta calidad que permitan a nuestros clientes alcanzar sus objetivos, ya sea en gaming, creación de contenido o trabajo profesional, con asesoría confiable y entrega rápida.</p>
        </div>

        <div class="section">
            <h2>Visión</h2>
            <p>Ser la referencia líder en la región para la compra de hardware de PC, reconocidos por nuestra calidad de servicio, selección de productos y compromiso con la comunidad tecnológica.</p>
        </div>

        <div class="section">
            <h2>Valores</h2>
            <div class="values-list">
                <div class="value"><strong>Calidad</strong><p>Seleccionamos solo marcas y modelos probados para ofrecer el mejor rendimiento y durabilidad.</p></div>
                <div class="value"><strong>Transparencia</strong><p>Precios claros, políticas justas y atención honesta para que compres con confianza.</p></div>
                <div class="value"><strong>Soporte</strong><p>Asesoría experta antes y después de la compra, con soluciones prácticas y efectivas.</p></div>
            </div>
        </div>

        <div class="section">
            <h2>Nuestra historia</h2>
            <p>Fundada por apasionados de la informática, supernova nació con el objetivo de acercar lo último en hardware a usuarios locales. Con años de experiencia en retail y soporte técnico, combinamos conocimiento y servicio para crear una experiencia de compra confiable.</p>
        </div>

        <div class="section contact-card">
            <h2>Contacta con nosotros</h2>
            <p>¿Tienes alguna duda? Nuestro equipo está listo para ayudarte.</p>
            <p><strong>Teléfono:</strong> +51 987 654 321<br>
               <strong>Email:</strong> soporte@supernova.com<br>
               <strong>Dirección:</strong> Av. Tecnología 123, Ciudad</p>
            <p><a href="contacto.jsp" class="cta-button">Enviar un mensaje</a></p>
        </div>
    </main>

    <footer class="footer">
           <jsp:include page="/includes/footer.jsp" />
    </footer>
</body>
</html>
