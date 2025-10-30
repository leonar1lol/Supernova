<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>supernova - Venta de Componentes de PC</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/all.min.css">
</head>
<body class="index-body">
    <%
        List<Map<String, String>> products = new ArrayList<>();

        Map<String, String> product1 = new HashMap<>();
        product1.put("name", "Tarjeta Gráfica RTX 4080");
        product1.put("price", "S/ 3.777,06");
        product1.put("image", "RTX 4080 GAMING X TRIO MSI.png");
        products.add(product1);

        Map<String, String> product2 = new HashMap<>();
        product2.put("name", "Procesador Intel Core i9 14900K");
        product2.put("price", "S/ 2.159,85");
        product2.put("image", "i9 14900K.png");
        products.add(product2);

        Map<String, String> product3 = new HashMap<>();
        product3.put("name", "Memoria RAM 32GB DDR5");
        product3.put("price", "S/ 281,39");
        product3.put("image", "kingston 32gb ddr5 5200mhz.png");
        products.add(product3);

        Map<String, String> product4 = new HashMap<>();
        product4.put("name", "SSD NVMe 2TB");
        product4.put("price", "S/ 458,96");
        product4.put("image", "kingston nv2 2TB.png");
        products.add(product4);
    %>

    <jsp:include page="/header.jsp" />

    <main>
        <section class="hero apple-hero">
            <h1>Potencia tu Creatividad.<br><span class="gradient-text">Arma tu PC Premium</span></h1>
            <p>Componentes de alto rendimiento, diseño minimalista y la mejor experiencia de compra.</p>
            <div style="display:flex;gap:12px;">
                <a href="#" class="cta-button apple-cta">Comprar Ahora</a>
            </div>
        </section>

        <section class="quick-categories">
            <div class="quick-category-list">
                <a href="procesadores.jsp"><i class="fas fa-microchip"></i> Procesadores</a>
                <a href="tarjetas_graficas.jsp"><i class="fas fa-video"></i> Tarjetas Gráficas</a>
                <a href="memorias_ram.jsp"><i class="fas fa-memory"></i> RAM</a>
                <a href="almacenamiento.jsp"><i class="fas fa-hdd"></i> Almacenamiento</a>
                <a href="fuentes.jsp"><i class="fas fa-plug"></i> Fuentes</a>
                <a href="gabinetes.jsp"><i class="fas fa-box"></i> Gabinetes</a>
                <a href="placa_madre.jsp"><i class="fas fa-server"></i> Placas Madre</a>
            </div>
        </section>

        <section class="promo-banner apple-promo">
            <div class="promo-content">
                <h2>¡Nuevo! RTX 4080 GAMING X TRIO</h2>
                <p>La tarjeta gráfica más avanzada para gamers y creadores. Stock limitado.</p>
                <a href="#" class="cta-button apple-cta-light">Ver Producto</a>
            </div>
        </section>

        <section class="featured-products">
            <h2>Productos Destacados</h2>
            <div class="product-grid">
                <%
                    for (Map<String, String> product : products) {
                %>
                <div class="product-card">
                    <img src="images/<%= product.get("image") %>" alt="<%= product.get("name") %>">
                    <h3><%= product.get("name") %></h3>
                    <p><%= product.get("price") %></p>
                    <a href="#" class="product-button">Ver Producto</a>
                </div>
                <%
                    }
                %>
            </div>
        </section>

        <section class="apple-benefits">
            <div class="benefit">
                <i class="fas fa-shipping-fast"></i>
                <h3>Envío Express</h3>
                <p>Recibe tus productos en 24-48h en todo el país.</p>
            </div>
            <div class="benefit">
                <i class="fas fa-award"></i>
                <h3>Garantía Oficial</h3>
                <p>Todos los productos cuentan con garantía y soporte local.</p>
            </div>
            <div class="benefit">
                <i class="fas fa-credit-card"></i>
                <h3>Pagos Seguros</h3>
                <p>Compra con total confianza y múltiples métodos de pago.</p>
            </div>
            <div class="benefit">
                <i class="fas fa-headset"></i>
                <h3>Soporte Premium</h3>
                <p>Asesoría personalizada antes y después de tu compra.</p>
            </div>
        </section>

        <section class="newsletter-section">
            <div class="newsletter-box">
                <h2>Suscríbete y recibe ofertas exclusivas</h2>
                <form class="newsletter-form">
                    <input type="email" placeholder="Tu correo electrónico" required>
                    <button type="submit">Suscribirme</button>
                </form>
            </div>
        </section>
    </main>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>