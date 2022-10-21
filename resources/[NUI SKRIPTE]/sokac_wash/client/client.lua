ESX = nil
local washing = false
local inMenu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.CarWash)
    SetBlipSprite(blip, Config.Blip.ID)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.Blip.Size)
    SetBlipColour(blip, Config.Blip.Colour)
    SetBlipAsShortRange(blip, true)
    SetBlipHighDetail(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.Display)
    EndTextCommandSetBlipName(blip)
end)

-- FUNCTIONS
function washVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    TriggerServerEvent('iCarWash:removeMoney', Config.WashPrice)
    SetVehicleDirtLevel(vehicle, 0)
ESX.ShowNotification('Oprali ste vozilo')
end

-- NUI CALLBACKS AND STUFF
function showUI()
    SetNuiFocus(true, true)

    SendNUIMessage({
        type = "show",
        status = true,
    })

    ESX.TriggerServerCallback("iCarWash:getOwner", function(owner)
        if owner then
            SendNUIMessage({
                type = "showowner",
                status = true,
            })
        else
            if Config.OwnerCategoryEveryone then
                SendNUIMessage({
                    type = "showowner",
                    status = true,
                })
            end
        end
    end)

    SendNUIMessage({action = 'businesscash', value = Config.WashPrice})

    ESX.TriggerServerCallback("iCarWash:getBusinessMoney", function(businessmoney)
        SendNUIMessage({action = 'businessmoney', value = businessmoney})
    end)

    ESX.TriggerServerCallback("iCarWash:getOwnername", function(owner)
        SendNUIMessage({action = 'ownername', value = owner})
    end)

    inMenu = true
end

function closeUI()
    SetNuiFocus(false, false)

    SendNUIMessage({
        type = "show",
        status = false,
    })

    inMenu = false
end

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)

    inMenu = false
end)
Citizen.CreateThread(function()

    local pranjeauta= {
        `u_m_y_baygor`,
    }
    exports['qtarget']:AddTargetModel(pranjeauta, {
        options = {
            {
                event = "pranjeauta-bog",
                icon = "fas fa-car",
                label = "Car wash",
            },
        },
        job = {"all"},
        distance = 5.0
    })
    end)

    RegisterNetEvent("pranjeauta-bog")
    AddEventHandler("pranjeauta-bog", function()
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            showUI()
        else
            ESX.ShowNotification('Nisi u vozilu')
        end
    end)
RegisterNUICallback("wash", function(data)
    closeUI()
    ESX.TriggerServerCallback('iCarWash:getMoney', function(cash)
        if cash >= Config.WashPrice then
            washing = true
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            UseParticleFxAssetNextCall("core")
	        particles = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", pedCoords.x, pedCoords.y, pedCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	        UseParticleFxAssetNextCall("core")
	        particles2 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", pedCoords.x + 2, pedCoords.y, pedCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Wait(2000)    
            washVehicle()
                StopParticleFxLooped(particles, 0)
                StopParticleFxLooped(particles2, 0)
                washing = false
           
        else

        end
    end)
end)

RegisterNUICallback("ownermenu", function(data)
    closeUI()
    ESX.TriggerServerCallback('iCarWash:getOwner', function(isOwner)
        if isOwner then
            local input = lib.inputDialog('Withdraw Business Money', {'Amount'})

            if input then
                local amount = tonumber(input[1])

                TriggerServerEvent('iCarWash:addMoney', amount)
            end
        else
     
        end
    end)
end)