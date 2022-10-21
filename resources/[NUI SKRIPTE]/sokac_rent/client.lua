
local boothModel = GetHashKey("prop_tollbooth_1")
local uzeo = false

function RequestModelLoad(modelHash)
  modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

  if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
      Citizen.Wait(4)
    end
  end

  return
end


local RentaLokacije = {
  [1] = {
    object = {vector3(-715.54, -170.46, 35.80), 118.48},
    spawns = {
      {vector3(-713.46, -174.95, 35.83), 208.05},
      {vector3(-710.62, -179.74, 35.89), 209.62},
      {vector3(-706.26, -187.10, 35.86), 211.05}
    }
  },

  [2] = {
    object = {vector3(-263.11, -1028.90, 27.37), 245.07},
    spawns = {
      {vector3(-264.27, -1032.24, 28.27), 166.46},
      {vector3(-266.72, -1038.88, 27.80),159.12},
      {vector3(-269.60, -1046.35, 27.22), 159.46}
    }
  },

  [3] = {
    object = {vector3(-136.82, 6356.73, 30.49) , 135.08},
    spawns = {
      {vector3(-149.85, 6362.42, 31.49) , 221.99},
      {vector3(-152.53, 6359.65, 31.49) , 225.62},
      {vector3(-155.16, 6356.25, 31.49) , 230.47}
    }
  },

  [4] = {
    object = {vector3(1418.24, 3630.13, 33.74) , 197.00},
    spawns = {
      {vector3(1424.20, 3624.61, 34.87) , 201.24},
      {vector3(1420.32, 3623.57, 34.86) , 206.94},
      {vector3(1416.31, 3622.74, 34.86) , 198.26}
    }
  },

  [5] = {
    object = {vector3(117.49, -1087.01, 28.21) , 4.64},
    spawns = {
      {vector3(117.42, -1081.75, 29.22) , 0.36},
      {vector3(121.33, -1081.93, 29.19) , 0.85},
      {vector3(124.88, -1081.92, 29.19) , 5.01}
    }
  },
  [5] = {
    object = {vector3(-500.84, -257.03, 34.56), 201.51},
    spawns = {
      {vector3(-506.17, -259.77, 35.51), 110.41},
      {vector3(-512.07, -262.11, 35.43), 112.76},
      {vector3(-520.66, -265.75, 35.33),112.86}
    }
  },
  [6] = {
    object = {vector3(1852.67, 2591.90, 44.67), 90.5},
    spawns = {
      {vector3(1858.75, 2591.07, 45.67), 271.16},
      {vector3(1858.31, 2595.00, 45.67), 267.20},
      {vector3(1858.45, 2598.82, 45.67), 266.71}
    }
  },
}

local currentData = nil

RegisterNUICallback("close", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    TriggerScreenblurFadeOut(0)
end)

AddEventHandler("otvori_rentu", function(data)
    PlayerData = ESX.GetPlayerData()

        local pare

        for i=1, #PlayerData.accounts, 1 do
            if PlayerData.accounts[i].name == 'money' then
                pare = PlayerData.accounts[i].money
            end
        end
    
        SendNUIMessage({
            action = "open",
            pare = pare,
        })
        currentData = data.location
        print(json.encode(currentData))
        SetNuiFocus(true, true)
        TriggerScreenblurFadeIn(0)
      end)
      
AddEventHandler("onResourceStop", function(res)
  if res ~= GetCurrentResourceName() then return end

  for id, data in pairs(RentaLokacije) do
    if data.entity then
      DeleteObject(data.entity)
      exports.qtarget:RemoveZone("renta-"..id)
    end
  end
end)


local function ModelLoad(model)
  if not HasModelLoaded(model) and IsModelInCdimage(model) then
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(100)
    end
    return true
  elseif HasModelLoaded(model) then
    return true
  elseif not IsModelInCdimage(model) then
    return false
  end
end

CreateThread(function()
 while true do
 Wait(5000)
  for id, data in pairs(RentaLokacije) do
    exports.qtarget:AddBoxZone("renta-"..id, data.object[1], 3.0, 3.3, {
      name="renta-"..id,
      heading= data.object[2],
      debugPoly=false,
      minZ=data.object[1].z - 0.5,
      maxZ=data.object[1].z + 2.0,
      }, {
        options = {
          {
            event = "otvori_rentu",
            location = data,
            icon = "fas fa-car",
            label = "Rent-A-Car",
          },
        },
        distance = 3.5,
    })

    local Blip = AddBlipForCoord(data.object[1])
    SetBlipSprite (Blip, 227)
    SetBlipDisplay(Blip, 2)
    SetBlipScale  (Blip, 0.6)
    SetBlipColour (Blip, 3)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Rent-a-Car")
    EndTextCommandSetBlipName(Blip)
    SetBlipRoute(Blip)
  end
end
end)

CreateThread(function()
  while true do
 Wait(2000)
  local position = GetEntityCoords(PlayerPedId())

  for id, data in pairs(RentaLokacije) do
    if not data.entity and #(data.object[1] - position) <= 75 then
      if ModelLoad(boothModel) then
        RentaLokacije[id]["entity"] = CreateObject(boothModel, data.object[1], false, true, false)
        while not DoesEntityExist(RentaLokacije[id]["entity"]) do Wait(100) end

        SetEntityHeading(RentaLokacije[id]["entity"], data.object[2])
        FreezeEntityPosition(RentaLokacije[id]["entity"], true)
      end
    elseif data.entity and #(data.object[1] - position) > 75 then
      DeleteEntity(data.entity)
      RentaLokacije[id].entity = nil

      SetModelAsNoLongerNeeded(boothModel)
    end
  end
end
end)

RegisterNUICallback("ford", function(data, cb)

    local spawnloc = nil

    for i=1, #currentData.spawns do
      if ESX.Game.IsSpawnPointClear(currentData.spawns[i][1], 3.0) then
        spawnloc = currentData.spawns[i]
        break
      end
    end

    if not spawnloc then
      exports['okokNotify']:Alert("Nevera Roleplay", "Nema mjesta za vozilo", 5000, 'info')
      return
    end
    if uzeo then
      exports['okokNotify']:Alert("Nevera Roleplay", "Morate da sackeate 5 minuta", 5000, 'info')
return
    end

    ESX.Game.SpawnVehicle("sultan", spawnloc[1], spawnloc[2], function(vehicle)
  --[[     TriggerEvent('npclock:register', GetVehicleNumberPlateText(vehicle), true) ]]
      TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
      uzeo = true
      TriggerServerEvent('skinikesmom')
      local netid = NetworkGetNetworkIdFromEntity(vehicle) Wait(200)
      Citizen.Wait('300000')
    uzeo = false
end)
end)

RegisterNUICallback("golf", function(data, cb)

    local spawnloc = nil

    for i=1, #currentData.spawns do
      if ESX.Game.IsSpawnPointClear(currentData.spawns[i][1], 3.0) then
        spawnloc = currentData.spawns[i]
        break
      end
    end

    if not spawnloc then
      exports['okokNotify']:Alert("Nevera Roleplay", "Nema mjesta za vozilo", 5000, 'info')
      return
    end

    if uzeo then
      exports['okokNotify']:Alert("Nevera Roleplay", "Morate da sackeate 5 minuta", 5000, 'info')
return
    end

    ESX.Game.SpawnVehicle("blista", spawnloc[1], spawnloc[2], function(vehicle)
  --[[     TriggerEvent('npclock:register', GetVehicleNumberPlateText(vehicle), true) ]]
      TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
      TriggerServerEvent('skinikesmom')
      local netid = NetworkGetNetworkIdFromEntity(vehicle) Wait(200)

    end)
  end)
