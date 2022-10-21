local CachedIgraci = {}

local checkingIdent = {
	["discord"] = true,
	["username"] = true,
	["steam"] = true,
	["license"] = true,
	["xbl"] = true,
	["live"] = true,
	["discord"] = true,
	["license2"] = true,
	["ip"] = true,
	["fivem"] = true,
}

AddEventHandler("playerDropped", function(reason)
    local src = source
    local ime = GetPlayerName(src)
    local IPCH = GetPlayerEndpoint(src)

    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(id, "steam:") then
            steamCH = string.gsub(id, "", "")
        end

        if string.match(id, "license:") then
            fivemCH = string.gsub(id, "", "")
        end

  		if string.match(id, "discord:") then
  			discordIdCH = string.gsub(id, "", "")
        end
    end
	local reason = reason
	table.insert(CachedIgraci, {
		source = src,
		ime = ime,
        steam = steamCH,
        fivem = fivemCH,
        IP = IPCH,
        discordID = discordIdCH,
		reason = reason
    })

	GlobalState["CachedIgraci"] = CachedIgraci, {
		source = src,
		ime = ime,
        steam = steamCH,
        fivem = fivemCH,
        IP = IPCH,
        discordID = discordIdCH,
		reason = reason
    } 
	print(json.encode(CachedIgraci))

    exports.oxmysql:execute("UPDATE users SET zadnjiput=@vrijeme WHERE identifier=@steamID", {['@vrijeme'] = os.date('%Y-%m-%d %H:%M:%S', os.time()), ['@steamID'] = steamCH})

end)



AddEventHandler("esx:playerLoaded", function(playerid)
	local src = playerid
	for k,v in pairs(CachedIgraci) do
		if CachedIgraci[k].name == GetPlayerName(src) then
			CachedIgraci[k] = nil
			break
		end
	end
end)

function CheckBanList(username, identifiers)

	local query, poruka

	query = 'SELECT * FROM bBanovi WHERE username = "' .. username ..'"'

    for _, v in pairs(identifiers) do
		local ltype, _ = v:match("(.+):(.+)")

		if checkingIdent[ltype] then
			query = string.format(' %s OR  %s = "%s"', query, ltype, v)
		end
    end

    local result = exports.oxmysql:executeSync(query, {})

    if result[1] then
    	if os.time() >= result[1].ban_expire  then
    		exports.oxmysql:executeSync("DELETE FROM bBanovi WHERE id = @id", { ['@id'] = result[1].id })
    		return false
    	else
	    	poruka = string.format(
	    		"\n———————————————————————————\n💢 𝗕𝗔𝗡𝗢𝗩𝗔𝗡/𝗔 𝘀𝗶 𝘀𝗮 𝗘𝗹𝗲𝗺𝗲𝗻𝘁 𝗥𝗼𝗹𝗲𝗽𝗹𝗮𝘆 𝘀𝗲𝗿𝘃𝗲𝗿𝗮! 💢\n\n🇧🇦🇳 🇮🇩: %d\n🇧🇦🇳🇴🇻🇦🇳 🇴🇩: %s\n🇷🇦🇿🇱🇴🇬: %s\n🇩🇦🇹🇺🇲 🇧🇦🇳-🇦: %s\n🇧🇦🇳 🇮🇸🇹🇮🇨🇪: %s\n———————————————————————————",
	    		result[1].id, result[1].banned_by, result[1].reason, os.date('%Y-%m-%d %H:%M:%S', result[1].ban_date), os.date('%Y-%m-%d %H:%M:%S', result[1].ban_expire)
	    	)
	    	return true, poruka
	    end
    end

    return false
end

RegisterServerCallback('bAdmin:fetchBanned', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Banovi = exports.oxmysql:executeSync('SELECT * FROM bBanovi')
	return Banovi
end)

RNE("bAdmin:meni:unban", function(banid)
	print(json.encode(banid))
	exports.oxmysql:executeSync("DELETE FROM bBanovi WHERE id = ?", {
		banid
   })
   print(json.encode(id))
   print("unbanovan")
end)

RegisterNetEvent("bAdmin:meni:ban", function(playerID, razlog, duzina, serverid)

	local banned_id = playerID
	local banned_name = GetPlayerName(playerID)

	if serverid then
		source = serverid
	end
	
	if banned_name then 
		print(banned_name)
		local identifiers = {}

		for k,v in pairs(checkingIdent) do
			identifiers[k] = nil
		end

		for _, v in pairs(GetPlayerIdentifiers(banned_id)) do
			local ltype, _ = v:match("(.+):(.+)")
			if checkingIdent[ltype] then
				identifiers[ltype] = v
			end
    	end

		local banned_reason = razlog
		local banned_when = os.time()
		local ban_lenght = duzina * 86400

		exports.oxmysql:execute("INSERT INTO bBanovi (banned_by, reason, username, ban_date, ban_expire, steam, license, xbl, live, discord, license2, ip, fivem) VALUES (@banned_by, @reason, @username, @ban_date, @ban_expire, @steam, @license, @xbl, @live, @discord, @license2, @ip, @fivem)", {
			["@banned_by"] = banned_by, 
			["@reason"] = banned_reason, 
			["@username"] = banned_name, 
			["@ban_date"] = banned_when, 
			["@ban_expire"] = os.time() + ban_lenght, 
			["@steam"] = identifiers["steam"], 
			["@license"] = identifiers["license"], 
			["@xbl"] = identifiers["xbl"], 
			["@live"] = identifiers["live"], 
			["@discord"] = identifiers["discord"], 
			["@license2"] = identifiers["license2"], 
			["@ip"] = identifiers["ip"], 
			["@fivem"] = identifiers["fivem"]
		})

		print(json.encode(banned_name))
		local poruka = string.format(
    		"\n———————————————————————————\n💢 𝗕𝗔𝗡𝗢𝗩𝗔𝗡/𝗔 𝘀𝗶 𝘀𝗮 𝗘𝗹𝗲𝗺𝗲𝗻𝘁 𝗥𝗼𝗹𝗲𝗽𝗹𝗮𝘆 𝘀𝗲𝗿𝘃𝗲𝗿𝗮! 💢\n\n🇧🇦🇳🇴🇻🇦🇳 🇴🇩: %s\n🇷🇦🇿🇱🇴🇬: %s\n🇩🇦🇹🇺🇲 🇧🇦🇳-🇦: %s\n🇧🇦🇳 🇮🇸🇹🇮🇨🇪: %s\n———————————————————————————",
    		banned_by, banned_reason, os.date('%Y-%m-%d %H:%M:%S', banned_when), os.date('%Y-%m-%d %H:%M:%S', os.time() + ban_lenght)
    	)

		DropPlayer(banned_id, poruka)
	else 
		print("nu")
	end

end)