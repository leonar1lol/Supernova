/* dashboard-chart.js
   Small, dependency-free bar chart renderer using HTML5 canvas.
   Renders a colorful bar chart similar to the provided reference image.
*/
(function(){
    'use strict';

    // initial placeholder data; will be replaced by server data if available
    const data = {
        labels: ['Frutas','Carnes','Lácteos','Limpieza','Panadería'],
        values: [260, 220, 180, 95, 120],
        colors: ['#8b3ff0', '#ff2d8a', '#1fa65a', '#ff7a18', '#29cc7a']
    };

    function fitToDevicePixel(canvas, w, h){
        const dpr = window.devicePixelRatio || 1;
        canvas.width = Math.floor(w * dpr);
        canvas.height = Math.floor(h * dpr);
        canvas.style.width = w + 'px';
        canvas.style.height = h + 'px';
        const ctx = canvas.getContext('2d');
        ctx.setTransform(dpr,0,0,dpr,0,0);
        return ctx;
    }

    function drawGrid(ctx, width, height, maxVal){
        const padding = 48;
        ctx.save();
        ctx.strokeStyle = '#eef2f7';
        ctx.lineWidth = 1;
        const steps = 5;
        for(let i=0;i<=steps;i++){
            const y = padding + ( (height - padding*1.5) * (i/steps) );
            ctx.beginPath();
            ctx.moveTo(padding, y);
            ctx.lineTo(width - padding, y);
            ctx.stroke();
            // tick label (from top to bottom -> reverse)
            const val = Math.round( maxVal * (1 - i/steps) );
            ctx.fillStyle = '#9aa4b2';
            ctx.font = '12px system-ui, Roboto, Arial';
            ctx.textAlign = 'right';
            ctx.fillText(val, padding - 8, y + 4);
        }
        ctx.restore();
    }

    function drawBars(ctx, width, height, maxVal){
        const padding = 48;
        const chartW = width - padding*2;
        const chartH = height - padding*1.8;
        const barCount = data.values.length;
        const gap = 18;
        const barW = (chartW - gap*(barCount-1)) / barCount;

        for(let i=0;i<barCount;i++){
            const v = data.values[i];
            const h = (v / maxVal) * chartH;
            const x = padding + i*(barW + gap);
            const y = padding + (chartH - h);

            // shadow
            ctx.save();
            ctx.fillStyle = data.colors[i];
            // rounded top rectangle
            const radius = 6;
            const bw = barW;
            const bh = h;
            const bx = x;
            const by = y;
            // draw rounded rect
            ctx.beginPath();
            ctx.moveTo(bx + radius, by);
            ctx.lineTo(bx + bw - radius, by);
            ctx.quadraticCurveTo(bx + bw, by, bx + bw, by + radius);
            ctx.lineTo(bx + bw, by + bh);
            ctx.lineTo(bx, by + bh);
            ctx.lineTo(bx, by + radius);
            ctx.quadraticCurveTo(bx, by, bx + radius, by);
            ctx.closePath();
            ctx.fill();
            ctx.restore();

            // label
            ctx.fillStyle = '#374151';
            ctx.font = '13px system-ui, Roboto, Arial';
            ctx.textAlign = 'center';
            ctx.fillText(data.labels[i], bx + bw/2, padding + chartH + 18);
        }
    }

    function render(canvas){
        if(!canvas) return;
        const rect = canvas.getBoundingClientRect();
        const ctx = fitToDevicePixel(canvas, Math.max(300, Math.floor(rect.width)), Math.max(240, Math.floor(rect.height)));
        const width = rect.width;
        const height = rect.height;
        // clear
        ctx.clearRect(0,0,width,height);

        const maxVal = Math.max(...data.values) * 1.15;

        // background subtle
        ctx.fillStyle = 'rgba(255,255,255,0)';
        ctx.fillRect(0,0,width,height);

        drawGrid(ctx, width, height, maxVal);
        drawBars(ctx, width, height, maxVal);
    }

    function init(){
        const canvas = document.getElementById('dashboardChart');
        if(!canvas) return;
        // try to fetch real data from server endpoint (requires DashboardDataServlet)
        try {
            const base = (window.APP_CTX && window.APP_CTX.length>0) ? window.APP_CTX : '';
            const url = base + '/admin/api/dashboard/categories';
            fetch(url, {cache: 'no-store'}).then(function(res){
                if(!res.ok) throw new Error('Network response not ok');
                return res.json();
            }).then(function(json){
                if(json && Array.isArray(json.labels) && Array.isArray(json.values)){
                    data.labels = json.labels;
                    data.values = json.values;
                    // generate colors if not provided
                    if(!json.colors || !Array.isArray(json.colors)){
                        const palette = ['#8b3ff0','#ff2d8a','#1fa65a','#ff7a18','#29cc7a','#2b9af3','#f59e0b'];
                        data.colors = data.labels.map((_,i)=>palette[i % palette.length]);
                    } else {
                        data.colors = json.colors;
                    }
                    // re-render after data loaded
                    render(canvas);
                }
            }).catch(function(err){
                // keep placeholder data on error
                // console.log('Chart data fetch error', err);
            });
        } catch(e){ /* ignore */ }
        // set automatic height based on wrapper
        const wrapper = canvas.parentElement;
        function resize(){
            // ensure wrapper has defined height via CSS; use its rect
            const rect = wrapper.getBoundingClientRect();
            canvas.style.width = rect.width + 'px';
            canvas.style.height = rect.height + 'px';
            render(canvas);
        }
        window.addEventListener('resize', debounce(resize,200));
        // initial
        resize();
    }

    // simple debounce
    function debounce(fn, wait){ let t; return function(){ clearTimeout(t); t = setTimeout(()=>fn.apply(this, arguments), wait); } }

    // init when DOM ready
    if(document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init); else init();

})();
