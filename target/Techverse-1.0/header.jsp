<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String uri = request.getRequestURI();
    String path = uri != null && uri.startsWith(ctx) ? uri.substring(ctx.length()) : uri;
    boolean activeIndex = path.equals("/") || path.endsWith("Index.jsp") || path.equals("/Index.jsp");
    boolean activeContact = path.endsWith("contacto.jsp") || path.equals("/contacto.jsp");
    boolean activeSobre = path.endsWith("sobre_nosotros.jsp") || path.equals("/sobre_nosotros.jsp");
    boolean activeProcesadores = path.endsWith("procesadores.jsp") || path.equals("/procesadores.jsp");
    boolean activeTarjetas = path.endsWith("tarjetas_graficas.jsp") || path.equals("/tarjetas_graficas.jsp");
    boolean activeMemorias = path.endsWith("memorias_ram.jsp") || path.equals("/memorias_ram.jsp");
    boolean activeFuentes = path.endsWith("fuentes.jsp") || path.equals("/fuentes.jsp");
    boolean activeGabinetes = path.endsWith("gabinetes.jsp") || path.equals("/gabinetes.jsp");
    boolean activePlacas = path.endsWith("placa_madre.jsp") || path.equals("/placa_madre.jsp");
    String username = (String) session.getAttribute("username");
%>
<header>
    <div class="navbar">
        <div class="logo"><a href="<%= ctx %>/Index.jsp">supernova</a></div>
        <div class="nav-links">
            <div class="dropdown">
                <a class="dropbtn" href="#">Arma tu PC &#9662;</a>
                <div class="dropdown-content">
                    <a href="<%= ctx %>/procesadores.jsp" class="<%= activeProcesadores ? "active" : "" %>">Procesadores</a>
                    <a href="<%= ctx %>/tarjetas_graficas.jsp" class="<%= activeTarjetas ? "active" : "" %>">Tarjetas Gráficas</a>
                    <a href="<%= ctx %>/memorias_ram.jsp" class="<%= activeMemorias ? "active" : "" %>">Memorias RAM</a>
                    <a href="<%= ctx %>/almacenamiento.jsp">Almacenamiento</a>
                    <a href="<%= ctx %>/fuentes.jsp" class="<%= activeFuentes ? "active" : "" %>">Fuentes de Poder</a>
                    <a href="<%= ctx %>/gabinetes.jsp" class="<%= activeGabinetes ? "active" : "" %>">Gabinetes</a>
                    <a href="<%= ctx %>/placa_madre.jsp" class="<%= activePlacas ? "active" : "" %>">Placas Madre</a>
                </div>
            </div>
            <a href="<%= ctx %>/contacto.jsp" class="<%= activeContact ? "active" : "" %>">Contacto</a>
            <a href="<%= ctx %>/sobre_nosotros.jsp" class="<%= activeSobre ? "active" : "" %>">Sobre Nosotros</a>

            <% if (username != null) { %>
                <% String role = (String) session.getAttribute("role"); %>
                <div class="dropdown">
                    <a class="dropbtn">Bienvenido, <%= username %> &#9662;</a>
                    <div class="dropdown-content">
                        <% if ("admin".equals(role)) { %>
                            <a href="<%= ctx %>/admin/dashboard">Panel Admin</a>
                        <% } %>
                        <a href="<%= ctx %>/logout.jsp">Cerrar Sesion</a>
                    </div>
                </div>
            <% } else { %>
                <a href="<%= ctx %>/Login.jsp">Login</a>
            <% } %>

            <a href="#" class="search-icon"><i class="fas fa-search"></i></a>
            <a href="<%= ctx %>/Cart.jsp" class="cart-icon"><i class="fas fa-shopping-cart"></i></a>
        </div>
    </div>
</header>
