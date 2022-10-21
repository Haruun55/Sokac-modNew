local client = TriggerClientEvent
local server = TriggerEvent
local AEH = AddEventHandler
local RNE = RegisterNetEvent
local komanda = RegisterCommand
local callback = RegisterNUICallback
local CT = CreateThread

GlobalState.Vozila = Shared.Vozila

RegisterServerEvent('bSalon:setVehicleOwner')
AddEventHandler('bSalon:setVehicleOwner', function(vehicleProps, slika, ime)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
	}, function (rowsChanged)
		client('bNotify:posalji', 'fas fa-car', 'AUTOSALON', 'Vozilo sa tablicama ' .. vehicleProps.plate .. ' sada pripada vama.')
	end)
end)

ESX.RegisterServerCallback('bSalon:buyVehicle', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('salon:napraviBucket')
AddEventHandler('salon:napraviBucket', function(entity)
	local random = math.random(1, 5000)
    SetPlayerRoutingBucket(source, random)
	local vozilo = GetVehiclePedIsIn(GetPlayerPed(source), false)
	Wait(1000)
	SetEntityRoutingBucket(vozilo, random)
end)

RegisterServerEvent('salon:resetujBucket')
AddEventHandler('salon:resetujBucket', function(data)
    SetPlayerRoutingBucket(source, 0)
end)

ESX.RegisterServerCallback('bSalon:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

function kupljenoAuto(name,message,color)
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
				["text"]= "⚠ Vehicle Shop ⚠",
		   },
		}
	}
	
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(Shared.WebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end



RegisterCommand('fulltune', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getGroup() == 'owner' or xPlayer.getGroup() == "developer" then

    print(vehicle)

    TriggerClientEvent('esxbalkan_fulltune', source)
    xPlayer.showNotification('Vozilo full tuneano!')
  else
    xPlayer.showNotification('Nemate permisiju za ovo!')
  end
end)