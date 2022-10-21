AvailableWeatherTypes = { ['EXTRASUNNY'] = true, ['CLEAR'] = true, ['NEUTRAL'] = true, ['SMOG'] = true, ['FOGGY'] = true, ['OVERCAST'] = true, ['CLOUDS'] = true, ['CLEARING'] = true, ['RAIN'] = true, ['THUNDER'] = true, ['SNOW'] = true, ['BLIZZARD'] = true, ['SNOWLIGHT'] = true, ['XMAS'] = true, ['HALLOWEEN'] = true}

if IsDuplicityVersion() then

    if not GlobalState["bCore:Time-h"] then
        GlobalState["bCore:Time-h"] = 12 
    end

    if not GlobalState["bCore:Weather"] then
        GlobalState["bCore:Weather"] = "EXTRASUNNY"
    end

    if not GlobalState["bCore:Time-m"] then
        GlobalState["bCore:Time-m"] = 12
    end

    if GlobalState["bCore:Blackout"] then
        GlobalState["bCore:Blackout"] = false
    end
    if not GlobalState["baseTime"] then
        GlobalState["baseTime"] = 3600
    end

    Citizen.CreateThread(function()
        while true do
            if not PauseForUpdate and not FreezeTime then
                GlobalState["baseTime"] = GlobalState["baseTime"] + 1
                GlobalState["bCore:Time-h"] = math.floor((GlobalState["baseTime"]/60)%24)
                GlobalState["bCore:Time-m"] = math.floor(GlobalState["baseTime"]%60)
            end
            Citizen.Wait(1000)
        end
    end)

    FreezeTime = false
    local PauseForUpdate = false

    GlobalState["AddCommand"]("freezetime", function(src, args, grupa)
        FreezeTime = not FreezeTime
        TriggerClientEvent('chatMessage', src, "^1[bAdmin]^0: Freezao si vrijeme!")
    end, {
        ["developer"] = true,
        ["vlasnik"] = true,
        ["headadmin"] = true
    })

    GlobalState["AddCommand"]("time", function(src, args, grupa)
        PauseForUpdate = true
        if args[1] and args[2] then
            local hour = tonumber(args[1])
            local minute = tonumber(args[2])

            if hour > 23 then hour = 23 elseif hour < 1 then hour = 1 end
            if minute > 59 then minute = 59 elseif minute < 1 then minute = 1 end

            GlobalState["baseTime"] = (hour * 60)  + minute
            PauseForUpdate = false
            TriggerClientEvent('chatMessage', src, "^1[bAdmin]^0: sat promijenjen na ^1'"..hour..":"..minute.."'^0!")
        end
    end, {
        ["developer"] = true,
        ["owner"] = true,
        ["headadmin"] = true
    })


    GlobalState["AddCommand"]("weather", function(src, args, grupa)
        PauseForUpdate = true
        if args[1] then
            if args[1]  then
                if AvailableWeatherTypes[args[1]] then
                    GlobalState["bCore:Weather"] = args[1]
                    Wait(500)
                    TriggerClientEvent("bCore:tSync:UpdateWeather", -1)
                    TriggerClientEvent('chatMessage', src, "^1[bAdmin]^0: vrijeme promijenjeno na ^1'"..args[1].."'^0!")
                end
            end
        end
    end, {
        ["developer"] = true,
        ["owner"] = true,
        ["headadmin"] = true
    })

    GlobalState["AddCommand"]("blackout", function(src, args, grupa)
        GlobalState["bCore:Blackout"] = not GlobalState["bCore:Blackout"]

        if GlobalState["bCore:Blackout"] then
            TriggerClientEvent('chatMessage', src, "^1[bAdmin]^0: Iskljucio si struju u gradu!")
        else
            TriggerClientEvent('chatMessage', src, "^1[bAdmin]^0: Ukljucio si struju u gradu!")
        end

    end, {
        ["developer"] = true,
        ["vlasnik"] = true,
        ["direktor"] = true,
    })


    print("^3[bAdmin]^0: Weather sync ucitan !")
else

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            NetworkOverrideClockTime(GlobalState["bCore:Time-h"], GlobalState["bCore:Time-m"], 0)
            if GlobalState["bCore:Blackout"] then
                SetBlackout(GlobalState["bCore:Blackout"])
            end
        end
    end)

    RegisterNetEvent("bCore:tSync:UpdateWeather", function()

        local NewWeather = GlobalState["bCore:Weather"]

        if RecentWeather ~= NewWeather then
            SetWeatherTypeOverTime(NewWeather, 15.0)
            RecentWeather = NewWeather
            Wait(15000)
        end

        SetBlackout(GlobalState["bCore:Blackout"]) ClearOverrideWeather()
        ClearWeatherTypePersist() SetWeatherTypePersist(RecentWeather)
        SetWeatherTypeNow(RecentWeather) SetWeatherTypeNowPersist(RecentWeather)

        if RecentWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    
    end)

end