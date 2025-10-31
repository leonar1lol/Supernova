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

            <a href="#" class="search-icon" aria-label="Buscar">
                <svg viewBox="0 0 24 24" width="16" height="16" aria-hidden="true"><path d="M21 21l-4.35-4.35" stroke="#ddd" stroke-width="2" stroke-linecap="round"/></svg>
            </a>
            <a href="<%= ctx %>/Cart.jsp" class="cart-icon" aria-label="Carrito">
                <svg viewBox="0 0 24 24" width="16" height="16" aria-hidden="true"><path d="M6 6h15l-1.5 9h-12z" stroke="#ddd" stroke-width="1.2" fill="none" stroke-linejoin="round"/></svg>
            </a>
        </div>
    </div>
</header>
<!-- Global toast & confirm modals to avoid native alert/confirm -->
<div id="globalToastContainer" style="position:fixed;top:12px;right:12px;z-index:1400;display:flex;flex-direction:column;gap:8px"></div>
<div id="globalConfirmBackdrop" style="display:none;position:fixed;inset:0;align-items:center;justify-content:center;z-index:1450;background:rgba(2,6,23,0.6)">
    <div style="background:#fff;padding:16px;border-radius:8px;max-width:420px;box-shadow:0 8px 30px rgba(2,6,23,0.3)">
        <h3 id="globalConfirmTitle">Confirmar</h3>
        <p id="globalConfirmText" style="margin:8px 0"></p>
        <div style="display:flex;justify-content:flex-end;gap:8px">
            <button id="globalConfirmCancel" class="btn-ghost">Cancelar</button>
            <button id="globalConfirmOk" class="btn-danger">Confirmar</button>
        </div>
    </div>
</div>
<script>
    function globalShowToast(msg, kind){ try{ var ct = document.getElementById('globalToastContainer'); if(!ct) return; var d = document.createElement('div'); d.className = 'toast '+(kind||''); d.textContent = msg; d.style.padding='10px 14px'; d.style.borderRadius='8px'; d.style.color='#fff'; d.style.minWidth='180px'; d.style.boxShadow='0 6px 18px rgba(2,6,23,0.3)'; if(kind==='success') d.style.background='#0b8f3b'; else if(kind==='error') d.style.background='#c02828'; else d.style.background='#222'; ct.appendChild(d); setTimeout(function(){ d.style.transition='opacity 300ms'; d.style.opacity='0'; setTimeout(function(){ try{ ct.removeChild(d);}catch(e){} },350); },3500);}catch(e){console.log('toast',msg);} }

    function openGlobalConfirm(text, cbYes){ var bd = document.getElementById('globalConfirmBackdrop'); var txt = document.getElementById('globalConfirmText'); var btnOk = document.getElementById('globalConfirmOk'); var btnCancel = document.getElementById('globalConfirmCancel'); if(!bd||!txt||!btnOk||!btnCancel) return; txt.textContent = text; bd.style.display = 'flex'; function cleanup(){ bd.style.display='none'; btnOk.onclick = null; btnCancel.onclick = null; } btnCancel.onclick = function(e){ e.preventDefault(); cleanup(); }; btnOk.onclick = function(e){ e.preventDefault(); try{ cbYes && cbYes(); }catch(err){ console.error(err); } cleanup(); }; }
</script>
