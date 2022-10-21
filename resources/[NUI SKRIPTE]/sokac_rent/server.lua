ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('provjerakesamom', function(source, cb)
local xPlayer = ESX.GetPlayerFromId(source)
local Igracevepare = xPlayer.getMoney()
if Igracevepare >= 1000 then
    cb('true')
else
    cb('false')
end
end)

RegisterNetEvent('skinikesmom')
AddEventHandler('skinikesmom', function()
    local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeMoney('1000')
end)