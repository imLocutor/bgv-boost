// ========================================================
// ALDEIA BOOST V2.4 - NUI CLIENT LOGIC
// ========================================================

const overlay = document.getElementById('screenOverlay');
const statFps = document.getElementById('statFps');
const statCpu = document.getElementById('statCpu');
const statGpu = document.getElementById('statGpu');
const statRam = document.getElementById('statRam');
const metricFrameTime = document.getElementById('metricFrameTime');
const metricFpsMedio = document.getElementById('metricFpsMedio');
const metricVram = document.getElementById('metricVram');
const metricEficiencia = document.getElementById('metricEficiencia');

const sliderDistance = document.getElementById('sliderDistance');
const valDistance = document.getElementById('valDistance');

const sliderShadows = document.getElementById('sliderShadows');
const valShadows = document.getElementById('valShadows');

const sliderLights = document.getElementById('sliderLights');
const valLights = document.getElementById('valLights');

const sliderReflexes = document.getElementById('sliderReflexes');
const valReflexes = document.getElementById('valReflexes');

const toggleTexture = document.getElementById('toggleTexture');
const textureDesc = document.getElementById('textureDesc');

const btnClose = document.getElementById('btnClose');
const btnCancel = document.getElementById('btnCancel');
const btnReset = document.getElementById('btnReset');
const btnApply = document.getElementById('btnApply');

const shadowLabels = ['Desligado', 'Baixa', 'Média', 'Alta', 'Ultra'];

// FPS History & Calculation
let fpsHistory = [];
function updateFps(fps) {
    if (!fps || fps <= 0) fps = 60;
    statFps.textContent = fps;
    
    // Calculate Frame Time (1000 / fps)
    const frameTime = (1000 / fps).toFixed(1);
    metricFrameTime.textContent = frameTime + ' ms';

    // Calculate Average FPS
    fpsHistory.push(fps);
    if (fpsHistory.length > 30) fpsHistory.shift();
    const avg = (fpsHistory.reduce((a, b) => a + b, 0) / fpsHistory.length).toFixed(1);
    metricFpsMedio.textContent = avg;

    // Simulated realistic CPU/GPU based on FPS load
    const cpuLoad = Math.min(95, Math.max(12, Math.round(20 + (160 - fps) * 0.15)));
    statCpu.textContent = cpuLoad + '%';
    
    const gpuLoad = Math.min(98, Math.max(35, Math.round(60 + (160 - fps) * 0.2)));
    statGpu.textContent = gpuLoad + '%';

    // Efficiency tag
    if (fps >= 100) {
        metricEficiencia.textContent = 'Excelente';
        metricEficiencia.style.color = '#00e5ff';
    } else if (fps >= 60) {
        metricEficiencia.textContent = 'Boa';
        metricEficiencia.style.color = '#10b981';
    } else {
        metricEficiencia.textContent = 'Regular';
        metricEficiencia.style.color = '#f59e0b';
    }
}

// Slider Fill gradient update
function updateSliderProgress(slider) {
    const min = parseFloat(slider.min) || 0;
    const max = parseFloat(slider.max) || 100;
    const val = parseFloat(slider.value) || 0;
    const percent = ((val - min) / (max - min)) * 100;
    slider.style.background = `linear-gradient(90deg, #00b8e6 0%, #00f0ff ${percent}%, #0d1a29 ${percent}%, #0d1a29 100%)`;
}

// Distance Slider
sliderDistance.addEventListener('input', () => {
    valDistance.textContent = sliderDistance.value + ' m';
    updateSliderProgress(sliderDistance);
    clearPresetSelection();
});

// Shadows Slider
sliderShadows.addEventListener('input', () => {
    const idx = parseInt(sliderShadows.value) || 0;
    valShadows.textContent = shadowLabels[idx] || 'Alta';
    updateSliderProgress(sliderShadows);
    clearPresetSelection();
});

// Lights Slider
sliderLights.addEventListener('input', () => {
    valLights.textContent = sliderLights.value + '%';
    updateSliderProgress(sliderLights);
    clearPresetSelection();
});

// Reflexes Slider
sliderReflexes.addEventListener('input', () => {
    valReflexes.textContent = sliderReflexes.value + '%';
    updateSliderProgress(sliderReflexes);
    clearPresetSelection();
});

// Texture Switch
toggleTexture.addEventListener('change', () => {
    textureDesc.textContent = toggleTexture.checked ? 'Alocação atual: 4.0 GB' : 'Alocação atual: Padrão (2.0 GB)';
    clearPresetSelection();
});

function initSliders() {
    updateSliderProgress(sliderDistance);
    updateSliderProgress(sliderShadows);
    updateSliderProgress(sliderLights);
    updateSliderProgress(sliderReflexes);
}
initSliders();

// Browser preview fallback (if opened outside FiveM CEF)
if (!window.invokeNative && !window.GetParentResourceName) {
    overlay.style.display = 'flex';
}

// Navigation Tabs
const navButtons = document.querySelectorAll('.nav-btn');
const tabPanes = document.querySelectorAll('.tab-pane');

navButtons.forEach(btn => {
    btn.addEventListener('click', () => {
        const tabId = btn.getAttribute('data-tab');
        navButtons.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        tabPanes.forEach(pane => {
            pane.classList.remove('active');
            if (pane.id === 'tab-' + tabId) {
                pane.classList.add('active');
            }
        });
    });
});

// Presets (Perfis do Motor)
const presetButtons = document.querySelectorAll('.preset-btn');
const presets = {
    baixo: { distance: 800, shadows: 0, lights: 25, reflexes: 20, texture: false, desc: 'Alocação atual: Padrão (1.5 GB)' },
    medio: { distance: 1500, shadows: 2, lights: 50, reflexes: 45, texture: false, desc: 'Alocação atual: Padrão (2.0 GB)' },
    alto:  { distance: 2300, shadows: 3, lights: 75, reflexes: 62, texture: true,  desc: 'Alocação atual: 4.0 GB' },
    ultra: { distance: 3000, shadows: 4, lights: 100, reflexes: 100, texture: true, desc: 'Alocação atual: 6.0 GB' }
};

function clearPresetSelection() {
    presetButtons.forEach(b => b.classList.remove('active'));
}

presetButtons.forEach(btn => {
    btn.addEventListener('click', () => {
        const presetKey = btn.getAttribute('data-preset');
        const p = presets[presetKey];
        if (!p) return;

        clearPresetSelection();
        btn.classList.add('active');

        sliderDistance.value = p.distance;
        valDistance.textContent = p.distance + ' m';

        sliderShadows.value = p.shadows;
        valShadows.textContent = shadowLabels[p.shadows];

        sliderLights.value = p.lights;
        valLights.textContent = p.lights + '%';

        sliderReflexes.value = p.reflexes;
        valReflexes.textContent = p.reflexes + '%';

        toggleTexture.checked = p.texture;
        textureDesc.textContent = p.desc;

        initSliders();
    });
});

// FiveM Resource Name & NUI Comms
function getResourceName() {
    try {
        return window.GetParentResourceName ? window.GetParentResourceName() : 'five-boost';
    } catch (e) {
        return 'five-boost';
    }
}

function closeUi() {
    overlay.style.display = 'none';
    fetch(`https://${getResourceName()}/hideFrame`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify({})
    }).catch(() => {});
}

btnClose.addEventListener('click', closeUi);
btnCancel.addEventListener('click', closeUi);
window.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') closeUi();
});

// Reset to Default (ALTO Preset)
btnReset.addEventListener('click', () => {
    const altoBtn = document.querySelector('.preset-btn[data-preset="alto"]');
    if (altoBtn) altoBtn.click();
});

// Apply Settings
btnApply.addEventListener('click', () => {
    // Map to Lua
    const distanceVal = parseFloat(sliderDistance.value) / 1000; // 0.5 to 3.0
    const shadowMap = [0.0, 2.0, 3.5, 5.0, 10.0];
    const shadowsVal = shadowMap[parseInt(sliderShadows.value)] || 5.0;
    const lightsVal = (parseFloat(sliderLights.value) / 100) * 12.0;

    const homeData = {
        distance: distanceVal,
        shadows: shadowsVal,
        lights: lightsVal
    };

    const extrasData = {
        rainLevel: document.getElementById('extraRain').checked,
        windSpeed: document.getElementById('extraWind').checked,
        clearBlood: document.getElementById('extraBlood').checked,
        clearDirty: false,
        extraFps: document.getElementById('extraFps').checked,
        timeCycle: document.getElementById('extraTimecycle').checked
    };

    fetch(`https://${getResourceName()}/setConfigBoost`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(homeData)
    }).catch(() => {});

    fetch(`https://${getResourceName()}/setExtras`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(extrasData)
    }).catch(() => {});

    // Visual button feedback
    btnApply.innerHTML = '<i class="fa-solid fa-check"></i> ALTERAÇÕES APLICADAS!';
    btnApply.style.background = '#00ffaa';
    btnApply.style.boxShadow = '0 0 25px rgba(0, 255, 170, 0.6)';
    setTimeout(() => {
        btnApply.innerHTML = '<i class="fa-solid fa-wand-magic-sparkles"></i> APLICAR ALTERAÇÕES';
        btnApply.style.background = '#00e5ff';
        btnApply.style.boxShadow = '0 0 20px rgba(0, 229, 255, 0.45)';
    }, 1800);
});

// NUI Messages Listener from Lua
window.addEventListener('message', (event) => {
    const data = event.data;
    if (!data) return;

    if (data.method === 'setVisible') {
        const visible = Boolean(data.data);
        overlay.style.display = visible ? 'flex' : 'none';
        if (visible) initSliders();
    }

    if (data.method === 'setFrameRate') {
        const fps = parseInt(data.data) || 60;
        updateFps(fps);
    }

    if (data.method === 'setConfig' && data.data) {
        const cfg = data.data;
        if (cfg.distance) {
            sliderDistance.value = Math.round(cfg.distance * 1000);
            valDistance.textContent = sliderDistance.value + ' m';
        }
        if (cfg.shadows !== undefined) {
            if (cfg.shadows <= 0.0) sliderShadows.value = 0;
            else if (cfg.shadows <= 2.5) sliderShadows.value = 1;
            else if (cfg.shadows <= 4.0) sliderShadows.value = 2;
            else if (cfg.shadows <= 6.0) sliderShadows.value = 3;
            else sliderShadows.value = 4;
            valShadows.textContent = shadowLabels[sliderShadows.value];
        }
        if (cfg.lights !== undefined) {
            sliderLights.value = Math.min(100, Math.round((cfg.lights / 12.0) * 100));
            valLights.textContent = sliderLights.value + '%';
        }
        initSliders();
    }
});
