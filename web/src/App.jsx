import React, { useState, useEffect, useMemo, useCallback } from 'react';
import {
  Sliders,
  Activity,
  Cpu,
  RotateCcw,
  X,
  CloudRain,
  Wind,
  Droplets,
  Film,
  Zap,
  Layers,
  Check,
  Eye,
  Sun,
  Moon,
  Car
} from 'lucide-react';

const SHADOW_LABELS = ['Desativado', 'Baixa', 'Média', 'Alta', 'Ultra'];
const SHADOW_MAP = [0.0, 2.0, 3.5, 5.0, 10.0];

const PRESETS = {
  competitivo: {
    label: 'Competitivo',
    tag: 'Máx FPS',
    summary: 'Prioriza latência mínima e máxima estabilidade de quadros',
    distance: 750,
    shadows: 0,
    lights: 20,
    carTexture: 25,
    extendedTexture: false,
    extras: {
      rainLevel: true,
      windSpeed: true,
      clearBlood: true,
      timeCycle: false,
      extraFps: true,
    }
  },
  performance: {
    label: 'Performance',
    tag: 'Leve',
    summary: 'Reduz sombras dinâmicas e alcance mantendo boa visibilidade',
    distance: 1150,
    shadows: 1,
    lights: 40,
    carTexture: 50,
    extendedTexture: false,
    extras: {
      rainLevel: true,
      windSpeed: true,
      clearBlood: false,
      timeCycle: false,
      extraFps: false,
    }
  },
  equilibrado: {
    label: 'Equilibrado',
    tag: 'Padrão',
    summary: 'Balanço calibrado entre fidelidade visual e fluidez',
    distance: 1850,
    shadows: 2,
    lights: 65,
    carTexture: 75,
    extendedTexture: true,
    extras: {
      rainLevel: false,
      windSpeed: false,
      clearBlood: false,
      timeCycle: false,
      extraFps: false,
    }
  },
  ultra: {
    label: 'Qualidade',
    tag: 'Ultra',
    summary: 'Distância de horizonte estendida, sombras e luzes completas',
    distance: 3000,
    shadows: 4,
    lights: 100,
    carTexture: 100,
    extendedTexture: true,
    extras: {
      rainLevel: false,
      windSpeed: false,
      clearBlood: false,
      timeCycle: true,
      extraFps: false,
    }
  }
};

function getResourceName() {
  try {
    return window.GetParentResourceName ? window.GetParentResourceName() : 'bgv-boost';
  } catch {
    return 'bgv-boost';
  }
}

async function postNui(endpoint, payload = {}) {
  if (!window.invokeNative && !window.GetParentResourceName) return;
  try {
    await fetch(`https://${getResourceName()}/${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=UTF-8' },
      body: JSON.stringify(payload),
    });
  } catch {
    // Silent fallback outside FiveM CEF
  }
}

export default function App() {
  const isBrowserDev = !window.invokeNative && !window.GetParentResourceName;
  const [visible, setVisible] = useState(isBrowserDev);
  const [activeTab, setActiveTab] = useState('graphics');
  const [activePreset, setActivePreset] = useState('equilibrado');
  const [applyState, setApplyState] = useState('idle');
  const [liveSync, setLiveSync] = useState(true);

  // Core Graphic Controls
  const [distance, setDistance] = useState(1850);
  const [shadows, setShadows] = useState(2);
  const [lights, setLights] = useState(65);
  const [carTexture, setCarTexture] = useState(75);
  const [extendedTexture, setExtendedTexture] = useState(true);

  // Engine Extra Parameters
  const [extras, setExtras] = useState({
    rainLevel: false,
    windSpeed: false,
    clearBlood: false,
    clearDirty: false,
    timeCycle: false,
    extraFps: false,
  });

  // Live Telemetry
  const [fps, setFps] = useState(138);
  const [fpsHistory, setFpsHistory] = useState([
    126, 129, 132, 130, 134, 138, 136, 135, 139, 141,
    137, 139, 142, 140, 136, 138, 141, 144, 140, 138,
    136, 139, 142, 140, 138
  ]);

  const [lang, setLang] = useState(null);

  const metrics = useMemo(() => {
    const safeFps = Math.max(15, fps || 60);
    const frameTime = (1000 / safeFps).toFixed(1);
    const avgFps = fpsHistory.length
      ? (fpsHistory.reduce((acc, v) => acc + v, 0) / fpsHistory.length).toFixed(0)
      : safeFps.toFixed(0);
    const minFps = fpsHistory.length ? Math.min(...fpsHistory) : safeFps;
    const maxFps = fpsHistory.length ? Math.max(...fpsHistory) : safeFps;

    const distWeight = ((3000 - distance) / 2500) * 35;
    const shadowWeight = ((4 - shadows) / 4) * 30;
    const lightWeight = ((100 - lights) / 100) * 15;
    const extrasCount = Object.values(extras).filter(Boolean).length;
    const extrasWeight = (extrasCount / 5) * 20;
    const boostGainScore = Math.min(98, Math.max(6, Math.round(distWeight + shadowWeight + lightWeight + extrasWeight)));

    const cpuLoad = Math.min(92, Math.max(14, Math.round(22 + (distance / 3000) * 22 - (extras.extraFps ? 7 : 0))));
    const gpuLoad = Math.min(96, Math.max(26, Math.round(38 + (shadows / 4) * 32 + (lights / 100) * 18)));
    const vramUsed = (2.1 + (extendedTexture ? 1.8 : 0.4) + (carTexture / 100) * 1.1).toFixed(1);

    return {
      frameTime,
      avgFps,
      minFps,
      maxFps,
      boostGainScore,
      cpuLoad,
      gpuLoad,
      vramUsed,
      activeExtrasCount: extrasCount,
    };
  }, [fps, fpsHistory, distance, shadows, lights, extras, extendedTexture, carTexture]);

  const buildHomePayload = useCallback((overrides = {}) => {
    const d = overrides.distance ?? distance;
    const s = overrides.shadows ?? shadows;
    const l = overrides.lights ?? lights;
    const c = overrides.carTexture ?? carTexture;

    return {
      distance: Number((d / 1000).toFixed(2)),
      shadows: SHADOW_MAP[s] ?? 5.0,
      lights: Number(((l / 100) * 12.0).toFixed(2)),
      carTexture: Number((c / 100).toFixed(2)),
    };
  }, [distance, shadows, lights, carTexture]);

  const applyToClient = useCallback((showFeedback = true, customHome = null, customExtras = null) => {
    postNui('setConfigBoost', customHome || buildHomePayload());
    postNui('setExtras', customExtras || extras);

    if (showFeedback) {
      setApplyState('applied');
      setTimeout(() => setApplyState('idle'), 1600);
    }
  }, [buildHomePayload, extras]);

  const handleClose = useCallback(() => {
    setVisible(false);
    postNui('hideFrame', {});
  }, []);

  useEffect(() => {
    const onKeyDown = (e) => {
      if (e.key === 'Escape' && visible) handleClose();
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [visible, handleClose]);

  useEffect(() => {
    const onMessage = (event) => {
      const msg = event.data;
      if (!msg) return;

      if (msg.method === 'setVisible') {
        setVisible(Boolean(msg.data));
      }
      if (msg.method === 'setFrameRate') {
        const nextFps = Math.max(1, parseInt(msg.data, 10) || 60);
        setFps(nextFps);
        setFpsHistory((prev) => [...prev.slice(-24), nextFps]);
      }
      if (msg.method === 'setLang' && msg.data) {
        setLang(msg.data);
      }
      if (msg.method === 'setConfig' && msg.data) {
        const cfg = msg.data;
        if (cfg.distance !== undefined) {
          setDistance(Math.min(3000, Math.max(500, Math.round(Number(cfg.distance) * 1000))));
        }
        if (cfg.shadows !== undefined) {
          const sv = Number(cfg.shadows);
          let idx = 3;
          if (sv <= 0.0) idx = 0;
          else if (sv <= 2.5) idx = 1;
          else if (sv <= 4.0) idx = 2;
          else if (sv <= 6.0) idx = 3;
          else idx = 4;
          setShadows(idx);
        }
        if (cfg.lights !== undefined) {
          setLights(Math.min(100, Math.max(0, Math.round((Number(cfg.lights) / 12.0) * 100))));
        }
        if (cfg.carTexture !== undefined) {
          setCarTexture(Math.min(100, Math.max(20, Math.round(Number(cfg.carTexture) * 100))));
        }
      }
      if (msg.method === 'setExtrasConfig' && msg.data) {
        setExtras((prev) => ({ ...prev, ...msg.data }));
      }
    };

    window.addEventListener('message', onMessage);
    return () => window.removeEventListener('message', onMessage);
  }, []);

  useEffect(() => {
    if (!isBrowserDev) return;
    const interval = setInterval(() => {
      setFps((curr) => {
        const baseTarget = 115 + Math.round(((3000 - distance) / 2500) * 35) + (4 - shadows) * 5;
        const delta = Math.floor(Math.random() * 5) - 2;
        const next = Math.min(220, Math.max(60, Math.round((curr * 0.6) + (baseTarget * 0.4) + delta)));
        setFpsHistory((prev) => [...prev.slice(-24), next]);
        return next;
      });
    }, 1000);
    return () => clearInterval(interval);
  }, [isBrowserDev, distance, shadows]);

  const handleSelectPreset = (key) => {
    const p = PRESETS[key];
    if (!p) return;
    setActivePreset(key);
    setDistance(p.distance);
    setShadows(p.shadows);
    setLights(p.lights);
    setCarTexture(p.carTexture);
    setExtendedTexture(p.extendedTexture);
    setExtras((prev) => ({ ...prev, ...p.extras }));

    if (liveSync) {
      const nextHome = {
        distance: Number((p.distance / 1000).toFixed(2)),
        shadows: SHADOW_MAP[p.shadows] ?? 5.0,
        lights: Number(((p.lights / 100) * 12.0).toFixed(2)),
        carTexture: Number((p.carTexture / 100).toFixed(2)),
      };
      applyToClient(false, nextHome, { ...extras, ...p.extras });
    }
  };

  const handleToggleExtra = (key) => {
    setActivePreset(null);
    setExtras((prev) => {
      const updated = { ...prev, [key]: !prev[key] };
      if (liveSync) postNui('setExtras', updated);
      return updated;
    });
  };

  const updateGraphicParam = (setter, key, value) => {
    setActivePreset(null);
    setter(value);
    if (liveSync) {
      postNui('setConfigBoost', buildHomePayload({ [key]: value }));
    }
  };

  const handleReset = () => {
    handleSelectPreset('equilibrado');
    applyToClient(true);
  };

  const sparklineData = useMemo(() => {
    if (!fpsHistory.length) return { line: '', area: '' };
    const min = Math.min(...fpsHistory, 50) - 12;
    const max = Math.max(...fpsHistory, 165) + 12;
    const range = Math.max(10, max - min);
    const width = 580;
    const height = 110;

    const coords = fpsHistory.map((val, i) => {
      const x = (i / Math.max(1, fpsHistory.length - 1)) * width;
      const y = height - ((val - min) / range) * (height - 20) - 10;
      return [x, y];
    });

    const line = coords.map(([x, y]) => `${x.toFixed(1)},${y.toFixed(1)}`).join(' ');
    const area = `0,${height} ${line} ${width},${height}`;
    return { line, area };
  }, [fpsHistory]);

  if (!visible) return null;

  return (
    <div className="w-screen h-screen flex items-center justify-center bg-transparent overflow-hidden select-none p-6">
      {/* MAIN OBSIDIAN & SAPPHIRE GLASS CHASSIS */}
      <div className="glass-chassis animate-chassis w-[960px] max-w-[95vw] rounded-[20px] flex flex-col overflow-hidden relative text-slate-100">
        
        {/* Top Specular Refraction Line */}
        <div className="specular-edge h-[1px] w-full" />

        {/* ============================================================
            HEADER
           ============================================================ */}
        <header className="px-7 py-5 flex items-center justify-between border-b border-white/[0.06]">
          <div className="flex items-center gap-3.5">
            <div className="w-9 h-9 rounded-xl glass-surface-active flex items-center justify-center text-blue-400">
              <Zap className="w-4 h-4 stroke-[2.2]" aria-hidden="true" />
            </div>
            <div>
              <div className="flex items-center gap-2.5">
                <h1 className="font-display text-lg font-semibold tracking-tight text-white">
                  Aldeia Boost
                </h1>
                <span className="px-2 py-0.5 rounded-md text-[11px] font-medium bg-blue-500/10 text-blue-400 border border-blue-400/20">
                  Engine Suite
                </span>
              </div>
              <p className="text-xs text-slate-400 mt-0.5">
                Calibragem gráfica e otimização de streaming em tempo real
              </p>
            </div>
          </div>

          {/* Right Telemetry & Actions */}
          <div className="flex items-center gap-3">
            {/* Compact Telemetry Strip */}
            <div className="glass-well px-4 py-2 rounded-xl flex items-center gap-4">
              <div className="flex items-baseline gap-1.5">
                <span className="w-1.5 h-1.5 rounded-full bg-blue-400 self-center mr-0.5 shadow-[0_0_8px_#60a5fa]" />
                <span className="font-mono text-lg font-semibold tabular-nums text-white leading-none">
                  {fps}
                </span>
                <span className="text-[11px] font-medium text-slate-400">FPS</span>
              </div>

              <div className="h-4 w-[1px] bg-white/[0.07]" />

              <div className="flex items-baseline gap-1">
                <span className="font-mono text-xs font-medium tabular-nums text-slate-200">
                  {metrics.frameTime}
                </span>
                <span className="text-[11px] text-slate-400">ms</span>
              </div>

              <div className="h-4 w-[1px] bg-white/[0.07]" />

              <div className="flex items-center gap-1.5 text-xs">
                <span className="text-slate-400">Ganho</span>
                <span className="font-mono font-semibold tabular-nums text-blue-400">
                  +{metrics.boostGainScore}%
                </span>
              </div>
            </div>

            {/* Instant Sync Toggle */}
            <button
              type="button"
              onClick={() => setLiveSync(!liveSync)}
              aria-pressed={liveSync}
              className={`px-3 py-2 rounded-xl text-xs font-medium flex items-center gap-2 transition-all cursor-pointer ${
                liveSync
                  ? 'glass-surface-active text-blue-300'
                  : 'glass-control text-slate-400 hover:text-slate-200'
              }`}
            >
              <span className={`w-1.5 h-1.5 rounded-full ${liveSync ? 'bg-blue-400' : 'bg-slate-500'}`} />
              Sync Automático
            </button>

            {/* Close */}
            <button
              type="button"
              onClick={handleClose}
              aria-label="Fechar painel"
              title="Fechar (ESC)"
              className="w-9 h-9 rounded-xl glass-control flex items-center justify-center text-slate-400 hover:text-white cursor-pointer"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </header>

        {/* ============================================================
            BODY: SIDEBAR + MAIN VIEWPORT
           ============================================================ */}
        <div className="flex min-h-[430px]">
          
          {/* SIDEBAR */}
          <aside className="w-[240px] border-r border-white/[0.06] p-5 flex flex-col justify-between bg-[#050811]/45">
            <div className="space-y-6">
              {/* Navigation */}
              <div>
                <div className="text-[11px] font-medium text-slate-400 px-2 mb-2">
                  Navegação
                </div>
                <nav className="flex flex-col gap-1" aria-label="Seções do painel">
                  {[
                    { id: 'graphics', label: lang?.navegation?.home || 'Renderização', icon: Sliders },
                    {
                      id: 'advanced',
                      label: lang?.navegation?.extras || 'Parâmetros Extras',
                      icon: Cpu,
                      badge: metrics.activeExtrasCount > 0 ? metrics.activeExtrasCount : null
                    },
                    { id: 'telemetry', label: 'Telemetria & Quadros', icon: Activity },
                  ].map((item) => {
                    const Icon = item.icon;
                    const active = activeTab === item.id;
                    return (
                      <button
                        key={item.id}
                        type="button"
                        onClick={() => setActiveTab(item.id)}
                        className={`w-full flex items-center justify-between px-3 py-2.5 rounded-xl text-xs font-medium transition-all cursor-pointer ${
                          active
                            ? 'glass-surface-active text-white'
                            : 'text-slate-400 hover:text-slate-200 hover:bg-white/[0.03] border border-transparent'
                        }`}
                      >
                        <span className="flex items-center gap-2.5">
                          <Icon className={`w-4 h-4 ${active ? 'text-blue-400' : 'text-slate-400'}`} aria-hidden="true" />
                          <span>{item.label}</span>
                        </span>
                        {item.badge && (
                          <span className="px-1.5 py-0.5 rounded-md text-[10px] font-mono font-semibold tabular-nums bg-blue-500/20 text-blue-300 border border-blue-400/25">
                            {item.badge}
                          </span>
                        )}
                      </button>
                    );
                  })}
                </nav>
              </div>

              {/* Engine Presets */}
              <div>
                <div className="text-[11px] font-medium text-slate-400 px-2 mb-2">
                  Perfis de Motor
                </div>
                <div className="flex flex-col gap-1.5">
                  {Object.entries(PRESETS).map(([key, preset]) => {
                    const selected = activePreset === key;
                    return (
                      <button
                        key={key}
                        type="button"
                        onClick={() => handleSelectPreset(key)}
                        className={`text-left px-3 py-2.5 rounded-xl transition-all cursor-pointer ${
                          selected
                            ? 'glass-surface-active'
                            : 'glass-surface'
                        }`}
                      >
                        <div className="flex items-center justify-between">
                          <span className={`text-xs font-semibold ${selected ? 'text-white' : 'text-slate-200'}`}>
                            {preset.label}
                          </span>
                          <span className={`text-[10px] font-mono px-1.5 py-0.5 rounded ${
                            selected
                              ? 'bg-blue-500/25 text-blue-300 border border-blue-400/30'
                              : 'bg-white/[0.04] text-slate-400'
                          }`}>
                            {preset.tag}
                          </span>
                        </div>
                        <p className="text-[11px] text-slate-400 mt-1 line-clamp-1">
                          {preset.summary}
                        </p>
                      </button>
                    );
                  })}
                </div>
              </div>
            </div>
          </aside>

          {/* MAIN CONTENT VIEWPORT */}
          <main className="flex-1 p-6 flex flex-col justify-between">
            
            {/* ============================================================
                TAB 1: RENDERIZAÇÃO & GRÁFICOS
               ============================================================ */}
            {activeTab === 'graphics' && (
              <div className="animate-view flex flex-col h-full justify-between gap-5">
                <div className="flex items-baseline justify-between">
                  <div>
                    <h2 className="font-display text-base font-semibold text-white">
                      Calibragem de Renderização
                    </h2>
                    <p className="text-xs text-slate-400 mt-0.5">
                      Controle o alcance de objetos (LOD), cascata de sombras e distância de luzes
                    </p>
                  </div>
                  <span className="text-xs font-mono text-slate-400 tabular-nums">
                    VRAM Estimada: <strong className="text-slate-200">{metrics.vramUsed} GB</strong>
                  </span>
                </div>

                {/* 2x2 Sliders Grid */}
                <div className="grid grid-cols-2 gap-4">
                  
                  {/* SLIDER 1: DISTÂNCIA */}
                  <div className="glass-surface p-4 rounded-2xl flex flex-col gap-3">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <Eye className="w-4 h-4 text-blue-400" aria-hidden="true" />
                        <span className="text-xs font-medium text-slate-200">
                          Distância de Carregamento
                        </span>
                      </div>
                      <span className="font-mono text-xs font-semibold tabular-nums text-blue-400">
                        {distance} m
                      </span>
                    </div>

                    <div className="relative w-full h-5 flex items-center">
                      <div className="w-full h-1.5 rounded-full glass-well overflow-hidden pointer-events-none">
                        <div
                          className="h-full rounded-full bg-gradient-to-r from-blue-600 to-blue-400"
                          style={{ width: `${((distance - 500) / 2500) * 100}%` }}
                        />
                      </div>
                      <input
                        type="range"
                        min="500"
                        max="3000"
                        step="50"
                        value={distance}
                        aria-label="Distância de Carregamento"
                        onChange={(e) => updateGraphicParam(setDistance, 'distance', Number(e.target.value))}
                        className="precision-range absolute inset-0 w-full h-full"
                      />
                    </div>

                    <div className="flex justify-between text-[11px] text-slate-400">
                      <span>500 m</span>
                      <span>1750 m</span>
                      <span>3000 m</span>
                    </div>
                  </div>

                  {/* SLIDER 2: SOMBRAS */}
                  <div className="glass-surface p-4 rounded-2xl flex flex-col gap-3">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <Moon className="w-4 h-4 text-blue-400" aria-hidden="true" />
                        <span className="text-xs font-medium text-slate-200">
                          Qualidade das Sombras
                        </span>
                      </div>
                      <span className="font-mono text-xs font-semibold text-blue-400">
                        {SHADOW_LABELS[shadows]}
                      </span>
                    </div>

                    <div className="relative w-full h-5 flex items-center">
                      <div className="w-full h-1.5 rounded-full glass-well overflow-hidden pointer-events-none">
                        <div
                          className="h-full rounded-full bg-gradient-to-r from-blue-600 to-blue-400"
                          style={{ width: `${(shadows / 4) * 100}%` }}
                        />
                      </div>
                      <input
                        type="range"
                        min="0"
                        max="4"
                        step="1"
                        value={shadows}
                        aria-label="Qualidade das Sombras"
                        onChange={(e) => updateGraphicParam(setShadows, 'shadows', Number(e.target.value))}
                        className="precision-range absolute inset-0 w-full h-full"
                      />
                    </div>

                    <div className="flex justify-between text-[11px] text-slate-400">
                      <span>Desativado</span>
                      <span>Média</span>
                      <span>Ultra</span>
                    </div>
                  </div>

                  {/* SLIDER 3: ILUMINAÇÃO */}
                  <div className="glass-surface p-4 rounded-2xl flex flex-col gap-3">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <Sun className="w-4 h-4 text-blue-400" aria-hidden="true" />
                        <span className="text-xs font-medium text-slate-200">
                          Alcance de Iluminação
                        </span>
                      </div>
                      <span className="font-mono text-xs font-semibold tabular-nums text-blue-400">
                        {lights}%
                      </span>
                    </div>

                    <div className="relative w-full h-5 flex items-center">
                      <div className="w-full h-1.5 rounded-full glass-well overflow-hidden pointer-events-none">
                        <div
                          className="h-full rounded-full bg-gradient-to-r from-blue-600 to-blue-400"
                          style={{ width: `${lights}%` }}
                        />
                      </div>
                      <input
                        type="range"
                        min="0"
                        max="100"
                        step="5"
                        value={lights}
                        aria-label="Alcance de Iluminação"
                        onChange={(e) => updateGraphicParam(setLights, 'lights', Number(e.target.value))}
                        className="precision-range absolute inset-0 w-full h-full"
                      />
                    </div>

                    <div className="flex justify-between text-[11px] text-slate-400">
                      <span>Reduzido</span>
                      <span>Equilibrado</span>
                      <span>Máximo</span>
                    </div>
                  </div>

                  {/* SLIDER 4: LOD DE VEÍCULOS */}
                  <div className="glass-surface p-4 rounded-2xl flex flex-col gap-3">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <Car className="w-4 h-4 text-blue-400" aria-hidden="true" />
                        <span className="text-xs font-medium text-slate-200">
                          Detalhe de Veículos (LOD)
                        </span>
                      </div>
                      <span className="font-mono text-xs font-semibold tabular-nums text-blue-400">
                        {carTexture}%
                      </span>
                    </div>

                    <div className="relative w-full h-5 flex items-center">
                      <div className="w-full h-1.5 rounded-full glass-well overflow-hidden pointer-events-none">
                        <div
                          className="h-full rounded-full bg-gradient-to-r from-blue-600 to-blue-400"
                          style={{ width: `${((carTexture - 20) / 80) * 100}%` }}
                        />
                      </div>
                      <input
                        type="range"
                        min="20"
                        max="100"
                        step="5"
                        value={carTexture}
                        aria-label="Detalhe de Veículos"
                        onChange={(e) => updateGraphicParam(setCarTexture, 'carTexture', Number(e.target.value))}
                        className="precision-range absolute inset-0 w-full h-full"
                      />
                    </div>

                    <div className="flex justify-between text-[11px] text-slate-400">
                      <span>20% (Leve)</span>
                      <span>60%</span>
                      <span>100% (Original)</span>
                    </div>
                  </div>

                </div>

                {/* Bottom Card: Texture Buffer */}
                <button
                  type="button"
                  onClick={() => {
                    setActivePreset(null);
                    setExtendedTexture(!extendedTexture);
                  }}
                  aria-pressed={extendedTexture}
                  className={`w-full text-left p-4 rounded-2xl flex items-center justify-between transition-all cursor-pointer ${
                    extendedTexture ? 'glass-surface-active' : 'glass-surface'
                  }`}
                >
                  <div className="flex items-center gap-3.5">
                    <div className={`w-9 h-9 rounded-xl flex items-center justify-center border ${
                      extendedTexture
                        ? 'bg-blue-500/15 border-blue-400/35 text-blue-400'
                        : 'bg-white/[0.03] border-white/10 text-slate-400'
                    }`}>
                      <Layers className="w-4 h-4" aria-hidden="true" />
                    </div>
                    <div>
                      <div className="flex items-center gap-2">
                        <span className="text-xs font-semibold text-white">
                          Buffer Estendido de Texturas HD
                        </span>
                        <span className="text-[11px] font-mono text-blue-400">
                          {extendedTexture ? '4.0 GB Alocados' : '2.0 GB Padrão'}
                        </span>
                      </div>
                      <p className="text-xs text-slate-400 mt-0.5">
                        Prioriza o cache de geometria urbana na VRAM para evitar falhas de carregamento em alta velocidade
                      </p>
                    </div>
                  </div>

                  <div
                    className={`w-10 h-5 rounded-full p-0.5 transition-colors flex items-center shrink-0 ${
                      extendedTexture
                        ? 'bg-blue-500 justify-end'
                        : 'bg-slate-800 border border-white/10 justify-start'
                    }`}
                  >
                    <div className="w-4 h-4 rounded-full bg-white shadow-sm" />
                  </div>
                </button>
              </div>
            )}

            {/* ============================================================
                TAB 2: PARÂMETROS EXTRAS
               ============================================================ */}
            {activeTab === 'advanced' && (
              <div className="animate-view flex flex-col h-full justify-between gap-4">
                <div>
                  <h2 className="font-display text-base font-semibold text-white">
                    Parâmetros Extras do Motor
                  </h2>
                  <p className="text-xs text-slate-400 mt-0.5">
                    Desative efeitos climáticos pesados e rotinas secundárias do GTA V
                  </p>
                </div>

                <div className="grid grid-cols-1 gap-2.5 my-auto">
                  {[
                    {
                      key: 'rainLevel',
                      icon: CloudRain,
                      title: 'Desabilitar Gotas e Partículas de Chuva',
                      desc: 'Neutraliza o reflexo e partículas densas durante tempestades',
                      impact: 'Alto impacto',
                    },
                    {
                      key: 'windSpeed',
                      icon: Wind,
                      title: 'Reduzir Física de Vento e Vegetação',
                      desc: 'Diminui a oscilação dinâmica de árvores, folhagens e bandeiras',
                      impact: 'Médio impacto',
                    },
                    {
                      key: 'clearBlood',
                      icon: Droplets,
                      title: 'Limpeza Automática de Decals e Dano',
                      desc: 'Remove marcas de sangue, sujeira e umidade acumulada no personagem',
                      impact: 'Leve impacto',
                    },
                    {
                      key: 'timeCycle',
                      icon: Film,
                      title: 'Perfil de Iluminação Cinema (Timecycle)',
                      desc: 'Aplica filtro de contraste suave e reduz bloom excessivo de postes',
                      impact: 'Pós-processamento',
                    },
                    {
                      key: 'extraFps',
                      icon: Zap,
                      title: 'Rotina Contínua de Limpeza de Cache (Extra FPS)',
                      desc: 'Limpa vidros quebrados, áreas HD ociosas, histórico de replay e blur de tela a cada 1.5s',
                      impact: 'Otimização profunda',
                    },
                  ].map((item) => {
                    const Icon = item.icon;
                    const checked = Boolean(extras[item.key]);
                    return (
                      <button
                        key={item.key}
                        type="button"
                        onClick={() => handleToggleExtra(item.key)}
                        aria-pressed={checked}
                        className={`w-full text-left px-4 py-3 rounded-2xl flex items-center justify-between transition-all cursor-pointer ${
                          checked ? 'glass-surface-active' : 'glass-surface'
                        }`}
                      >
                        <div className="flex items-center gap-3.5 pr-4">
                          <div className={`w-8 h-8 rounded-xl flex items-center justify-center shrink-0 border ${
                            checked
                              ? 'bg-blue-500/20 border-blue-400/40 text-blue-400'
                              : 'bg-white/[0.03] border-white/10 text-slate-400'
                          }`}>
                            <Icon className="w-4 h-4" aria-hidden="true" />
                          </div>
                          <div>
                            <div className="flex items-center gap-2">
                              <span className="text-xs font-semibold text-white">
                                {item.title}
                              </span>
                              <span className="text-[11px] text-slate-400">
                                • {item.impact}
                              </span>
                            </div>
                            <p className="text-xs text-slate-400 mt-0.5 line-clamp-1">
                              {item.desc}
                            </p>
                          </div>
                        </div>

                        <div
                          className={`w-10 h-5 rounded-full p-0.5 transition-colors flex items-center shrink-0 ${
                            checked
                              ? 'bg-blue-500 justify-end'
                              : 'bg-slate-800 border border-white/10 justify-start'
                          }`}
                        >
                          <div className="w-4 h-4 rounded-full bg-white shadow-sm" />
                        </div>
                      </button>
                    );
                  })}
                </div>
              </div>
            )}

            {/* ============================================================
                TAB 3: TELEMETRIA & QUADROS
               ============================================================ */}
            {activeTab === 'telemetry' && (
              <div className="animate-view flex flex-col h-full justify-between gap-4">
                <div className="flex items-baseline justify-between">
                  <div>
                    <h2 className="font-display text-base font-semibold text-white">
                      Telemetria em Tempo Real
                    </h2>
                    <p className="text-xs text-slate-400 mt-0.5">
                      Histórico de estabilidade de quadros e distribuição de carga gráfica
                    </p>
                  </div>

                  <div className="flex items-center gap-4 text-xs font-mono tabular-nums">
                    <span className="text-slate-400">Mín: <strong className="text-slate-200">{metrics.minFps}</strong></span>
                    <span className="text-slate-400">Méd: <strong className="text-blue-400">{metrics.avgFps}</strong></span>
                    <span className="text-slate-400">Máx: <strong className="text-slate-200">{metrics.maxFps}</strong></span>
                  </div>
                </div>

                {/* Area Chart Card */}
                <div className="glass-surface p-4 rounded-2xl flex flex-col gap-3">
                  <div className="flex items-center justify-between text-xs">
                    <span className="font-medium text-slate-300">Curva de Estabilidade (FPS)</span>
                    <span className="font-mono text-slate-400 tabular-nums">Janela de 25s</span>
                  </div>

                  <div className="w-full h-[120px] glass-well rounded-xl p-2 flex items-center overflow-hidden">
                    <svg viewBox="0 0 580 110" className="w-full h-full overflow-visible">
                      <defs>
                        <linearGradient id="sapphireStroke" x1="0" y1="0" x2="1" y2="0">
                          <stop offset="0%" stopColor="#2563eb" />
                          <stop offset="100%" stopColor="#60a5fa" />
                        </linearGradient>
                        <linearGradient id="sapphireArea" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="0%" stopColor="rgba(59, 130, 246, 0.28)" />
                          <stop offset="100%" stopColor="rgba(59, 130, 246, 0.0)" />
                        </linearGradient>
                      </defs>
                      <line x1="0" y1="25" x2="580" y2="25" stroke="rgba(255,255,255,0.04)" strokeDasharray="3 3" />
                      <line x1="0" y1="55" x2="580" y2="55" stroke="rgba(255,255,255,0.04)" strokeDasharray="3 3" />
                      <line x1="0" y1="85" x2="580" y2="85" stroke="rgba(255,255,255,0.04)" strokeDasharray="3 3" />

                      {sparklineData.area && (
                        <polygon fill="url(#sapphireArea)" points={sparklineData.area} />
                      )}
                      {sparklineData.line && (
                        <polyline
                          fill="none"
                          stroke="url(#sapphireStroke)"
                          strokeWidth="2.2"
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          points={sparklineData.line}
                        />
                      )}
                    </svg>
                  </div>
                </div>

                {/* 3 Metric Cards */}
                <div className="grid grid-cols-3 gap-3.5">
                  <div className="glass-surface p-3.5 rounded-2xl flex flex-col gap-2">
                    <div className="flex justify-between text-xs">
                      <span className="text-slate-400">Uso Estimado CPU</span>
                      <span className="font-mono font-semibold tabular-nums text-white">{metrics.cpuLoad}%</span>
                    </div>
                    <div className="w-full h-1.5 rounded-full glass-well overflow-hidden">
                      <div className="h-full rounded-full bg-blue-500" style={{ width: `${metrics.cpuLoad}%` }} />
                    </div>
                    <span className="text-[11px] text-slate-400">Streaming de entidades</span>
                  </div>

                  <div className="glass-surface p-3.5 rounded-2xl flex flex-col gap-2">
                    <div className="flex justify-between text-xs">
                      <span className="text-slate-400">Carga de Shaders GPU</span>
                      <span className="font-mono font-semibold tabular-nums text-white">{metrics.gpuLoad}%</span>
                    </div>
                    <div className="w-full h-1.5 rounded-full glass-well overflow-hidden">
                      <div className="h-full rounded-full bg-blue-400" style={{ width: `${metrics.gpuLoad}%` }} />
                    </div>
                    <span className="text-[11px] text-slate-400">Sombras e luzes dinâmicas</span>
                  </div>

                  <div className="glass-surface p-3.5 rounded-2xl flex flex-col gap-2">
                    <div className="flex justify-between text-xs">
                      <span className="text-slate-400">Redução de Draw Calls</span>
                      <span className="font-mono font-semibold tabular-nums text-blue-400">+{metrics.boostGainScore}%</span>
                    </div>
                    <div className="w-full h-1.5 rounded-full glass-well overflow-hidden">
                      <div className="h-full rounded-full bg-blue-400" style={{ width: `${metrics.boostGainScore}%` }} />
                    </div>
                    <span className="text-[11px] text-slate-400">Economia do perfil atual</span>
                  </div>
                </div>
              </div>
            )}

          </main>
        </div>

        {/* ============================================================
            FOOTER
           ============================================================ */}
        <footer className="px-7 py-4 border-t border-white/[0.06] bg-[#050811]/70 flex items-center justify-between">
          <button
            type="button"
            onClick={handleReset}
            className="flex items-center gap-2 text-xs font-medium text-slate-400 hover:text-white transition-colors cursor-pointer"
          >
            <RotateCcw className="w-3.5 h-3.5" aria-hidden="true" />
            Restaurar padrão equilibrado
          </button>

          <div className="flex items-center gap-2.5">
            <button
              type="button"
              onClick={handleClose}
              className="px-4 py-2 rounded-xl glass-control text-xs font-medium text-slate-300 hover:text-white cursor-pointer"
            >
              Fechar
            </button>

            <button
              type="button"
              onClick={() => applyToClient(true)}
              className={`px-5 py-2 rounded-xl text-xs font-semibold text-white flex items-center gap-2 cursor-pointer ${
                applyState === 'applied'
                  ? 'bg-emerald-600 border border-emerald-400/40 shadow-[0_6px_18px_rgba(16,185,129,0.35)]'
                  : 'btn-sapphire'
              }`}
            >
              {applyState === 'applied' ? (
                <>
                  <Check className="w-3.5 h-3.5 stroke-[2.5]" aria-hidden="true" />
                  <span>Configuração Aplicada</span>
                </>
              ) : (
                <span>{lang?.home?.apply ? 'Aplicar Otimização' : 'Aplicar Otimização'}</span>
              )}
            </button>
          </div>
        </footer>

      </div>
    </div>
  );
}
