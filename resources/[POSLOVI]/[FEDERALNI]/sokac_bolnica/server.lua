local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent("logovismrt")
AddEventHandler("logovismrt", function(glava, ubica, uzrok)

	local src = source

	local killer = "Nema"
	local Pozicija = GetEntityCoords(GetPlayerPed(src))

	if ubica and ubica ~= -1 then
		killer = GetPlayerName(ubica)
	end

    local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())
	local embed = {
        {   
			["color"] = 15728653,
			["description"] = string.format("%s\n------------------------------", GetPlayerName(src)),
            ["fields"] = {
				{
					["name"] = "Headshot",
					["value"] = glava,
				},
				{
					["name"] = "Lokacija Smrti",
					["value"] = tostring(Pozicija)
				},
				{
					["name"] = "Ubica",
					["value"] = killer,
					["inline"] = true
				},
				{
					["name"] = "Uzrok",
					["value"] = uzrok or "Nije Poznat",
					["inline"] = true
				},
			},
            ["footer"] = {
                ["text"] = vrijeme,
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/835511361731297310/HiDdIP4ss8mvf2t5JqcEYs4GAzTBD1RtVKZDRFKf9R6SY6SSdYb-12r12b2HCAvqoFSE", function(err, text, headers) end, 'POST', json.encode({username = "Death Log", embeds = embed}), { ['Content-Type'] = 'application/json' })

end)

RegisterNetEvent('dajmumedikit')
AddEventHandler('dajmumedikit', function()
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('medikit', 1)
end)

RegisterNetEvent('dajmubandage')
AddEventHandler('dajmubandage', function()
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('bandage', 1)
end)