ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('beachHud:povuciPare', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  local zapush = {
    banka = xPlayer.getAccount('bank').money,
    kes = xPlayer.getMoney()
  }

  cb(zapush)
end)
