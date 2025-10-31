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
</head>
<body>
<jsp:include page="../header.jsp" />
<div class="admin-layout">
    <jsp:include page="../includes/admin-sidebar.jsp" />

    <main class="admin-main">
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
        <a class="action-card" href="<%= ctx %>/admin/products"><div style="width:42px;height:42px;border-radius:8px;background:#f9a825;margin-right:10px"></div><div>Gestionar Productos</div></a>
        <a class="action-card" href="<%= ctx %>/admin/users"><div style="width:42px;height:42px;border-radius:8px;background:#1976d2;margin-right:10px"></div><div>Gestionar Usuarios</div></a>
    </div>
            <div class="chart-panel panel">
                <div class="chart-header">
                    <h3>Ventas por Categoría</h3>
                    <div class="chart-controls">
                        <select class="sort-select">
                            <option>Últimos 7 días</option>
                            <option>Últimos 30 días</option>
                        </select>
                    </div>
                </div>
                <div class="chart-placeholder">
                    <div class="chart-canvas-wrapper">
                        <canvas id="dashboardChart" class="chart-canvas" role="img" aria-label="Gráfico de ventas por categoría"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </main>

</div>

<script>window.APP_CTX = '<%= ctx %>';</script>
<script src="<%= ctx %>/js/dashboard-chart.js"></script>
</body>
</html>
