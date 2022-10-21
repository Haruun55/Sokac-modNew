ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


 ESX.RegisterServerCallback('radio:ima', function(source, cb, item)
    local src = source
    local item = 'radio'
    local player = ESX.GetPlayerFromId(src)
    local playerItem = player.getInventoryItem(item)

    if player and playerItem ~= nil then
        if playerItem.count >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        print('Nema radio')
    end
end)