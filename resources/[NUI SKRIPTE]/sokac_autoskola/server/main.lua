ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('angelsrp_autoskola:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('angelsrp_autoskola:addLicense')
AddEventHandler('angelsrp_autoskola:addLicense', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem('dmv', 1)
	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('angelsrp_autoskola:loadLicenses', _source, licenses)
		end)
	end)
end)

RegisterNetEvent('angelsrp_autoskola:pay')
AddEventHandler('angelsrp_autoskola:pay', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(price)))
end)
