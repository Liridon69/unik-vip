local QBCore = exports['qb-core']:GetCoreObject() 


local allowed = Config.PlayersWhitelisted



local function IsWhitelisted(CitizenId)
    local retval = false
    for _, cid in pairs(Config.PlayersWhitelisted) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    local Player = QBCore.Functions.GetPlayerByCitizenId(CitizenId)
    local Perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
    if Perms.god then
        retval = true
    end
    return retval
end


QBCore.Commands.Add("vipmenu", "Vip Menu", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if IsWhitelisted(Player.PlayerData.citizenid) then
        TriggerClientEvent("unik-vip:openMenu", src)
    else
        TriggerClientEvent('QBCore:Notify', src, "You are not whitelisted for this", 'error')
    end
end)











