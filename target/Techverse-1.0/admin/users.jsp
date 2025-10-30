<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.util.Map" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Admin - Usuarios</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css" />
    <link rel="stylesheet" href="<%= ctx %>/css/all.min.css" />
    <link rel="stylesheet" href="<%= ctx %>/css/admin.css" />
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="admin-container">
    <div class="admin-grid">
        <div class="admin-form users-panel">
            <h2>Usuarios</h2>
        <%
            String error = request.getParameter("error");
            if ("email_exists".equals(error)) {
        %>
            <div style="color:#b71c1c;background:#ffebee;padding:8px;border-radius:4px;margin-bottom:8px;">El email ya está registrado por otro usuario.</div>
        <% } %>
        <%
            Map<String,Object> editUser = (Map<String,Object>) request.getAttribute("editUser");
            String formAction = "create";
            if (editUser != null) formAction = "update";
        %>
        <form method="post" action="<%= request.getContextPath() %>/admin/users" class="admin-form-inner admin-form">
            <input type="hidden" name="action" value="<%= formAction %>" />
            <input type="hidden" name="id" value="<%= editUser!=null?editUser.get("id"):"" %>" />
            <div class="form-grid">
                <div>
                    <label class="small">Nombre</label>
                    <input type="text" name="nombre" value="<%= editUser!=null?editUser.get("nombre") : "" %>" required />
                </div>
                <div>
                    <label class="small">Apellidos</label>
                    <input type="text" name="apellidos" value="<%= editUser!=null?editUser.get("apellidos") : "" %>" />
                </div>

                <div class="full-width">
                    <label class="small">Email</label>
                    <input type="email" name="email" value="<%= editUser!=null?editUser.get("email") : "" %>" required />
                </div>

                <div>
                    <label class="small">Contraseña <small>(dejar vacío para mantener)</small></label>
                    <input type="password" name="password" />
                </div>
                <div>
                    <label class="small">Fecha de nacimiento</label>
                    <input type="date" name="fecha_nacimiento" value="<%= editUser!=null?editUser.get("fecha_nacimiento") : "" %>" />
                </div>

                <div class="full-width">
                    <label class="small">Rol</label>
                    <select name="rol" class="sort-select">
                        <option value="user" <%= (editUser!=null && "admin".equals(editUser.get("rol")))?"":"selected" %>>user</option>
                        <option value="admin" <%= (editUser!=null && "admin".equals(editUser.get("rol")))?"selected":"" %>>admin</option>
                    </select>
                </div>

            </div>

            <div class="controls-right save-row" style="margin-top:8px">
                <button type="submit" class="btn-save"><i class="fas fa-check"></i> Guardar</button>
                <% if (editUser != null) { %>
                    <a href="<%= request.getContextPath() %>/admin/users" class="btn-ghost">Cancelar</a>
                <% } %>
            </div>
        </form>
    </div>
    <div class="admin-table table-scroll">
        <div style="display:flex;justify-content:space-between;align-items:center;gap:12px">
            <h2 style="margin:0">Lista de usuarios</h2>
            <div style="display:flex;gap:8px;align-items:center">
                <input id="userSearch" class="search-input" placeholder="Buscar usuarios (nombre, email)" />
                <select id="userSort" class="sort-select">
                    <option value="id">Orden: ID</option>
                    <option value="nombre">Orden: Nombre</option>
                    <option value="email">Orden: Email</option>
                    <option value="created">Orden: Creado</option>
                </select>
            </div>
        </div>

        <table class="admin-table" style="margin-top:12px">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Email</th>
                    <th>Fecha nacimiento</th>
                    <th>Created At</th>
                    <th>Rol</th>
                    <th class="text-center">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String,Object>> users = (List<Map<String,Object>>) request.getAttribute("users");
                    if (users != null) {
                        for (Map<String,Object> u : users) {
                %>
                <tr>
                    <td><%= u.get("id") %></td>
                    <td><strong><%= u.get("nombre") %></strong></td>
                    <td><%= u.get("apellidos") %></td>
                    <td><%= u.get("email") %></td>
                    <td><%= u.get("fecha_nacimiento") %></td>
                    <td><%= u.get("created_at")!=null?u.get("created_at") : "" %></td>
                    <td><span style="padding:6px 8px;border-radius:6px;background:#f3f4f6;color:#111;font-weight:600;font-size:0.9rem"><%= (u.get("rol")!=null?u.get("rol"):(u.get("is_admin")!=null && (Boolean)u.get("is_admin")?"admin":"user")) %></span></td>
                    <td class="text-center">
                        <div class="action-forms">
                            <a class="action-btn btn-edit small-btn" href="<%= request.getContextPath() %>/admin/users?edit=<%= u.get("id") %>">Editar</a>
                            <form method="post" action="<%= request.getContextPath() %>/admin/users" onsubmit="return confirm('Eliminar usuario?');">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="id" value="<%= u.get("id") %>" />
                                <button class="action-btn btn-danger small-btn" type="submit">Eliminar</button>
                            </form>
                            <form method="post" action="<%= request.getContextPath() %>/admin/users">
                                <input type="hidden" name="action" value="toggleAdmin" />
                                <input type="hidden" name="id" value="<%= u.get("id") %>" />
                                <button class="action-btn btn-toggle small-btn" type="submit" title="<%= ("admin".equals(u.get("rol")) || (u.get("is_admin")!=null && (Boolean)u.get("is_admin"))) ? "Desactivar" : "Activar" %>">
                                    <i class="fas fa-power-off"></i>
                                    <span class="label"><%= ("admin".equals(u.get("rol")) || (u.get("is_admin")!=null && (Boolean)u.get("is_admin"))) ? "Desactivar" : "Activar" %></span>
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
  </div>
</div>

<script>
    (function(){
        const input = document.getElementById('userSearch');
        const sort = document.getElementById('userSort');
        const table = document.querySelector('.admin-table');
        if (!table) return;
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));

        function normalize(t){ return (t||'').toString().toLowerCase(); }

        if (input) input.addEventListener('input', function(){
            const q = normalize(this.value);
            rows.forEach(r=>{
                const cells = r.querySelectorAll('td');
                const hay = normalize(cells[1].textContent).includes(q) || normalize(cells[3].textContent).includes(q);
                r.style.display = hay ? '' : 'none';
            });
        });

        if (sort) sort.addEventListener('change', function(){
            const v = this.value;
            const sorted = rows.slice().sort((a,b)=>{
                if (v==='id') return Number(a.children[0].textContent) - Number(b.children[0].textContent);
                if (v==='nombre') return a.children[1].textContent.localeCompare(b.children[1].textContent);
                if (v==='email') return a.children[3].textContent.localeCompare(b.children[3].textContent);
                if (v==='created') return new Date(a.children[5].textContent) - new Date(b.children[5].textContent);
                return 0;
            });
            sorted.forEach(r=> tbody.appendChild(r));
        });
    })();
</script>

</div>
</body>
</html>
