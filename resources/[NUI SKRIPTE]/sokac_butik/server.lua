ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('fizzfau-clothes:getPlayerDressing', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local count    = store.count('dressing')
        local labels   = {}

        for i=1, count, 1 do
            local entry = store.get('dressing', i)
            table.insert(labels, entry.label)
        end
  
        cb(labels)
    end)
end)

ESX.RegisterServerCallback('fizzfau-clothes:getPlayerOutfit', function(source, cb, num)
    local xPlayer  = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local outfit = store.get('dressing', num)
        cb(outfit.skin)
    end)
end)

RegisterServerEvent('fizzfau-clothes:saveOutfit')
AddEventHandler('fizzfau-clothes:saveOutfit', function(label, skin)

	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
	end)
end)


RegisterServerEvent("fivem-appearance:saveOutfit")
AddEventHandler("fivem-appearance:saveOutfit", function(name, pedModel, pedComponents, pedProps)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.insert('INSERT INTO outfits (identifier, name, ped, components, props) VALUES (@identifier, @name, @ped, @components, @props)', {
        ['@ped'] = json.encode(pedModel),
        ['@components'] = json.encode(pedComponents),
        ['@props'] = json.encode(pedProps),
        ['@name'] = name,
        ['@identifier'] = xPlayer.identifier
    })
end)

