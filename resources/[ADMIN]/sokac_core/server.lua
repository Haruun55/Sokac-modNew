RegisterServerEvent('najbilizi:igrac')
AddEventHandler('najbilizi:igrac',function(igrc)
        local xPlayer = ESX.GetPlayerFromId(source)
        print(igrc)
        TriggerClientEvent('staviu:voziloigrc', igrc)
    
end)

RegisterServerEvent('najbilizi:igrac2')
AddEventHandler('najbilizi:igrac2',function(igrc)
        local xPlayer = ESX.GetPlayerFromId(source)
        print(igrc)
        TriggerClientEvent('civil_funkcije:outOfVeh', igrc, xPlayer)
    
end)

local carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
local carried = {}
--carried[targetSource] = source, targetSource is being carried by source

RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
	local source = source
	local sourcePed = GetPlayerPed(source)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc)
        local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
		carrying[source] = targetSrc
		carried[targetSrc] = source
	end
end)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)



--apartmani
RegisterServerEvent('napraviBucketapartman')
AddEventHandler('napraviBucketapartman', function(id)
    SetPlayerRoutingBucket(source, id)
end)

RegisterServerEvent('obrisibucketapartman')
AddEventHandler('obrisibucketapartman', function(data)
    SetPlayerRoutingBucket(source, 0)
end)


RegisterServerEvent('registrujstashove')
AddEventHandler('registrujstashove', function()


    local playerStash = {
        id = xPlayer.identifier,
        label = 'Apartman Skladiste',
        slots = 50,
        weight = 50000,
        owner = true
    }

    exports.ox_inventory:RegisterStash(playerStash.id, playerStash.label, playerStash.slots, playerStash.weight, true)
end)