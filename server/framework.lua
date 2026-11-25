--- GET PLAYER STEAM
--- @param source number
--- @return string | nil
function GetPlayerSteam(source)
    if type(source) == "number" and DoesEntityExist(GetPlayerPed(source)) then
        for k, v in ipairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, 5) == "steam" then return tonumber(v:sub(7), 16) end
        end
    end
end

--- GET PLAYER ID
--- @param source number
--- @return number | string | nil
function GetUserId(source)
    return vRP and vRP.getUserId and vRP.getUserId(source) or GetPlayerSteam(source)
end
