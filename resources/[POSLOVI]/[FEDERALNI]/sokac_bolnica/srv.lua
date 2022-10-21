local ESX = nil
ESX = nil
SviMrtviSpawnan = {}

GubiOruzje = true
GubiNovac = true
gubiIteme = true

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
	local SviMrtviFajl = LoadResourceFile(GetCurrentResourceName(), "./storage/mrtvi.json")
    SviMrtviBaza = json.decode(SviMrtviFajl)

    for k,v in pairs(SviMrtviBaza) do
        local igrac = ESX.GetPlayerFromIdentifier(k)
        if igrac then
            SviMrtviSpawnan[igrac.source] = {isHead = v.uGlavu, coords = GetEntityCoords(GetPlayerPed(igrac.source))}
        end
    end

    TriggerClientEvent("bBolnica:PrenosMrtvih", -1, SviMrtviSpawnan)
	
	while true do 
		Citizen.Wait(10000)
        SaveResourceFile(GetCurrentResourceName(), "./storage/mrtvi.json", json.encode(SviMrtviBaza, {indent = true}), -1)
    end
    
end)

RegisterServerEvent("esx:onPlayerSpawn")
AddEventHandler("esx:onPlayerSpawn", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local identifier = xPlayer.identifier

    if SviMrtviBaza[identifier] then
        TriggerClientEvent("bBolnica:IgracSpawnan", src, SviMrtviBaza[identifier].uGlavu)
        SviMrtviSpawnan[src] = {isHead = SviMrtviBaza[identifier].uGlavu, coords = GetEntityCoords(GetPlayerPed(src))}
        Player(src).state.isDead = true
    end

    if ESX.GetPlayerFromId(src).getJob().name == "bolnica" then
        TriggerClientEvent("bBolnica:PrenosMrtvih", src, SviMrtviSpawnan)
    end

end)

AddEventHandler("playerDropped", function()
    local src = source
    if SviMrtviSpawnan[src] then
        SviMrtviSpawnan[src] = nil
        TriggerClientEvent("bBolnica:PrenosMrtvih", -1, SviMrtviSpawnan)
    end
end)

RegisterServerEvent("bBolnica:UmroIgrac")
AddEventHandler("bBolnica:UmroIgrac", function(isHead)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local identifier = xPlayer.identifier

    SviMrtviBaza[identifier] = {
        uGlavu = isHead
    }

    SviMrtviSpawnan[src] = {isHead = isHead, coords = GetEntityCoords(GetPlayerPed(src))}

    Player(src).state.isDead = true

    TriggerClientEvent("bBolnica:PrenosMrtvih", -1, SviMrtviSpawnan)

end)


RegisterServerEvent("bBolnica:OzivljenIgrac")
AddEventHandler("bBolnica:OzivljenIgrac", function(id, jeladmin)
    if id then
        src = tonumber(id)
    else
        src = source
    end

    local xPlayer = ESX.GetPlayerFromId(src)

    local identifier = xPlayer.identifier

    SviMrtviBaza[identifier] = nil
    SviMrtviSpawnan[src] = nil

    Player(src).state.isDead = false

    TriggerClientEvent("bBolnica:PrenosMrtvih", -1, SviMrtviSpawnan)

    TriggerClientEvent("bBolnica:OzivljenIgrac", src, jeladmin)
end)

ESX.RegisterServerCallback("bBolnica:ImaLiDoktora", function(source, cb)

    local src = source
    local doktori = exports.bSvastara:SviClanoviOrg("bolnica")
    local BrojDoktora = 0

    for k, v in pairs(doktori) do
        BrojDoktora = BrojDoktora + 1
    end

    if BrojDoktora == 1 and doktori[src] then
        cb(0)
    else
        cb(BrojDoktora)
    end

end)

RegisterNetEvent("bBolnica:UmroSkroz")
AddEventHandler("bBolnica:UmroSkroz", function()

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local identifier = xPlayer.identifier

    

    SviMrtviBaza[identifier] = nil
    SviMrtviSpawnan[src] = nil

    for i=1, #xPlayer.inventory, 1 do
        if xPlayer.inventory[i].count > 0 then
            xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
        end
    end
    TriggerClientEvent('eleNotif:Notify', src, {
        type = 'warning',
        title = 'Bolnica',
        message = 'Umro si , izgubio si sve sto si imao kod sebe',
    })
 --[[   if GubiIteme then
        for i=1, #igrac.inventory, 1 do
			if igrac.inventory[i].count > 0 then
				igrac.setInventoryItem(igrac.inventory[i].name, 0)
			end
		end
    end

    if GubiOruzje then
        for k,v in ipairs(igrac.getLoadout()) do
            igrac.removeWeapon(v.name)
            igrac.removeInventoryItem(k, v)
        end
    end

    if GubiNovac then
        igrac.setAccountMoney("black_money", 0)
        igrac.setAccountMoney("cash", 0)
    end

    igrac.removeAccountMoney("bank", 5000)--]]

end)


RegisterServerEvent("bBolnica:Lijecenje")
AddEventHandler("bBolnica:Lijecenje", function(id)

    local src = source

    if id then
        TriggerClientEvent("bBolnica:PocniProcesLijecenja_pacijent", id)
        TriggerClientEvent("bBolnica:PocniProcesLijecenja_doktor", src)
    else
        TriggerClientEvent("bBolnica:PocniProcesLijecenja_sebe", src)
    end

end)

RegisterNetEvent("bBolnica:ObrisiBolnicarskoAuto")
AddEventHandler("bBolnica:ObrisiBolnicarskoAuto", function(netid)

    local netID = netid
    local voz = NetworkGetEntityFromNetworkId(netID)

    if DoesEntityExist(voz) then
        DeleteEntity(voz)
    end

end)

ESX.RegisterServerCallback("bBolnica:CheckCoords", function(source, cb)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local ProvjeraIgrac = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    if ProvjeraIgrac[1] then
        infokord = json.decode(ProvjeraIgrac[1].position)
        lokacija = vector3(infokord.x, infokord.y, infokord.z + 2.0)
        heading = infokord.heading

        print(lokacija, heading)

        cb(lokacija, heading)
    else
        cb(vector3(-539.15, -214.07, 37.65), 120.0)
    end

end)

RegisterServerEvent("bBolnica:NaplatiDizanje")
AddEventHandler("bBolnica:NaplatiDizanje", function(id)

    local src = source
    local ID = tonumber(id)

    local igrac = ESX.GetPlayerFromId(src)
    local ozivljen = ESX.GetPlayerFromId(ID)
--[[ 
    TriggerEvent("benno_orgmeni:transfer", "cisti", true, 2000, "bolnica", true)
    igrac.addMoney(1500)
    TriggerClientEvent("bfunkcije:notif", src, "", string.format("Ozivio si %s i dobio %d$ a %d$ je otislo u trezor bolnice!", GetPlayerName(ID), 1500, 2000), 7, true)
    ozivljen.removeAccountMoney("bank", 1500)
    TriggerClientEvent("bfunkcije:notif", ID, "", string.format("Ozivljen si od %s i tvoj racun je %d$!", GetPlayerName(ID), 1500), 7, true)
 ]]
end)



RegisterCommand("ozivi", function(source, args)
    
    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)
    local grupa = xPlayer.getGroup()
    if src ~= 0 then
        if grupa == "admin" or grupa == "owner"  or grupa == "headadmin" then 
            if args[1] then
                TriggerClientEvent("bBolnica:OzivljenIgracAdmin", tonumber(args[1]), true)
            else
                TriggerClientEvent("bBolnica:OzivljenIgracAdmin", source, true)
            end
        end
    else
        TriggerClientEvent("bBolnica:OzivljenIgracAdmin", tonumber(args[1]), true)
    end


end, false)


RegisterCommand("ozivisve", function(source, args)
    
    local src = source

    local igraci = GetPlayers()
    local range = tonumber(args[1])

    if src ~= 0 then

        TriggerEvent("badmin:ProvjeriAdmin", function(imal)
            
            if imal then

                if not range or range == 0 then
                    TriggerClientEvent("bBolnica:OzivljenIgracAdmin", -1, true)
                else
                    for i = 1, #igraci do
                        if range then
                            local pPedPos = GetEntityCoords( GetPlayerPed(src) )
                            
                            local id = tonumber(igraci[i])
                            local ped = GetPlayerPed(id)
                            local pos = GetEntityCoords(ped)
                            if #(pPedPos - pos) <= range then
                                TriggerClientEvent("bBolnica:OzivljenIgracAdmin", id, true) 
                            end
                        end
                    end
                end
            end
        end, src, false)

    else

        for i = 1, #igraci do
            if range then
                local id = tonumber(igraci[i])
                local ped = GetPlayerPed(id)
                local pos = GetEntityCoords(ped)
                if #(pPedPos - pos) <= range then
                    TriggerClientEvent("bBolnica:OzivljenIgracAdmin", id, true) 
                end
            end
        end

    end
    
end, true)

