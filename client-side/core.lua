local Tunnel = Tunnel
local vSERVER = Tunnel.getInterface()

local boostConfig = {
    extras = {
        rainLevel = false,
        windSpeed = false,
        clearBlood = false,
        clearDirty = false,
        extraFps = false,
        timeCycle = false
    },
    home = nil
}

local cachedHome = {}
local isInitialized = false

function SendReactMessage(action, data)
    SendNUIMessage({
        app = "fivem-boost",
        method = action,
        data = data
    })
end

function ToggleNuiFrame(state)
    SetNuiFocus(state, state)
    SendReactMessage("setVisible", state)
end

function boostConfig:Initilizer()
    -- Thread for FPS counter to send to React UI
    CreateThread(function()
        while true do
            local startFrame = GetFrameCount()
            Wait(1000)
            local currentFrame = GetFrameCount()
            local fps = currentFrame - startFrame
            SendReactMessage("setFrameRate", fps)
        end
    end)

    -- Thread for extras optimization
    CreateThread(function()
        while true do
            if boostConfig.extras.extraFps then
                ClearAllBrokenGlass()
                ClearAllHelpMessages()
                LeaderboardsReadClearAll()
                ClearBrief()
                ClearGpsFlags()
                ClearPrints()
                ClearSmallPrints()
                ClearReplayStats()
                LeaderboardsClearCacheData()
                ClearFocus()
                ClearHdArea()
                local ped = PlayerPedId()
                ClearPedBloodDamage(ped)
                ClearPedWetness(ped)
                ClearPedEnvDirt(ped)
                ResetPedVisibleDamage(ped)
                ClearExtraTimecycleModifier()
                ClearOverrideWeather()
                ClearHdArea()
                DisableVehicleDistantlights(false)
                DisableScreenblurFade()
            end

            if boostConfig.extras.rainLevel then
                SetRainLevel(0.0)
            end

            if boostConfig.extras.windSpeed then
                SetWindSpeed(0.0)
            end

            if boostConfig.extras.clearBlood then
                local ped = PlayerPedId()
                ClearPedBloodDamage(ped)
                ResetPedVisibleDamage(ped)
            end

            Wait(1500)
        end
    end)

    -- Thread for LOD scale
    CreateThread(function()
        while true do
            local sleep = 100
            if boostConfig.home and boostConfig.home.distance and boostConfig.home.distance ~= 1.0 then
                sleep = 0
                OverrideLodscaleThisFrame(boostConfig.home.distance)
            end
            Wait(sleep)
        end
    end)
end

local function openBoostMenu()
    if not isInitialized or not boostConfig.home then
        local serverConfig = vSERVER.OpenFiveBoost()
        if serverConfig and type(serverConfig) == "table" then
            for k, v in pairs(serverConfig) do
                serverConfig[k] = (tonumber(v) or 1.0) + 0.0
            end
            boostConfig.home = serverConfig
        else
            boostConfig.home = {
                distance = 1.0,
                lights = 10.0,
                shadows = 5.0
            }
        end

        cachedHome.home = json.encode(boostConfig.home)
        SendReactMessage("setLang", script.lang)
        boostConfig:Initilizer()
        SetResourceKvp("boost:extras", json.encode(boostConfig.extras))
        SetResourceKvp("boost:home", json.encode(boostConfig.home))
        isInitialized = true
    end

    if boostConfig.home then
        ToggleNuiFrame(true)
        SendReactMessage("setConfig", boostConfig.home)
        SendReactMessage("setColors", script.colors)
    end
end

RegisterCommand(script.command or "fpsboost", function()
    openBoostMenu()
end, false)

exports("openBoostMenu", openBoostMenu)

CreateThread(function()
    Wait(10000)
    local extrasKvp = GetResourceKvpString("boost:extras")
    local homeKvp = GetResourceKvpString("boost:home")
    if extrasKvp and homeKvp then
        pcall(function()
            boostConfig.home = json.decode(homeKvp)
            boostConfig.extras = json.decode(extrasKvp)
            boostConfig:Initilizer()
            isInitialized = true
        end)
    end
end)

local vehicleOpt = {}
function vehicleOpt.VehicleOtimization()
    local vehicles = GetGamePool("CVehicle")
    for i = 1, #vehicles do
        if boostConfig.home and boostConfig.home.carTexture then
            SetVehicleLodMultiplier(vehicles[i], boostConfig.home.carTexture)
        end
    end
end

RegisterNUICallback("setExtras", function(data, cb)
    boostConfig.extras.rainLevel = data.rainLevel
    boostConfig.extras.windSpeed = data.windSpeed
    boostConfig.extras.clearBlood = data.clearBlood
    boostConfig.extras.clearDirty = data.clearDirty
    boostConfig.extras.extraFps = data.extraFps
    boostConfig.extras.timeCycle = data.timeCycle

    if boostConfig.extras.timeCycle == true then
        SetTimecycleModifier("cinema")
    else
        SetTimecycleModifier("default")
    end

    SetResourceKvp("boost:extras", json.encode(boostConfig.extras))
    SetResourceKvp("boost:home", json.encode(boostConfig.home))
    cb(true)
end)

RegisterNUICallback("setConfigBoost", function(data, cb)
    boostConfig.home.distance = (tonumber(data.distance) or 1.0) + 0.0
    boostConfig.home.shadows = (tonumber(data.shadows) or 5.0) + 0.0
    boostConfig.home.lights = (tonumber(data.lights) or 10.0) + 0.0

    RopeDrawShadowEnabled(boostConfig.home.shadows == 5.0)
    CascadeShadowsSetEntityTrackerScale(boostConfig.home.shadows)
    CascadeShadowsSetDynamicDepthValue(boostConfig.home.shadows)
    CascadeShadowsSetCascadeBoundsScale(boostConfig.home.shadows)
    CascadeShadowsClearShadowSampleType()
    CascadeShadowsSetAircraftMode(boostConfig.home.shadows == 5.0)
    CascadeShadowsEnableEntityTracker(boostConfig.home.shadows == 0.0)
    CascadeShadowsSetDynamicDepthMode(boostConfig.home.shadows == 5.0)
    RopeDrawShadowEnabled(boostConfig.home.shadows == 5.0)

    SetFlashLightFadeDistance(boostConfig.home.lights)
    local lightsTweak = (boostConfig.home.lights == 5.0) and 0.0 or boostConfig.home.lights
    SetLightsCutoffDistanceTweak(lightsTweak)
    SetArtificialLightsState(boostConfig.home.lights == 5.0)

    SetResourceKvp("boost:extras", json.encode(boostConfig.extras))
    SetResourceKvp("boost:home", json.encode(boostConfig.home))
    cb(true)
end)

RegisterNUICallback("hideFrame", function(data, cb)
    ToggleNuiFrame(false)
    local currentHome = json.encode(boostConfig.home)
    if currentHome ~= cachedHome.home then
        cachedHome.home = currentHome
        vSERVER.SaveBoost(boostConfig.home)
    end
    cb({})
end)

