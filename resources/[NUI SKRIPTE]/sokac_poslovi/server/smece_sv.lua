ESX = nil
local discord = "https://discord.com/api/webhooks/905872701481168946/LaNUrVBatlzNDwmT7x3Fo2grnZb-qU_Y-GDNM4GLCIss6csL_Ef-Dk4ZiH2LyHrIJ-1V" -- Discord WebHook ovdje stavljate svoj webhook
local dumpsterItems = {
    [1] = {chance = 2, id = 'copper', name = 'Bakar', quantity = math.random(1,3), limit = 10},
    [2] = {chance = 4, id = 'iron', name = 'Metal', quantity = 1, limit = 4},
    [3] = {chance = 2, id = 'bandage', name = 'Zavoj', quantity = 1, limit = 2},
    [4] = {chance = 2, id = 'mak', name = 'Mak', quantity = 1, limit = 10},
    [5] = {chance = 3, id = 'icetea', name = 'Ledeni Caj', quantity = math.random(1,8), limit = 0},
    [6] = {chance = 4, id = 'WEAPON_BAT', name = 'Palica', quantity = 1, limit = 2},
    [7] = {chance = 8, id = 'electronics', name = 'Electronics', quantity = math.random(1,2), limit = 0},
    [8] = {chance = 5, id = 'sladoled', name = 'Sladoled', quantity = 1, limit = 5},
    [9] = {chance = 5, id = 'wrench', name = 'Kljuc', quantity = 1, limit = 1},
    [10] = {chance = 2, id = 'listkoke', name = 'List Koke', quantity = 1, limit = 10},
    [11] = {chance = 4, id = 'washKit', name = 'Wash Kit', quantity = 1, limit = 3},
    [12] = {chance = 3, id = 'heroin', name = 'Heroin', quantity = math.random(1,3), limit = 10},
    [13] = {chance = 2, id = 'fakeplate', name = 'Lazna Tablica', quantity = 1, limit = 1},
    [14] = {chance = 7, id = 'cartire', name = 'Car Tire', quantity = 1, limit = 4},
    [15] = {chance = 8, id = 'maska', name = 'Maska za ronjenje', quantity = 1, limit = 2},
    [16] = {chance = 2, id = 'lockpick', name = 'Alat za obijanje', quantity = 1, limit = 2},
    [17] = {chance = 2, id = 'donut', name = 'Donut', quantity = 1, limit = 1}
   }

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('onyx:startDumpsterTimer')
AddEventHandler('onyx:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('onyx:giveDumpsterReward')
AddEventHandler('onyx:giveDumpsterReward', function()
    local source = tonumber(source)
    local item = {}
    local xPlayer = ESX.GetPlayerFromId(source)
    local gotID = {}
    local rolls = math.random(1, 2)
    local foundItem = false

    for i = 1, rolls do
        item = dumpsterItems[math.random(1, #dumpsterItems)]
        if math.random(1, 10) >= item.chance then
            if item.isWeapon and not gotID[item.id] then
                if item.limit > 0 then
                    local count = xPlayer.getInventoryItem(item.id).count
                    if count >= item.limit then
                        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "LIBERTY", "Pronasao si " .. item.name .. " ali ne mozes nositi..", 4000, 'error')
					end
                end
            elseif not gotID[item.id] then
                if item.limit > 0 then
                    local count = xPlayer.getInventoryItem(item.id).count
                    if count >= item.limit then
                        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "LIBERTY", "Pronasao si " .. item.quantity .. "x " .. item.name .. "ali ne mozes nositi..", 4000, 'error')
                    else
                        gotID[item.id] = true
                        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "LIBERTY", "Pronasao si " .. item.quantity .. "x " .. item.name, 4000, 'error')
                        xPlayer.addInventoryItem(item.id, item.quantity)
						PerformHttpRequest(discord, function(err, text, headers) end, 'POST', json.encode({username = "Pretrazivanje..", content = "__**" .. GetPlayerName(source) .. "**__ pronasao: **" .. item.id .. " __ kolicina pronadjenih itema:" ..item.quantity.. ""}), { ['Content-Type'] = 'application/json' })
                        foundItem = true
                    end
                else
                    gotID[item.id] = true
                    TriggerClientEvent('okokNotify:Alert', xPlayer.source, "LIBERTY", "Pronasao si " .. item.quantity .. "x " .. item.name, 4000, 'error')
                    xPlayer.addInventoryItem(item.id, item.quantity)
					PerformHttpRequest(discord, function(err, text, headers) end, 'POST', json.encode({username = "Pretrazivanje..", content = "__**" .. GetPlayerName(source) .. "**__ pronasao: **" .. item.id .. " __ kolicina pronadjenih itema :" ..item.quantity.. " "}), { ['Content-Type'] = 'application/json' })
                    foundItem = true
                end
            end
        end
        if i == rolls and not gotID[item.id] and not foundItem then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Nisi pronasao nista..'})
			PerformHttpRequest(discord, function(err, text, headers) end, 'POST', json.encode({username = "Pretrazivanje..", content = "__**" .. GetPlayerName(source) .. "**__ nije pronasao nista. "}), { ['Content-Type'] = 'application/json' })
        end
    end
end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('onyx:removeDumpster', id, object)
        end
    end
end