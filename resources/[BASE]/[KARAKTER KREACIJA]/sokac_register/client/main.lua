local guiEnabled = false
local myIdentity = {}
local myIdentifiers = {}
local hasIdentity = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function EnableGui(state)
	SetNuiFocus(state, state)
	guiEnabled = state

	SendNUIMessage({
		type = "enableui",
		enable = state
	})
end

--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	getIdentity(source, function(data)
		print(data.firstname)
		if data.firstname == '' or data.firstname == nil or data.firstname == 0 or data.firstname == '0' then
		  TriggerClientEvent('esx_identity:showRegisterIdentity', source)
		else
		  print('JSFOUR Successfully Loaded Identity For ' .. data.firstname .. ' ' .. data.lastname)
		end
	  end)
end)]]

RegisterNetEvent('esx_identity:showRegisterIdentity')
AddEventHandler('esx_identity:showRegisterIdentity', function()
	Citizen.Wait(2000)			   
	EnableGui(true)
end)

RegisterNetEvent('esx_identity:identityCheck')
AddEventHandler('esx_identity:identityCheck', function(identityCheck)
	hasIdentity = identityCheck
end)

RegisterNetEvent('esx_identity:saveID')
AddEventHandler('esx_identity:saveID', function(data)
	myIdentifiers = data
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
	else
		print('Greska: Morate se registrovati da biste nastavili!')
	end
end)
RegisterNetEvent('setajpedanovomigracu')
AddEventHandler("setajpedanovomigracu" , function()

                player = PlayerPedId()

                SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
                SetPedComponentVariation(player, 11, 0, 11, 0)
                SetPedComponentVariation(player, 8, 0, 1, 0)
                SetPedComponentVariation(player, 6, 0, 0, 0)
                SetPedHeadOverlayColor(player, 1, 1, 0, 0)
                SetPedHeadOverlayColor(player, 2, 1, 0, 0)
                SetPedHeadOverlayColor(player, 4, 2, 0, 0)
                SetPedHeadOverlayColor(player, 5, 2, 0, 0)
                SetPedHeadOverlayColor(player, 8, 2, 0, 0)
                SetPedHeadOverlayColor(player, 10, 1, 0, 0)
                SetPedHeadOverlay(player, 1, 0, 0.0)
                SetPedHairColor(player, 1, 1)
        
end)
RegisterNUICallback('register', function(data, cb)
	local reason = ""
	myIdentity = data
	for theData, value in pairs(myIdentity) do
		if theData == "firstname" or theData == "lastname" then
			reason = verifyName(value)
			
			if reason ~= "" then
				break
			end
		elseif theData == "dateofbirth" then
			if value == "invalid" then
				reason = "Netacan datum rodjenja!"
				break
			end
		elseif theData == "height" then
			local height = tonumber(value)
			if height then
				if height > 200 or height < 140 then
					reason = "Visina vam mora biti veca od 140 a manja od 200cm!"
					break
				end
			else
				reason = "Nevazeca visina!"
				break
			end
		end
	end
	
	if reason == "" then
		TriggerServerEvent('esx_identity:setIdentity', data, myIdentifiers)
		EnableGui(false)
	    TriggerEvent('identitispawn')
		Citizen.Wait(500)
		TriggerEvent('setajpedanovomigracu')
		--TriggerEvent('esx_skin:openSaveableMenu', myIdentifiers.id)
		TriggerEvent('otvoriEE')
		
	else
		print("POGREŠILI STE : " .. reason)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 18, guiEnabled) -- Enter
            DisableControlAction(0, 322, guiEnabled) -- ESC
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
			DisableControlAction(0, 30,  guiEnabled) -- MoveLeftRight
			DisableControlAction(0, 31,  guiEnabled) -- MoveUpDown
			DisableControlAction(0, 21,  guiEnabled) -- disable sprint
			DisableControlAction(0, 24,  guiEnabled) -- disable attack
			DisableControlAction(0, 25,  guiEnabled) -- disable aim
			DisableControlAction(0, 47,  guiEnabled) -- disable weapon
			DisableControlAction(0, 58,  guiEnabled) -- disable weapon
			DisableControlAction(0, 263, guiEnabled) -- disable melee
			DisableControlAction(0, 264, guiEnabled) -- disable melee
			DisableControlAction(0, 257, guiEnabled) -- disable melee
			DisableControlAction(0, 140, guiEnabled) -- disable melee
			DisableControlAction(0, 141, guiEnabled) -- disable melee
			DisableControlAction(0, 143, guiEnabled) -- disable melee
			DisableControlAction(0, 75,  guiEnabled) -- disable exit vehicle
			DisableControlAction(27, 75, guiEnabled) -- disable exit vehicle
			DisableControlAction(0, 245, guiEnabled) -- Disable Chat
			DisableControlAction(31, 245, guiEnabled) -- CHAT
            DisableControlAction(0, 309, guiEnabled) -- Disable K

            DisableControlAction(0, 29, guiEnabled) -- B
            DisableControlAction(0, 36, guiEnabled) -- Crouch
            DisableControlAction(0, 20, guiEnabled) -- Prone
        else
        	Citizen.Wait(700)
		end
	end
end)

function verifyName(name)
	-- Don't allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return 'Vase ime je prekratko ili predugacko.'
	end
	
	-- Don't allow special characters (doesn't always work)
	local count = 0
	for i in name:gmatch('[abcććšđžČĆĐŽdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Vase ime sadrzi nedozvoljene karaktere mozete koristiti samo SLOVA.'
	end
	
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	if spacesInName > 2 then
		return 'Vase ime ima preko 2 razmaka, to je zabranjeno!'
	end
	
	if spacesWithUpper ~= spacesInName then
		return 'Vase ime i prezime mora da pocinje VELIKIM slovom.'
	end

	return ''
end
