local Items = shared 'items'

local function GetItem(item)
	if item then
		item = string.lower(item)
		if item:find('weapon_') then item = string.upper(item) end
		return Items[item]
	end
end

local function Item(name, cb)
	if Items[name] then Items[name].effect = cb end
end

-----------------------------------------------------------------------------------------------
-- Clientside item use functions
Item('burger', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si burger'})
		end
	end)
end)

Item('fries', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si pomfrit'})
		end
	end)
end)

Item('nuggets', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si nuggets '})
		end
	end)
end)

Item('testburger', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			if data.server then print(json.encode(data.server, {indent=true})) end
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si '..data.name})
		end
	end)
end)

Item('water', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si vodu'})
		end
	end)
end)

Item('cola', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si colu'})
		end
	end)
end)

Item('mustard', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si '..data.name})
		end
	end)
end)




Item('sendvic', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si sendvic'})
		end
	end)
end)
Item('hotdog', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si hotdog'})
		end
	end)
end)
Item('cheeseburger', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si cheeseburger'})
		end
	end)
end)
Item('pizza', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si pizzu'})
		end
	end)
end)
Item('fanta', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si fantu'})
		end
	end)
end)
Item('sprite', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si sprite'})
		end
	end)
end)
 Item('redbull', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si redbull'})
		end
	end)
end)


Item('milka', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si milku'})
		end
	end)
end)
Item('snickers', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si snickers'})
		end
	end)
end)
Item('twix', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si twix'})
		end
	end)
end)
Item('mars', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si mars'})
		end
	end)
end)
Item('krofna', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si krofnu'})
		end
	end)
end)
Item('kafa', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si kafu'})
		end
	end)
end)

Item('bounty', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Pojeo si bounty'})
		end
	end)
end)


Item('cola', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si colu'})
		end
	end)
end)

Item('mustard', function(data, slot)
	TriggerEvent('ox_inventory:item', data, function(data)
		if data then
			TriggerEvent('ox_inventory:notify', {text = 'Popio si '..data.name})
		end
	end)
end)



--[[ 
Item('bandage', function(data, slot)
	local maxHealth = 200
	local health = GetEntityHealth(ESX.PlayerData.ped)
	if health < maxHealth then
		TriggerEvent('ox_inventory:item', data, function(data)
			if data then
				SetEntityHealth(ESX.PlayerData.ped, math.min(maxHealth, math.floor(health + maxHealth / 16)))
				TriggerEvent('ox_inventory:notify', {text = 'Vec se osjecaj bolje !'})
			end
		end)
	end
end) ]]

Item('armour', function(data, slot)
	if GetPedArmour(ESX.PlayerData.ped) < 100 then
		TriggerEvent('ox_inventory:item', data, function(data)
			if data then
				SetPlayerMaxArmour(PlayerId(), 100)
				SetPedArmour(ESX.PlayerData.ped, 100)
			end
		end)
	end
end)

ox.parachute = false
Item('parachute', function(data, slot)
	if not ox.parachute then
		TriggerEvent('ox_inventory:item', data, function(data)
			if data then
				local chute = `GADGET_PARACHUTE`
				SetPlayerParachuteTintIndex(PlayerData.id, -1)
				GiveWeaponToPed(PlayerData.ped, chute, 0, true, false)
				SetPedGadget(PlayerData.ped, chute, true)
				lib:requestModel(1269906701)
				ox.parachute = CreateParachuteBagObject(PlayerData.ped, true, true)
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)

-----------------------------------------------------------------------------------------------

exports('Items', GetItem)
client.items = Items