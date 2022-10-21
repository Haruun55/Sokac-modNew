

ESX = nil
Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
	exports.spawnmanager:setAutoSpawn(false)
end)


local AdminMeniOtvoren = false
local UItajmer = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            TriggerServerEvent("bAdmin:playerLoaded")
			TriggerServerEvent('phone:loadPhone')
            return
        end
    end
end)

RegisterClientCallback('bAdmin:isInVeh', function()

	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)

	if veh ~= 0 then
		veh = NetworkGetNetworkIdFromEntity(veh)
	else
		veh = false
	end
    return veh -- return any
end)

RegisterNetEvent("bAdmin:tpm", function()

	local blipnajebenojmapi = GetFirstBlipInfoId(8)
	if DoesBlipExist(blipnajebenojmapi) then
		local igrac = PlayerPedId()
		local teleportianientity = igrac
		if IsPedInAnyVehicle(igrac, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(igrac, false), -1) == igrac then
		  teleportianientity = GetVehiclePedIsIn(igrac, false)
		end
		NetworkFadeOutEntity(teleportianientity, true, false)
		local kordinate = GetBlipInfoIdCoord(blipnajebenojmapi)
		local jelipronadjenpod, kodrinateZ = false, 0
		local provjerisvevisine = {0.0, 50.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0,450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}
		local headingodigraca = GetEntityHeading(teleportianientity)
		--for _,visina in ipairs(provjerisvevisine) do
		for _,visina in pairs(provjerisvevisine) do -- brze :)
			--ESX.Game.Teleport(teleportianientity, {x = kordinate.x, y = kordinate.y, z = visina})
			ESX.Game.Teleport(teleportianientity, {
				  x = kordinate.x,
				  y = kordinate.y,
				  z = visina,
				  heading = headingodigraca
				}, function()
			  end, true) --
			local foundGround, z = GetGroundZFor_3dCoord(kordinate.x, kordinate.y, visina)
			if foundGround then
				kodrinateZ = z + 3.01
				jelipronadjenpod = true
				break
			end
		end
		if jelipronadjenpod then
			--ESX.Game.Teleport(teleportianientity, {x = kordinate.x, y = kordinate.y, z = kodrinateZ})
			ESX.Game.Teleport(teleportianientity, {
				  x = kordinate.x,
				  y = kordinate.y,
				  z = kodrinateZ,
				  heading = headingodigraca
				}, function()
			  end, true) --
			NetworkFadeInEntity(teleportianientity, true)
		--	print('dosla baba na marker')
		else
		 --  print('nema poda te portam na prvu pronadjenu zemlju')
		   RemoveBlip(blipnajebenojmapi)
			local retval, vannjskapozicija = GetNthClosestVehicleNode(kordinate.x, kordinate.y, kodrinateZ, 0, 0, 0, 0)
			--ESX.Game.Teleport(teleportianientity, {x = vannjskapozicija.x, y = vannjskapozicija.y, z = vannjskapozicija.z})
			ESX.Game.Teleport(teleportianientity, {
				  x = vannjskapozicija.x,
				  y = vannjskapozicija.y,
				  z = vannjskapozicija.z,
				  heading = headingodigraca
				}, function()
			  end, true) --
			NetworkFadeInEntity(teleportianientity, true)
		end
	else
		print('postavi marker na mapu')	
	 end 
end)
RegisterClientCallback("bAdmin:doesVehExist", function(auto)
	if IsModelInCdimage(auto) then
		return true
	else
		return false
	end
end)

RegisterNetEvent('bAdmin:fixveh',function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		NetworkRequestControlOfEntity(vehicle)
		while not NetworkHasControlOfEntity(vehicle) do Wait(10) end
		SetNetworkIdExistsOnAllMachines(VehNetId, true)
		SetEntityAsMissionEntity(vehicle, true, true)

		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)

		TriggerEvent('chat:addMessage', { templateId = 'bAdmin', args = {"Vozilo popravljeno!"} })
	else
		TriggerEvent('chat:addMessage', { templateId = 'bAdmin', args = {"^1[Sokac]^0: Nisi u vozilu!"} })
	end
end)


RegisterCommand("dajauto", function(source, args)
	
	ESX.TriggerServerCallback("badmin:ProvjeriAdmin_c", function(jel)

		if jel then
			if args[1] and args[2] and args[3] then
				vehicle = args[1]
				id = args[2]
				tablice = args[3]

				local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))

				if IsModelInCdimage(model) then
					local playerPed = PlayerPedId()
					local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						SetVehicleNumberPlateText(vehicle, tablice)

						local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
						vehicleProps.plate = tablice

						TriggerServerEvent("bAdmin:AutouBazu", vehicleProps, args[2])
					end)

					
				else
					TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Invalid vehicle model.' } })
				end

			end
		end

	end, false)

end, false)



RegisterNetEvent("bAdmin:slay", function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("bAdmin:tp", function(coords)
	local x = tonumber(coords[1]) + 0.0
	local y = tonumber(coords[2]) + 0.0
	local z = tonumber(coords[3]) + 0.0

 	SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z)
 	TriggerEvent('chat:addMessage', { templateId = 'nAdmin', args = {"Teleportovao si se na zeljene koordinate (".. x .. ", " .. y .. ", " .. z ..")!"}})
end)

local showPos = false
RegisterNetEvent("bAdmin:pozicija", function()
	showPos = not showPos
	if showPos then
		SendNUIMessage({akcija = "pozicija", akcija2 = "show"})
		local playerPed = PlayerPedId()

		while showPos do
			Wait(5)

			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)
			local kordinata = string.format("vector3(%.2f, %.2f, %.2f) h = %.2f", playerX, playerY, playerZ, playerH)
			local kordinata2 = string.format('vector4(%.2f, %.2f, %.2f, %.2f)', playerX, playerY, playerZ, playerH)

			SendNUIMessage({
				akcija = "pozicija",
				akcija2 = "update",
				coord1 = kordinata,
				coord2 = kordinata2
			})

			if IsControlPressed(0, 131) and IsControlJustReleased(0, 26) then
				SendNUIMessage({akcija = "pozicija", akcija2 = "copy2"})
			elseif IsControlJustPressed(0, 26) then
				SendNUIMessage({akcija = "pozicija", akcija2 = "copy1"})
			end
		end
	else
		SendNUIMessage({akcija = "pozicija", akcija2 = "hide"})
	end
end)

RegisterNetEvent("bAdmin:meni:show", function()
	SendNUIMessage({akcija = "adminmeni"})
	SetNuiFocus(true, true)
end)

RegisterNUICallback("zatvori", function()
	SetNuiFocus(false, false)
	showMeni = false
end)

RegisterNUICallback("kickuj", function(data, cb)
	TriggerServerEvent("bAdmin:meni:kick", data.playerid, data.reason)
end)

RegisterNUICallback("ban", function(data, cb)
	TriggerServerEvent("bAdmin:meni:ban", tonumber(data.playerid), data.reason, tonumber(data.lenght))
end)

RegisterNUICallback("getPlayers", function(data, cb)

	local igraci = TriggerServerCallback("bAdmin:meni:fetchIgraci")

	cb({igraci = igraci})
end)

local InvisiblePlayers = {}
local DoingUpdate = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		if not DoingUpdate then
			for k,v in pairs(GlobalState["invisiblePlayers"]) do
				local igrac = GetPlayerFromServerId(tonumber(k))
				if igrac ~= 0 and igrac ~= PlayerId() then
					NetworkConcealPlayer(igrac, true, true)
				end
			end
		end
	end
end)

RegisterNetEvent("bAdmin:ForwardDeleteInvisPlayer", function(id)
	DoingUpdate = true
	if GetPlayerFromServerId(id) ~= 0 then
		NetworkConcealPlayer(GetPlayerFromServerId(id), false, false)
	end
	Wait(500)
	DoingUpdate = false
end)

local SpectatedPlayer = 0
local SpectatedName = "N/N"
local PosBeforeSpec = nil
local RouteBeforeSpec = 0
local Spectate = false
local PauseNextSpec = false

RegisterNUICallback("spectate", function(data, cb)

	if tonumber(data.playerid) ~= GetPlayerServerId(PlayerId()) then
		spectateFun()
			NetworkSetInSpectatorMode(false, GetPlayerPed(SpectatedPlayer))
			local TargetID, myCoords = TriggerServerCallback("bAdmin:StartSpectate", tonumber(data.playerid))
			local OtherCoords = TriggerServerCallback("bAdmin:StartSpectate2", tonumber(data.playerid))
			TriggerServerEvent("bAdmin:AddToInvisible")
			ExecuteCommand("aduty")
			Wait(1000)
			if not Spectate then
				PosBeforeSpec = myCoords
			end

			SpectatedPlayer = 0

			while SpectatedPlayer == 0 or SpectatedPlayer == -1 do
				SpectatedPlayer = GetPlayerFromServerId(TargetID)
				SetEntityCoords(PlayerPedId(), OtherCoords, 0, 0, 0, 0)
			end

			SpectatedName = GetPlayerName(SpectatedPlayer)
			Spectate = true

			NetworkSetInSpectatorMode(true, GetPlayerPed(SpectatedPlayer))

			SendNUIMessage({
				action = "OpenSpecBox",
				playerName = SpectatedName
			})
	end
	local admin = GetPlayerName(PlayerId())
	TriggerServerEvent("StiflerLogovi:StartSpectateLog", SpectatedName, admin)
end)



spectateFun = function()
	SetInterval("spec", 0 , function()
	
		local LetSleep = true
		local playerPed = PlayerPedId()
		local player = PlayerId()
		local spec_ped = GetPlayerPed(SpectatedPlayer)

		if Spectate then
			LetSleep = false
			if SpectatedPlayer then
				SetEntityVisible(playerPed, false)
				SetEntityCoords(playerPed, GetEntityCoords(GetPlayerPed(SpectatedPlayer)))
				SetEntityInvincible(playerPed, true)
				SetPlayerInvincible(player, true)
				SetEntityCompletelyDisableCollision(playerPed, false, false)

				local ped_maxhealth = GetPedMaxHealth(spec_ped)
				local ped_currenthealth = GetEntityHealth(spec_ped)
				local ped_armour = GetPedArmour(spec_ped)
				local ped_maxarmour = GetPlayerMaxArmour(SpectatedPlayer)

				SendNUIMessage({
					action = "updateSpecBox",
					ped_maxhealth = ped_maxhealth,
					ped_currenthealth = ped_currenthealth,
					ped_armour = ped_armour,
					ped_maxarmour = ped_maxarmour
				})
			end

			if IsControlJustPressed(0, 38) then
				Spectate = false
				ExecuteCommand("aduty")
				NetworkSetInSpectatorMode(false, PlayerPedId())
				SetEntityCoords(PlayerPedId(), PosBeforeSpec - vector3(0.0, 0.0, 0.5), 0, 0, 0, 0)
				TriggerServerEvent("bAdmin:RemoveFromInvisible", RouteBeforeSpec)
				PosBeforeSpec, SpectatedPlayer, SpectatedName = nil, 0, nil

				SetEntityVisible(playerPed, true)
				SetEntityCompletelyDisableCollision(playerPed, true, true)
				SetEntityInvincible(playerPed, false)
				SetPlayerInvincible(player, false)
				ClearInterval("spec")
				SendNUIMessage({
					action = "CloseSpecBox"
				})
			end
		end
	end)
end

local showIDs = false

local bojeTagova = {
    ["owner"] = "204, 0, 0, 1.0",
    ["developer"] = "53, 56, 55, 1.0",
  	["admin"] = "0, 255, 0, 1.0",
  	["headadmin"] = "56, 219, 255, 1.0",
  	["drug"] = "255, 0, 255, 1.0",
    ["vodjahelpera"] = "255, 0, 255, 1.0",
}

RegisterNetEvent("bAdmin:showIDs", function()
  if not showIDs then
	exports.eleNotif:Notify({type = 'success',title = 'Notifikacija',message = 'ID Iznad glave ukljucen'})
    showIDs = true
  else
    showIDs = false
	exports.eleNotif:Notify({type = 'success',title = 'Notifikacija',message = 'ID Iznad glave iskljucen'})
  end
end)

local pokazujem = false 

CreateThread(function()
	while true do
		Wait(20)
		local pPed = PlayerPedId()
		local coord = GetEntityCoords(pPed)
		local igraci = GetActivePlayers()
		local letSleep = true

		for i = 1, #igraci do
			local coord2 = GetEntityCoords(GetPlayerPed(igraci[i]))
			local srvID = GetPlayerServerId(igraci[i])

			local playerData = Player(srvID).state
			local bojaTag = bojeTagova[playerData.aGroup]

			if not pokazuje then 
				if #(coord - coord2) < 20 and not showIDs then
					if bojeTagova[playerData.aGroup] then
						if playerData.aduty then
							letSleep = false
							draw3dNUI( " <span style = 'color:rgba(".. bojaTag .."); font-size: 1.5em;'> [ " .. playerData.aGroup .." ] </span> <br> "..GetPlayerName(igraci[i]), coord2 + vector3(0.0, 0.0, 1.1), "player-"..srvID)
						end
					end
				end
			end

			if showIDs then
				if #(coord - coord2) < 100 then
					letSleep = false
					draw3dNUI( " [ " .. srvID .." ] | "..GetPlayerName(igraci[i]), coord2 + vector3(0.0, 0.0, 1.1), "ids-"..srvID)
				end
			end 
		end
		if letSleep then
			Wait(1000)
		end
	end
end)

function draw3dNUI(text, coords, id)
	local paused = false
	if IsPauseMenuActive() then paused = true end
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
	if not paused then
		isDrawing = true
		if paused then SendNUIMessage ({action = "hide"}) else SendNUIMessage({action = "display", x = _x, y = _y, text = text, id = id}) end
		last_x, last_y, lasttext = _x, _y, text
		Citizen.Wait(0)
	end
end
---


local DelObjekt = false

RegisterNetEvent("bAdmin:delObjekt", function()
	if not DelObjekt then 
		DelObjekt = true 
		brObjekt()
	else
		DelObjekt = false
		ClearInterval('del')
	end
end)


brObjekt = function()
	SetInterval("del", 0, function()
		local isAim, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
		if IsControlJustPressed(0, 38) then
			if isAim then
				SetEntityAsMissionEntity(entity, true, true)
				NetworkRegisterEntityAsNetworked(entity)
				TriggerServerEvent("bAdmin:objektDel", NetworkGetNetworkIdFromEntity(entity))
			end
		end
	end)
end

RegisterNUICallback("TeleportTo", function(data, cb)
	TriggerServerEvent("bAdmin:TeleportTo", tonumber(data.playerid))
end)

RegisterNUICallback("Inventar", function(data, cb)
	SendNUIMessage({
		sise = "zatvarajsve"
	})
		SetNuiFocus(false, false)
	showMeni = false
	Wait(500)
	TriggerServerEvent('ratkocigan', tonumber(data.playerid))
end)

RegisterNUICallback("ToTeleport", function(data, cb)
	TriggerServerEvent("bAdmin:ToTeleport", tonumber(data.playerid))
end)

RegisterNUICallback("freeze", function(data, cb)
	TriggerServerEvent("bAdmin:freeze", tonumber(data.playerid))
end)

local jelVisible = true
RegisterNUICallback("invisible", function(data, cb)

	if jelVisible then
			TriggerServerEvent("bAdmin:AddToInvisible")
		SetEntityAlpha(PlayerPedId(), 120, false)
	else
		TriggerServerEvent("bAdmin:RemoveFromInvisible")
		SetEntityAlpha(PlayerPedId(), 255, false)
	end

	jelVisible = not jelVisible
end)

RegisterNUICallback("getOfflinePlayers", function(data, cb)
	cb(GlobalState["CachedIgraci"])
end)

RegisterNUICallback("banOffline", function(data, cb)
	TriggerServerEvent("bAdmin:meni:ban", tonumber(data.playerid), data.reason, tonumber(data.lenght))
end)

RegisterNUICallback("getBannedPlayers", function(data, cb)
	local Banovi = TriggerServerCallback("bAdmin:fetchBanned")
	cb(Banovi)
end)

RegisterNUICallback("Unbanban_igraca", function(data, cb)
	TriggerServerEvent("bAdmin:meni:unban", tonumber(data.banid))
end)



---------------- ANNOUNCE
lastfor = 10
announcestring = false
announceime = false
VecImaAnnounce = false

RegisterNetEvent('announce')
AddEventHandler('announce', function(msg, ime)
	PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)

	if VecImaAnnounce then
		VecImaAnnounce = false
	end

	Citizen.CreateThread(function()

		VecImaAnnounce = true
		local tajmer = GetCloudTimeAsInt() + lastfor
		local announceime = ime

		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
		end

		while tajmer > GetCloudTimeAsInt() and VecImaAnnounce do
				Citizen.Wait(0)

				PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
				PushScaleformMovieFunctionParameterString(announceime .. string.char(13) .." ~y~Obavjestenje")
				PushScaleformMovieFunctionParameterString(msg)
				PopScaleformMovieFunctionVoid()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end)
end)

RegisterKeyMapping("adminmenu2", "Admin meni", "keyboard", "DELETE")
RegisterCommand("adminmenu2", function()
	ExecuteCommand("adminmeni")
end)

RegisterCommand("clear", function()
	TE("chat:clear")
end)

RNE("bAdmin:DonatorskoDaj:c", function(org, model)
	local has = GetHashKey(model)

	if not IsModelInCdimage(has) then return end

	RequestModel(has)
	while not HasModelLoaded(has) do Wait(10) end

	ESX.Game.SpawnVehicle(has, GetEntityCoords(PlayerPedId()), GetEntityHeading(GetPlayerPed(playerSrc)), function(veh)
		local vehData = ESX.Game.GetVehicleProperties(veh)
		TSE("bAdmin:DonatorskoDaj", org, vehData, model)
	end)

end)
local listOpen = false
RNE("bAdmin:discordlista", function(data)
	listOpen = not listOpen

	SendNUIMessage({
		action = "discordLista",
		discordi = data,
		action2 = listOpen
	})

	SetNuiFocus(listOpen, listOpen)
end)

RegisterNUICallback("focusOff", function()
		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "discordLista",
			action2 = false
		})

		listOpen = false
end)



RegisterNetEvent("bAdmin:FlipAuto")
AddEventHandler("bAdmin:FlipAuto", function()

	local voz = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 127)

	NetworkRequestControlOfEntity(voz)
	while not NetworkHasControlOfEntity(voz) do Wait(10) end
	SetEntityAsMissionEntity(voz, true, false)
	SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(voz), true)

	SetEntityRotation(voz, 0.0, 0.0, 0.0, 0, false)

end)

