(function(){
    'use strict';

    function $(sel, ctx){ return (ctx||document).querySelector(sel); }
    function $all(sel, ctx){ return Array.from((ctx||document).querySelectorAll(sel)); }

    function renderRow(u){
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td data-label="ID">${u.id}</td>
            <td data-label="Nombre"><strong>${escapeHtml(u.nombre||'')}</strong></td>
            <td data-label="Email">${escapeHtml(u.email||'')}</td>
            <td data-label="Rol">${escapeHtml(u.rol||'')}</td>
            <td data-label="Activo">${u.activo ? 'Sí' : 'No'}</td>
            <td class="text-center" data-label="Acciones">
                <div class="action-forms">
                    <button class="action-btn btn-edit small-btn" data-id="${u.id}" data-action="edit" title="Editar">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a1.003 1.003 0 0 0 0-1.42l-2.34-2.34a1.003 1.003 0 0 0-1.42 0l-1.83 1.83 3.75 3.75 1.84-1.82z"/></svg>
                        <span>Editar</span>
                    </button>
                    <button class="action-btn btn-danger small-btn" data-id="${u.id}" data-action="delete" title="Eliminar">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 19a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>
                        <span>Eliminar</span>
                    </button>
                    <button class="action-btn btn-toggle small-btn" data-id="${u.id}" data-action="toggle" title="Activar/Desactivar usuario">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 12c2.7 0 5-2.3 5-5s-2.3-5-5-5-5 2.3-5 5 2.3 5 5 5zm0 2c-3.3 0-10 1.7-10 5v3h20v-3c0-3.3-6.7-5-10-5z"/></svg>
                        <span>${u.activo ? 'Desactivar' : 'Activar'}</span>
                    </button>
                </div>
            </td>
        `;
        return tr;
    }

    function escapeHtml(s){ return (s||'').toString().replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

    function load(){
        const base = window.APP_CTX || '';
        fetch(base + '/admin/api/users', {cache:'no-store'}).then(function(r){
            if (!r.ok) return r.text().then(function(t){ throw new Error('HTTP '+r.status+': '+(t||r.statusText)); });
            return r.json();
        }).then(function(json){
            if (!Array.isArray(json)){
                console.error('users load unexpected response', json);
                try{ globalShowToast('Respuesta inesperada del servidor al cargar usuarios','error'); }catch(e){ console.log('toast',e); }
                return;
            }
            const tbody = $('#usersTable tbody');
            tbody.innerHTML = '';
            if (!json.length){
                var tr = document.createElement('tr');
                tr.innerHTML = '<td colspan="6" style="text-align:center;color:#666;padding:20px">(No hay usuarios)</td>';
                tbody.appendChild(tr);
            } else {
                json.forEach(u=> tbody.appendChild(renderRow(u)) );
            }
        }).catch(err=>{ console.error('users load',err); try{ globalShowToast('Error cargando usuarios: '+(err && err.message?err.message:'ver consola'),'error'); }catch(e){ console.log(err); } });
    }

    function postAction(action, id, callback){
        const base = window.APP_CTX || '';
        const params = new URLSearchParams(); params.append('action', action); params.append('id', id);
        fetch(base + '/admin/api/users', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'}, body: params.toString()}).then(r=>r.json()).then(callback).catch(err=>{ console.error('action',err); });
    }

    document.addEventListener('DOMContentLoaded', function(){
        load();
        var btnNew = document.getElementById('btnNewUser');
        if (btnNew){
            var cModal = document.getElementById('createUserModal');
            var cuNombre = document.getElementById('cuNombre');
            var cuEmail = document.getElementById('cuEmail');
            var cuRol = document.getElementById('cuRol');
            var cuPassword = document.getElementById('cuPassword');
            var cuCancel = document.getElementById('cuCancel');
            var cuCreate = document.getElementById('cuCreate');
            function closeCreate(){ cModal.style.display='none'; cuCreate.disabled=false; cuCreate.textContent='Crear'; }
                btnNew.addEventListener('click', function(e){ e.preventDefault(); cuNombre.value=''; cuEmail.value=''; cuRol.value='operario'; cuPassword.value=''; cModal.style.display='flex'; });
            cuCancel.addEventListener('click', function(e){ e.preventDefault(); closeCreate(); });
            cuCreate.addEventListener('click', function(e){ e.preventDefault(); cuCreate.disabled=true; cuCreate.textContent='Creando...';
                var p = new URLSearchParams(); p.append('action','create'); p.append('nombre', cuNombre.value || ''); p.append('email', cuEmail.value || ''); p.append('rol', cuRol.value || 'operario'); p.append('password', cuPassword.value || '');
                fetch((window.APP_CTX||'') + '/admin/api/users', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'}, body: p.toString()}).then(function(r){ return r.json(); }).then(function(res){ if (res && res.ok){ closeCreate(); globalShowToast('Usuario creado','success'); load(); } else { globalShowToast('Error al crear usuario: '+(res && res.error?res.error:JSON.stringify(res)),'error'); } }).catch(function(err){ console.error('create user',err); globalShowToast('Error al crear usuario','error'); }).finally(function(){ cuCreate.disabled=false; cuCreate.textContent='Crear'; });
            });
        }
        document.body.addEventListener('click', function(e){
            const btn = e.target.closest('button[data-action]'); if(!btn) return;
            const action = btn.getAttribute('data-action'); const id = btn.getAttribute('data-id');
            if (action === 'delete'){
                openGlobalConfirm('Eliminar usuario?', function(){
                    postAction('delete', id, function(res){
                        if (res && res.ok) {
                            load();
                        } else {
                            try{ globalShowToast('Error al eliminar','error'); }catch(e){ console.log('Error al eliminar'); }
                        }
                    });
                });
            } else if (action === 'toggle'){
                postAction('toggleActive', id, function(res){ if(res && res.ok){ load(); } else { globalShowToast('Error al cambiar estado','error'); } });
            } else if (action === 'edit'){
                var modal = document.getElementById('editUserModal');
                var euNombre = document.getElementById('euNombre');
                var euEmail = document.getElementById('euEmail');
                var euRol = document.getElementById('euRol');
                var euPassword = document.getElementById('euPassword');
                var euCancel = document.getElementById('euCancel');
                var euSave = document.getElementById('euSave');
                var tr = btn.closest('tr');
                euNombre.value = tr.children[1].textContent.trim();
                euEmail.value = tr.children[2].textContent.trim();
                try{
                    var roleVal = (tr.children[3].textContent||'').trim().toLowerCase();
                    var found = Array.from(euRol.options).some(function(o){ return o.value === roleVal; });
                    euRol.value = found ? roleVal : 'operario';
                }catch(err){ euRol.value = 'operario'; }
                euPassword.value = '';
                modal.style.display = 'flex';
                function closeModal(){ modal.style.display='none'; euSave.disabled=false; euSave.textContent='Guardar'; }
                euCancel.onclick = function(e){ e.preventDefault(); closeModal(); };
                euSave.onclick = function(e){ e.preventDefault(); euSave.disabled=true; euSave.textContent='Guardando...';
                    var p = new URLSearchParams(); p.append('action','update'); p.append('id', id); p.append('nombre', euNombre.value||''); p.append('email', euEmail.value||''); p.append('rol', euRol.value||''); if (euPassword.value) p.append('password', euPassword.value);
                    fetch((window.APP_CTX||'') + '/admin/api/users', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'}, body: p.toString()}).then(function(r){ return r.json(); }).then(function(res){ if (res && res.ok){ closeModal(); globalShowToast('Usuario actualizado','success'); load(); } else { globalShowToast('Error al actualizar: '+(res && res.error?res.error:JSON.stringify(res)),'error'); } }).catch(function(err){ console.error('update user',err); globalShowToast('Error al actualizar usuario','error'); }).finally(function(){ euSave.disabled=false; euSave.textContent='Guardar'; });
                };
            }
        });

        const input = document.getElementById('userSearch');
        if (input) input.addEventListener('input', function(){ const q = this.value.toLowerCase(); $all('#usersTable tbody tr').forEach(r=>{ const name = r.children[1].textContent.toLowerCase(); const email = r.children[2].textContent.toLowerCase(); r.style.display = (name.includes(q) || email.includes(q)) ? '' : 'none'; }); });
    });

})();
