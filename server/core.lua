local Tunnel = Tunnel
local vRP = nil
if DoesExportExist and DoesExportExist("vrp", "getvRP") then
    vRP = exports.vrp:getvRP()
end

local default_config = {
    distance = 1.0,
    lights = 10.0,
    shadows = 5.0
}

local cached_configs = {}

local vSERVER = {}
Tunnel.bindInterface(vSERVER)

function vSERVER.OpenFiveBoost()
    local source = source
    local user_id = GetUserId(source)
    if not user_id then
        return default_config
    end

    if cached_configs[user_id] then
        return cached_configs[user_id]
    end

    local rows = query("getBoostConfig", { id = user_id })
    if rows and #rows > 0 and rows[1] and rows[1].config then
        local status, decoded = pcall(json.decode, rows[1].config)
        if status and decoded and type(decoded) == "table" and decoded.distance then
            cached_configs[user_id] = decoded
            return cached_configs[user_id]
        end
    end

    -- If no config exists in DB or decode failed, initialize with default
    pcall(function()
        query("initBoostConfig", {
            user_id = user_id,
            config = json.encode(default_config)
        })
    end)

    cached_configs[user_id] = default_config
    return cached_configs[user_id]
end

function vSERVER.SaveBoost(newConfig)
    local source = source
    local user_id = GetUserId(source)
    if user_id and newConfig then
        cached_configs[user_id] = newConfig
        if DEBUG_SCRIPT then
            print(Color("%{magentabg white }             aldeia-boost            %{reset}"))
            print(Color("%{greenbg black }  [ID:" .. tostring(user_id) .. "] CACHE SAVE CONFIG   %{reset}"))
            if DEBUG_SCRIPT_TABLE then
                print(Tabular({ ID = user_id, CONFIG = cached_configs[user_id] }))
            end
        end
    end
end

AddEventHandler("playerDropped", function()
    local source = source
    local user_id = GetUserId(source)
    if user_id and cached_configs[user_id] then
        local saved = query("saveBoostConfig", {
            id = user_id,
            config = json.encode(cached_configs[user_id])
        })
        if saved and DEBUG_SCRIPT then
            print(Color("%{magentabg white }             aldeia-boost            %{reset}"))
            print(Color("%{greenbg black }  [ID:" .. tostring(user_id) .. "] DB SAVE CONFIG    %{reset}"))
            if DEBUG_SCRIPT_TABLE then
                print(Tabular({ ID = user_id, CONFIG = cached_configs[user_id] }))
            end
        end
        cached_configs[user_id] = nil
    end
end)

local function InitDB()
    if DATA_BASE_NAME == "" then
        print(Color("%{magentabg white }             aldeia-boost            %{reset}"))
        print(Color("%{redbg white }  CONFIGURE O NOME DA SUA DATABASE %{reset}"))
    end
    local check = query("checkDBBoostConfig", { db = DATA_BASE_NAME })
    if check and #check == 0 then
        query("createBoostConfig")
        print(Color("%{magentabg white }             aldeia-boost            %{reset}"))
        print(Color("%{greenbg black }    DATABASE CRIADA COM SUCESSO    %{reset}"))
    end
end

CreateThread(function()
    InitDB()
    print(Color("%{magentabg white }             aldeia-boost            %{reset}"))
    print(Color("%{greenbg black }      SUCESSO AO INICIAR O SCRIPT    %{reset}"))
end)

