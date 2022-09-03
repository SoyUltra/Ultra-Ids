local onlinePlayers, forceDraw = {}, false
local TimeLeft=0
local ThreadWait=5
local Coldown = false

local playerPed = GetPlayerPed(-1)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if forceDraw and Coldown == false then
            for k, v in pairs(GetNeareastPlayers()) do
                local x, y, z = table.unpack(v.coords)
                Draw3DText(x, y, z + 1.1, ''..v.playerId..'', 1.6)
            if v.playerId == GetPlayerServerId(PlayerId()) then
                Draw3DText(x, y, z - 0.10, ''..TimeLeft .." ".. Config.Secconds, 0.6)
            end
            end
        end
    end
end)

function animacion()
    if Config.EnableAnim then
        RequestAnimDict('missheistdockssetup1clipboard@base')
    while not HasAnimDictLoaded('missheistdockssetup1clipboard@base') do
        Citizen.Wait(100)
    end
        TaskPlayAnim(playerPed, 'missheistdockssetup1clipboard@base', 'base', 8.0, -8, -1, 49, 0, 0, 0, 0)
        clipboardEntity = CreateObject(GetHashKey(Config.PropAnim), x, y, z, true)
        coords = { x = 0.1, y = -0.04, z = 0.07 }
        rotation = { x = 360.0, y = 0.0, z = 150.0 }
        AttachEntityToEntity(clipboardEntity, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905), coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, 1, 1, 0, 1, 0, 1)
    end
end

function clearanim()
    if Config.EnableAnim then
        ClearPedTasks(GetPlayerPed(-1))
        if clipboardEntity ~= nil then
            DeleteEntity(clipboardEntity)
            clipboardEntity = nil
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if forceDraw==true then
            TimeLeft=TimeLeft-1
            if TimeLeft==0 then            
                clearanim()
                TriggerEvent('cd_drawtextui:HideUI')
                forceDraw=false
            end
        end
    end
end)

function TimerCheck()
    if not forceDraw then
        forceDraw=true
        Coldown = false
        TimeLeft=Config.ShowTime
        TriggerEvent('cd_drawtextui:ShowUI', 'show', Config.Notif)  
        local PlayersIDs = GetNeareastPlayers()      
        TriggerServerEvent('ultra-ids:idNoty' , PlayersIDs)
    else
        Coldown = true
        TriggerEvent('cd_drawtextui:ShowUI', 'show', Config.Spam1 .. Config.Cooldown .. Config.Spam2)
        TimeLeft=Config.Cooldown
        Citizen.Wait(Config.Cooldown)
        TriggerEvent('cd_drawtextui:HideUI')
        forceDraw = false
        Coldown = false
    end
end

RegisterCommand(Config.CommandId, function()
    TimerCheck()
end)

function Draw3DText(x, y, z, text, newScale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(Config.R, Config.G, Config.B, 200)
        SetTextDropShadow(255, 255, 255, 150, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local players, _ = GetPlayersInArea(playerCoords, 30)

    local players_clean = {}
    local found_players = false

    for i = 1, #players, 1 do
        found_players = true
        table.insert(players_clean, { playerName = GetPlayerName(players[i]), playerId = GetPlayerServerId(players[i]), coords = GetEntityCoords(GetPlayerPed(players[i])) })
    end
    return players_clean
end


function GetPlayersInArea(coords, area)
	local players, playersInArea = GetPlayers(), {}
	local coords = vector3(coords.x, coords.y, coords.z)
	
    for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end



RegisterNetEvent('ultra-ids:Notify')
AddEventHandler('ultra-ids:Notify', function(id)
    TriggerEvent('cd_drawtextui:ShowUI', 'show', Config.NotiPlayer1 .. id .. Config.NotiPlayer2) 
    ShowLupita(id)
    Citizen.Wait(6000)
    TriggerEvent('cd_drawtextui:HideUI')
end)

local lupaDraw = false
local lupaDraw = nil

function ShowLupita(id)
    lupaDraw = true
    lupaID = id
    Citizen.Wait(6000)
    lupaDraw = false
    lupaID = nil
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if lupaDraw then
            for k, v in pairs(GetNeareastPlayers()) do
                local x, y, z = table.unpack(v.coords)
                if v.playerId == lupaID then
                    Draw3DText(x, y, z + 1.1, '🔍 [ '..v.playerId..' ]', 1.2)
                end
            end
        end
    end
end)

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end        
    end

    local playerPed = GetPlayerPed(-1)

    TaskPlayAnim(playerPed, 'missheistdockssetup1clipboard@base', 'base', 8.0, -8, -1, 49, 0, 0, 0, 0)
    return animDict
end

local timethread = 5
CreateThread(function()
    while true do
        Wait(timethread)
        if Config.EnableKey then
            if IsControlJustReleased(0, tonumber(Config.Key)) then

                TimerCheck()
                Wait(Config.ShowTime*1000)
            end
        else
            timethread = 50000
        end
    end
end)