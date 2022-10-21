

local client = TriggerEvent
local server = TriggerServerEvent
local AEH = AddEventHandler
local RNE = RegisterNetEvent
local komanda = RegisterCommand
local callback = RegisterNUICallback
local CT = CreateThread

local Charset= {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local usalonu = false

exports['qtarget']:AddTargetModel({-941548444}, {
  options = {
    {
      event = "bSalon:otvoriSalon",
      icon = "fas fa-car",
      label = "Pristupi AutoSalonu",
    },
  },
  distance = 2.5
})

CT(function()
  local blip = AddBlipForCoord(vector3(-41.45, -1098.26, 26.42))
  SetBlipSprite(blip, 225)
  SetBlipScale(blip, 0.6)
  SetBlipColour(blip, 18)
  SetBlipDisplay(blip, 4)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Auto Salon")
  EndTextCommandSetBlipName(blip)
end)

RNE('bSalon:otvoriSalon', function()
  SetTimecycleModifier('hud_def_blur') -- blur
  SendNUIMessage({action = "open", vozila = GlobalState.Vozila, banka = LocalPlayer.state.bankaPare})
  SetNuiFocus(true, true)
  usalonu = true
end)
RegisterCommand('salon', function()
	SetTimecycleModifier('hud_def_blur') -- blur
	SendNUIMessage({action = "open", vozila = GlobalState.Vozila, banka = LocalPlayer.state.bankaPare})
	SetNuiFocus(true, true)
	usalonu = true
end)
local lastPos = 0
local lastHead = 0
local lastPlayerPos = 0
local lastPedHeading = 0
local InTestDrive = false

callback('kupiVozilo', function(data, cb)
    local dataTable = data
    ESX.TriggerServerCallback('bSalon:buyVehicle', function(hasEnoughMoney)
		  if hasEnoughMoney then
		    ESX.Game.SpawnVehicle(dataTable.model, Shared.LokacijaSpawnAuta, Shared.LokacijaSpawnAutaHeading, function (vehicle)
          SetVehicleCustomPrimaryColour(vehicle, boja_r, boja_g, boja_r)
				  TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
				  local newPlate = GeneratePlate()
				  local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
				  vehicleProps.plate = newPlate

				  SetVehicleNumberPlateText(vehicle, newPlate)
				  server('bSalon:setVehicleOwner', vehicleProps, data.slika, data.name)
        print('kupljeno')
			  end)
		else
print('nemas repa')
		end
	end, dataTable.price)
  SetNuiFocus(false, false)
  SetTimecycleModifier('default')
end)

callback("close", function(data, cb)
  SetNuiFocus(false, false)
  SetTimecycleModifier('default')
  cb("ok")
  usalonu = false
end)

AddEventHandler('onResourceStop', function()
	if (GetCurrentResourceName() ~= GetCurrentResourceName()) then
	  return
	end
	SetNuiFocus(false, false)
end)

function GeneratePlate()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(Shared.PlateLetters) .. GetRandomNumber(Shared.PlateNumbers))	
		ESX.TriggerServerCallback('bSalon:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end
	return generatedPlate
end

function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('bSalon:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end



RegisterNetEvent('esxbalkan_fulltune')
AddEventHandler('esxbalkan_fulltune', function(source)
    local vozilo = GetVehiclePedIsIn(PlayerPedId(source))
    local props = {
      windowTint      = 5,
      modArmor        = 4,
      modXenon        = true,
      fuelLevel         = 100.0,
      plate           = 'JEVTA',
      modEngine       = 4,
      modBrakes       = 4,
      modTransmission = 4,
      modSuspension   = 4,
      modTurbo        = true,
    }
    ESX.Game.SetVehicleProperties(vozilo, props)
end)