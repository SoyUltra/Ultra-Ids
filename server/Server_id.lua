RegisterNetEvent('ultra-ids:idNoty')
AddEventHandler('ultra-ids:idNoty', function(nearPlayers)
    local src = source
    if nearPlayers ~=nil then
        for k, v in pairs(nearPlayers) do
            if v.playerId ~= src then
                TriggerClientEvent('ultra-ids:Notify', v.playerId, src)
            end
        end
    else
    end
end)

