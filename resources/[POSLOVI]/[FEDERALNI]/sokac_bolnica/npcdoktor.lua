
RegisterNetEvent("doktor:brojdoktora_c")
RegisterNetEvent("doktor:jelmrtav_c")

PoslaoVecPomoc = false
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

AddEventHandler("doktor:brojdoktora_c", function(broj) 
	BrojDoktora = broj
end)

AddEventHandler("doktor:jelmrtav_c", function(bool) 
	JelMrtav = bool
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


AddEventHandler("doktor:pozoviDoktora", function()
	PoslaoVecPomoc = true

	exports.eleNotif:Notify({
		type = 'error',
		title = 'Bolnica',
		message = 'Hitna pomoc je poslana na tvoju lokaciju, izdrzi jos malo'
	})

	TriggerEvent("ZapocniBrojacDoNPC")
	PozoviDoktora()
end)


function PozoviDoktora()
	player = GetPlayerPed(-1)

	model = GetHashKey("s_m_m_doctor_01")
	ped = GetPlayerPed(-1)
	pedLocation = GetEntityCoords(ped)
	vehhash = GetHashKey("ambulance")     

	
	while not HasModelLoaded(model) and RequestModel(model) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
        RequestModel(model)
        RequestModel(vehhash)
        Citizen.Wait(0)
	end

	if DoesEntityExist(targetVeh) then
    	if DoesEntityExist(mechVeh) then
			DeleteVeh(mechVeh, mechPed)			
		end
	end 
	
	local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(pedLocation.x + 100.0, pedLocation.y + 100.0, pedLocation.z, 0, 3, 0)

	if found and HasModelLoaded(vehhash) and HasModelLoaded(vehhash) then
		ClearAreaOfVehicles(spawnPos, 5000, false, false, false, false, false);
		mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, false, true)
		SetEntityAsMissionEntity(mechVeh, true, true)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(mechVeh), true)
		SetVehicleOnGroundProperly(mechVeh)
		SetVehicleColours(mechVeh, 111, 111)
		
		mechPed = CreatePedInsideVehicle(mechVeh, 4, model, -1, true, true)
		mechBlip = AddBlipForEntity(mechVeh)
		SetBlipFlashes(mechBlip, true)  
		SetBlipColour(mechBlip, 5)
		SetBlockingOfNonTemporaryEvents(mechPed, true)
	end

	GoToTarget(pedLocation.x, pedLocation.y, pedLocation.z, mechVeh, mechPed, vehhash, pedLocation, mechBlip)

end

AddEventHandler("ZapocniBrojacDoNPC", function()
	brojac = 0

	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(1000)
			if not OsobaMrtva then 
				return
			end

			brojac = brojac + 1
			if brojac > 300 then 
				TriggerServerEvent("bBolnica:OzivljenIgrac")

				exports.eleNotif:Notify({
					type = 'error',
					title = 'Bolnica',
					message = 'Mnogo ti je bolje sad, naplaceno ti je ' .. 1500 .. ' $ sa bankovnog racuna'
				})

				TriggerServerEvent("doktor:naplata")
				DeleteVeh(mechVeh, mechPed)	
				TriggerEvent('esx:onPlayerSpawn')
				PoslaoVecPomoc = false
				enroute = false
				distanceToTarget = nil
				OsobaMrtva = false
				return
			end
		end
	end)

	Citizen.CreateThread(function()
		while OsobaMrtva do
			Citizen.Wait(5)
			if OsobaMrtva and brojac then
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.4)
				SetTextColour(255, 128, 128, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString("Vrijeme do auto-ozivljavanja: ".. 300 - brojac .."s")
				DrawText(0.020, 0.720)
			end
		end 
	end)
end)


function DeleteVeh(Veh, Ped)
	DeleteEntity(Veh) DeleteVehicle(Veh)
	DeleteEntity(Ped) DeleteVehicle(Ped)
	RemoveBlip(mechBlip)
end


function GoToTarget(x, y, z, vehicle, driver, vehhash, target, mechBlip)

	TaskVehicleDriveToCoordLongrange(driver, vehicle, x, y, z, 80.0, 2883621, 1)
	SetVehicleSiren(vehicle,true)
	enroute = true
	local ProsaoJednom = false

	while enroute do
		Citizen.Wait(500)
        distanceToTarget = GetDistanceBetweenCoords(target, GetEntityCoords(vehicle).x + 5, GetEntityCoords(vehicle).y + 5, GetEntityCoords(vehicle).z, true)
		if distanceToTarget < 25 then
			SetPedCanBeTargetted(driver, false)
			SetEntityInvincible(driver,true)
			TaskVehicleTempAction(driver, vehicle, 27, 6000)
			SetVehicleUndriveable(vehicle, true)
			GoToTargetWalking(target, vehicle, driver, mechBlip)
		end
    end
end

function GoToTargetWalking(target, vehicle, driver, mechBlip)
    while enroute do
		Citizen.Wait(500)
		TaskSetBlockingOfNonTemporaryEvents(driver, true)
        engine = target
        TaskGoToCoordAnyMeans(driver, engine, 2.0, 0, 0, 786603, 0xbf800000)
        distanceToTarget = GetDistanceBetweenCoords(engine, GetEntityCoords(driver).x, GetEntityCoords(driver).y, GetEntityCoords(driver).z, true)
        norunrange = false 
        if distanceToTarget <= 10 and not norunrange then
            TaskGoToCoordAnyMeans(driver, engine, 1.0, 0, 0, 786603, 0xbf800000)
            norunrange = true
        end
		if distanceToTarget <= 3 then
			SetBlockingOfNonTemporaryEvents(driver, true)
			enroute = false
			SetPedCanBeTargetted(driver, false)
			SetEntityInvincible(driver,true)
            SetVehicleUndriveable(mechVeh, true)
            TaskTurnPedToFaceCoord(driver, target, 5000)
            Citizen.Wait(1000)
            TaskStartScenarioInPlace(driver, "PROP_HUMAN_BUM_BIN", 0, 1)
			Citizen.Wait(10000)
			TaskEnterVehicle(driver, vehicle, 10000, -1, 2.0, 1, 0)
			Wait(2000)
			SetVehicleUndriveable(mechVeh, false)
			TaskVehicleDriveWander(driver, vehicle, 80.0, 786603)
            ClearPedTasks(driver)
			TriggerServerEvent("bBolnica:OzivljenIgrac")
			enroute = false
			SetVehicleSiren(vehicle, false)
			exports.eleNotif:Notify({
				type = 'error',
				title = 'Bolnica',
				message = 'Mnogo ti je bolje sad, naplaceno ti je ' .. 1500 .. ' $ sa bankovnog racuna'
			})
			TriggerEvent('esx:onPlayerSpawn')
			TriggerServerEvent("doktor:naplata")
			Wait(15000)
			DeleteEntity(vehicle)
			DeleteEntity(driver)
			PoslaoVecPomoc = false
			OsobaMrtva = false
        end
        
    end
end


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(2)

		if enroute and distanceToTarget ~= nil then
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.3)
			SetTextColour(128, 128, 128, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Hitna je udaljena " .. string.format("%.2f", distanceToTarget) .. "m od tebe")
			DrawText(0.020, 0.750)
		else
			Wait(1000)
		end

	end
end)