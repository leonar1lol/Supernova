<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css" />
    <link rel="stylesheet" href="<%= ctx %>/css/admin.css" />
    <link rel="stylesheet" href="<%= ctx %>/css/all.min.css" />
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="admin-container">
    <div class="dashboard-hero">
        <h1>Panel de Administración</h1>
        <p>Bienvenido al panel. Desde aquí puedes gestionar los recursos principales de la tienda.</p>
    </div>

    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="num"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "--" %></div>
            <div>
                <div class="label">Usuarios</div>
                <div class="muted">Cantidad total de usuarios</div>
            </div>
        </div>
        <div class="kpi-card">
            <div class="num"><%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : "--" %></div>
            <div>
                <div class="label">Productos</div>
                <div class="muted">Cantidad total de productos</div>
            </div>
        </div>
        <div class="kpi-card">
            <div class="num"><%= request.getAttribute("pendingOrders") != null ? request.getAttribute("pendingOrders") : "--" %></div>
            <div>
                <div class="label">Órdenes</div>
                <div class="muted">Órdenes pendientes</div>
            </div>
        </div>
    </div>

    <div class="actions-grid">
        <a class="action-card" href="<%= ctx %>/admin/products"><i class="fas fa-boxes" style="color:#f9a825"></i><div>Gestionar Productos</div></a>
        <a class="action-card" href="<%= ctx %>/admin/users"><i class="fas fa-users" style="color:#1976d2"></i><div>Gestionar Usuarios</div></a>
    </div>
</div>

</body>
</html>
