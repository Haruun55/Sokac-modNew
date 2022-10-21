ESX = nil
Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX == nil do Citizen.Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(10) end

    PlayerData = ESX.GetPlayerData()

end)
local PlayerLoaded = false

AddEventHandler('playerSpawned', function()

  if not PlayerLoaded then
    TriggerEvent("ucitaj:target")
  end
end)

RegisterCommand("probja", function()
  if not PlayerLoaded then

    TriggerEvent("ucitaj:target")
end

end)
AddEventHandler("society:OpenMenu", function()
	FirstMenuSetup()
end)


function FirstMenuSetup()

	local resp = TriggerServerCallback("society:fetchPerms")

	SendNUIMessage({
		action = "open",
		jobLabel = LocalPlayer.state.job.label,
		jobName =  LocalPlayer.state.job.name,
		perms = resp
	})
	SetNuiFocus(true, true)
end


RegisterNUICallback("fetchAllMembers", function(data, cb)
	local resp = TriggerServerCallback("society:fetchAllMembers")
	cb(resp)
end)

RegisterNUICallback("getRankPerms", function(data, cb)
	local resp = TriggerServerCallback("society:fetchRankPerms")
	cb(resp)
end)

RegisterNUICallback("updatePerm", function(data, cb)
	TriggerServerEvent("society:UpdatePerms", tonumber(data.rank), data.vrsta)
end)

RegisterNUICallback("getClosestPlayers", function(data, cb)

	local igraci = GetActivePlayers()
	local myPos = GetEntityCoords(PlayerPedId())
	local resp = {}

	for i = 1, #igraci do
		local pped = GetPlayerPed(tonumber(igraci[i]))

		if #(myPos - GetEntityCoords(pped)) < 15 then
			if Player(GetPlayerServerId(igraci[i])).state.job.name ~= LocalPlayer.state.job.name then
				table.insert(resp, {
					identifier = Player(GetPlayerServerId(igraci[i])).state.identifier,
					name = Player(GetPlayerServerId(igraci[i])).state.name,
					lastname = Player(GetPlayerServerId(igraci[i])).state.lastname
				})
			end
		end

	end
	cb(resp)
end)


function DrawText3D(coords, text, scale2)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)

    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    SetTextScale(0.0, scale2 * scale)
    SetTextFont(6)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextOutline()
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end



local locations = {
  ['Policijski vault'] = {  
      coords = vector3(-1099.1, -829.37, 34.28),
      minZ = 31.52,
      maxZ = 36.87,
      width = 1.4,
      length = 3.2,
      distance = 2.5,
      heading = 308, 
  }
}



AddEventHandler("ucitaj:target", function()
  SetInterval("target", 5, function()
    local playerPed = PlayerPedId()
    local playerData = LocalPlayer.state.job
    if not playerLoaded then 
      for k, v in pairs(locations) do
        playerLoaded = true
        if playerData.name then
            name = ""..k
            exports.qtarget:AddBoxZone(name, v.coords, v.width, v.length,  {
              heading=v.heading,
              debugPoly=false,
              minZ=v.minZ,
              maxZ=v.maxZ,
              }, {
                  options = {
                      {
                          event = "society:OpenMenu",
                          icon = "fas fa-toggle-on",
                          label = "Otvori "..name,
                          job = playerData.name,
                      }
                  },
                  distance = v.distance
          })
        end
      end
    elseif playerLoaded then 
      playerLoaded = false
      ClearInterval("target")
    end
  end)
end)




RegisterNUICallback("zaposliOsobu", function(data, cb)
	TriggerServerEvent("society:zaposliOsobu", data.identifier, data.grade)
end)

RegisterNUICallback("unaprijediClana", function(data, cb)
	TriggerServerEvent("society:unaprijedi", data.identifier, data.grade)
end)

RegisterNUICallback("spustiClana", function(data, cb)
	TriggerServerEvent("society:spusti", data.identifier, data.grade)
end)

RegisterNUICallback("otpustiClana", function(data, cb)
	TriggerServerEvent("society:otpustiClana", data.identifier, data.grade)
end)

RegisterNUICallback("getOrgMoney", function(data, cb)
	local money = TriggerServerCallback("society:GetOrgMoney")
	cb(money)
end)

RegisterNUICallback("fetchAllPlate", function(data, cb)
  local plate = TriggerServerCallback("borgmeni:FetchPlate")
  cb(plate)
end)

RegisterNUICallback("promijeniPlatu", function(data, cb)
  TriggerServerEvent("borgmeni:SetPlata", data)
end)

RegisterNUICallback("orgUplati", function(data, cb)
	TriggerServerEvent("society:UplatiNovac", data.vrsta, tonumber(data.kolicina))
end)

RegisterNUICallback("orgPodigni", function(data, cb)
	TriggerServerEvent("society:PodigniNovac", data.vrsta, tonumber(data.kolicina))
end)

RegisterNUICallback("zatvoriMeni", function()
	SetNuiFocus(false, false)
end)

RegisterNUICallback("refreshMeni", function()
  FirstMenuSetup()
end)

exports("fetchmoney", function()
  local money = TriggerServerCallback("society:GetOrgMoney")
  return money
end)



AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return TriggerEvent("ucitaj:target")
  end
  print('' .. resourceName .. ' Je ucitao poslove.')
  TriggerEvent("ucitaj:target")
end)

