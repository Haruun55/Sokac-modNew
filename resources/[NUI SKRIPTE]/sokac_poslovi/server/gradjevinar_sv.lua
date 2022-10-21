ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sicilia_gradjevinar:gmoney')
AddEventHandler('sicilia_gradjevinar:gmoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.addMoney(30) -- This is money which will player get when put brick
end)

RegisterServerEvent('sicilia_gradjevinar:greward')
AddEventHandler('sicilia_gradjevinar:greward', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.addMoney(760) -- This is reward which will player get after some putted bricks
end)