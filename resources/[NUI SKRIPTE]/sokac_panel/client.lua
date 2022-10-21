

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while not ESX do Wait(100) end
   
	Citizen.Wait(3000)
	ESX.TriggerServerCallback('_plane_glavni:cb', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('panel:dodatciIgraca', 'playerSpawned')
end)

RegisterNetEvent('_panel:KonektovaniIgraci')
AddEventHandler('_panel:KonektovaniIgraci', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)


function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local jobless, ems, police,  mechanic, players = 0, 0, 0, 0, 0, 0, 0
	local sourceID = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))

	for k,v in pairs(connectedPlayers) do
		players = players + 1

		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1
		elseif v.job == 'unemployed' then
			jobless = jobless + 1
		end
	end
	
	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, mechanic = mechanic, jobless = jobless, player_count = GlobalState["BrojIgraca"]},
		data = jobName,
		data2 = rankName,
		data3 = sourceID
	})
end

RegisterNetEvent('elePanel:povuciPodatke')
AddEventHandler('elePanel:povuciPodatke', function(data)
	SendNUIMessage({
		message = 'updateMoney',
		kes = data.cash,
		banka = data.bank,
	})
end)

local nesto = false
RegisterCommand('+igraci91', function()
    SendNUIMessage({action = "open"})
	TriggerServerEvent('elePanel:povuciPodatke')
	ESX.TriggerServerCallback('_plane_glavni:cb', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
	if nesto == false then 
		ExecuteCommand("dajmuga22")
		nesto = true
	end
end, false)

RegisterCommand('-igraci91', function()
    SendNUIMessage({action = "close"})
end, false)

RegisterKeyMapping('+igraci91', 'Scoreboard', 'keyboard', 'F4')