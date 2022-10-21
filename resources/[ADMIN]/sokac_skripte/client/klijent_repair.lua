Config.InfiniteRepairs		= false -- Should one repairkit last forever?
Config.RepairTime			= 15 -- In seconds, how long should a repair take?
Config.IgnoreAbort			= true -- Remove repairkit from inventory even if user aborts repairs?
Config.AllowMecano			= false -- Allow mechanics to use this repairkit?

Locale				= 'en'

Locales  = {
	['used_kit']					= 'you used ~y~x1 ~b~Repairkit',
	['must_be_outside']				= 'you must be outside of the vehicle!',
	['no_vehicle_nearby']			= 'there is no ~r~vehicle ~w~nearby',
	['finished_repair']				= '~g~you repaired the vehicle!',
	['abort_hint']					= 'press ~INPUT_VEH_DUCK~ to cancel',
	['aborted_repair']				= 'you ~r~aborted ~w~the repairs',
}



local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX						= nil
local CurrentAction		= nil
local PlayerData		= {}
local bFunkcije = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
        
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function ImalReapirKit()

	local imalRepair = false
	local Inventory = ESX.GetPlayerData().inventory

	for i=1, #Inventory, 1 do
		if Inventory[i].name == "repairkit" then
			if Inventory[i].count > 0 then
				imalRepair = true
				break
			end
		end
	end	

	return imalRepair

end

RegisterNetEvent('esx_repairkit:onUse')
AddEventHandler('esx_repairkit:onUse', function()
	local playerPed		= PlayerPedId()
	local coords		= GetEntityCoords(playerPed)
	local BlizuAuto, BlizuDist 	= ESX.Game.GetClosestVehicle(coords)

	if BlizuDist < 5 then

		if DoesEntityExist(BlizuAuto) then

			SetEntityAsMissionEntity(BlizuAuto, true, true)
			NetworkRegisterEntityAsNetworked(BlizuAuto)

			NetworkRequestControlOfEntity(BlizuAuto)
			while not NetworkHasControlOfEntity(BlizuAuto) do Wait(10) end
			SetNetworkIdExistsOnAllMachines(BlizuAuto, true)
			SetEntityAsMissionEntity(BlizuAuto, true, true)

			local VehNetId = NetworkGetNetworkIdFromEntity(BlizuAuto)
			local haubaPos = GetOffsetFromEntityInWorldCoords(BlizuAuto, 0.0, 3.0, 0.0)

			if #(haubaPos - coords) < 3 then

				if IsPedInAnyVehicle(PlayerPedId(), false) then
					ESX.ShowNotification('Moras biti van vozila da ga popravis!')
				else
					if DoesEntityExist(BlizuAuto) then
						
						local prvo = Entity(BlizuAuto).state.fuel

						TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
						SetVehicleDoorsLockedForAllPlayers(BlizuAuto, true)
						SetVehicleDoorOpen(BlizuAuto, 4, false, false)

						TriggerEvent("bfunkcije:tajmerdosto", "Popravljanje vozila...", 15, true, function(prekinuo)
							if not prekinuo then
								local item = TriggerServerCallback("find:repair")
								print(json.encode(item))
								if item then 
									SetVehicleFixed(BlizuAuto)
									SetVehicleDeformationFixed(BlizuAuto)
									SetVehicleUndriveable(BlizuAuto, false)
									SetVehicleEngineOn(BlizuAuto, true, true)
									SetVehicleFuelLevel(BlizuAuto, ZadnjeGorivo)
									ClearPedTasksImmediately(playerPed)

									Entity(BlizuAuto).state:set("fuel", prvo,  true)
									SetVehicleFuelLevel(BlizuAuto, prvo)
									
									ESX.ShowNotification('Popravili ste vozilo')
									TriggerServerEvent('esx_repairkit:removeKit')
								else
									ESX.ShowNotification('Pokusao si popraviti vozilo bez repairkita ?...')
								end
							else
								ESX.ShowNotification('Prekinuo si popravku')
							end
							ClearPedTasksImmediately(PlayerPedId())
							SetVehicleDoorsLockedForAllPlayers(BlizuAuto, false)
							SetVehicleDoorShut(BlizuAuto, 4, false)
						end)
					end
				end
			else
				ESX.ShowNotification('Moras biti blizu prednje strane vozila!')
			end
		end

	else
		ESX.ShowNotification('Nema vozila u blizini')
	end
end)