<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<aside class="admin-sidebar">
    <div class="brand">
        <div class="logo">SN</div>
        <div class="title">SuperNova</div>
    </div>
    <nav>
    <a class="nav-link" href="<%= ctx %>/admin/dashboard.jsp" data-slug="dashboard">
            <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="3"/></svg>
            <span>Dashboard</span>
        </a>
    <a class="nav-link" href="<%= ctx %>/admin/orders.jsp" data-slug="orders">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 6h18v2H3zM5 10h14v10H5z"/></svg>
            <span>Gestión de Pedidos</span>
        </a>
    <a class="nav-link" href="<%= ctx %>/admin/route-optimization.jsp" data-slug="route-optimization">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2v6l4 2v6l-4 2v6"/></svg>
            <span>Optimización de Ruta</span>
        </a>
    <a class="nav-link" href="<%= ctx %>/admin/product-validation.jsp" data-slug="product-validation">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9 11l3 3L22 4"/></svg>
            <span>Validación de Productos</span>
        </a>
    <a class="nav-link" href="<%= ctx %>/admin/notifications.jsp" data-slug="notifications">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2a6 6 0 0 0-6 6v5l-2 2h16l-2-2V8a6 6 0 0 0-6-6z"/></svg>
            <span>Notificaciones</span>
        </a>
    </nav>
</aside>

<script>
    (function(){
        try{
            var path = location.pathname || '';
            var parts = path.split('/');
            var last = parts.length ? parts[parts.length-1] : '';
            var links = document.querySelectorAll('.admin-sidebar .nav-link');
            links.forEach(function(a){
                a.classList.remove('active');
                var slug = a.getAttribute('data-slug') || '';
                // match /admin/slug or /admin/slug.jsp or path segments containing the slug
                if (slug) {
                    if (path.indexOf('/admin/'+slug) !== -1 || path.indexOf('/admin/'+slug+'.jsp') !== -1 || last === slug || last === slug + '.jsp') {
                        a.classList.add('active');
                    }
                }
            });
        }catch(e){/* ignore in older browsers */}
    })();
</script>
