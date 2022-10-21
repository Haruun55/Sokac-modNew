ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('esx:playerLoaded', function(source)


    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ImeIgraca = GetPlayerName(_source)
    local id = xPlayer.identifier

    while xPlayer == nil do
        Citizen.Wait(10)
    end

    exports.oxmysql:execute('SELECT * FROM users WHERE identifier = @id', {["id"] = id }, function(igrac)
        if (igrac[1].ime == nil) or (igrac[1].ime == "") then
            Citizen.CreateThread(function()
                exports.oxmysql:execute("UPDATE users SET ime=@name WHERE identifier=@id", {['@id'] = id, ['@name'] = ImeIgraca})
            end)
            print(id)
        end



        if (igrac[1].identifier == id) and (ImeIgraca ~= igrac[1].ime) then

            Citizen.CreateThread(function()
                exports.oxmysql:execute("UPDATE users SET ime=@name WHERE identifier=@id", {['@id'] = id, ['@name'] = ImeIgraca})
            end)

        end

    end)

end)

function IDeviIgraca(source)

    local src = source
    
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(id, "steam:") then
            steamCH = string.gsub(id, "", "")
        end

        if string.match(id, "license:") then
            fivemCH = string.gsub(id, "", "")
        end

        if string.match(id, "ip:") then
            IPCH = string.gsub(id, "", "")
        end

  		if string.match(id, "discord:") then
  			discordIdCH = string.gsub(id, "", "")
        end
    end


    IDovi = {}
    IDovi = {
        steam = steamCH, 
        fivem = fivemCH, 
        discord = discordIdCH, 
        ip = IPCH
    }

    return(IDovi)

end

Sistem = {ime = "Sistem", slika = "https://cdn3.iconfinder.com/data/icons/business-people-part-2/512/Businessman_Gear-512.png" , webhook = "https://discord.com/api/webhooks/835510651462877235/DyGaFCLYMJJnYXcw6JuKAkAO9wU_wBQq5ithl-hycatRYJqDEUqqqBIJFXYSBlXMDLIt"}
Chat = {ime = "Chat", slika = "https://w7.pngwing.com/pngs/417/555/png-transparent-speech-balloon-air-bubble-white-text-speech-balloon.png" , webhook = "https://discord.com/api/webhooks/835510750818205766/Rn_5keQWVcVLg1dfqHbbk05NCk--eFBSbNWQosCr8D-_yetlFIkKUh-wG8abhIZVHIvs"}
AutoPijaca = {ime = "Auto Pijaca", slika = "https://cdn2.iconfinder.com/data/icons/travel-set-2/512/27-512.png" , webhook = "https://discordapp.com/api/webhooks/709250092552683572/ur7hgkmXuL8QKwhhqyQZ12K9alM18sKjPwdsBr0VJHsaY7OLQO631sg6ZMsDPdfyYgbD"}
Zatvor = {ime = "Zatvor", slika = "http://pngimg.com/uploads/handcuffs/handcuffs_PNG56.png" , webhook = "https://discord.com/api/webhooks/835510854232571916/LAbd0If88Dni-Jp2k_FaNyFdPtpH9TpxTEOmzbFJHaFFcEMWk46nRz7r3xNMT_PSVOkt"}
Inventory = {ime = "Inventory", slika = "http://pngimg.com/uploads/handcuffs/handcuffs_PNG56.png" , webhook = "https://discord.com/api/webhooks/835507390702813235/QLtHWzHvoj2Xn5xXUrzUqhgJsNCCtm0Gsj74sf7KIP3bdUuWKBS_GYqlznyyj61mYm-u"}
Pretrazivanje = {ime = "Pretrazivanje", slika = "https://i.dlpng.com/static/png/6668444_preview.png", webhook = "https://discord.com/api/webhooks/835511194894073898/Qk-bmS10A1n50BBO61f_nDPz5fpg9HYwabFPWDeUDP7LspK5vNFNuWYlzheNQpeljNPX4"}
Cheater = {ime = "Cheater", slika = "https://cdn1.iconfinder.com/data/icons/social-shade-rounded-rects/512/anonymous-512.png", webhook = "https://discord.com/api/webhooks/835511279686385714/5GN65MJd-qLlatOc2HsT2IFt910hQl4n9MQtE4G8dGb22sfkWdXjR2rGSxMo4ueC9gq7"}
KillLog = {ime = "Kill Log", slika = "https://cdn.iconscout.com/icon/premium/png-512-thumb/kill-1783856-1517049.png", webhook = "https://discord.com/api/webhooks/870005638552490034/PswNl4X93oU0ASdWxIZa2b0QqRyiLwkWuQ2J5NHH7iUBSgGzjFVv0S8nUtyv6bynJ0VM"}
CD = {ime = "Conn/Disc", slika = "https://w0.pngwave.com/png/965/514/ethernet-network-cables-network-switch-rj45-png-clip-art.png", webhook = "https://discord.com/api/webhooks/835511433252306974/CbtSvXw64LdYREIJSkLHpIzScBEWM1B9GIQ_Muvl0Dl6yWpCNus011ZJm9z81LCbs497"}




AddEventHandler("playerConnecting", function()

    local IDs = IDeviIgraca(source)
    local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())

    local text = string.format("Igrac **%s** se konektuje\n```%s\n%s\n%s\n%s```", GetPlayerName(source), IDs.steam, IDs.discord, GetPlayerEndpoint(source), IDs.fivem)

    local embed = {
        {   
            ["color"] = 6866900,
            ["description"] = text,
            ["footer"] = {
                ["text"] = vrijeme,
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/835511433252306974/CbtSvXw64LdYREIJSkLHpIzScBEWM1B9GIQ_Muvl0Dl6yWpCNus011ZJm9z81LCbs497", function(err, text, headers) end, 'POST', json.encode({username = CD.ime, embeds = embed, avatar_url = CD.slika}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(Reason)

    local IDs = IDeviIgraca(source)
    local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())
    local embed = {
        {   
            ["color"] = 15728653,
            ["description"] = string.format("Igrac **%s** se diskonektovao                \n```%s\n%s\nIP: %s\n\nRazlog: %s```", GetPlayerName(source), IDs.steam, IDs.discord, GetPlayerEndpoint(source), Reason),
            ["footer"] = {
                ["text"] = vrijeme,
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/835511433252306974/CbtSvXw64LdYREIJSkLHpIzScBEWM1B9GIQ_Muvl0Dl6yWpCNus011ZJm9z81LCbs497", function(err, text, headers) end, 'POST', json.encode({username = CD.ime, embeds = embed, avatar_url = CD.slika}), { ['Content-Type'] = 'application/json' })

end)


RegisterServerEvent("StiflerLogovi:LogUFile")
AddEventHandler("StiflerLogovi:LogUFile", function(text)

    log = io.open("kastomlog.log", "a")
    if log then
        time = os.date("*t")
        log:write(os.date("%x", 906000490) .. " - " .. time.hour .. ":" .. time.min .. ":" .. time.sec.." | ".. text, "\n")
    else
        print("Log file doesnt exist")
    end
    log:close()

end)



RegisterServerEvent("StiflerLogovi:StartSpectateLog")
AddEventHandler("StiflerLogovi:StartSpectateLog", function(SpectatedName, admin)

	local _source = source
	local Igrac = SpectatedName
	local ime = Sistem.ime .. " Spectate Log"

	local poruka = "```css\nAdmin: [".. admin .. "] je poceo spectate na: [" .. Igrac .. "]\n ```"

	PerformHttpRequest("https://discord.com/api/webhooks/913037188583788566/6Mno3OG0oMiMZh36szbrbblRm-N0qyYJb7KidPoXJN1k1fscstnvNLosVaOc41RGksFY", function(err, text, headers) end, 'POST', json.encode({username = ime, content = poruka, avatar_url = Sistem.slika}), { ['Content-Type'] = 'application/json' })


end)


AddEventHandler("StiflerLogovi:AutoPijacaProdajaLog", function(kupac, prodavac, tablice, cijena)

  local poruka = "```css\nKupac: [".. kupac .. "] je kupio auto od: [" .. prodavac .. "] sa tablicama [".. tablice .."] za ".. cijena .. "$\n ```"
  PerformHttpRequest("https://discordapp.com/api/webhooks/756131607055827125/baZo7smYWnNVcfMpCZgp9xBam3LTrTQDFi4XtRkkwHGFUbG5z72_nuP2NZsrK2ACBVWv", function(err, text, headers) end, 'POST', json.encode({username = AutoPijaca.ime, content = poruka, avatar_url = AutoPijaca.slika}), { ['Content-Type'] = 'application/json' })

end)

AddEventHandler("StiflerLogovi:AutoPijacaPostavljanjeLog", function(prodavac, tablice, cijena)

  local poruka = "```css\nOsoba: [".. prodavac .. "] je postavila auto sa tablicama: [" .. tablice .. "] na prodaju za ".. cijena .."$\n ```"
  PerformHttpRequest("https://discordapp.com/api/webhooks/756131607055827125/baZo7smYWnNVcfMpCZgp9xBam3LTrTQDFi4XtRkkwHGFUbG5z72_nuP2NZsrK2ACBVWv", function(err, text, headers) end, 'POST', json.encode({username = AutoPijaca.ime, content = poruka, avatar_url = AutoPijaca.slika}), { ['Content-Type'] = 'application/json' })

end)


AddEventHandler("StiflerLogovi:ZatvorLog", function(zatvorenik, policajac, vrijeme)

    if policajac ~= "POREZNA UPRAVA" then

        local polis = GetPlayerName(policajac)
        local zatvorenik = GetPlayerName(zatvorenik)

        local poruka = "```css\nPolicajac: [" .. polis .. "] je zatvorio igraca: [" .. zatvorenik .. "] na: [" .. vrijeme .. "] mjeseci  ```"
        PerformHttpRequest("https://discord.com/api/webhooks/835510854232571916/LAbd0If88Dni-Jp2k_FaNyFdPtpH9TpxTEOmzbFJHaFFcEMWk46nRz7r3xNMT_PSVOkt", function(err, text, headers) end, 'POST', json.encode({username = Zatvor.ime, content = poruka, avatar_url = Zatvor.slika}), { ['Content-Type'] = 'application/json' })

    else 

        local poruka = "```css\nPorezna uprava je zatvorila igraca: [" .. zatvorenik .. "] na: [" .. vrijeme .. "] mjeseci  ```"
        PerformHttpRequest("https://discord.com/api/webhooks/835510854232571916/LAbd0If88Dni-Jp2k_FaNyFdPtpH9TpxTEOmzbFJHaFFcEMWk46nRz7r3xNMT_PSVOkt", function(err, text, headers) end, 'POST', json.encode({username = Zatvor.ime, content = poruka, avatar_url = Zatvor.slika}), { ['Content-Type'] = 'application/json' })

    end
end)

AddEventHandler("StiflerLogovi:ZatvorPusten", function(oslobodjen, admin)

    if admin == nil then 
        local zatvorenik = GetPlayerName(oslobodjen)

        local poruka = "```css\nZatvorenik: [" .. zatvorenik .. "] je zavrsio svoju kaznu```"
        PerformHttpRequest("https://discord.com/api/webhooks/835510854232571916/LAbd0If88Dni-Jp2k_FaNyFdPtpH9TpxTEOmzbFJHaFFcEMWk46nRz7r3xNMT_PSVOkt", function(err, text, headers) end, 'POST', json.encode({username = Zatvor.ime, content = poruka, avatar_url = Zatvor.slika}), { ['Content-Type'] = 'application/json' })
    else

        local zatvorenik = GetPlayerName(oslobodjen)
        local adm = GetPlayerName(admin)

        local poruka = "```css\nAdmin: [".. adm .."] je oslobodio igraca: [" .. zatvorenik .. "]```"
        PerformHttpRequest("https://discord.com/api/webhooks/835510854232571916/LAbd0If88Dni-Jp2k_FaNyFdPtpH9TpxTEOmzbFJHaFFcEMWk46nRz7r3xNMT_PSVOkt", function(err, text, headers) end, 'POST', json.encode({username = Zatvor.ime, content = poruka, avatar_url = Zatvor.slika}), { ['Content-Type'] = 'application/json' })
    

    end

end)



RegisterServerEvent("StiflerLogovi:PretrazivanjeLog")
AddEventHandler("StiflerLogovi:PretrazivanjeLog", function(koje1 ,pokraden, stvar, kolicina)

    local odkoga = GetPlayerName(koje1)
    local koje = GetPlayerName(pokraden)

    local poruka = "```css\n Igrac [".. koje .."] je ukrao(dobio) item [".. stvar .."] komada [".. kolicina .. "] od igraca [".. odkoga .."]```"
    PerformHttpRequest("https://discordapp.com/api/webhooks/756131943036223518/de0Na4t6SGnjEA89OD0t4cVVXbvaKWVxkIk1fLbSmyIYBTMhNVxwonVtBLN1tluQ3cho", function(err, text, headers) end, 'POST', json.encode({username = Pretrazivanje.ime, content = poruka, avatar_url = Pretrazivanje.slika}), { ['Content-Type'] = 'application/json' })


end)

RegisterServerEvent("StiflerLogovi:InventoryLog")
AddEventHandler("StiflerLogovi:InventoryLog", function(bezveze, ime, kolicina, kome)

    if source and kome then
        local poruka = "```css\n Igrac [".. GetPlayerName(source) .."] je dao item [".. ime .."] komada [".. kolicina .. "] igracu [".. GetPlayerName(tonumber(kome)) .."]```"
        PerformHttpRequest("https://discord.com/api/webhooks/835507390702813235/QLtHWzHvoj2Xn5xXUrzUqhgJsNCCtm0Gsj74sf7KIP3bdUuWKBS_GYqlznyyj61mYm-u", function(err, text, headers) end, 'POST', json.encode({username = "Davanje Itema", content = poruka, avatar_url = Pretrazivanje.slika}), { ['Content-Type'] = 'application/json' })
    end

end)


RegisterServerEvent("StiflerLogovi:AntiCheat_oruzje")
AddEventHandler("StiflerLogovi:AntiCheat_oruzje", function(ime, poruka)

    local IDs = IDeviIgraca(source)
    local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())
    local embed = {
        {   
            ["author"]= {
            ["name"] = "Stifler - AntiCheat",
            },
            ["color"] = 8193562,
            ["title"] = "**CHEATER JE REGISTROVAN NA SERVERU**",
            ["description"] = string.format("> %s\n\n**IME:** _%s_\n**ID:** _%s_\n**License:** _%s_\n**Discord:** _%s_\n**IP:** _%s_\n", poruka, ime, IDs.steam, IDs.fivem, IDs.discord, IDs.ip),
            ["footer"] = {
                ["text"] = vrijeme,
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn.onlinewebfonts.com/svg/img_560621.png",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/835511279686385714/5GN65MJd-qLlatOc2HsT2IFt910hQl4n9MQtE4G8dGb22sfkWdXjR2rGSxMo4ueC9gq7", function(err, text, headers) end, 'POST', json.encode({username = Cheater.ime, embeds = embed, avatar_url = Cheater.slika}), { ['Content-Type'] = 'application/json' })
    
end)

RegisterServerEvent("stifler:posloviLog")
AddEventHandler("stifler:posloviLog", function(ime, poruka)

    local IDs = IDeviIgraca(source)
    local vrijeme = os.date('%Y-%m-%d %H:%M:%S', os.time())
    local embed = {
        {   
            ["author"]= {
            ["name"] = "STIFLER - AntiCheat - POSLOVI",
            },
            ["color"] = 8193562,
            ["title"] = "**CHEATER JE BANOVAN SA SERVERA [ DAVANJE NOVCA PREKO POSLA ]**",
            ["description"] = string.format("> %s\n\n**IME:** _%s_\n**ID:** _%s_\n**License:** _%s_\n**Discord:** _%s_\n**IP:** _%s_\n", poruka, ime, IDs.steam, IDs.fivem, IDs.discord, IDs.ip),
            ["footer"] = {
                ["text"] = vrijeme,
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn.onlinewebfonts.com/svg/img_560621.png",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/904530733295624223/Rxm-eM6G9oO1_ABIG2d75IcLqCkU9mH46zhWqPxQ8B1Nf63lE1ruFGc-xxjuTawBS8QA", function(err, text, headers) end, 'POST', json.encode({username = Cheater.ime, embeds = embed, avatar_url = Cheater.slika}), { ['Content-Type'] = 'application/json' })
    
end)

AddEventHandler("StiflerCheatCheck:AnitCheat_exp", function(igrac, brojexp)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' then
        if igrac ~= nil then
            local IDs = IDeviIgraca(igrac)
            local ime = GetPlayerName(igrac)
            local poruka = "**Igrac je napravio " .. brojexp .. " explozija za manje od 2 sekunde**"

            local embed = {
                {   
                    ["author"]= {
                        ["name"] = "Stifler - AntiCheat",
                    },
                    ["color"] = 8193562,
                    ["title"] = "**CHEATER JE REGISTROVAN NA SERVERU**",
                    ["description"] = string.format("> %s\n\n**IME:** _%s_\n**ID:** _%s_\n**License:** _%s_\n**Discord:** _%s_\n**IP:** _%s_\n", poruka, ime, IDs.steam, IDs.fivem, IDs.discord, IDs.ip),
                    ["footer"] = {
                        ["text"] = vrijeme,
                    },
                    ["thumbnail"] = {
                        ["url"] = "https://cdn3.iconfinder.com/data/icons/explosives/30/explode-512.png",
                    },
                }
            }
            PerformHttpRequest("https://discord.com/api/webhooks/835511279686385714/5GN65MJd-qLlatOc2HsT2IFt910hQl4n9MQtE4G8dGb22sfkWdXjR2rGSxMo4ueC9gq7", function(err, text, headers) end, 'POST', json.encode({username = Cheater.ime, embeds = embed, avatar_url = Cheater.slika}), { ['Content-Type'] = 'application/json' })
        end
    end

end)


AddEventHandler("StiflerCheatCheck:AnitCheat_event", function(igrac, event)

    local IDs = IDeviIgraca(igrac)
    local ime = GetPlayerName(igrac)
    local poruka = "**Igrac je pokusao pozvati event koji je zabranjen!**\nEvent: '"..event.."'"

    local embed = {
        {   
            ["author"]= {
                ["name"] = "Stifler - AntiCheat",
            },
            ["color"] = 8193562,
            ["title"] = "**CHEATER JE REGISTROVAN NA SERVERU**",
            ["description"] = string.format("> %s\n\n**IME:** _%s_\n**ID:** _%s_\n**License:** _%s_\n**Discord:** _%s_\n**IP:** _%s_\n", poruka, ime, IDs.steam, IDs.fivem, IDs.discord, IDs.ip),
            ["footer"] = {
                ["text"] = vrijeme,
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn3.iconfinder.com/data/icons/explosives/30/explode-512.png",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/835511279686385714/5GN65MJd-qLlatOc2HsT2IFt910hQl4n9MQtE4G8dGb22sfkWdXjR2rGSxMo4ueC9gq7", function(err, text, headers) end, 'POST', json.encode({username = Cheater.ime, embeds = embed, avatar_url = Cheater.slika}), { ['Content-Type'] = 'application/json' })


end)



RegisterServerEvent("StiflerLogovi:Chat")
AddEventHandler("StiflerLogovi:Chat", function(nacin, poruka, igrac)

        if igrac ~= nil then
            ime = GetPlayerName(igrac)
        else 
            ime = GetPlayerName(source)
        end
            
        if nacin == "TWEET" or nacin == "ANO CHAT" or nacin == "ADVERT" then
            local poruka = string.format("> **%s:** %s", ime, poruka)
            PerformHttpRequest("https://discord.com/api/webhooks/835510750818205766/Rn_5keQWVcVLg1dfqHbbk05NCk--eFBSbNWQosCr8D-_yetlFIkKUh-wG8abhIZVHIvs", function(err, text, headers) end, 'POST', json.encode({username = nacin, content = poruka, avatar_url = Chat.slika}), { ['Content-Type'] = 'application/json' })
        else
            local poruka = string.format("> %s", poruka)
            PerformHttpRequest("https://discord.com/api/webhooks/835510750818205766/Rn_5keQWVcVLg1dfqHbbk05NCk--eFBSbNWQosCr8D-_yetlFIkKUh-wG8abhIZVHIvs", function(err, text, headers) end, 'POST', json.encode({username = ime, content = poruka, avatar_url = Chat.slika}), { ['Content-Type'] = 'application/json' })
        end

end)


RegisterServerEvent("StiflerLogovi:KillLog")
AddEventHandler("StiflerLogovi:KillLog", function(poruka, oruzje)


    if oruzje ~= nil then

    send = "> "..poruka .. " sa " .. oruzje
    else

    send = "> "..poruka
    end

    PerformHttpRequest("https://discord.com/api/webhooks/835511361731297310/HiDdIP4ss8mvf2t5JqcEYs4GAzTBD1RtVKZDRFKf9R6SY6SSdYb-12r12b2HCAvqoFSE", function(err, text, headers) end, 'POST', json.encode({username = KillLog.ime, content = send, avatar_url = Chat.slika}), { ['Content-Type'] = 'application/json' })

end)