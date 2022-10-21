ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('liberty:plati')
AddEventHandler('liberty:plati', function(jobStatus)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if jobStatus then
        if xPlayer ~= nil then
            local randomMoney = math.random(600,800)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerEvent('libertyPlati:logovi',_source,xPlayer.getName(),randomMoney)
        end
    else
        print("Citer Bracoooooooooooooooo: ",xPlayer.getName())
    end
end)
