Citizen.CreateThread(function()

  while not GlobalState["AC-Weps"] or not PlayerData or not PlayerData.job do
    Wait(100)
  end

  local forbLista = GlobalState["AC-Weps"]

  while true do
    Citizen.Wait(500)
    pPed = PlayerPedId()

    if LocalPlayer.state.aGroup == nil and LocalPlayer.state.aGroup == "user" then

      for i = 1, #forbLista do
          if HasPedGotWeapon(pPed, forbLista[i], false) then
              --TriggerServerEvent("bAdmin:flagged", "weapon", tostring(forbLista[i]))
              RemoveWeaponFromPed(pPed, forbLista[i])
          end
      end
      if NetworkIsInSpectatorMode() then
        TriggerServerEvent("bAdmin:flagged", "spectate")
        return
      end

    end
end
end)

RegisterNetEvent("bAdmin:car", function(model, pose, head)
RequestModel(model)
while not HasModelLoaded(model) do Wait(10) end

ESX.Game.SpawnVehicle(model, pose, head, function(veh)
  TriggerEvent('npclock:register', GetVehicleNumberPlateText(veh))
  TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
end)
end)

RegisterNetEvent("bAdmin:expNotif", function(ime, id, vrsta, broj)
if LocalPlayer.state.aGroup ~= "user" then
  TriggerEvent('chatMessage', "^1[Sokac - AC]^0: ^1EXPLOZIJA^0  - Uzrokovao: ^3("..id..")".. ime.."^0 | Vrsta Explozije: ^3"..vrsta.."^0 | [".. broj .."]!")
end
end)

Citizen.CreateThread(function()
  Wait(5000)
  local ListaPedova = GlobalState["AC-Ped"]
  while true do
      Citizen.Wait(5000)
      for k,v in pairs(ListaPedova) do
        SetPedModelIsSuppressed(k, true)
      end
  end
end)

Citizen.CreateThread(function()
  Citizen.Wait(10000)
  local ListaAuta = GlobalState["AC-Veh"]

  while true do
      Citizen.Wait(2000)

      for k,v in pairs(ListaAuta) do
        SetVehicleModelIsSuppressed(k, true)
      end
  end

end)

RegisterNUICallback('callback', function()
TriggerServerEvent('bAdmin:Browser')
end)
