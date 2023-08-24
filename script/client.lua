-- SNR STORE | https://discord.gg/TtHFpf3enK
local QBCore = nil
local ESX = nil
local suankimoteli = nil
local pinkcagecoord = Config.MotelBlip
local beklemewaitmotel = 500

-- Create local functions for optimiation

local function DrawText3D(coord, text)
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

local function OpenMotelWardrobe()
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

local function OpenMotelInventory()
    if Config.ESXorQBorNewQB == "esx" then
        ESX.PlayerData = xPlayer
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrmotelstash_"..ESX.GetPlayerData().identifier)
        TriggerEvent("inventory:client:SetCurrentStash","snrmotelstash_"..ESX.GetPlayerData().identifier)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "snrmotelstash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "snrmotelstash_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    if Config.ESXorQBorNewQB == "esx" then return end
    suankimoteli = math.random(1, #Config.PinkCage)
    QBCore.Functions.Notify(locale.Newmotel ..suankimoteli, "success", 2500)

    exports["qb-target"]:AddBoxZone("Sandıks", vector3(Config.PinkCage[suankimoteli].stash),2,2,
        {
            name = "snrmotel",
            heading = Config.PinkCage[suankimoteli].h,
            debugPoly = false,
            minZ = 18.669,
            maxZ = 999.87834
        },{
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

    exports["qb-target"]:AddBoxZone("Gardorps",vector3(Config.PinkCage[suankimoteli].clothe),2,2,
        {
            name = "snrmotel",
            heading = Config.PinkCage[suankimoteli].h,
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
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    if Config.ESXorQBorNewQB == "qb" or Config.ESXorQBorNewQB == "newqb" then return end
    suankimoteli = math.random(1, #Config.PinkCage)
    TriggerEvent('notification', locale.Newmotel ..suankimoteli, 1)
end)

-- Threads

CreateThread(function()
    if Config.ESXorQBorNewQB == "esx" then
        CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Wait(0)
            end
            ESX.PlayerData = ESX.GetPlayerData()
        end)
    elseif Config.ESXorQBorNewQB == "qb" then
        CreateThread(function()
        while QBCore == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Wait(30) -- Saniye Bekletme
        end
        end)
    elseif Config.ESXorQBorNewQB == "newqb" then
        QBCore = exports['qb-core']:GetCoreObject()
    else
        CreateThread(function()
            while true do
                Wait(500)
                TriggerServerEvent("snr:motel:print", locale.uyari)
            end
        end)
    end
end)

CreateThread(function()
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

CreateThread(function()
    while true do
        Wait(beklemewaitmotel)
        if suankimoteli ~= nil then
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local stashdistance = #(playercoords - Config.PinkCage[suankimoteli].stash)
            local clothedistance = #(playercoords - Config.PinkCage[suankimoteli].clothe)
            local doordistance = #(playercoords - Config.PinkCage[suankimoteli].doortext)
            local moteldistance = #(playercoords - pinkcagecoord)

            if moteldistance <= 45.0 then
                beklemewaitmotel = 1
                if doordistance <= 30.0 then
                    DrawMarker(2, Config.PinkCage[suankimoteli].doortext.x, Config.PinkCage[suankimoteli].doortext.y, Config.PinkCage[suankimoteli].doortext.z - 0.3, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                end
                if stashdistance <= 1.5 then
                    if Config.Target == true then
                        if Config.ESXorQBorNewQB == "esx" then
                            DrawText3D(Config.PinkCage[suankimoteli].stash, locale.sandik)
                            if IsControlJustReleased(0, 38) then
                                OpenMotelInventory()
                            end
                        end
                    else
                        DrawText3D(Config.PinkCage[suankimoteli].stash, locale.sandik)
                        if IsControlJustReleased(0, 38) then
                            OpenMotelInventory()
                        end
                    end
                end
                if clothedistance <= 1.5 then
                    if Config.Target == true then
                        if Config.ESXorQBorNewQB == "esx" then
                            DrawText3D(Config.PinkCage[suankimoteli].clothe, locale.gardrop)
                            if IsControlJustReleased(0, 38) then
                                OpenMotelWardrobe()
                            end
                        end
                    else
                        DrawText3D(Config.PinkCage[suankimoteli].clothe, locale.gardrop)
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