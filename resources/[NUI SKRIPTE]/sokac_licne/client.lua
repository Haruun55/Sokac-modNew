local open = false

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
RegisterKeyMapping('izgasilicnu', 'ugasi licnu gmazu ', 'KEYBOARD', 'BACK')
RegisterCommand('izgasilicnu', function()
	SendNUIMessage({
		action = "close"
	})
	open = false
end)
AddEventHandler('jsfour:vidilicnu', function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

