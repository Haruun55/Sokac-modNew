 local isInVehicle = false
local isEnteringVehicle = false
local currentVehicle = 0
local currentSeat = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		local ped = PlayerPedId()
		local TryingEnter = GetVehiclePedIsTryingToEnter(ped)
		local JelUVoz = IsPedInAnyVehicle(ped, true)
		local lastSleep = true
		

		if not isInVehicle then
			lastSleep = false
			if TryingEnter ~= 0 and not isEnteringVehicle then
				-- trying to enter a vehicle!
				local vehicle = TryingEnter
				local seat = GetSeatPedIsTryingToEnter(ped)
				local netId = VehToNet(vehicle)
				isEnteringVehicle = true
				TriggerServerEvent('baseevents:enteringVehicle', vehicle, seat, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), netId)
				TriggerEvent('baseevents:enteringVehicle', vehicle, seat, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), netId)
			elseif TryingEnter == 0 and not JelUVoz and isEnteringVehicle then
				-- vehicle entering aborted
				TriggerServerEvent('baseevents:enteringAborted')
				isEnteringVehicle = false
			elseif JelUVoz then
				-- suddenly appeared in a vehicle, possible teleport
				isEnteringVehicle = false
				isInVehicle = true
				currentVehicle = GetVehiclePedIsUsing(ped)
				currentSeat = GetSeatPedIsTryingToEnter(ped)
				RunningExitTask = false
				local model = GetEntityModel(currentVehicle)
				local name = GetDisplayNameFromVehicleModel()
				local netId = VehToNet(currentVehicle)
				TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
				TriggerEvent("baseevents:enteredVehicle", currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
			end
			if lastSleep then 
				Wait(1000)
			end
		elseif isInVehicle then
			if not JelUVoz or IsPlayerDead(PlayerId()) then
				lastSleep = false
				-- bye, vehicle
				local model = GetEntityModel(currentVehicle)
				local name = GetDisplayNameFromVehicleModel()
				local netId = VehToNet(currentVehicle)
				TriggerServerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
				TriggerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
				isInVehicle = false
				currentVehicle = 0
				currentSeat = 0
				RunningExitTask = false
			end
			if lastSleep then 
				Wait(1000)
			end
		end
		if lastSleep then 
			Wait(1000)
		end

		if not RunningExitTask then
			lastSleep = false
			if GetIsTaskActive(ped, 167) then
				RunningExitTask = true
				TriggerEvent('baseevents:LeavingVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
			end
		end
		if lastSleep then 
			Wait(1000)
		end
	end
end)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end