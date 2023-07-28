-- SNR STORE | https://discord.gg/TtHFpf3enK
local QBCore = nil
local ESX = nil
    
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if Config.ESXorQBorNewQB == "esx" then
            ESX = nil
            Citizen.CreateThread(function()
                while ESX == nil do
                    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                    Citizen.Wait(0)
                end
                ESX.PlayerData = ESX.GetPlayerData()
            end)

        elseif Config.ESXorQBorNewQB == "qb" then
            QBCore = nil
            Citizen.CreateThread(function()
            while QBCore == nil do
                TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
                Citizen.Wait(30) -- Saniye Bekletme
            end
            end)
        elseif Config.ESXorQBorNewQB == "newqb" then
            QBCore = exports['qb-core']:GetCoreObject()
        else
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(500)
                    TriggerServerEvent("snr:motel:print", locale.uyari)
                end
            end)
        end
    end
end)

local suankimoteli = nil
local pinkcagecoord = Config.MotelBlip
local pinkcage = {
    [1] = {door = vector3(307.57, -213.29, 54.22), h = 68.9096, doortext = vector3(307.318, -213.26, 54.2199), stash = vector3(306.71, -208.50, 54.22), obj = nil, clothe = vector3(302.58, -207.35, 54.22), locked = true},
    [2] = {door = vector3(311.36, -203.46, 54.22), h = 68.9096, doortext = vector3(311.108, -203.39, 54.2199), stash = vector3(310.51, -198.61, 54.22), obj = nil, clothe = vector3(306.32, -197.45, 54.22), locked = true},
    [3] = {door = vector3(315.79, -194.79, 54.22), h = 338.946, doortext = vector3(315.829, -194.65, 54.2267), stash = vector3(320.45, -194.13, 54.22), obj = nil, clothe = vector3(321.79, -189.81, 54.22), locked = true},
    [4] = {door = vector3(315.84, -219.66, 58.02), h = 158.946, doortext = vector3(314.827, -219.78, 58.0220), stash = vector3(310.17, -220.36, 58.02), obj = nil, clothe = vector3(308.85, -224.63, 58.02), locked = true},
    [5] = {door = vector3(307.35, -213.24, 58.02), h = 68.9096, doortext = vector3(307.322, -213.25, 58.0151), stash = vector3(306.78, -208.53, 58.02), obj = nil, clothe = vector3(302.52, -207.23, 58.02), locked = true},
    [6] = {door = vector3(311.22, -203.35, 58.02), h = 68.9096, doortext = vector3(311.107, -203.40, 58.0151), stash = vector3(310.64, -198.74, 58.02), obj = nil, clothe = vector3(306.33, -197.41, 58.02), locked = true},
    [7] = {door = vector3(315.78, -194.62, 58.02), h = 338.946, doortext = vector3(315.817, -194.64, 58.0151), stash = vector3(320.51, -194.11, 58.02), obj = nil, clothe = vector3(321.73, -189.70, 58.02), locked = true},
    [8] = {door = vector3(339.20, -219.47, 54.22), h = 248.909, doortext = vector3(339.316, -219.52, 54.2199), stash = vector3(339.93, -224.19, 54.22), obj = nil, clothe = vector3(344.24, -225.47, 54.22), locked = true},
    [9] = {door = vector3(342.93, -209.50, 54.22), h = 248.909, doortext = vector3(343.130, -209.61, 54.2199), stash = vector3(343.61, -214.35, 54.22), obj = nil, clothe = vector3(348.01, -215.56, 54.22), locked = true},
    [10]= {door = vector3(346.78, -199.66, 54.22), h = 248.909, doortext = vector3(346.927, -199.74, 54.2199), stash = vector3(347.34, -204.44, 54.22), obj = nil, clothe = vector3(351.86, -205.67, 54.22), locked = true},
    [11]= {door = vector3(335.00, -227.38, 58.02), h = 158.946, doortext = vector3(334.916, -227.47, 58.0150), stash = vector3(330.27, -228.04, 58.02), obj = nil, clothe = vector3(328.99, -232.40, 58.02), locked = true},
    [12]= {door = vector3(339.27, -219.49, 58.02), h = 248.909, doortext = vector3(339.301, -219.53, 58.0150), stash = vector3(339.85, -224.16, 58.02), obj = nil, clothe = vector3(344.21, -225.51, 58.02), locked = true},
    [13]= {door = vector3(343.08, -209.54, 58.02), h = 248.909, doortext = vector3(343.094, -209.64, 58.0150), stash = vector3(343.63, -214.27, 58.02), obj = nil, clothe = vector3(347.95, -215.52, 58.02), locked = true},
    [14]= {door = vector3(346.69, -199.66, 58.02), h = 248.909, doortext = vector3(346.924, -199.73, 58.0150), stash = vector3(347.49, -204.41, 58.02), obj = nil, clothe = vector3(351.77, -205.64, 58.02), locked = true},
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    if Config.ESXorQBorNewQB == "esx" then
	return
    else
        suankimoteli = math.random(1, #pinkcage)
        QBCore.Functions.Notify(locale.Newmotel ..suankimoteli, "success", 2500)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    if Config.ESXorQBorNewQB == "qb" or Config.ESXorQBorNewQB == "newqb" then
	return
    else
        suankimoteli = math.random(1, #pinkcage)
        TriggerEvent('notification', locale.Newmotel ..suankimoteli, 1)
    end
end)

Citizen.CreateThread(function()
    local gblip = AddBlipForCoord(pinkcagecoord)
    SetBlipSprite(gblip, 475)
    SetBlipDisplay(gblip, 4)
    SetBlipScale (gblip, 0.7)
    SetBlipColour(gblip, 4)
    SetBlipAsShortRange(gblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.MotelBlipIsim)
    EndTextCommandSetBlipName(gblip)
end)

local stashCoord = vector3(-1231.6, 3878.42, 154.114)
local clotheCoord = vector3(-1236.0, 3880.17, 154.114)
local beklemewaitmotel = 500

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(beklemewaitmotel)
        if suankimoteli ~= nil then
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local stashdistance = #(playercoords - pinkcage[suankimoteli].stash)
            local clothedistance = #(playercoords - pinkcage[suankimoteli].clothe)
            local doordistance = #(playercoords - pinkcage[suankimoteli].doortext)
            local moteldistance = #(playercoords - pinkcagecoord)

            if moteldistance <= 45.0 then
                beklemewaitmotel = 1
                if doordistance <= 30.0 then
                    DrawMarker(2, pinkcage[suankimoteli].doortext.x, pinkcage[suankimoteli].doortext.y, pinkcage[suankimoteli].doortext.z - 0.3, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                end
                if stashdistance <= 1.5 then
                    if Config.Target == true then
                        if Config.ESXorQBorNewQB == "esx" then
                            DrawText3D(pinkcage[suankimoteli].stash, locale.sandik)
                            if IsControlJustReleased(0, 38) then
                                OpenMotelInventory()
                            end
                        else
                            exports["qb-target"]:AddBoxZone(
                                "Sandıks",
                                vector3(pinkcage[suankimoteli].stash),
                                2,
                                2,
                                {
                                    name = "snrmotel",
                                    heading = pinkcage[suankimoteli].h,
                                    debugPoly = false,
                                    minZ = 18.669,
                                    maxZ = 999.87834
                                },
                                {
                                    options = {
                                        {
                                            type = "Client",
                                            event = "snr:motelstash",
                                            icon = "fas fa-circle",
                                            label = locale.targetsandik
                                        }
                                    },
                                    distance = 1.5
                                }
                            )
                        end
                    else
                        DrawText3D(pinkcage[suankimoteli].stash, locale.sandik)
                        if IsControlJustReleased(0, 38) then
                            OpenMotelInventory()
                        end
                    end
                end
                if clothedistance <= 1.5 then
                    if Config.Target == true then
                        if Config.ESXorQBorNewQB == "esx" then
                            DrawText3D(pinkcage[suankimoteli].clothe, locale.gardrop)
                            if IsControlJustReleased(0, 38) then
                                OpenMotelWardrobe()
                            end
                        else
                            exports["qb-target"]:AddBoxZone(
                                "Gardorps",
                                vector3(pinkcage[suankimoteli].clothe),
                                2,
                                2,
                                {
                                    name = "snrmotel",
                                    heading = pinkcage[suankimoteli].h,
                                    debugPoly = false,
                                    minZ = 18.669,
                                    maxZ = 999.87834
                                },
                                {
                                    options = {
                                        {
                                            type = "Client",
                                            event = "snr:gardirop",
                                            icon = "fas fa-circle",
                                            label = locale.targetgardrop
                                        }
                                    },
                                    distance = 1.5
                                }
                            )
                        end
                    else
                        DrawText3D(pinkcage[suankimoteli].clothe, locale.gardrop)
                        if IsControlJustReleased(0, 38) then
                            OpenMotelWardrobe()
                        end
                    end
                end
            else
                beklemewaitmotel = 2500
            end
        end
    end
end)

RegisterNetEvent("snr:gardirop")
AddEventHandler("snr:gardirop", function()
    if Config.ESXorQBorNewQB == "esx" then
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',{
            title    = 'Gardrop',
            align    = 'right',
            elements = {
                {label = 'Kıyafetler', value = 'player_dressing'},
                {label = 'Kıyafet Sil', value = 'remove_cloth'}
            }
        }, function(data, menu)
    
            if data.current.value == 'player_dressing' then 
                menu.close()
                ESX.TriggerServerCallback('motel:server:getPlayerDressing', function(dressing)
                    elements = {}
    
                    for i=1, #dressing, 1 do
                        table.insert(elements, {
                            label = dressing[i],
                            value = i
                        })
                    end
    
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
                    {
                        title    = 'Kıyafetler',
                        align    = 'right',
                        elements = elements
                    }, function(data2, menu2)
    
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            ESX.TriggerServerCallback('motel:server:getPlayerOutfit', function(clothes)
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                TriggerEvent('esx_skin:setLastSkin', skin)
    
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerServerEvent('esx_skin:save', skin)
                                end)
                            end, data2.current.value)
                        end)
    
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                end)
    
            elseif data.current.value == 'remove_cloth' then
                menu.close()
                ESX.TriggerServerCallback('motel:server:getPlayerDressing', function(dressing)
                    elements = {}
    
                    for i=1, #dressing, 1 do
                        table.insert(elements, {
                            label = dressing[i],
                            value = i
                        })
                    end
    
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
                        title    = 'Kıyafet Sil',
                        align    = 'right',
                        elements = elements
                    }, function(data2, menu2)
                        menu2.close()
                        TriggerServerEvent('motel:server:removeOutfit', data2.current.value)
                        TriggerEvent('notification', 'Kıyafet silindi', 1)
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                end)
            end
        end, function(data, menu)
            menu.close()
        end)
    else
        TriggerEvent('qb-clothing:client:openOutfitMenu')
    end
end)

RegisterNetEvent("snr:motelstash")
AddEventHandler("snr:motelstash", function()
    if Config.ESXorQBorNewQB == "esx" then
        ESX.PlayerData = xPlayer
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrmotelstash_"..ESX.GetPlayerData().identifier)
        TriggerEvent("inventory:client:SetCurrentStash","snrmotelstash_"..ESX.GetPlayerData().identifier)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrmotelstash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "snrmotelstash_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end)

function OpenMotelInventory()
    if Config.ESXorQBorNewQB == "esx" then
        ESX.PlayerData = xPlayer
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrmotelstash_"..ESX.GetPlayerData().identifier)
        TriggerEvent("inventory:client:SetCurrentStash","snrmotelstash_"..ESX.GetPlayerData().identifier)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrmotelstash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "snrmotelstash_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end

function OpenMotelWardrobe()
    if Config.ESXorQBorNewQB == "esx" then
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',{
            title    = 'Gardrop',
            align    = 'right',
            elements = {
                {label = 'Kıyafetler', value = 'player_dressing'},
                {label = 'Kıyafet Sil', value = 'remove_cloth'}
            }
        }, function(data, menu)
    
            if data.current.value == 'player_dressing' then 
                menu.close()
                ESX.TriggerServerCallback('motel:server:getPlayerDressing', function(dressing)
                    elements = {}
    
                    for i=1, #dressing, 1 do
                        table.insert(elements, {
                            label = dressing[i],
                            value = i
                        })
                    end
    
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
                    {
                        title    = 'Kıyafetler',
                        align    = 'right',
                        elements = elements
                    }, function(data2, menu2)
    
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            ESX.TriggerServerCallback('motel:server:getPlayerOutfit', function(clothes)
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                TriggerEvent('esx_skin:setLastSkin', skin)
    
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerServerEvent('esx_skin:save', skin)
                                end)
                            end, data2.current.value)
                        end)
    
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                end)
    
            elseif data.current.value == 'remove_cloth' then
                menu.close()
                ESX.TriggerServerCallback('motel:server:getPlayerDressing', function(dressing)
                    elements = {}
    
                    for i=1, #dressing, 1 do
                        table.insert(elements, {
                            label = dressing[i],
                            value = i
                        })
                    end
    
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
                        title    = 'Kıyafet Sil',
                        align    = 'right',
                        elements = elements
                    }, function(data2, menu2)
                        menu2.close()
                        TriggerServerEvent('motel:server:removeOutfit', data2.current.value)
                        TriggerEvent('notification', 'Kıyafet silindi', 1)
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                end)
            end
        end, function(data, menu)
            menu.close()
        end)
    else
        TriggerEvent('qb-clothing:client:openOutfitMenu')
    end
end

function DrawText3D(coord, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coord.x, coord.y, coord.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
	end
end
