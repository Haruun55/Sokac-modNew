

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local backGOTO = {}
local backBRING = {}


AddEventHandler("esx:playerLoaded", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local grupa = xPlayer.getGroup()
	print(grupa)
	if grupa == 'owner' then 
		xPlayer.setGroup("owner")
		Player(source).state.aGroup = "owner"
		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^1owner^0!")
	elseif grupa == 'admin' then 
		xPlayer.setGroup("admin")
		Player(source).state.aGroup = "admin"
		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^admin^0!")
	elseif grupa == 'headadmin' then 
		xPlayer.setGroup("headadmin")
		Player(source).state.aGroup = "headadmin"
		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^headadmin^0!")
	elseif grupa == 'gm' then 
		xPlayer.setGroup("gm")
		Player(source).state.aGroup = "gm"

		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^GameMaster^0!")
	elseif grupa == 'gm1' then 
		xPlayer.setGroup("gm1")
		Player(source).state.aGroup = "gm1"

		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^Game Master 1^0!")
	elseif grupa == 'gm2' then 
		xPlayer.setGroup("gm2")
		Player(source).state.aGroup = "gm2"

		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^Game Master 2^0!")
	elseif grupa == 'gm3' then 
		xPlayer.setGroup("gm3")
		Player(source).state.aGroup = "gm3"

		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^Game Master 3^0!")
	elseif grupa == 'gm4' then 
		xPlayer.setGroup("gm4")
		Player(source).state.aGroup = "gm4"

		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^Head Game Master 3^0!")
	elseif grupa == 'vodjahelpera' then 
		xPlayer.setGroup("vodjahelpera")
		Player(source).state.aGroup = "vodjahelpera"

		TriggerClientEvent('chatMessage', xPlayer.source, "^1[Sokac]^0: ^0 Ucitana je tvoja grupa  ^vodjahelpera 3^0!")
	end
  end)


GlobalState["AddCommand"] = function(komanda, back, dozvoljeno)
	RegisterCommand(komanda, function(source, args, rawCommand)
		local igrac = ESX.GetPlayerFromId(source)
		if source == 0 then
			back(source, args)
		else
			if (dozvoljeno["all"] and igrac.getGroup() ~= "user") or dozvoljeno[igrac.getGroup()] then
				if komanda == "aduty" then
					back(source, args, igrac.getGroup(), rawCommand)
				else
					if Player(source).state.aduty then
						back(source, args, igrac.getGroup(), rawCommand)
					else
						TriggerClientEvent('chatMessage', source, "^1[Sokac]^0: Nisi na ^1ADMIN^0 duznosti!")
					end
				end
			else
				TriggerClientEvent('chatMessage', source, "^1[Sokac]^0: komanda ^1'"..komanda.."'^0 ti nije dozvoljena!")
			end 
		end
	end)
end


GlobalState["AddCommand"]("aduty", function(source, args)
	Player(source).state.aduty = not Player(source).state.aduty

end, {
	["all"] = true
})

GlobalState["AddCommand"]("dv", function(src, args)

	local source = src
	local inVeh = TriggerClientCallback(source, 'bAdmin:isInVeh')

	if inVeh then
		DeleteEntity(NetworkGetEntityFromNetworkId(inVeh))
	elseif not inVeh and args[1] then
		if tonumber(args[1]) > 0 then
			local vehPool = GetAllVehicles()
			local playerPed = GetPlayerPed(source)
			local pos = GetEntityCoords(playerPed)
			local brojBrisanja = 0

			for i = 1, #vehPool do
				if #(pos - GetEntityCoords(vehPool[i])) <= tonumber(args[1]) then
					DeleteEntity(vehPool[i])
					brojBrisanja = brojBrisanja +1
				end
			end

			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: obrisao si ".. brojBrisanja.." auta u krugu od ".. args[1] .."m!")
		else
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: udaljenost za brisanje mora biti 1 ili veca !")
		end
	else
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Nisi u vozilu i nisi kucao udaljenost za brisanje!")
	end


end, {
	["developer"] = true,
	["owner"] = true,
	["headadmin"] = true,
	["admin"] = true,
	["vodjahelpera"] = true,
})

--- ESX Komande -- 

GlobalState["AddCommand"]("setjob", function(src, args)

	if not args[1] or not args[2] or not args[3] then
		return
	end

	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

	if tPlayer then
		if ESX.DoesJobExist(args[2], tonumber(args[3])) then
			tPlayer.setJob(args[2], tonumber(args[3]))
		else
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Posao ne postoji!")
		end

	else
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Taj igrac ne postoji!")
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["headadmin"] = true,
	["admin"] = true
})


GlobalState["AddCommand"]("setgroup", function(src, args)

	if not args[1] or not args[2] then return end
	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

	if src == 0 then
		tPlayer.setGroup(args[2])
		Player(tonumber(args[1])).state.aGroup = args[2]
	else
		if tPlayer then
			tPlayer.setGroup(args[2])
			Player(tonumber(args[1])).state.aGroup = args[2]

			TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Setovao si grupu ^1%s^0 igracu ^1%s^0!", GetPlayerName(tonumber(args[1])) ,args[2]))
			TriggerClientEvent('chatMessage', tPlayer.source, string.format("^1[Sokac]^0: Setovana ti je grupa ^1%s^0 od strane clana staffa ^1%s^0!", args[2], GetPlayerName(src) ))
		end
	end

end, {
	["developer"] = true,
	["owner"] = true
})

GlobalState["AddCommand"]("setaccountmoney", function(src, args)
	if not args[1] or not args[2] or not args[2] then return end
	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

	if tPlayer.getAccount(args[2]) then
		if tPlayer then
			if src == 0 then
				tPlayer.setAccountMoney(args[2], tonumber(args[3]))
				print("novac setovan igracu")
			else
				tPlayer.setAccountMoney(args[2], tonumber(args[3]))
				TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Setovao si novac na racunu ^1%s^0 igracu ^1%s^0 na ^1%d^0!", GetPlayerName(tonumber(args[1])) ,args[2] , tonumber(args[3])))
				TriggerClientEvent('chatMessage', tPlayer.source, string.format("^1[Sokac]^0: Setovan ti je novac na racunu ^1%s^0 na ^1%d^0!", args[2], tonumber(args[3]) ))
			end
		end
	else
		TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Nevazeci racun ^1%s^0!", GetPlayerName(args[2])))
	end

end, {
	["developer"] = true,
	["owner"] = true
})

GlobalState["AddCommand"]("pare", function(src, args)
	if not args[1] or not args[2] or not args[2] then return end
	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
	if tPlayer then
		if tPlayer.getAccount(args[2]) then
			if tPlayer then
				if src == 0 then
					tPlayer.addAccountMoney(args[2], tonumber(args[3]))
					print("novac dodan igracu")
				else
					tPlayer.addAccountMoney(args[2], tonumber(args[3]))
					TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Dodao si novac na racunu ^1%s^0 igracu ^1%s^0 od ^1%d^0!", GetPlayerName(tonumber(args[1])) ,args[2] , tonumber(args[3])))
					TriggerClientEvent('chatMessage', tPlayer.source, string.format("^1[Sokac]^0: Dodan ti je novac na racunu ^1%s^0 od ^1%d^0!", args[2], tonumber(args[3]) ))
				end
			end
		else
			TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Nevazeci racun ^1%s^0!", args[2]))
		end
	else
		TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Nevazeci ID!"))
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["headadmin"] = true,
})

GlobalState["AddCommand"]("giveitem", function(src, args)
	if not args[1] or not args[2]  or not args[2] then return end
	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

	if tPlayer.getInventoryItem(args[2]) then
		if tPlayer then
			if src == 0 then
				tPlayer.addInventoryItem(args[2], tonumber(args[3]))
				print("novac dodan igracu")
			else
				tPlayer.addInventoryItem(args[2], tonumber(args[3]))
				TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Dao si igracu ^1%s^0 item ^1%s^0 komada ^1%d^0!", GetPlayerName(tonumber(args[1])) ,args[2] , tonumber(args[3])))
				TriggerClientEvent('chatMessage', tPlayer.source, string.format("^1[Sokac]^0: Dodan ti je item ^1%s^0 komada ^1%d^0!", args[2], tonumber(args[3]) ))
			end
		end
	else
		TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Nevazeci racun ^1%s^0!", GetPlayerName(args[2])))
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["headadmin"] = true,
})


GlobalState["AddCommand"]("clearinventory", function(src, args)
	if not args[1] then return end
	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

	if tPlayer then
		if src == 0 then
			for k,v in ipairs(tPlayer.getInventory()) do
				if v.count > 0 then
					tPlayer.setInventoryItem(v.name, 0)
				end
			end
			print("Inventory obrisan igracu")
		else
			for k,v in ipairs(tPlayer.getInventory()) do
				if v.count > 0 then
					tPlayer.setInventoryItem(v.name, 0)
				end
			end
			TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Obrisao si inventory igracu ^1%s^0!", GetPlayerName(tonumber(args[1])) ))
			TriggerClientEvent('chatMessage', tPlayer.source, string.format("^1[Sokac]^0: Obrisan ti je inventory od strane ^1%s^0!", GetPlayerName(src)))
		end
	end
	
end, {
	["developer"] = true,
	["owner"] = true
})

--------

GlobalState["AddCommand"]("kick", function(src, args)
	if not args[1] then return end

	local kicker = GetPlayerName(src) or "N/N"
	local razlog = args[2] or "Nije poznat!"

	local str = "\n\nKickovan si sa servera od strane: "..kicker.."\nRazlog: " .. razlog
	if GetPlayerName(tonumber(args[1])) then
		DropPlayer(tonumber(args[1]), str)
		TriggerClientEvent('chatMessage', src, string.format("^1[Sokac]^0: Kikovao si igraca ^1%s^0!", GetPlayerName(tonumber(args[1])) ))
	end

end, {
	["all"] = true,
})

function StringSplit(s, argumenti)
    local result = ""
    local count = 0

    for match in (s.." "):gmatch("(.-) ") do
    	if count > argumenti then
    		result = result .. " " .. match
    	end
    	count = count +1
    end

    

    return result;
end

GlobalState["AddCommand"]("ban", function(src, args, grupa, rawCommand)
	if not args[1] or not args[2] then return end

 	local banned_id = tonumber(args[1])
 	local banned_time = tonumber(args[2])
 	local razlog = "Nije naveden"

	if args[3] then
		razlog = StringSplit(rawCommand, 2)
	end

	TriggerEvent("bAdmin:meni:ban", banned_id, razlog, tonumber(args[2]), src)
	 
end, {
	["developer"] = true,
	["owner"] = true,
})

GlobalState["AddCommand"]("goto", function(src, args)
	if not args[1] then return end

	local tigrac = ESX.GetPlayerFromId(tonumber(args[1]))

	if tigrac then
		backGOTO[tostring(src)] = GetEntityCoords(GetPlayerPed(src))

		SetEntityCoords(GetPlayerPed(src), GetEntityCoords(GetPlayerPed(tonumber(args[1]))), 0, 0, 0, 0)

		TriggerClientEvent('chatMessage', tigrac.source, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 se teleportovao do tebe!")
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Teleportovao si se do ^1".. GetPlayerName(tigrac.source) .."^0!")
	end

end, {
	["all"] = true,
})


local ZadnjaPozicijaTPM = {}

GlobalState["AddCommand"]("vratime", function(source, args)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)

		local playerCoords = savedCoords[source]
		if playerCoords then
			xPlayer.setCoords(playerCoords)
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'success',
				title = 'STAFF',
				message = 'Vratio si se na zadnju poziciju',
			})
			savedCoords[source] = nil
			
		elseif ZadnjaPozicijaTPM[source] then
			xPlayer.setCoords(ZadnjaPozicijaTPM[source])
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'success',
				title = 'STAFF',
				message = 'Vratio si se na zadnju poziciju',
			})
			ZadnjaPozicijaTPM[source] = nil
		else
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'error',
				title = 'STAFF',
				message = 'Nije pronađena zadnja pozicija',
			})
		end
	end
end, {
	["all"] = true,
})


GlobalState["AddCommand"]("flip", function(source, args)
	TriggerClientEvent("bAdmin:FlipAuto", source)
end, {
	["all"] = true,
})





savedCoords   = {}
GlobalState["AddCommand"]("bring", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local grupa = xPlayer.getGroup()

	if args[1] and tonumber(args[1]) then
		local targetId = tonumber(args[1])
		local xTarget = ESX.GetPlayerFromId(targetId)
		if xTarget then
			targetCoords = GetEntityCoords(GetPlayerPed(targetId))
			local playerCoords = xPlayer.getCoords()
			savedCoords[targetId] = targetCoords
			SetEntityCoords(GetPlayerPed(targetId), GetEntityCoords(GetPlayerPed(source)))

			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'info',
				title = 'STAFF',
				message = 'Portao si igraca ' ..GetPlayerName(targetId).. ' do sebe',
			})

			TriggerClientEvent('eleNotif:Notify', targetId, {
				type = 'info',
				title = 'STAFF',
				message = 'Admin '..GetPlayerName(source).. ' te portao do sebe' ,
			})

		else
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'info',
				title = 'STAFF',
				message = 'Igrac nije u gradu' ,
			})
		end
	else
		TriggerClientEvent('eleNotif:Notify', source, {
			type = 'error',
			title = 'STAFF',
			message = 'Nevazeca komanda' ,
		})
	end
end, {
	["all"] = true,
	["vodjahelpera"] = true,
})


GlobalState["AddCommand"]("vrati", function(source, args)

	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
		if args[1] and tonumber(args[1]) then
			local targetId = tonumber(args[1])
			local xTarget = ESX.GetPlayerFromId(targetId)
			if xTarget then
				local playerCoords = savedCoords[targetId]
				if playerCoords then
				SetEntityCoords(GetPlayerPed(targetId),playerCoords)
				TriggerClientEvent('eleNotif:Notify', source, {
					type = 'info',
					title = 'STAFF',
					message = 'Vratio si igraca ' ..GetPlayerName(targetId).. ' na prvobitni polozaj',
				})
				TriggerClientEvent('eleNotif:Notify', targetId, {
					type = 'info',
					title = 'STAFF',
					message = 'Admin ' ..GetPlayerName(source).. ' te vratio na prvobitni polozaj',
				})
				savedCoords[targetId] = nil
			else
				TriggerClientEvent('eleNotif:Notify', source, {
					type = 'info',
					title = 'STAFF',
					message = 'Nije pronađena zadnja pozicija',
				})
			end
		else
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'info',
				title = 'STAFF',
				message = 'Nema igraca u gradu',
			})
			end
		else
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'error',
				title = 'STAFF',
				message = 'Nevazeca komanda',
			})
		end
	end
end, {
	["all"] = true,
})





GlobalState["AddCommand"]("tpm", function(src, args)
	TriggerClientEvent("bAdmin:tpm", src)
	backGOTO[tostring(src)] = GetEntityCoords(GetPlayerPed(src))
end, {
	["all"] = true,
})

GlobalState["AddCommand"]("tp", function(src, args)

	if not tonumber(args[1]) or not tonumber(args[2]) or not tonumber(args[3]) then
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Potrebno je da uneses 3 koordinate, x, y i z!")
		return
	end

	TriggerClientEvent("bAdmin:tp", src, args)
end, {
	["all"] = true,
	["vodjahelpera"] = true,
})

GlobalState["AddCommand"]("sethelper", function(src, args)

	if not args[1] then return end

	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
	if tPlayer then
		tPlayer.setGroup("helper")
		Player(tonumber(args[1])).state.aGroup = "helper"

		TriggerClientEvent('chatMessage', tPlayer.source, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 ti je dao role ^1HELPER^0!")
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Setao si role ^1HELPER^0 igracu ^1".. GetPlayerName(tPlayer.source) .."^0!")
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["admin"] = true,
	["headadmin"] = true
})


GlobalState["AddCommand"]("setv", function(src, args)

	if not args[1] then return end

	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
	if tPlayer then
		tPlayer.setGroup("owner")
		Player(tonumber(args[1])).state.aGroup = "owner"

		TriggerClientEvent('chatMessage', tPlayer.source, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 ti je dao role ^1owner^0!")
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Setao si role ^1owner^0 igracu ^1".. GetPlayerName(tPlayer.source) .."^0!")
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["admin"] = true,
	["helper"] = true,
	["headadmin"] = true
})


GlobalState["AddCommand"]("coords", function(src, args)
	TriggerClientEvent("bAdmin:pozicija", src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["admin"] = true,
	["headadmin"] = true
})


GlobalState["AddCommand"]("checkmoney", function(src, args)

	if not args[1] then return end

	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
	if tPlayer then

		local racun = "cash"
		local novac = 0

		if not args[2] then
			novac = tPlayer.getMoney()
		elseif args[2] then
			novac = tPlayer.getAccount(args[2]).money
			racun = args[2]
		end

		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: igrac ".. GetPlayerName(tPlayer.source) .." ima ".. novac .."$ na racunu "..racun.."!")
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["admin"] = true,
	["headadmin"] = true
})

local frozen = {}
GlobalState["AddCommand"]("freeze", function(src, args)

	if not args[1] then return end

	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
	if tPlayer then

		frozen[args[1]] = not frozen[args[1]]
		FreezeEntityPosition(GetPlayerPed(tPlayer.source), frozen[args[1]])

		if frozen[args[1]] then
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Freezao si igraca ".. GetPlayerName(tPlayer.source) .."!")
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Clan staffa ".. GetPlayerName(src) .." te je freezao!")
		else
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Unfreezao si igraca ".. GetPlayerName(tPlayer.source) .."!")
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Clan staffa ".. GetPlayerName(src) .." te je unfreezao!")
		end
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["admin"] = true,
	["headadmin"] = true
})


local DozvoljenaAuta = {
	["admin"] = {
		["blista"] = true,
		["bmx"] = true
	}
}

GlobalState["AddCommand"]("car", function(src, args, grupa)

	if not args[1] then return end

	local dozvoljeno = false

	if DozvoljenaAuta[grupa] then
		if DozvoljenaAuta[grupa][args[1]] then
			dozvoljeno = true
		end
	else
		dozvoljeno = true
	end

	if dozvoljeno then

		local model = GetHashKey(args[1])
		local postojili = TriggerClientCallback(src, 'bAdmin:doesVehExist', model)

		if postojili then
			print("aut")
			local pos = GetEntityCoords(GetPlayerPed(src))
			local heading = GetEntityHeading(GetPlayerPed(src))

			local veh = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, model, pos, heading )
			Wait(500)
			TaskWarpPedIntoVehicle(GetPlayerPed(src), veh, -1)
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Spawnao si vozilo ^1'"..args[1].."'^0!")
		else
			TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Vozilo sa spawn kodom ^1'"..args[1].."'^0 ne postoji!")
		end

	else
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Nemas dozvolu da spawnas vozilo ^1'"..args[1].."'^0!")
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["admin"] = true,
	["admin"] = true,
	["headadmin"] = true,
	["user"] = true,
	["vodjahelpera"] = true,

})


GlobalState["AddCommand"]("setadmin", function(src, args)

	if not args[1] then return end

	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
	if tPlayer then
		tPlayer.setGroup("admin")
		Player(tonumber(args[1])).state.aGroup = "admin"

		TriggerClientEvent('chatMessage', tPlayer.source, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 ti je dao role ^1ADMIN^0!")
		TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Setao si role ^1ADMIN^0 igracu ^1".. GetPlayerName(tPlayer.source) .."^0!")
	end

end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true
})



RegisterServerEvent("bAdmin:AutouBazu") 
AddEventHandler("bAdmin:AutouBazu", function(props, id)

	local source = source 
	local src = id
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer then
		exports.oxmysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = props.plate,
			['@vehicle'] = json.encode(props),
		}, function (rowsChanged)
			TriggerClientEvent('eleNotif:Notify', source, {
				type = 'success',
				title = 'Info',
				message = 'Dao si auto sa tablicama ' ..props.plate.. ' osobi ' ..GetPlayerName(src)
			})
		end)
	else
		TriggerClientEvent('eleNotif:Notify', source, {
			type = 'success',
			title = 'Info',
			message = 'Nema igraca sa tim ID-om'
		})
	end

end)

ESX.RegisterServerCallback("badmin:ProvjeriAdmin_c", function(source, cb, helper)

	local help = helper

	ImalAdmina(source, help, function(imal)
	
		if imal then
			cb(true)
		else
			cb(false)
		end
	
	end)


end)


GlobalState["AddCommand"]("vipmeni", function(src, args)
		
	local igraci, don = {}, {}
    local src = source
    local numPlayers = GetPlayers()

    local result = exports.ghmattimysql:executeSync("SELECT * FROM autosalon WHERE kategorija = @cat", {['@cat'] = "donatorsko"})
    local donatori = exports.ghmattimysql:executeSync("SELECT * FROM users WHERE vip = 1", {})

    for i = 1, #donatori do 
        table.insert(don, {
            label = donatori[i].ime,
            steam = donatori[i].identifier
        })
    end

    for i = 1, #numPlayers do
        table.insert(igraci, {
            label = GetPlayerName(tonumber(numPlayers[i])),
            steam = GetPlayerIdentifier(tonumber(numPlayers[i]))
        })
    end

    TriggerClientEvent("bSalon_VipSend", src, igraci, result, don)

end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true
})
--[[ 
GlobalState["AddCommand"]("dajauto", function(src, args)
	if not args[1] or not args[2] then
		return
	end

	TriggerClientEvent("bAdmin:DajAuto", src, args)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true
}) ]]

GlobalState["AddCommand"]("noclip", function(src, args)
	TriggerClientEvent("bAdmin:noclip", src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
	["vodjahelpera"] = true,
})

GlobalState["AddCommand"]("fix", function(src, args)
	TriggerClientEvent("bAdmin:fixveh", src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
})

GlobalState["AddCommand"]("revive", function(src, args)
	TriggerEvent('bAdmin:revive', src, args)
	TriggerClientEvent("reload_death:revive", args[1] or src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
	["vodjahelpera"] = true,
})

GlobalState["AddCommand"]("heal", function(src, args)
	TriggerClientEvent("esx_basicneeds:healPlayer", tonumber(args[1]) or src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
})

GlobalState["AddCommand"]("slay", function(src, args)
	TriggerClientEvent("bAdmin:slay", tonumber(args[1]) or src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
})

GlobalState["AddCommand"]("skin", function(src, args)
	 TriggerClientEvent('cui_character:open', src or tonumber(args[1]), { 'identity', 'features', 'style', 'apparel' })
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
})

GlobalState["AddCommand"]("id", function(src, args)
	 TriggerClientEvent('bAdmin:showIDs', src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
	["vodjahelpera"] = true,
})

GlobalState["AddCommand"]("adminmeni", function(src, args)
	 TriggerClientEvent('bAdmin:meni:show', src)
end, {
	["all"] = true,
})

GlobalState["AddCommand"]("delobjekt", function(src, args)
	 TriggerClientEvent('bAdmin:delObjekt', src)
end, {
	["developer"] = true,
	["owner"] = true,
	["direktor"] = true,
	["headadmin"] = true,
	["admin"] = true,
})

GlobalState["AddCommand"]("updateESX", function(src, args)
	 TriggerEvent('bAdmin:UpdateExtended')
end, {
	["developer"] = true,
	["owner"] = true,
})

print("^1[Sokac]^0: Komande ucitane !")

AddEventHandler("playerConnecting", function()
	local src = source

	print(json.encode(GetPlayerIdentifiers(src)))

end)


RegisterNetEvent("bAdmin:meni:kick", function(id, razlog)
	local src = source
	local playerid = tonumber(id)
	local igrac = ESX.GetPlayerFromId(src)

	if GetPlayerName(playerid) then
		if igrac.getGroup() ~= "user" then

			local reason = razlog or "Nije poznat!"
			local str = "\n\nKickovan si sa servera od strane: "..GetPlayerName(src).."\nRazlog: " .. reason
			DropPlayer(playerid, str)

		end
	end

end)

RegisterServerCallback("bAdmin:meni:fetchIgraci", function(source)

	local igraci = GetPlayers()
	local sendIgraci = {}

	for i = 1, #igraci do
		table.insert(sendIgraci, {
			id = tonumber(igraci[i]),
			name = GetPlayerName(igraci[i])
		})
	end

	return sendIgraci

end)

GlobalState["invisiblePlayers"] = {}

RegisterNetEvent("bAdmin:AddToInvisible", function()
	local playerid = source
	local igrac = ESX.GetPlayerFromId(playerid)

	if igrac.getGroup() ~= "user" then
		GlobalState["invisiblePlayers"][tostring(playerid)] = true 
	end

end)

RegisterNetEvent("bAdmin:RemoveFromInvisible", function(RouteBeforeSpec)
	local InvisP = GlobalState["invisiblePlayers"]
	if InvisP[tostring(source)] then
		InvisP[tostring(source)] = nil
		GlobalState["invisiblePlayers"] = InvisP

		if RouteBeforeSpec then
			SetPlayerRoutingBucket(source, 0)
		end
		
		TriggerClientEvent("bAdmin:ForwardDeleteInvisPlayer", -1, tostring(source))
	end
end)

RegisterServerCallback("bAdmin:StartSpectate", function(source, id)
	local playerid = source
	local targetSrc = tonumber(id)
	local igrac = ESX.GetPlayerFromId(playerid)

	if igrac.getGroup() ~= "user" then
		if GetPlayerName(targetSrc) then

			local pRB = GetPlayerRoutingBucket(targetSrc)
			if pRB ~= 0 then
				SetPlayerRoutingBucket(playerid)
			end

			local OtherCoords = GetEntityCoords(GetPlayerPed(targetSrc))
			local srcCoords = GetEntityCoords(GetPlayerPed(playerid))
			SetEntityCoords(GetPlayerPed(playerid), OtherCoords + vector3(0.0, 0.0, - 50.0), 0, 0, 0, 0)
			Wait(500)
			return targetSrc, srcCoords
		end
	end

	return false
end)

RegisterServerCallback("bAdmin:StartSpectate2", function(source, id)
	local playerid = source
	local targetSrc = tonumber(id)
	local igrac = ESX.GetPlayerFromId(playerid)

	if igrac.getGroup() ~= "user" then
		
		local OtherCoords = GetEntityCoords(GetPlayerPed(targetSrc))
		SetEntityCoords(GetPlayerPed(playerid), OtherCoords + vector3(0.0, 0.0, - 50.0), 0, 0, 0, 0)
		Wait(500)
		return OtherCoords
	end

	return false
end)

RegisterNetEvent("bAdmin:objektDel", function(netID)
	DeleteEntity(NetworkGetEntityFromNetworkId(netID))
end)

RegisterNetEvent("bAdmin:KickAFK", function()
	local src = source
	DropPlayer(src, "Kickovan si sa servera jer si bio AFK!")
end)

RegisterNetEvent("bAdmin:TeleportTo", function(playerId)
	local src = source

	backGOTO[tostring(src)] = GetEntityCoords(GetPlayerPed(src))

	SetEntityCoords(GetPlayerPed(src), GetEntityCoords(GetPlayerPed(playerId)))

	TriggerClientEvent('chatMessage', playerId, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 se teleportovao do tebe!")
	TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Teleportovao si se do ^1".. GetPlayerName(playerId) .."^0")

end)

RegisterNetEvent("bAdmin:ToTeleport", function(playerId)
	local src = source

	backBRING[tostring(playerId)] = GetEntityCoords(GetPlayerPed(playerId))

	SetEntityCoords(GetPlayerPed(playerId), GetEntityCoords(GetPlayerPed(src)))

	TriggerClientEvent('chatMessage', playerId, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 te je teleportovao do sebe!")
	TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: Teleportovao si ^1".. GetPlayerName(playerId) .."^0 do sebe!")
end)


local FrozenStatus = {}
local FreezeStatusMessage = {
	[false] = "unfreezao",
	[true] = "freezao"
}

RegisterNetEvent("bAdmin:freeze", function(playerId)
	local src = source

	FrozenStatus[playerId] = not FrozenStatus[playerId]
	FreezeEntityPosition(GetPlayerPed(playerId), FrozenStatus[playerId])

	TriggerClientEvent('chatMessage', playerId, "^1[Sokac]^0: Clan staffa ^1".. GetPlayerName(src) .."^0 te je ^1".. FreezeStatusMessage[FrozenStatus[playerId]] .."^0!")
	TriggerClientEvent('chatMessage', src, "^1[Sokac]^0: ^1".. FreezeStatusMessage[FrozenStatus[playerId]] .."^0 si ^1".. GetPlayerName(playerId) .."^0!")
end)

------------------REP


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)

Citizen.CreateThread(function()

    local tBaza = LoadResourceFile(GetCurrentResourceName(), "/s_utils/reporti.json")
    REPORTI = json.decode(tBaza)

    while true do 
        Citizen.Wait(10000)
		SaveResourceFile(GetCurrentResourceName(), "/s_utils/reporti.json", json.encode(REPORTI, {indent = true}), -1)
    end
end)



Staff = {}

Citizen.CreateThread(function()
	staff = exports.oxmysql:executeSync('SELECT * FROM users WHERE staff="true" OR `group`="superadmin" OR `group`="admin" OR `group`="owner" OR `group`="headadmin"')
	while true do
		local StaffZaPoslat = {}

		for i = 1, #staff do
			if not staff[i].iskljucio then
				local igrac = ESX.GetPlayerFromIdentifier(staff[i].identifier)
				if igrac then
					table.insert(StaffZaPoslat, { src = igrac.source, ime = staff[i].ime, grupa = staff[i].group, speca = staff[i].speca or false  } )
				end
			end
			Citizen.Wait(5)
		end

		TriggerClientEvent("bSvastara:SviAdminiShow", -1, StaffZaPoslat)
		Citizen.Wait(2000)
	end

end)


function ImalAdmina(source, helper, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ID = xPlayer.identifier
	
	for i = 1, #staff do
		if staff[i].identifier == ID then
			if helper then
				if staff[i].group == "superadmin" or staff[i].group == "admin" or staff[i].group == "owner"  or staff[i].group == "headadmin"  or staff[i].group == "vodjahelpera" or staff[i].staff == "true" then
					if not staff[i].iskljucio then
						cb(true, staff[i].group)
						break
					else
						cb(false)
						break
					end
				else
					cb(false)
					break
				end
			else
				if staff[i].group == "superadmin" or staff[i].group == "admin" or staff[i].group == "owner" or staff[i].group == "headadmin"  or staff[i].group == "vodjahelpera" then
					if not staff[i].iskljucio then
						cb(true, staff[i].group)
						break
					else
						cb(false)
						break
					end
				else
					cb(false)
					break
				end
			end
		end
	end
end



RegisterCommand("vrati", function(source, args, rawCommand)	-- /bringback [ID] will teleport player back where he was before /bring
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'owner'  or xPlayer.getGroup() == 'headadmin' or xPlayer.getGroup() == 'vodjahelpera' then
				if args[1] and tonumber(args[1]) then
					local targetId = tonumber(args[1])
					local xTarget = ESX.GetPlayerFromId(targetId)
					if xTarget then
						local playerCoords = savedCoords[targetId]
						if playerCoords then
						SetEntityCoords(GetPlayerPed(targetId),playerCoords)
						TriggerClientEvent('eleNotif:Notify', source, {
							type = 'info',
							title = 'STAFF',
							message = 'Vratio si igraca ' ..GetPlayerName(targetId).. ' na prvobitni polozaj',
						})
						TriggerClientEvent('eleNotif:Notify', targetId, {
							type = 'info',
							title = 'STAFF',
							message = 'Admin ' ..GetPlayerName(source).. ' te vratio na prvobitni polozaj',
						})
						savedCoords[targetId] = nil
					else
						TriggerClientEvent('eleNotif:Notify', source, {
							type = 'info',
							title = 'STAFF',
							message = 'Nije pronađena zadnja pozicija',
						})
					end
				else
					TriggerClientEvent('eleNotif:Notify', source, {
						type = 'info',
						title = 'STAFF',
						message = 'Nema igraca u gradu',
					})
					end
				else
					TriggerClientEvent('eleNotif:Notify', source, {
						type = 'error',
						title = 'STAFF',
						message = 'Nevazeca komanda',
					})
				end
		end
	end
end, false)

RegisterCommand('reply', function(source, args, rawCommand)
	src = source
	ImalAdmina(src, true, function(imal, grupa)
		if imal then
			local rank = ""

			if grupa == "user" then
				rank = "HELPER"
			else
				rank = "ADMIN"
			end

			local xPlayer = ESX.GetPlayerFromId(src)
			local cm = stringsplit(rawCommand, ' ')
			local formatOfMessage = '<b><font color=red>[{0}]:</b></font> {1}</div>'
			
			local tPID = tonumber(cm[2])
			local names2 = GetPlayerName(tPID)
			local names3 = GetPlayerName(source)

			if names2 then
				local textmsg = ''
				for i=1, #cm do
					if i ~= 1 and i ~=2 then
						textmsg = (textmsg .. ' ' .. tostring(cm[i]))
					end
				end

				for i = 1, #staff do
					if not staff[i].iskljucio then
						local xPlayer = ESX.GetPlayerFromIdentifier(staff[i].identifier)
		
						if xPlayer then
							TriggerClientEvent('chat:addMessage', xPlayer.source, {
								template = formatOfMessage,
								args = {"^1ODGOVOR^1", " ^9(^1" .. GetPlayerName(source) .." - ^1".. xPlayer.getGroup() .."^1 | "..source.." --> ^2" .. names2 .. " | ".. tPID .."^9) : ^0"  .. textmsg}
							})
						end
					end
				end

				TriggerClientEvent('chat:addMessage', tPID, {
					template = formatOfMessage,
					args = {"^1ODGOVOR^1", " ^9(^1" .. GetPlayerName(source) .." - ^1".. xPlayer.getGroup() .."^1 | "..source.." --> ^2" .. names2 .. " | ".. tPID .."^9) : ^0"  .. textmsg}
				})


				if xPlayer.getGroup() == "user" then
					grupa = "Helper"
				else
					grupa = "Admin"
				end
				
				if REPORTI[GetPlayerIdentifier(src)] then
					REPORTI[GetPlayerIdentifier(src)] = REPORTI[GetPlayerIdentifier(src)] + 1
				else
					REPORTI[GetPlayerIdentifier(src)] = 1
				end

				local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())
				local text = string.format("%s **%s** je ODGOVORIO na report igraca **%s**, a poruka glasi:\n> %s\n\n_Broj odgovorenih reporta: **%d**_", grupa,  names3, names2, textmsg, REPORTI[GetPlayerIdentifier(src)])
				local embed = {
					{   
						["color"] = 6866900,
						["description"] = text,
						["footer"] = {
							["text"] = vrijeme,
						},
					}
				}
				PerformHttpRequest("https://discord.com/api/webhooks/920331165313937408/N6jhsv1PNRmSYrzbQl-wphsCBQH-MAHK76WO48rlT4V0qZAoUFoFL_y7W6loLoXPa-f1", function(err, text, headers) end, 'POST', json.encode({username = "REPORT REPLY SYSTEM", embeds = embed}), { ['Content-Type'] = 'application/json' })
				

			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, 'Igrac je offline ili je pogresan ID')
			end

		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, 'Nisi clan STAFFa!')
		end	
	end)

end, false)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end



-----------------------REPORTOVANJE
Reporti = {}

RegisterCommand("report", function(source, args)

	local src = source
	local MorelPoslat = true

	if Reporti[src] then
		if Reporti[src] > os.time() then
			MorelPoslat = false
		end
	end

	if MorelPoslat then

		local formatOfMessage = '<div </i> {0}:</b></font> {1}</div>'
		TriggerClientEvent('chat:addMessage', src, {
			template = formatOfMessage,
			args = {"^1[ TVOJ REPORT ]", " ^2(^2" .. GetPlayerName(src) .. "^2 | " .. src .. "^2): ^1 ^*" .. table.concat(args, " ")}
		})
		
		for i = 1, #staff do
			if not staff[i].iskljucio then
				local xPlayer = ESX.GetPlayerFromIdentifier(staff[i].identifier)
				local formatOfMessage = '<b><font color=red>{0}:</b></font> {1}</div>'
				if xPlayer then
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = formatOfMessage,
						args = {"^1[ NOVI REPORT ]", " ^2[Igrac --> ^0" .. GetPlayerName(src) .." | ID : "..src.."^2]: ^0 ^*" .. table.concat(args, " ")}
					})
				end

			end
		end
		
		local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())
		local text = string.format("**%s** je POSLAO report koji glasi: \n> %s", GetPlayerName(src), table.concat(args, " "))
		local embed = {
			{   
				["color"] = 15158332,
				["description"] = text,
				["footer"] = {
					["text"] = vrijeme,
				},
			}
		}
		PerformHttpRequest("https://discord.com/api/webhooks/920331165313937408/N6jhsv1PNRmSYrzbQl-wphsCBQH-MAHK76WO48rlT4V0qZAoUFoFL_y7W6loLoXPa-f1", function(err, text, headers) end, 'POST', json.encode({username = "REPORT REPLY SYSTEM", embeds = embed}), { ['Content-Type'] = 'application/json' })


		Reporti[src] = os.time() + 15

	else
		TriggerClientEvent("bfunkcije:notif", src, "", "Moras cekati 15 sekundi do sljedeceg reporta!", 5, false)
	end

end)

------------------ ANNOUNCE 


msg = ""
ime = test
RegisterCommand('announce', function(source, args, ime)
	local ime = GetPlayerName(source)
	ImalAdmina(source, true, function()
		for i,v in pairs(args) do
			msg = msg .. " " .. v
			ime = GetPlayerName(source)
		end
		TriggerClientEvent("announce", -1, msg, ime)
		msg = ""
		ime = test
    end)
end)



RegisterCommand("admini", function(source, args)

	local src = source

	TriggerClientEvent('chat:addMessage', src, {
		args = {"----------------\n^5SVI ONLINE ADMINI", "----------------"}
	})

	for i = 1, #staff do
		local igrac = ESX.GetPlayerFromIdentifier(staff[i].identifier)
		if igrac then
			if staff[i].iskljucio then Aktivan = "Nije" else Aktivan = "Jest" end

			if staff[i].group == "user" then
				TriggerClientEvent('chat:addMessage', src, {
					args = {string.format("HELPER: ^5%s", staff[i].ime), string.format("^7Aktivan: ^5%s", Aktivan)}
				})
			else
				TriggerClientEvent('chat:addMessage', src, {
					args = {string.format("Admin: ^5%s", staff[i].ime), string.format("Level: ^5%s, ^7Aktivan: ^5%s", staff[i].group, Aktivan)}
				})
			end
		end
	end

	TriggerClientEvent('chat:addMessage', src, {
		args = {"--------------------------------", "----------------"}
	})

end)
