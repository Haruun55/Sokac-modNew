ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

 RegisterServerCallback("element_bankomat:GetMoneyData", function(source)

    xPlayer = ESX.GetPlayerFromId(source)

    RegisteredData = {}

    RegisteredData.bank = xPlayer.getAccount('bank').money

    RegisteredData.cash = xPlayer.getMoney()

    RegisteredData.firstname = GetChar(source).firstname
    
    RegisteredData.lastname = GetChar(source).lastname
    return RegisteredData
end)


GetChar = function(src)

    xPlayer = ESX.GetPlayerFromId(src)

    local result = exports.oxmysql:executeSync('SELECT * FROM `users` WHERE `identifier` = \'' .. xPlayer.identifier .. '\'', {})

    if result[1] then

        return result[1]

    else

        return nil

    end

end


RegisterServerEvent('element_bankomat:withdraw', function(amount)
    local PocetniNovac = xPlayer.getMoney()
	local PocetnoStanje = xPlayer.getAccount('bank').money
    xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getAccount('bank').money >= amount then
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
        TriggerClientEvent('eleNotif:Notify', source, {
            type = 'success',
            title = 'ATM',
            message = 'Podigao si ' ..amount.. '$ sa svog bankovnog racuna'
        })
      --  sendToDiscord('ATM', ">> Podigao sa racuna \n\n Igrac: [".. GetPlayerName(source) .. "]\n\n Kolicina: ".. amount .."$\n\nProsla kolicina: [".. PocetniNovac .."$]\nNova kolicina: " .. xPlayer.getAccount('bank').money, 3066993)
    else 
    TriggerClientEvent('eleNotif:Notify', source, {
        type = 'error',
        title = 'ATM',
        message = 'Nemas ' ..amount.. '$ na svom racunu'
    })
   -- sendToDiscord('ATM', ">>Nema dovoljno novca \n\n Igrac: [".. GetPlayerName(source) .. "] je pokusao podignuti : ".. amount .."$ sa svog racuna a nema toliko" , 15158332)
    end
end)

RegisterServerEvent('element_bankomat:deposit', function(amount)

    local PocetniNovac = xPlayer.getMoney()
	local PocetnoStanje = xPlayer.getAccount('bank').money
    xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', amount)
        TriggerClientEvent('eleNotif:Notify', source, {
            type = 'success',
            title = 'ATM',
            message = 'Stavio si ' ..amount.. '$ na svoj bankovni racun'
        })
      --  sendToDiscord('ATM', ">>Uplata na svoj racun\n\n Igrac: [".. GetPlayerName(source) .. "]\n\n Kolicina: ".. amount .."$\n\nProsla kolicina: [".. PocetniNovac .."$]\nNova kolicina: " .. xPlayer.getAccount('bank').money, 3066993)
    else 
        TriggerClientEvent('eleNotif:Notify', source, {
            type = 'error',
            title = 'ATM',
            message = 'Nemas ' ..amount.. '$ novca kod sebe'
        })

      --  sendToDiscord('ATM', ">>Nema dovoljno novca \n\n Igrac: [".. GetPlayerName(source) .. "] je pokusao uplatiti : ".. amount .."$ na svoj racun a nema toliko" , 15158332)
    end
end)


RegisterServerEvent('element_bankomat:transfer', function(id, amount)

    local PocetniNovac = xPlayer.getMoney()
	local PocetnoStanje = xPlayer.getAccount('bank').money
	xPlayer = ESX.GetPlayerFromId(source)
	xTarget = ESX.GetPlayerFromId(id)

	if xTarget ~= nil then
		if source ~= id then
			if xPlayer.getAccount('bank').money >= amount then
				xPlayer.removeAccountMoney('bank', amount)
				xTarget.addAccountMoney('bank', amount)
              
            else
                TriggerClientEvent('eleNotif:Notify', source, {
                    type = 'error',
                    title = 'Banka',
                    message = 'Nemas ' ..amount.. ' $ na svom racunu'
                })
            end

            TriggerClientEvent('eleNotif:Notify', id, {
                type = 'success',
                title = 'Banka',
                message = 'Stiglo ti je ' ..amount.. '$ od ' ..GetPlayerName(source).. ''
            })
            TriggerClientEvent('eleNotif:Notify', source, {
                type = 'success',
                title = 'Banka',
                message = 'Prebacio si ' ..amount.. '$ igracu ' ..GetPlayerName(id).. ''
            })
         --   sendToDiscord('ATM', ">> Transfer \n\n Igrac: [".. GetPlayerName(source) .. " je prebacio novac igracu " .. GetPlayerName(id) .. " ]\n\n Kolicina: ".. amount .."$\n\nProsla kolicina: [".. xPlayer.getAccount('bank').money .."$]\nNova kolicina: " .. xPlayer.getAccount('bank').money.. "\n\n Nova kolicina igraca : [" .. GetPlayerName(id) .. "  ]" .. xTarget.getAccount('bank').money, 3066993)
		end
	else 
        TriggerClientEvent('eleNotif:Notify', source, {
            type = 'success',
            title = 'Banka',
            message = 'Nema igraca sa tim ID-om !'
        })
    end
end)