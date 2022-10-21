ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()

    while bFunkcije == nil do
        Wait(10)
        TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)
    end

    TriggerEvent("bZatvor:ProvjeriZatvor")
end)

local Zatvoren = false
local VrataPos = {
    [1] = { lok = vector3(455.19, 4818.58, -60.00), h = 90.0 }, 
    [2] = { lok = vector3(455.41, 4821.74, -60.00), h = 270.0 }
}

local pozicije = {
    SpawnPos = vector3(458.76, 4820.72, -59.00),
    ExitLoc = vector3(1850.11, 2586.05, 44.67)
}

local posao1 = {
    [1] = { pozicija = vector3(481.51, 4773.02, -59.99), h = 160.00 },
    [2] = { pozicija = vector3(485.73, 4765.30, -59.99), h = 173.33 },
    [3] = { pozicija = vector3(482.24, 4766.05, -59.99), h = 166.14 },
    [4] = { pozicija = vector3(478.65, 4767.87, -59.99), h = 155.83 }
}

local posa1Anim = {
    [1] = 2,
    [2] = 16
}

local posao2 = {
    [1] = { pozicija = vector3(477.28, 4791.21, -59.39), h = 333.21 },
    [2] = { pozicija = vector3(485.43, 4787.50, -59.39), h = 234.33 },
    [3] = { pozicija = vector3(491.50, 4795.52, -59.39), h = 338.04 },
    [4] = { pozicija = vector3(486.50, 4804.26, -59.38), h = 37.61 },
    [5] = { pozicija = vector3(480.82, 4809.62, -59.38), h = 26.62 },
}

local posa2Anim = {
    [1] = 15,
    [2] = 31
}

PreostaloVrijeme = 0
local PosloviMarkeri = {}

local ZadnjiPosao1 = 0
local ZavrsioPosao1 = false
local Posao1Marker = false

local ZadnjiPosao2 = 0
local ZavrsioPosao2 = false
local Posao2Marker = false

local MetlaModel = "prop_tool_broom"

local CentarZatvora = vector3(460.32, 4819.99, -59.00)

AddEventHandler("playerSpawned", function()
    TriggerEvent("bZatvor:ProvjeriZatvor")
end)

AddEventHandler("bZatvor:ProvjeriZatvor", function()

    ESX.TriggerServerCallback("bZatvor:ProvjeriZatvor", function(vrijeme)
        if vrijeme and vrijeme ~= 0 then
            print(vrijeme)
            PreostaloVrijeme = vrijeme
            Zatvoren = true
            TriggerEvent("bZatvor:Zatvoren", vrijeme)
            mins = string.format("%02.f", math.floor(PreostaloVrijeme / 60));
            secs = string.format("%02.f", math.floor(PreostaloVrijeme - mins *60));

            SendNUIMessage({
                akcija = "pokazi",
                min = mins,
                secs = secs
            })

            SendNUIMessage({
                akcija = "pokazi",
                min = mins,
                secs = secs
            })

        end
    end)

end)


RegisterNetEvent("bZatvor:UpdateVrijeme")
AddEventHandler("bZatvor:UpdateVrijeme", function(novoVrijeme)
    PreostaloVrijeme = novoVrijeme
end)


Citizen.CreateThread(function()
    while true do
        if Zatvoren then
            Citizen.Wait(50)
            local ped = PlayerPedId()
            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true)
            if IsPedArmed(ped, 1) or IsPedArmed(ped, 4) then
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end

            if IsPedInMeleeCombat(ped) then
                ClearPedTasksImmediately(ped)
            end

            SetPlayerInvincible(ped, true)
            SetEntityInvincible(ped, true)
            SetPedCanBeTargetted(ped, false)

        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if Zatvoren then
            DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
            DisableControlAction(0, 48, true) -- vezivanje

            if IsDisabledControlJustReleased(0, 37) then
                SendNUIMessage({
                    akcija = "infoclose",
                })
            end
        else
            Citizen.Wait(1000)
        end
    end
end )

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if Zatvoren then
            PreostaloVrijeme = PreostaloVrijeme - 1

            if PreostaloVrijeme > 0 then
                mins = string.format("%02.f", math.floor(PreostaloVrijeme / 60));
                secs = string.format("%02.f", math.floor(PreostaloVrijeme - mins *60));
            else
                mins = 0
                secs = 0
            end

            SendNUIMessage({
                akcija = "update",
                min = mins,
                secs = secs
            })
            TriggerServerEvent("bZatvor:Tick")

            if PreostaloVrijeme <= 0 then
                TriggerServerEvent("bZatvor:Oslobodi")
                SendNUIMessage({akcija = "zatvori"})
            else
                if #(pozicije.SpawnPos - GetEntityCoords(PlayerPedId())) > 200 then
                    SetEntityCoords(PlayerPedId(), pozicije.SpawnPos)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        if Zatvoren then
            local ped = PlayerPedId()
            local pedPos = GetEntityCoords(ped)

            TriggerEvent("stifi:napunistatsBolnica")
            SetEntityHealth(ped, 200)

            if #(VrataPos[1].lok - pedPos) < 20 then
                for vrata, dat in pairs(VrataPos) do
                    local vrata = GetClosestObjectOfType(dat.lok, 1.0, 4787313, false, false, false)
                    FreezeEntityPosition(vrata, true)
                    SetEntityHeading(vrata, dat.h)
                end
            end

            -- POSLOVI --
            if PreostaloVrijeme > 31 then
                if ZadnjiPosao1 == 0 then
                    ZadnjiPosao1 = math.random(1, 4)
                end

                if not Posao1Marker then
                    Posao1Marker = CreateCheckpoint(47, posao1[ZadnjiPosao1].pozicija, posao1[ZadnjiPosao1].pozicija, 0.5, 0, 0, 255, 100, 0)
                    SetCheckpointCylinderHeight(Posao1Marker, 1.5, 1.5, 0.5)
                end

                if #( posao1[ZadnjiPosao1].pozicija - pedPos) <= 1.5 then
                    if IsControlPressed(0, 38) then
                        RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                        while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do Wait(100) end

                        DeleteCheckpoint(Posao1Marker) 
                        Posao1Marker = false

                        TaskPlayAnim( ped , "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, -8.0, -1, posa1Anim[math.random(1, 2)], 1, false, false, false)

                        bFunkcije.BlokTipke(true)
                        SetEntityHeading(ped, posao1[ZadnjiPosao1].h)
                        isAnimiran = true

                        local newPosao = math.random(1,4)
                        while newPosao == ZadnjiPosao1 do 
                            newPosao = math.random(1,4)
                            Wait(100)
                        end
                        ZadnjiPosao1 = newPosao


                        TriggerEvent("bfunkcije:tajmerdosto", "Popravljanje...", 30, false, function()
                            ClearPedTasks( ped )
                            bFunkcije.BlokTipke(false)
                            TriggerServerEvent("bZatvor:UpdateVrijeme")
                            isAnimiran = false

                         
                            exports.eleNotif:Notify({
                                type = 'info',
                                title = 'Zatvor',
                                message = 'Popravka gotova, kazna smanjena za 15 sekundi'
                            })
                        end)

                        while isAnimiran do Wait(100) end

                    end
                end

                if ZadnjiPosao2 == 0 then
                    ZadnjiPosao2 = math.random(1, 5)
                end

                if not Posao2Marker then
                    Posao2Marker = CreateCheckpoint(47, posao2[ZadnjiPosao2].pozicija, posao2[ZadnjiPosao2].pozicija, 0.5, 0, 204, 102, 100, 0)
                    SetCheckpointCylinderHeight(Posao2Marker, 1.5, 1.5, 0.5)
                end

                if #( posao2[ZadnjiPosao2].pozicija - pedPos) <= 1.5 then
                    if IsControlPressed(0, 38) then

                        RequestAnimDict("amb@world_human_janitor@male@idle_a")
                        while not HasAnimDictLoaded("amb@world_human_janitor@male@idle_a") do Wait(100) end

                        
                        local newPosao2 = math.random(1,5)
                        while newPosao2 == ZadnjiPosao2 do 
                            newPosao2 = math.random(1,5)
                            Wait(100)
                        end
                        ZadnjiPosao2 = newPosao2

                        DeleteCheckpoint(Posao2Marker) 
                        Posao2Marker = false

                        local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                        local SpawnMetla = CreateObject(GetHashKey(MetlaModel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)

                        AttachEntityToEntity(SpawnMetla, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)

                        TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 1, 0, false, false, false)

                        bFunkcije.BlokTipke(true)
                        isAnimiran = true

                        TriggerEvent("bfunkcije:tajmerdosto", "Ciscenje...", 30, false, function()
                            ClearPedTasks( ped )
                            bFunkcije.BlokTipke(false)
                            TriggerServerEvent("bZatvor:UpdateVrijeme")
                            isAnimiran = false
                            
                            DetachEntity(SpawnMetla, 1, 1)
                            DeleteEntity(SpawnMetla)

                   
                            exports.eleNotif:Notify({
                                type = 'info',
                                title = 'Zatvor',
                                message = 'Ciscenje gotovo, kazna smanjena za 15 sekundi'
                            })
                        end)

                        while isAnimiran do Wait(100) end

                    end
                end
            else
                DeleteCheckpoint(Posao2Marker) Posao2Marker = false
                DeleteCheckpoint(Posao1Marker) Posao1Marker = false
            end 
        
        end
    end
end)

RegisterNetEvent("bZatvor:Zatvoren")
AddEventHandler("bZatvor:Zatvoren", function(vrijeme)

    FreezeEntityPosition(PlayerPedId(), true)
    PreostaloVrijeme = vrijeme
    DoScreenFadeOut(800)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), pozicije.SpawnPos, 0, 0, 0, 0)

    while #(GetEntityCoords(PlayerPedId()) - pozicije.SpawnPos) > 10 do 
        Wait(200) 
    end

    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
        Wait(200)
    end

    Wait(5000)
    
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(800)

    SendNUIMessage({
        akcija = "pokazi"
    })

    Zatvoren = true

    TriggerEvent("bZatvor:Odvezi")
end)

RegisterNetEvent("bZatvor:Oslobodi")
AddEventHandler("bZatvor:Oslobodi", function()

    Zatvoren = false
    FreezeEntityPosition(PlayerPedId(), true)
    PreostaloVrijeme = 0
    DoScreenFadeOut(800)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), pozicije.ExitLoc, 0, 0, 0, 0)
    while #(GetEntityCoords(PlayerPedId()) - pozicije.ExitLoc) > 10 do Wait(200) end
    Wait(2000)
    DoScreenFadeIn(800)
    FreezeEntityPosition(PlayerPedId(), false)
    SendNUIMessage({akcija = "zatvori"})
    Citizen.Wait(2000)
    SetPlayerInvincible(PlayerId(), false)
    SetEntityInvincible(PlayerPedId(), false)
    SetPedCanBeTargetted(PlayerPedId(), true)
    SendNUIMessage({akcija = "zatvori"})

end)

local show1 = false
local show2 = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local pedPos = GetEntityCoords(PlayerPedId())
        if Zatvoren then
            if PreostaloVrijeme > 31 then
                if posao1[ZadnjiPosao1] then
                    if #(pedPos  - posao1[ZadnjiPosao1].pozicija) <= 2 then
                        if not show1 then
                            show1 = true
                            Citizen.CreateThread(function()
                                while show1 or not Zatvoren do
                                    Citizen.Wait(20)
                                    pokazi3d(posao1[ZadnjiPosao1].pozicija, 'Drzi tipku [E] da popravis', 40)
                                end
                            end)
                        end
                    elseif show1 and #(pedPos  - posao1[ZadnjiPosao1].pozicija) > 2 then
                        show1 = false
                    end
                end

                if posao2[ZadnjiPosao2] then
                    if #(pedPos  - posao2[ZadnjiPosao2].pozicija) <= 2 then
                        if not show2 then
                            show2 = true
                            Citizen.CreateThread(function()
                                while show2 or not Zatvoren do
                                    Citizen.Wait(20)
                                    pokazi3d(posao2[ZadnjiPosao2].pozicija, 'Drzi tipku [E] da ocistis', 200)
                                end
                            end)
                        end
                    elseif show2 and #(pedPos  - posao2[ZadnjiPosao2].pozicija) > 2 then
                        show2 = false
                    end
                end
            end
        end
    end
end)


pokazi3d = function(pos, text, boja)
    AddTextEntry(GetCurrentResourceName(), text)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)
    SetFloatingHelpTextWorldPosition(1, pos + vector3(0.0, 0.0, 1.0))
    SetFloatingHelpTextStyle(1, 1, boja, -1, 3, 2)
end

RegisterNetEvent("bZatvor:zatvorenotif")
AddEventHandler("bZatvor:zatvorenotif", function(ime, vrijeme, razlog)

    SendNUIMessage({
        akcija = "Notifikacija",
        ime = ime,
        vrijeme = vrijeme,
        razlog = razlog or "nepoznato"
    })

end)

local DozvoljeneLokacije = {
    vector3(441.14, -984.29, 30.69),
    vector3(1853.94, 2585.64, 45.67 ),
    vector3(1856.72, 3680.65, 34.04)
}


RNE('zatvori:igraca', function()
    local igraci = {}
    local SviIgraci = GetActivePlayers()
    for i = 1, #SviIgraci do
        local pPed = GetPlayerPed( SviIgraci[i] )
        if #( GetEntityCoords(pPed) - GetEntityCoords(PlayerPedId()) ) < 5 then
            local PsID = GetPlayerServerId(SviIgraci[i])
            table.insert(igraci, {label = GetPlayerName(SviIgraci[i]), value = PsID } )
        end
    end

    TE('nh-context:sendMenu', {
        {
            id = 1,
            header = 'Zatvori igraca',
            txt = "Izaberi",
            params = {
                event = "zatvor:potvrdi",
            }
        },
    })
end)

RNE("zatvor:potvrdi", function()

    local ped = PlayerPedId()
    local pozicija = GetEntityCoords(ped)
    local mozeOvdje = false

    for i = 1, #DozvoljeneLokacije do
        if #(pozicija - DozvoljeneLokacije[i]) < 75 then
            mozeOvdje = true
            break
        end
    end
        local dialog = exports['zf_dialog']:DialogInput({
            header = "Zatvor", 
            rows = {
                {
                    id = 1, 
                    txt = "#Vrijeme 1 = 1min"
                },
                {
                    id = 2, 
                    txt = "#ID-Zatvorenika"
                },
                {
                    id = 3, 
                    txt = "#Razlog-Robije"
                },
            }
        })

    if dialog ~= nil then
        if dialog[1].input == nil then
            TE('mythic_notify:client:SendAlert', {type = 'error', text = 'Polje ne moze biti prazno', length = 3500})
        else
            local vrijemeRobije, idZatvorenika, razlogrobije = dialog[1].input, dialog[2].input, dialog[3].input
            TSE("bZatvor:Zatvori", idZatvorenika, vrijemeRobije, razlogrobije or "nije navedeno")
        end
    end
end)


RNE("policija:racun", function()
    local dialog = exports['zf_dialog']:DialogInput({
        header = "Kazna", 
        rows = {
            {
                id = 1, 
                txt = "#Iznos"
            },
            {
                id = 2, 
                txt = "#ID-Osobe"
            },
            {
                id = 3, 
                txt = "#Razlog"
            },
        }
    })
    if dialog ~= nil then
        if dialog[1].input == nil then
            TE('mythic_notify:client:SendAlert', {type = 'error', text = 'Polje ne moze biti prazno', length = 3500})
        else
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 3.0 then
                exports.eleNotif:Notify({type = 'success', title = 'Notifikacija', message = 'Nema nikog u blizini tebe'})
            else
                TriggerServerEvent("eleRacuni:DajRacun", GetPlayerServerId(closestPlayer), dialog[3].input, dialog[1].input )
            end
        end
    end
end)