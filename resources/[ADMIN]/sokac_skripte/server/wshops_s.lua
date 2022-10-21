
--[[ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)

ESX.RegisterServerCallback("bShops:ImalPara", function(source, cb, item, cijena, dodatno)

    local src = source
    local igrac = ESX.GetPlayerFromId(src)

    if igrac.hasWeapon(item) then
        cb(false, true)
    else
        if igrac.getMoney() >= cijena then
            igrac.removeMoney(cijena)
            igrac.addWeapon(item, 0)
            if dodatno then
                for k,v in pairs(dodatno) do
                    igrac.addInventoryItem(k, v)
                end
            end
            cb(true, false)
        else
            cb(false, false)
        end
    end

end)


ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 15000 then
		xPlayer.removeMoney(15000)

		TriggerEvent('esx_license:addLicense', _source, 'weapon', function()
			cb(true)
		end)
    else
        
        TriggerClientEvent("bfunkcije:notif", _source, "", "Nemas dovoljno novca!")
		cb(false)
	end
end)--]]



