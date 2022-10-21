local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()

    local SviZatvoreniiFajl = LoadResourceFile(GetCurrentResourceName(), "./zatvor.json")
    SviZatvoreni = json.decode(SviZatvoreniiFajl)


    while true do 
        Citizen.Wait(10000)
        SaveResourceFile(GetCurrentResourceName(), "./zatvor.json", json.encode(SviZatvoreni, {indent = true}), -1)
    end

end)

RegisterServerEvent("bZatvor:Zatvori")
AddEventHandler("bZatvor:Zatvori", function(id, vrijeme, razlog)

    local sourc = source
    local polic = ESX.GetPlayerFromId(sourc)

    if polic.getJob().name == "police" or polic.getJob().name == "sheriff" then

        local src = id
        local vrijeme = tonumber(vrijeme) * 60
        local igrac = ESX.GetPlayerFromId(src)

        local steam = ESX.GetIdentifier(id)
        SviZatvoreni[steam] = vrijeme
        TriggerClientEvent("bZatvor:Zatvoren", id, SviZatvoreni[steam])

        local IgracBaza = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {['@identifier'] = igrac.identifier})
        TriggerClientEvent("bZatvor:zatvorenotif", -1, IgracBaza[1].firstname .. " " .. IgracBaza[1].lastname, vrijeme / 60, razlog or "nije navedeno")

        local poruka = "```css\nPolicajac "..GetPlayerName(sourc).." je **zatvorio** igraca: [" .. GetPlayerName(src) .. "] na: [" .. vrijeme / 60 .. "] mjeseci  ```"
        PerformHttpRequest("https://discordapp.com/api/webhooks/756131746088747048/yUWxDdwLCFZnr4Ruv5GZczQmUGBcP_mtIpvALOfusGlcp3YdR-_tw8_xjv3ircGhhw2Q", function(err, text, headers) end, 'POST', json.encode({username = "Zatvor", content = poruka}), { ['Content-Type'] = 'application/json' })


    end

end)


RegisterCommand("zatvori", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local grupa = xPlayer.getGroup()
    if grupa == 'admin' or grupa == 'owner' or grupa == 'headadmin' then
        if args[1] then
            local id = tonumber(args[1])
            local vrijeme = tonumber(args[2]) * 60
            local igrac = ESX.GetPlayerFromId(id)
    
            SviZatvoreni[igrac.identifier] = vrijeme
            TriggerClientEvent("bZatvor:Zatvoren", id, SviZatvoreni[igrac.identifier])
    
            local IgracBaza = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {['@identifier'] = ESX.GetIdentifier(igrac.source)})
            TriggerClientEvent("bZatvor:zatvorenotif", -1, IgracBaza[1].firstname .. " " .. IgracBaza[1].lastname, vrijeme / 60, "Admin Zatvaranje")

            
            local poruka = "```css\nAdmin "..GetPlayerName(src).." je **zatvorio** igraca: [" .. GetPlayerName(id) .. "] na: [" .. vrijeme / 60 .. "] mjeseci  ```"
            PerformHttpRequest("https://discordapp.com/api/webhooks/756131746088747048/yUWxDdwLCFZnr4Ruv5GZczQmUGBcP_mtIpvALOfusGlcp3YdR-_tw8_xjv3ircGhhw2Q", function(err, text, headers) end, 'POST', json.encode({username = "Zatvor", content = poruka}), { ['Content-Type'] = 'application/json' })
        end
    end


end, false)

RegisterCommand("oslobodi", function(source, args)

    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)
    local grupa = xPlayer.getGroup()
    if grupa == 'admin' or grupa == 'owner ' or grupa == 'headadmin' then

        if args[1] then
            local id = tonumber(args[1])
            SviZatvoreni[ESX.GetIdentifier(id)] = 0
            TriggerClientEvent("bZatvor:Zatvoren", id, SviZatvoreni[ESX.GetIdentifier(id)])

            local poruka = "```css\nAdmin "..GetPlayerName(src).." je **oslobodio** igraca: [" .. GetPlayerName(id) .. "] ```"
            PerformHttpRequest("https://discordapp.com/api/webhooks/756131746088747048/yUWxDdwLCFZnr4Ruv5GZczQmUGBcP_mtIpvALOfusGlcp3YdR-_tw8_xjv3ircGhhw2Q", function(err, text, headers) end, 'POST', json.encode({username = "Zatvor", content = poruka}), { ['Content-Type'] = 'application/json' })

        end
    end
    
end, false)

RegisterServerEvent("bZatvor:Tick")
AddEventHandler("bZatvor:Tick", function()

    local src = source
    local id = ESX.GetIdentifier(src)

    if SviZatvoreni[id] then
        SviZatvoreni[id] = SviZatvoreni[id] - 1
    end

end)

RegisterServerEvent("bZatvor:Oslobodi")
AddEventHandler("bZatvor:Oslobodi", function()

    local src = source
    if SviZatvoreni[ESX.GetIdentifier(src)] then
        if SviZatvoreni[ESX.GetIdentifier(src)] <= 0 then
            TriggerClientEvent("bZatvor:Oslobodi", src)
            SviZatvoreni[ESX.GetIdentifier(src)] = nil

            local poruka = "```css\nIgrac "..GetPlayerName(src).." je odsluzio svoju kaznu ```"
            PerformHttpRequest("https://discordapp.com/api/webhooks/756131746088747048/yUWxDdwLCFZnr4Ruv5GZczQmUGBcP_mtIpvALOfusGlcp3YdR-_tw8_xjv3ircGhhw2Q", function(err, text, headers) end, 'POST', json.encode({username = "Zatvor", content = poruka}), { ['Content-Type'] = 'application/json' })
        end
    end

end)

ESX.RegisterServerCallback("bZatvor:ProvjeriZatvor", function(source, cb)

    local src = source
    if SviZatvoreni[ESX.GetIdentifier(src)] then
        cb(
            SviZatvoreni[ESX.GetIdentifier(src)]
        )
    else
        cb(0)
    end

end)

RegisterNetEvent("bZatvor:UpdateVrijeme")
AddEventHandler("bZatvor:UpdateVrijeme", function()

    local src = source
    if SviZatvoreni[ESX.GetIdentifier(src)] then
        SviZatvoreni[ESX.GetIdentifier(src)] = SviZatvoreni[ESX.GetIdentifier(src)] - 15
        TriggerClientEvent("bZatvor:UpdateVrijeme", src, SviZatvoreni[ESX.GetIdentifier(src)])
    end

end)