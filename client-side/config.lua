script = {}
script.command = 'fpsboost'

--- Paleta de cores em tom azul / neon cyan
script.colors = {
    bgcolor = 'transparent',                                                                            -- SEM FUNDO ESCURO EXTERNO (TRANSPARENTE)
    fxColor = { '#00d2ff', "#0066ff" },                                                                -- EFEITO CIANO / AZUL NEON
    bgPrimary = 'transparent',                                                                          -- CONTAINER EXTERNO TRANSPARENTE
    bgSecondary = 'rgba(19, 26, 42, 0.95)',                                                             -- FUNDO DO PAINEL PRINCIPAL
    navegationColors = { '#3b82f6', 'rgba(255,255,255,.06)' },                                         -- MENU DE NAVEGAÇÃO SELECIONADO/INATIVO
    buttonHome = 'linear-gradient(90deg, #10b981 0%, #06b6d4 100%)',                                   -- BOTAO APLICAR ESTILO VERDE/CIANO
    inputColors = {
        background = 'rgba(255,255,255,.05)',
        color = '#06b6d4',
        track = 'linear-gradient(90deg, #3b82f6 0%, #06b6d4 100%)',
        thumb = '#FFFFFF',
        shadowBefore = '0 2px 6px 0 rgba(0,0,0,0.5)',
        shadowHover = '0px 0px 14px 3px rgba(6, 182, 212, 0.65)',
        rail = '#0f172a',
        opacityRail = 0.8
    },
    extras = {
        background = 'rgba(255,255,255,.05)',
        toogle = {
            background = 'rgba(255,255,255,.05)',
            active = { '#0077ff', 'rgba(255,255,255,.10)' }
        }
    }
}

script.lang = {
    home = {
        distance = 'distancia de carregamento',
        lights = 'otimizar luzes',
        shadows = 'otimizar sombras',
        apply = 'APLICAR BOOST',
    },
    navegation = {
        home = 'Principal',
        extras = 'Extras'
    },
    extras = {
        title = 'parâmetros extras',
        rain = 'desabilitar gotas de chuva',
        rainDesc = 'Ganho significativo de fps durante chuvas',
        wind = 'desabilitar vento',
        windDesc = 'Medio significativo de fps durante chuvas',
        blood = 'desabilitar sangue',
        bloodDesc = 'Baixo ganho de fps',
        timeCycle = 'ATIVAR TIMECYCLE',
        timeDesc = 'Muda o time cycle para cinema',
        extraFps = 'extra fps (BETA)',
        extraFpsDesc =
        'Ativar a opção EXTRA FPS ira forçar com que varias funções nativas do jogo sejam desabilitadas ou limpas.O ganho de performance pode não ser tão significativo!'
    }
}
