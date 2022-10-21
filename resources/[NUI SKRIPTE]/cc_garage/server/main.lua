ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


ESX.RegisterServerCallback('cc_garage:loadVehicles', function(source, cb)
	local ownedCars = {}
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `owner` = @owner AND `stored` = 1 AND `job`="civ"', {['@owner'] = x.identifier}, function(vehicles)

		for _,v in pairs(vehicles) do
			--if v.job == nil then
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate, name = v.nickname})
			--end
		end
		cb(ownedCars)
	end)
end)

ESX.RegisterServerCallback('cc_garage:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `plate` = @plate', {['@plate'] = plate}, function(vehicle)

		
		cb(vehicle)
	end)
end)

MySQL.ready(function()

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored'] = false
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
		end
	end)
end)


ESX.RegisterServerCallback('cc_garage:isOwned', function(source, cb, plate)

	local s = source
	local x = ESX.GetPlayerFromId(s)

	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `plate` = @plate AND `owner` = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
        if vehicle[1] ~= nil then
            if vehicle[1].vehicle then
                cb(true, vehicle[1].nickname)
            else
                cb(false, vehicle[1].nickname)
            end 
        end
	end)
end)

RegisterNetEvent('cc_garage:changeState')
AddEventHandler('cc_garage:changeState', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET `stored` = @state WHERE `plate` = @plate", {['@state'] = state, ['@plate'] = plate})
end)

RegisterNetEvent('cc_garage:saveProps')
AddEventHandler('cc_garage:saveProps', function(plate, props)
    local xProps = json.encode(props)
    local vehiclemodel = props.model

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        if result[1] ~= nil then
            local originalvehprops = json.decode(result[1].vehicle)
            if originalvehprops.model == vehiclemodel then
                MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@props WHERE plate=@plate", {['@plate'] = plate, ['@props'] = xProps})
            else
                print("Jemand hat versucht sich ein Auto zu cheaten. Bann den Hurensohn weg!")
            end
        end
    end)
end)

RegisterNetEvent('cc_garage:changeName')
AddEventHandler('cc_garage:changeName', function(plate, name)
	MySQL.Sync.execute("UPDATE owned_vehicles SET `nickname` = @nickname WHERE `plate` = @plate", {['@nickname'] = name, ['@plate'] = plate})
end)

local text = [[
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


ESX = nil
local usedFrakgarage = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end

    PlayerData = ESX.GetPlayerData()
end)

local garages = {
    {vector3(100.97, -1073.49, 29.37), vector3(117.73, -1081.17, 29.22), 0.01, true},
    {vector3(275.182, -345.534, 45.173), vector3(266.498, -332.475, 43.43), 251.0, true},
    {vector3(-833.255, -2351.34, 14.57), vector3(-823.68, -2342.975, 13.803), 147.0, true},
    {vector3(-400.74, 1209.87, 325.92), vector3(-406.82, 1207.15, 325.664), 167.65, true},
    {vector3(112.23, 6619.66, 31.82), vector3(115.81,6599.34, 32.01), 265.81, true},
    {vector3(1951.79, 3750.95, 32.16), vector3(1949.57, 3759.33, 32.21), 34.16, true},
    {vector3(1829.09, 2555.89, 46.21), vector3(1854.74, 2560.04, 44.67), 275.26, true},
    {vector3(889.24, -53.87, 78.91), vector3(886.12, -62.68, 78.76), 236.43, true},
    {vector3(-1184.85, -1510.05, 4.65), vector3(-1183.01, -1495.34, 4.38), 125.56, true},
    {vector3(1036.67, -763.43, 57.99), vector3(1020.1, -766.99, 57.93), 323.98, true},
    {vector3(-316.38, -2748.19, 6), vector3(-335.81, -2738.82, 6.03), 5.91, true},
    {vector3(2763, 1346.56, 24.52), vector3(2732.62, 1329.28, 24.52), 3.22, true},
    {vector3(570.24, 2797.07, 42.01), vector3(588.78, 2791.1, 42.16), 359.84, true},
    {vector3(-3057.32, 115.04, 11.6081), vector3(-3048.16, 113.88, 11.56), 315.37, true},
    {vector3(393.27, -1633.07, 29.29), vector3(394.37, -1617.59, 29.29), 315.91, true}, --abschlepphof
    {vector3(-149.46,-1300.15,31.26), vector3(-165.89,-1302.22,31.33),90.0, true},
    {vector3(2483.08, 4957.63, 44.92), vector3(2476.94, 4948.42, 45.07),226.51, true},
    {vector3(-1519.77, -510.56, 35.52), vector3(-1515.79, -507.69, 35.53),29.64, true},
    {vector3(-1887.4132, 2039.0493, 140.8888), vector3(-1895.7722, 2034.5126, 140.7414),157.55, true},
    {vector3(-619.3730, -82.4586, 41.1978), vector3(-633.2050, -74.8637, 40.4067),359.97, true},
    {vector3(-168.9192, 927.7741, 235.6558), vector3(-158.7469, 927.6494, 235.6556),221.4, false}, --Supremo
    {vector3(-1132.1317, -1609.3931, 4.3984), vector3(-1125.1610, -1611.0333, 4.3984),303.34, false}, --Kanacks
    {vector3(-812.6985, 189.6793, 72.4745), vector3(-819.8787, 184.1815, 72.1394),128.84, false}, --Balkan
    {vector3(-1520.8723, 80.9978, 56.6975), vector3(-1525.7490, 85.7034, 56.5419),271.84, false}, --LCN
    {vector3(-310.1942, 222.3365, 87.9261), vector3(-293.9587, 233.1252, 88.3259),359.19, false}, --CUKUR
    {vector3(1156.5122, -1645.1516, 36.9518), vector3(1160.6941, -1650.9780, 36.9196),204.40, false}, --MG13
    {vector3(1-1529.5890, 846.2028, 181.5947), vector3(-1529.3065, 879.6235, 181.7199),268.29, false}, -- Yakuza
    {vector3(-21.1397, -1442.4423, 30.7007), vector3(-25.2537, -1436.3347, 30.6531),180.37, false}, -- Ballas
    {vector3(-78.7110, 364.3872, 112.4582), vector3(-74.0795, 357.8152, 112.4440),253.97, false}, -- Orga
    {vector3(-2592.5227, 1928.5963, 167.3050), vector3(-2586.9990, 1930.6641, 167.3038),270.11, false}, -- Bratwa/Supremo
    {vector3(-128.0087, 1009.1151, 235.7321), vector3(-122.3736, 996.6443, 235.7518),146.61, false}, -- Sinaloa
    {vector3(4990.0625, -5741.9219, 19.8802), vector3(4995.3843, -5730.0103, 19.8802),54.85, false}, -- Corleone
    {vector3(1378.7407, -600.1053, 74.3380), vector3(1377.2708, -595.8635, 74.3380),46.23, false}, -- Picky
    {vector3(-1787.1252, 459.3786, 128.3082), vector3(-1796.7899, 457.8294, 128.3082),89.98, false}, -- Bratwa
    {vector3(-315.0560, -2698.5166, 7.5499), vector3(-308.6483, -2698.6406, 6.0003),322.81, false}, -- Midnight
    {vector3(-208.03, -1696.04, 34.26), vector3(-222.51, -1692.20, 33.86),174.55, false}, -- GhettoKingZ
    {vector3(-566.38, 299.78, 83.05), vector3(-561.46, 302.03, 83.16),264.10, false}, -- SoA
    {vector3(1410.68, 1115.30, 114.84), vector3(1407.28, 1118.59, 114.83),86.76, false}, -- Trijaden/Cnjg
    {vector3(2545.17, -374.27, 92.99), vector3(2537.34, -378.30, 92.99),169.42, false}, -- FIB
    {vector3(551.05, -1775.94, 29.31), vector3(555.79, -1786.04, 29.02),155.83, false}, -- GroveStreet NEW
    {vector3(-1850.35, 324.84, 89.71), vector3(-1856.24, 326.68, 7.60),155.83, false}, -- Melidin
    {vector3(-1581.38, -83.64, 54.18), vector3(-1576.08, -83.91, 54.18),267.36, false}, -- FakeCarlito
    {vector3(-1586.31, -62.64, 56.48), vector3(-1582.19, -59.49, 56.49),270.94, false}, -- Melidin
    {vector3(730.80, 2535.19, 73.22), vector3(745.41, 2532.44, 73.13),175.60, false}, -- FFA
    {vector3( 19.31, 549.96, 176.22), vector3(10.57, 556.21, 176.52),100.01, false}, -- Dead Angels
    {vector3(-421.62,-349.49,24.23), vector3(-436.33,-349.94,24.23),198.9, false}, -- MD
  
}

local coordinate = {
    { -150.05795288086,-1300.2517089844,31.274225234985, nil, 366.85, nil, 1169888870},
    { 275.182, -345.534, 45.173, nil, 0.0, nil, 1169888870},
    { -833.255, -2351.34, 14.57, nil, 284.43, nil, 1169888870},
    { -400.74, 1209.87, 325.92, nil, 178.25, nil, 1169888870},
    { 112.23, 6619.66, 31.82, nil, 237.14, nil, 1169888870},
    { 1951.79, 3750.95, 32.16, nil, 118.06, nil, 1169888870},
    { 1829.11, 2554.61, 47.21, nil, 0.85, nil, 1169888870},
    { 889.24, -53.87, 78.91, nil, 0.0, nil, 1169888870},
    { -1184.85, -1510.05, 4.65, nil, 300.03, nil, 1169888870},
    { 1036.67, -763.43, 57.99, nil, 240.62, nil, 1169888870},
    { -316.38, -2748.19, 6.0, nil, 39.39, nil, 1169888870},
    { 570.24, 2797.07, 42.01, nil, 278.44, nil, 1169888870},
    { 100.97, -1073.49, 29.37, nil, 73.88, nil, 1169888870},
    { -3057.65, 114.75, 11.6081, nil, 304.55, nil, 1169888870}, -- paradise
    { 393.27, -1633.07, 29.29, nil, 51.29, nil, 1169888870}, --abschlepphof
    { 2482.46, 4958.21, 44.89,  nil, 226.54, nil, 1169888870},
    { -1520.62, -510.86, 35.56,  nil, 303.96, nil, 1169888870},
    { -1887.2311, 2039.5256, 140.9012, nil, 151.15, nil, 1169888870},
    { -619.4282, -82.9636, 41.1966, nil, 3.88, nil, 1169888870},
    { -169.3464, 927.3983, 235.6558,  nil, 318.84, nil, 1169888870}, --Supremo
    { -1132.5990, -1609.7601, 4.3984,  nil, 309.21, nil, 1169888870}, --Kanacks
    { -812.8925, 190.1424, 72.4768,  nil, 206.59, nil, 1169888870}, -- Balkan
    { -310.0476, 221.7639, 87.9277,  nil, 17.65, nil, 1169888870}, -- Cukur
    { 1156.3195, -1644.6642, 36.9621,  nil, 211.13, nil, 1169888870}, -- MG13
    { -1528.9556, 845.1380, 181.5947,  nil, 30.27, nil, 1169888870}, -- Yakzua
    { -78.4937, 364.9441, 112.4582,  nil, 153.89, nil, 1169888870}, -- Orga
    { -2592.3926, 1927.8771, 167.3059,  nil, 4.89, nil, 1169888870}, -- Bratwa / Sumpremo
    { -128.2423, 1009.5905, 235.7321,  nil, 194.48, nil, 1169888870}, -- Sinaloa
    { 4990.5103, -5742.2510, 19.8802,  nil, 67.72, nil, 1169888870}, -- Corleone
    { 1379.8024, -600.7593, 74.3380,  nil, 52.93, nil, 1169888870}, -- Picky
    { -1786.5018, 459.6755, 128.3082,  nil, 102.98, nil, 1169888870}, -- Bratwa
    { -315.1060, -2698.5413, 7.5499,  nil, 289.80, nil, 1169888870}, -- Midnight
    { -207.57, -1696.73, 34.28,  nil, 31.28, nil, 1169888870}, -- GhettoKingz
    { -566.8773, 299.8112, 83.0411, nil, 267.8201, nil, 1169888870}, -- SoA
    { 1410.7383, 1114.4750, 114.8364, nil, 1.5877, nil, 1169888870}, -- Triaden/Cnjg
    { 2545.1045, -375.3679, 93.1201, nil, 6.95, nil, 1169888870}, -- fIB
    { 550.41, -1775.56, 29.31, nil, 257.7, nil, 1169888870}, -- --GroveStreet NEW
    { -1850.19, 324.14, 89.72, nil, 13.36, nil, 1169888870}, -- -- Melidin
    { -1581.67, -83.54, 54.25, nil, 261.53, nil, 1169888870}, -- -- Fake Carlito
    { -1586.67, -62.54, 56.48, nil, 273.93, nil, 1169888870}, -- -- Costa
    { 730.38, 2535.05, 73.22, nil, 266.01, nil, 1169888870}, -- FFA
    { 19.31, 549.96, 176.22, nil, 100.01, nil, 1169888870}, -- Dead Angels
    { -421.03,-349.34,24.23, nil, 108.38, nil, 1169888870}, -- MD

}


RegisterNetEvent('garagehuan:opengarage')
AddEventHandler('garagehuan:opengarage', function(useddingsda)
   toggleField(true)
   usedFrakgarage = useddingsda
end)

Citizen.CreateThread(function()

    for _,v in pairs(coordinate) do
      RequestModel(v[7])
      while not HasModelLoaded(v[7]) do
        Wait(1)
      end
  

      ped =  CreatePed(4, v[7],v[1],v[2],v[3]-1, 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
	  SetEntityInvincible(ped, true)

      SetBlockingOfNonTemporaryEvents(ped, true)
	end

end)

local enableField = false

function AddCar(plate, model)
    SendNUIMessage({
        action = 'add',
        plate = plate,
        name = model
    }) 
end

function AddCarP(plate, model)
    SendNUIMessage({
        action = 'add-p',
        plate = plate,
        name = model
    }) 
end

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open'
        }) 
    else
        SendNUIMessage({
            action = 'close'
        }) 
    end
end

AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    toggleField(false)
end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('enable-parkout', function(data, cb)
    	ESX.TriggerServerCallback('cc_garage:loadVehicles', function(ownedCars)
		if #ownedCars == 0 then

		else
			for _,v in pairs(ownedCars) do
				local vehicleName = v.name
                local plate = v.plate
                AddCar(plate, vehicleName)
			
			end
        end
    end)

    cb('ok')
end) 

RegisterNUICallback('enable-parking', function(data, cb)
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        ESX.TriggerServerCallback('cc_garage:isOwned', function(owned, name)
		    print(GetVehicleNumberPlateText(value))

			if owned then
				--print("Ja ist owned")
                AddCarP(GetVehicleNumberPlateText(value), GetDisplayNameFromVehicleModel(GetEntityModel(value)))
            end
    
        end, GetVehicleNumberPlateText(value))
    end
    
    cb('ok')
end) 

RegisterNUICallback('new-name', function(data, cb)
    TriggerServerEvent('cc_garage:changeName', data.plate, data.newName)
end)

local usedGarage

RegisterNUICallback('park-out', function(data, cb)

    if usedFrakgarage ~= nil then
		ESX.TriggerServerCallback('cc_garage:loadVehicle', function(vehicle)
			local x = usedFrakgarage.garagespawn.x
			local y = usedFrakgarage.garagespawn.y
			local z = usedFrakgarage.garagespawn.z
			
			local props = json.decode(vehicle[1].vehicle)

			ESX.Game.SpawnVehicle(props.model, {
				x = x,
				y = y,
				z = z + 1
			}, tonumber(usedFrakgarage.heading2), function(callback_vehicle)
				ESX.Game.SetVehicleProperties(callback_vehicle, props)
				SetVehRadioStation(callback_vehicle, "OFF")
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
			end)

		end, data.plate)

		TriggerServerEvent('cc_garage:changeState', data.plate, 0)
		
		cb('ok')
	else
		ESX.TriggerServerCallback('cc_garage:loadVehicle', function(vehicle)
			local x,y,z = table.unpack(garages[usedGarage][2])
			local props = json.decode(vehicle[1].vehicle)

            TriggerEvent("rc_alert:startAlert", 5000, "NOTIFIKACIJA", "Izvukli ste vozilo!")
			ESX.Game.SpawnVehicle(props.model, {
				x = x,
				y = y,
				z = z + 1
			}, garages[usedGarage][3], function(callback_vehicle)
				ESX.Game.SetVehicleProperties(callback_vehicle, props)
				SetVehRadioStation(callback_vehicle, "OFF")
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
			end)

		end, data.plate)

		TriggerServerEvent('cc_garage:changeState', data.plate, 0)

		
		cb('ok')
	end
end)

RegisterNUICallback('park-in', function(data, cb)
    
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            TriggerEvent("rc_alert:startAlert", 5000, "NOTIFIKACIJA", "Parkirali ste vozilo!")
            TriggerServerEvent('cc_garage:saveProps', data.plate, ESX.Game.GetVehicleProperties(value))
            TriggerServerEvent('cc_garage:changeState', data.plate, 1)
            ESX.Game.DeleteVehicle(value)
        end
    end
	
    cb('ok')
end)




Citizen.CreateThread(function()

    local garage= {
        1169888870,
    }
    exports['qtarget']:AddTargetModel(garage, {
        options = {
            {
                event = "harun-garaza",
                icon = "fa fa-car",
                label = "Garaza",
            },
        },
        job = {"all"},
        distance = 2.0
    })
    end)

    RegisterNetEvent("harun-garaza")
    AddEventHandler("harun-garaza", function()
        for key, value in pairs(garages) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value[1])

            if dist <= 2.0 then
                letSleep = false
        usedFrakgarage = nil
        toggleField(true)
        usedGarage = key
            end
        end
    
    end)

Citizen.CreateThread(function()
    for _, coords in pairs(garages) do
        if coords[4] then
            local blip = AddBlipForCoord(coords[1])

            SetBlipSprite(blip, 473)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 29)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Garage")
            EndTextCommandSetBlipName(blip)
        end
    end
end)
]]

RegisterServerEvent('garagehuan:garagehuan')
AddEventHandler('garagehuan:garagehuan', function()
    local _source = source
    TriggerClientEvent('garagehuan:garagehuan', _source, text)
end)

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    local _source = source
	
    TriggerClientEvent('garagehuan:garagehuann', _source, text)
end)