RegisterServerEvent('IndicatorL')
RegisterServerEvent('IndicatorR')
 
AddEventHandler('IndicatorL', function(IndicatorL)
    local netID = source
    TriggerClientEvent('updateIndicators', -1, netID, 'left', IndicatorL)
 --   print(netID .. "Indicator left")
end)
 
AddEventHandler('IndicatorR', function(IndicatorR)
    local netID = source
    TriggerClientEvent('updateIndicators', -1, netID, 'right', IndicatorR)
--    print(netID .. "Indicator right")
end)