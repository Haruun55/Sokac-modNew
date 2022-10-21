ESX = nil

local searched = {3423423424}
local canSearch = true
local dumpsters = {1437508529} -- Hash objekta
local searchTime = 14000 -- Duzina pretrazivanja 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

exports['qtarget']:AddTargetModel({1437508529}, {
    options = {
        {
            event = "pretrazismece",
            icon = "fas fa-archive", -- <i class="fas fa-archive"></i> -- ako zelite da promjenite ikonicu -- https://fontawesome.com/v5.15/icons?d=gallery&p=1
            label = "Pretrazi smece",
        },
    },
    distance = 1.5
})

RegisterNetEvent('pretrazismece')
AddEventHandler('pretrazismece', function()
        if canSearch then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dumpsterFound = false

            for i = 1, #dumpsters do
                local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
                local dumpPos = GetEntityCoords(dumpster)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)


                        for i = 1, #searched do
                            if searched[i] == dumpster then
                                dumpsterFound = true
                            end
                            if i == #searched and dumpsterFound then
                                exports['okokNotify']:Alert("SICILIA", "Vec si pretrazio!", 2500, 'info')
                            elseif i == #searched and not dumpsterFound then
                                exports['okokNotify']:Alert("SICILIA", "Pocinjes pretrazivati!", 2500, 'info')
                                startSearching(searchTime, 'amb@prop_human_bum_bin@base', 'base', 'onyx:giveDumpsterReward')
                                TriggerServerEvent('onyx:startDumpsterTimer', dumpster)
                                table.insert(searched, dumpster)
                            end
                        end
            end
        end
end)
--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if canSearch then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local dumpsterFound = false

            for i = 1, #dumpsters do
                local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
                local dumpPos = GetEntityCoords(dumpster)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)

                if dist < 1.8 then
                    DrawText3Ds(dumpPos.x, dumpPos.y, dumpPos.z + 1.0, 'Press [~y~H~w~] to dumpster dive')
                    if IsControlJustReleased(0, 74) then
                        for i = 1, #searched do
                            if searched[i] == dumpster then
                                dumpsterFound = true
                            end
                            if i == #searched and dumpsterFound then
                                exports['mythic_notify']:DoHudText('error', 'This dumpster has already been searched')
                            elseif i == #searched and not dumpsterFound then
                                exports['mythic_notify']:DoHudText('inform', 'You begin to search the dumpster')
                                startSearching(searchTime, 'amb@prop_human_bum_bin@base', 'base', 'onyx:giveDumpsterReward')
                                TriggerServerEvent('onyx:startDumpsterTimer', dumpster)
                                table.insert(searched, dumpster)
                            end
                        end
                    end
                end
            end
        end
    end
end)
]]--
RegisterNetEvent('onyx:removeDumpster')
AddEventHandler('onyx:removeDumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

-- Funkcije

function startSearching(time, dict, anim, cb)
FreezeEntityPosition(PlayerPedId(), true)
    local animDict = dict
    local animation = anim
    local ped = PlayerPedId()

    canSearch = false

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    exports['progressBars']:startUI(time, "Pretrazujes..")
    TaskPlayAnim(ped, animDict, animation, 8.0, 8.0, time, 1, 1, 0, 0, 0)

    local ped = PlayerPedId()

	Citizen.Wait(time)
	FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(ped)
    canSearch = true
    TriggerServerEvent(cb)
end

