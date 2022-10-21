ESX = nil
bFunkcije = nil
OsobaMrtva = false
OzivljavaNekog = false
PrviSpawn = false

PrviTajmerProsao = false
DrugiTajmerProsao = false

PrviTajmer = 900
SkoroDrugi = 600
DrugiTajmer = 300

VrijemeUmro = 0

PreneseniMrtvi = {}
local LokacijeKreveta = {
    {loc = vector3(-462.64, -281.31, 35.84), h = 202.88},
    {loc = vector3(-466.25, -282.98, 35.84), h = 146.69},
    {loc = vector3(322.84, -586.71, 43.20), h = 158.63},
    {loc = vector3(-469.72, -284.54, 35.84), h = 23.19},
    {loc = vector3(-466.97, -291.04, 35.84), h = 310.83},

    {loc = vector3(-463.91, -289.72, 35.83), h = 303.87},
    {loc = vector3(-460.56, -288.37, 35.83), h = 203.09}
}
LokacijaBolnice = vector3(-811.29, -1231.95, 34.50)

lista = {
    vector3(-1580.32, 202.85, 61.65), --Zabranjene lokacije za G
}

uniforme = {
    doktor = {
        male = {
            tshirt_1 = 19,  tshirt_2 = 2,
            torso_1 = 73,   torso_2 = 15,
            decals_1 = 0,   decals_2 = 0,
            arms = 85,
            pants_1 = 24,   pants_2 = 5,
            shoes_1 = 20,   shoes_2 = 3,
            helmet_1 = 122,  helmet_2 = 0,
            chain_1 = 126,    chain_2 = 0,
            ears_1 = 2,     ears_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
            torso_1 = 48,   torso_2 = 0,
            decals_1 = 0,   decals_2 = 0,
            arms = 44,
            pants_1 = 34,   pants_2 = 0,
            shoes_1 = 27,   shoes_2 = 0,
            helmet_1 = 45,  helmet_2 = 0,
            chain_1 = 0,    chain_2 = 0,
            ears_1 = 2,     ears_2 = 0
        }
    },
    bolnicar = {
        male = {
            tshirt_1 = 19,  tshirt_2 = 2,
            torso_1 = 73,   torso_2 = 15,
            decals_1 = 0,   decals_2 = 0,
            arms = 85,
            pants_1 = 24,   pants_2 = 5,
            shoes_1 = 20,   shoes_2 = 3,
            helmet_1 = 122,  helmet_2 = 0,
            chain_1 = 126,    chain_2 = 0,
            ears_1 = 2,     ears_2 = 0
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    direktor = { -- currently the same as chef_wear
        male = {
            tshirt_1 = 19,  tshirt_2 = 2,
            torso_1 = 73,   torso_2 = 15,
            decals_1 = 0,   decals_2 = 0,
            arms = 85,
            pants_1 = 24,   pants_2 = 5,
            shoes_1 = 20,   shoes_2 = 3,
            helmet_1 = 122,  helmet_2 = 0,
            chain_1 = 126,    chain_2 = 0,
            ears_1 = 2,     ears_2 = 0
        },
        female = {
            tshirt_1 = 35,  tshirt_2 = 0,
            torso_1 = 48,   torso_2 = 0,
            decals_1 = 7,   decals_2 = 3,
            arms = 44,
            pants_1 = 34,   pants_2 = 0,
            shoes_1 = 27,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = 0,    chain_2 = 0,
            ears_1 = 2,     ears_2 = 0
        }
    },

}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()

    if PlayerData.job.name ~= "bolnica" then
		--exports["rp-radio"]:RemovePlayerAccessToFrequency(3,4)
    elseif PlayerData.job.name == "bolnica" then
       -- exports["rp-radio"]:GivePlayerAccessToFrequencies(3,4)
    end

    local blip = AddBlipForCoord(-811.29, -1231.95, 34.50)

    SetBlipSprite (blip, 498)
    SetBlipDisplay(blip, 2)
    SetBlipScale  (blip, 0.7)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bolnica")
    EndTextCommandSetBlipName(blip)

    while bFunkcije == nil do
        Wait(10)
        TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)
    end

end)

function JelMrtvaOsoba()
    return OsobaMrtva
end

function MrtveOsobe()
    return PreneseniMrtvi
end

AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    if PlayerData.job.name ~= "bolnica" then
		exports["rp-radio"]:RemovePlayerAccessToFrequency(3,4)
    elseif PlayerData.job.name == "bolnica" then
        exports["rp-radio"]:GivePlayerAccessToFrequencies(3,4)
    end
end)

RegisterNetEvent("bBolnica:PrenosMrtvih")
AddEventHandler("bBolnica:PrenosMrtvih", function(PreneseniMrtvi2)
    PreneseniMrtvi = PreneseniMrtvi2
end)

AddEventHandler("playerSpawned", function()
    if not PrviSpawn then

        ESX.TriggerServerCallback('bBolnica:CheckCoords', function(coords, heading)
            
           -- FreezeEntityPosition(PlayerPedId(), true)
            Wait(100)
            SetEntityCoords(PlayerPedId(), vector3(coords.x, coords.y, coords.z + 1) )
            SetEntityHeading(PlayerPedId(), heading)

            while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Wait(100) end

           -- FreezeEntityPosition(PlayerPedId(), false)
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

        end)

        PrviSpawn = true
    end

end)

RegisterNetEvent("bBolnica:IgracSpawnan")
AddEventHandler("bBolnica:IgracSpawnan", function(isHead)
    TriggerEvent("bBolnica:ProcessUmro", isHead)
end)

AddEventHandler("onUbijen", function(isHead)

    exports.spawnmanager:setAutoSpawn(false)

    if OsobaMrtva then 
        return 
    end

    TriggerEvent("bBolnica:ProcessUmro", isHead)

end)

AddEventHandler("bBolnica:ProcessUmro", function(isHead2)

    if not OsobaMrtva then

        local isHead = isHead2
        local PlayerPed = PlayerPedId()
        SetCurrentPedWeapon(PlayerPed, GetHashKey("WEAPON_UNARMED"), true)

        RequestAnimDict("missarmenian2")
        while not HasAnimDictLoaded("missarmenian2") do 
            Wait(10)
        end


        RagTajmer = GetCloudTimeAsInt() + 20
        while IsEntityInAir(PlayerPed) do 
            Wait(500)
            print("Cekam Da zavrsi inAir", RagTajmer - GetCloudTimeAsInt()) 
            if RagTajmer < GetCloudTimeAsInt() then 
                break
            end
        end

        RagTajmer = GetCloudTimeAsInt() + 20
        while IsPedRagdoll(PlayerPed) do
            Citizen.Wait(500)
            print("Cekam Da zavrsi ragdoll", RagTajmer - GetCloudTimeAsInt())
            if RagTajmer < GetCloudTimeAsInt() then 
                break
            end
        end


        local coords = GetEntityCoords(PlayerPed)
        TriggerServerEvent('esx:updateLastPosition', coords)
        TriggerServerEvent("bBolnica:UmroIgrac", isHead)

        SendNUIMessage({
            step ="Prvi",
        })

       -- TriggerEvent('blokiraj:tipke')

        ResurrectPed(PlayerPed)
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z + 0.2, 150.0, true, false)
        SetEntityHealth(PlayerId(), 151)

        ClearPedTasksImmediately(PlayerPed)
        TaskPlayAnim(PlayerPed, "missarmenian2", "drunk_loop", 2.0, -8.0, -1, 2, 1, false, false, false)

        OsobaMrtva = true

        Citizen.CreateThread(function()
            if isHead then
                VrijemeDoSmrti = GetCloudTimeAsInt() + PrviTajmer / 2
            else
                VrijemeDoSmrti = GetCloudTimeAsInt() + PrviTajmer
            end
            DrugoVrijemeDoSmrti = VrijemeDoSmrti + DrugiTajmer
            SkoroDrugoVrijeme = VrijemeDoSmrti - SkoroDrugi

            while OsobaMrtva do
                Citizen.Wait(1000)

                if not IsEntityPlayingAnim(PlayerPed, "missarmenian2", "drunk_loop", 3) then
                    TaskPlayAnim(PlayerPed, "missarmenian2", "drunk_loop", 2.0, -8.0, -1, 2, 1, false, false, false)
                end

                if GetCloudTimeAsInt() < VrijemeDoSmrti then
                    mins = string.format("%02.f", math.floor((VrijemeDoSmrti - GetCloudTimeAsInt())/60));
                    secs = string.format("%02.f", math.floor((VrijemeDoSmrti - GetCloudTimeAsInt()) - mins *60));
    

                    if isHead then
                        text = 'Nemas puls, mrtav si'
                    end

                    if not isHead and not PozvaoPomoc and GetCloudTimeAsInt() < SkoroDrugoVrijeme then
                        text = 'Ne osjecas se dobro i gubis svijest<br>Sacekaj <span style = "color:red; font-weight: bold;">5 minuta</span> da pozoves pomoc!'
                    end

                    if not isHead and not PozvaoPomoc and GetCloudTimeAsInt() > SkoroDrugoVrijeme then
                        text = 'Ne osjecas se dobro i gubis svijest<br>Drzi tipku <span style = "color:red; font-weight: bold;">G</span> da pozoves pomoc!'
                    end
                        
                    if PozvaoPomoc then
                        text = ' Ne osjecas se dobro i gubis svijest<br>Pozvao si pomoc...'
                    end

                    SendNUIMessage({
                        step ="timeupdate",
                        vrijeme = mins.." : " .. secs,
                        text = text,
                        head = isHead
                    })
                   

                    if not isHead and not PozvaoPomoc and GetCloudTimeAsInt() > SkoroDrugoVrijeme and IsControlPressed(0, 47) then

                        local NeMozeOvdje = false

                        for i = 1, #lista do
                            if #(GetEntityCoords(PlayerPedId()) - lista[i]) < 150 then
                                NeMozeOvdje = true
                            end
                        end
                        
                        if not NeMozeOvdje then
                            PozvaoPomoc = true
                            TriggerEvent("doktor:pozoviDoktora")
                            --[[
                            ESX.TriggerServerCallback("bBolnica:ImaLiDoktora", function(broj)

                                if broj > 0 then
                                    TriggerServerEvent("bOrgMeni:PrimiSlucaj", GetEntityCoords(PlayerPedId()), "bolnica", "Unserecena osoba je prijavljena na lokaciji!")
                                else
                                    TriggerEvent("doktor:pozoviDoktora")
                                end
                            
                            end)
                            ]]
                        else
                            exports.eleNotif:Notify({
                                type = 'error',
                                title = 'Bolnica',
                                message = 'Ne mozes zvati pomoc ovdje'
                            })
                        end
                    end

                else
                    mins = string.format("%02.f", math.floor((DrugoVrijemeDoSmrti - GetCloudTimeAsInt())/60));
                    secs = string.format("%02.f", math.floor((DrugoVrijemeDoSmrti - GetCloudTimeAsInt()) - mins *60));

                    SendNUIMessage({
                        step ="timeupdate",
                        vrijeme = mins.." : " .. secs,
                        text = 'Isteklo ti je vrijeme<br>Drzi tipku <span style = "color:red; font-weight: bold;">G</span> da se respawnas!'
                    })

                    if IsControlPressed(0, 47) then
                        TriggerEvent("bBolnica:ZadnjiRespawn")
                        return
                    end

                    if OsobaMrtva and GetCloudTimeAsInt() > DrugoVrijemeDoSmrti then
                        TriggerEvent("bBolnica:ZadnjiRespawn")
                        return
                    end
                end

            end
        end)
    end

end)

Citizen.CreateThread(function()
	while true do 
        Citizen.Wait(10)
        if OsobaMrtva then
            local PlayerPed = PlayerPedId()
            SetEntityInvincible(PlayerPed, true)
            SetEntityCollision(PlayerPed, false, true)
            FreezeEntityPosition(PlayerPed, true)
            SetPedCanBeTargetted(PlayerPed, false)
            SetPlayerInvincible(PlayerId(), true)
        else
            Citizen.Wait(1500)
        end
	end

end)

RegisterNetEvent("bBolnica:OzivljenIgracAdmin")
AddEventHandler("bBolnica:OzivljenIgracAdmin", function(jeladmin)
    TriggerServerEvent("bBolnica:OzivljenIgrac", false, jeladmin)
    TriggerEvent ('esx:onPlayerSpawn')
    Wait(1000)
    ClearPedTasksImmediately(PlayerPedId())
end)

AddEventHandler("bBolnica:ZadnjiRespawn", function()
    local PlayerPed = PlayerPedId()
    OsobaMrtva = false

    TriggerServerEvent("bBolnica:OzivljenIgrac")
    TriggerServerEvent("bBolnica:UmroSkroz")

    SetEntityCoords(PlayerPed, LokacijaBolnice)
    Wait(1000)
    NetworkResurrectLocalPlayer(LokacijaBolnice.x, LokacijaBolnice.y, LokacijaBolnice.z + 0.2, 150.0, true, false)

    RequestAnimDict("dead@fall")
    while not HasAnimDictLoaded("dead@fall") do 
        Wait(150)
    end

    for i = 1, #LokacijeKreveta do 
        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer(LokacijeKreveta[i].loc)
        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            SetEntityCoords(PlayerPed, LokacijeKreveta[i].loc, 0, 0, 0, false)
            SetEntityHeading(PlayerPed, LokacijeKreveta[i].h)
            FreezeEntityPosition(PlayerPed, true)
           -- TriggerEvent('blokiraj:tipke')
    
            TaskPlayAnim(PlayerPed, "dead@fall", "dead_land_up", 2.0, -8.0, -1, 2, 1, false, false, false)
                TriggerEvent("bfunkcije:tajmerdosto", "Odmaranje...", 60, false, function()
                 --   TriggerEvent('odblokiraj:tipke')
                    exports.eleNotif:Notify({
                        type = 'error',
                        title = 'Bolnica',
                        message = 'Sada si bolje i slobodan si'
                    })
                    ClearPedTasks(PlayerPed)
                    FreezeEntityPosition(PlayerPed, false)
                    TriggerEvent ('esx:onPlayerSpawn')
                end)
            break
        end
    end
end)

RegisterNetEvent("bBolnica:OzivljenIgrac")
AddEventHandler("bBolnica:OzivljenIgrac", function(jeladmin)

    OsobaMrtva, PozvaoPomoc = false, false

    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do Wait(100) end

    local PlayerPed = PlayerPedId()
    local Player = PlayerId()

    SetPlayerInvincible(Player, false)
    ClearPedBloodDamage(PlayerPed)
    SetEntityCollision(PlayerPed, true, true)
    SetEntityInvincible(PlayerPed, false)
    SetPlayerInvincible(Player, false)
    FreezeEntityPosition(PlayerPed, false)
    Wait(1000)
    ClearPedTasksImmediately(PlayerPedId())

    SetEntityHealth(PlayerPed, 200)

    SendNUIMessage({
        step ="ozviljen",
    })

    TriggerEvent("stifi:napunistatsBolnica")

    ClearPedTasks(PlayerPed)
    SetPedCanBeTargetted(PlayerPed, true)
    FreezeEntityPosition(PlayerPed, false)
    TriggerEvent ('esx:onPlayerSpawn')


    local PosTemp = GetEntityCoords(PlayerPedId())
    NetworkResurrectLocalPlayer(PosTemp.x, PosTemp.y, PosTemp.z + 0.2, 150.0, true, false)
    OsobaMrtva = false
    PozvaoPomoc = false
    PrviTajmerProsao, DrugiTajmerProsao = false, false
    VrijemeUmro, VrijemeDoSmrti, DrugoVrijemeDoSmrti = 0, 0, 0
    isHead = false
end)

local MrtviMarkeri = {}
local OdmorPos = vector3(305.00, -600.17, 42.28)
local SefLokacija = vector3(334.71, -593.64, 42.28)
local PresvlacenjeLokacija = vector3(299.64, -597.24, 42.28)
local OdmorPosCP, SefAkcijeCP, PresvlacenjeCP = false, false, false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local PlayerPed = PlayerPedId()
        local PedPos = GetEntityCoords(PlayerPed)
        
        if PlayerData.job.name == "bolnica" then
            if not OsobaMrtva then

                for i = 1, #MrtviMarkeri do
                    DeleteCheckpoint(MrtviMarkeri[i])
                end

                for k,v in pairs(PreneseniMrtvi) do
                    if GetPlayerPed(GetPlayerFromServerId(k)) ~= PlayerPedId() then
        
                        if #(PedPos - v.coords) < 50 then
                            table.insert(MrtviMarkeri, CreateCheckpoint(47, v.coords.x, v.coords.y, v.coords.z - 1, v.coords, 3.0, 250, 0, 0, 255, 0))
                            if #(PedPos - v.coords) < 2 then
                                if not v.isHead then
                                    TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da zapocnes ozivljavanje")
                                    if IsControlPressed(0, 38) then
                                        OzivljavaNekog = true

                                        local lice = GetPlayerPed(GetPlayerFromServerId(k))
                                        local liceKords = GetEntityCoords(lice)
                                        local liceGlava = GetWorldPositionOfEntityBone(lice, GetPedBoneIndex(lice, 31086))
                                        local ZaPogledat = GetHeadingFromVector_2d(liceGlava.x, liceGlava.y)
                                    
                                        SetEntityHeading(PlayerPedId(), ZaPogledat)
                                        SetEntityCoords(PlayerPedId(), liceKords.x, liceKords.y, liceKords.z - 0.8)

                                        Citizen.CreateThread(function()

                                            local lib5, anim5 = "amb@medic@standing@tendtodead@enter", "enter"
                                            local lib6, anim6 = "mini@cpr@char_a@cpr_def", "cpr_intro"
                                            local lib7, anim7 = "missheistfbi3b_ig8_2", "cpr_loop_paramedic"
                                            RequestAnimDict(lib5) while not HasAnimDictLoaded(lib5) do Wait(100) end
                                            RequestAnimDict(lib6) while not HasAnimDictLoaded(lib6) do Wait(100) end
                                            RequestAnimDict(lib7) while not HasAnimDictLoaded(lib7) do Wait(100) end
                                            TaskPlayAnim(PlayerPedId(), lib5, anim5, 2.0, -8.0, -1, 2, 1, false, false, false)
                                            Citizen.Wait(2000)
                                            TaskPlayAnim(PlayerPedId(), lib6, anim6, 2.0, -8.0, -1, 2, 1, false, false, false)
                                            Citizen.Wait(13000)
                                            TaskPlayAnim(PlayerPedId(), lib7, anim7, 2.0, -8.0, -1, 2, 1, false, false, false)
                                            Citizen.Wait(5000)
                                        
                                        end)

                                        TriggerEvent("bfunkcije:tajmerdosto", "Ozivljavanje...", 21, false, function()
                                           -- TriggerEvent('odblokiraj:tipke')
                                            TriggerServerEvent("bBolnica:OzivljenIgrac", k)
                                            TriggerServerEvent("bBolnica:NaplatiDizanje", k)
                                            TriggerEvent ('esx:onPlayerSpawn')
                                            ClearPedTasks(PlayerPed)
                                            FreezeEntityPosition(PlayerPed, false)
                                            OzivljavaNekog = false
                                        end)

                                        while OzivljavaNekog do Wait(100) end
                                    end
                                else
                                    TriggerEvent("bfunkcije:ticknotif", true, true, "Ova osoba nema pulsa...")
                                end
                            end
                        end
                    end
                end
            end

            DeleteCheckpoint(OdmorPosCP)
            DeleteCheckpoint(SefAkcijeCP)
            DeleteCheckpoint(PresvlacenjeCP)

            if #(PedPos - OdmorPos) < 20 then
                OdmorPosCP = CreateCheckpoint(47,OdmorPos, OdmorPos, 1.0, 255, 0, 0, 255, 0)
                SetCheckpointCylinderHeight(OdmorPosCP, 2.0, 2.0, 2.0)

                if #(PedPos - OdmorPos) < 1.5 then
                    TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da se odmoris")
                    if IsControlPressed(0, 38) then
                        OdmaraSe = true
                        DoScreenFadeOut(1000)
                        Wait(2500)
                        TriggerEvent("HVS:odmaranje")
                        Wait(2500)
                        TriggerEvent("bfunkcije:notif", "", "Odmorio si se...", 5, true)
                        DoScreenFadeIn(1000)
                        OdmaraSe = false
                    end
                end
            end

            if PlayerData.job.grade_name == "boss" then
                local SefUdalj = #(SefLokacija - PedPos)
                if SefUdalj < 15 then
                    SefAkcijeCP = CreateCheckpoint(47,SefLokacija, SefLokacija, 1.0, 255, 0, 0, 255, 0)
                    SetCheckpointCylinderHeight(SefAkcijeCP, 2.0, 2.0, 2.0)

                    if SefUdalj < 1.5 then
                        TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da akcije sefa")
                        if IsControlPressed(0, 38) then 
                            TriggerEvent("benno_orgmeni:Otvori")
                        end
                    end
                end
            end

            local PresvUdalj = #(PresvlacenjeLokacija - PedPos)
            if PresvUdalj < 15 then
                PresvlacenjeCP = CreateCheckpoint(47,PresvlacenjeLokacija, PresvlacenjeLokacija, 1.0, 255, 0, 0, 255, 0)
                SetCheckpointCylinderHeight(PresvlacenjeCP, 2.0, 2.0, 2.0)

                if PresvUdalj < 1.5 then
                    TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da otvoris ormar")
                    if IsControlPressed(0, 38) then 
                        OpenCloakroomMenu()
                    end
                end
            end


        else
            for k,v in pairs(PreneseniMrtvi) do
                if GetPlayerPed(GetPlayerFromServerId(k)) ~= PlayerPedId() then
                    if not ProvjeravaPuls and #(PedPos - v.coords) < 2 then
                        TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da provjeris puls")
                        if IsControlPressed(0, 38) then
                            ProvjeravaPuls = true
                            TriggerEvent("bfunkcije:tajmerdosto", "Provjeravanja pulsa...", 5, false, function()
                                if v.isHead then
                                    TriggerEvent("bfunkcije:notif", "", "Ova osoba nema puls...", 5, false)
                                else    
                                    TriggerEvent("bfunkcije:notif", "", "Ova osoba ima puls!", 5, true)
                                end
                                ProvjeravaPuls = false
                            end)
                            while ProvjeravaPuls do Wait(100) end
                        end
                    end
                end
            end
        end
    end
end) 


---------------------- vozila
Citizen.CreateThread(function()

    local bolnicagaraza= {
        `s_m_m_doctor_01`,
    }
    exports['qtarget']:AddTargetModel(bolnicagaraza, {
        options = {
            {
                event = "bolnicagaraza-bog",
                icon = "fas fa-car",
                label = "Garaza Bolnica",
				job = 'bolnica'
            },
            {
                event = "bolnicagaraza-parkiraj",
                icon = "fas fa-car",
                label = "Parkiraj Vozilo",
				job = 'bolnica'
            },
        },
        job = {"all"},
        distance = 2.0
    })
    end)

    RegisterNetEvent("bolnicagaraza-bog")
    AddEventHandler("bolnicagaraza-bog", function()
		otvorivozilabolnica()
    end)
    AddEventHandler('bolnicagaraza-parkiraj', function()
    	local vozilo = GetVehiclePedIsIn(PlayerPedId(), true)
			ESX.Game.DeleteVehicle(vozilo)
    end)
    function otvorivozilabolnica()
        TriggerEvent('nh-context:sendMenu', {
            {
                id = 1,
                header = "🚑 >> Ambulantni kombi",
                txt = "Brzina: 300km/h - Kocnice: 2/4 - Transmision: 3/4 ",
                params = {
                    event = "vozilo1bolnica",
                }
                
            },
            {
                id = 2,
                header = "🚑 >> Dodge",
                txt = "Brzina: 280km/h - Kocnice: 2/4 - Transmision: 3/4 ",
                params = {
                    event = "vozilo2bolnica",
                }
                
            },
        
        })
    end
    
    AddEventHandler('vozilo1bolnica', function()
        ESX.Game.SpawnVehicle("ambulance", vector3(-828.70, -1218.50, 6.43), 320.00, function(vehicle)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)

            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            SetVehicleNumberPlateText(vehicle --[[ Vehicle ]], 'POLICIJA' --[[ string ]])
            SetVehicleNumberPlateTextIndex(vehicle --[[ Vehicle ]],1 --[[ integer ]])
        end)
        Wait(200)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleDirtLevel(vehicle, 0.0)

        ESX.UI.Menu.CloseAll()
    end)
    AddEventHandler('vozilo2bolnica', function()
        ESX.Game.SpawnVehicle("ambulance", vector3(-828.70, -1218.50, 6.43), 320.00, function(vehicle)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)

            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            SetVehicleNumberPlateText(vehicle --[[ Vehicle ]], 'POLICIJA' --[[ string ]])
            SetVehicleNumberPlateTextIndex(vehicle --[[ Vehicle ]],1 --[[ integer ]])
        end)
        Wait(200)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleDirtLevel(vehicle, 0.0)

        ESX.UI.Menu.CloseAll()
    end)
---------------------- boss akcije

exports.qtarget:AddBoxZone("bolnicaboss", vector3(-815.59, -1235.9, 7.34), 1, 1, {
    name="bolnicaboss",
    heading=11.0,
    debugPoly=false,
    }, {
        options = {
            {
                event = "bolnica:boss",
                icon = "fas fa-sign-in-alt",
                label = "Boss akcije",
                job = "bolnica",
            },
      
        },
        distance = 3.5
})

AddEventHandler('bolnica:boss', function()
    if PlayerData.job.grade_name == "boss" then
 
        TriggerEvent('society:OpenMenu')
        else
            ESX.ShowNotification('Nisi ovlasten za ovo!')
        end
end)
---------------------- presvlacenje
exports.qtarget:AddBoxZone("bolnicapresvalcenje", vector3(-826.23, -1237.09, 7.34), 3, 8, {
    name="bolnicapresvalcenje",
    heading=11.0,
    debugPoly=false,
    }, {
        options = {
            {
                event = "presvlacenjebolnica",
                icon = "fas fa-sign-in-alt",
                label = "Ormar sa odjecom",
                job = "bolnica",
            },
      
        },
        distance = 3.5
})

AddEventHandler('presvlacenjebolnica', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "👨‍⚕️ >> Radno odjelo",
			txt = "Doktorska uniforma",
			params = {
				event = "bolnica:radno",
			}
			
		},
		{
			id = 2,
			header = "👨 >> Civilno odjelo",
			txt = "Civilna odjeca",
			params = {
				event = "bolnica:civil",
			}
			
		},
	 
	})
    AddEventHandler('bolnica:radno', function()
        local playerPed = PlayerPedId()
        setUniform('doktor', playerPed)
        setUniform('brat', playerPed)
        setUniform('chief', playerPed)
        setUniform('boss', playerPed)
    end)
    AddEventHandler('bolnica:civil', function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            local isMale = skin.sex == 0
    
            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                    TriggerEvent('esx:restoreLoadout')
                end)
            end)
    
        end)
    
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        
    end)
  
end)


--------------- ormar sa stvarima
exports.qtarget:AddBoxZone("bolnicastvari", vector3(-820.71, -1243.72, 7.34), 2, 3, {
    name="bolnicastvari",
    heading=11.0,
    debugPoly=false,
    }, {
        options = {
            {
                event = "uzmistvaribolnica",
                icon = "fas fa-sign-in-alt",
                label = "Ormar sa ljekovima",
                job = "bolnica",
            },
      
        },
        distance = 3.5
})

AddEventHandler('uzmistvaribolnica', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "💉 >> Uzmi medikit",
			txt = "Medikit za dizanje igraca",
			params = {
				event = "medikit:bolnica",
			}
			
		},
		{
			id = 2,
			header = "💉 >> Uzmi bandage",
			txt = "Bandage za ljecenje rana",
			params = {
				event = "bandage:bolnica",
			}
			
		},
	 
	})

  
end)
AddEventHandler('medikit:bolnica', function()
    TriggerServerEvent('dajmumedikit')
    
end)
AddEventHandler('bandage:bolnica', function()
    TriggerServerEvent('dajmubandage')
    
end)
function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.GetPlayerData().job.grade_name

	local elements = {
		{label = "Uniforma Doktora", uniform = 'doktor'},
		{label = "Uniforma Bolnicara", uniform = 'bolnicar'},
        {label = "Uniforma Direktora", uniform = 'direktor'},
        {label = "Tvoja Odjeca", value = 'citizen_wear'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "Presvlacenje - Bolnica",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'citizen_wear' then
			
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)

		end

		if data.current.uniform then
			setUniform(data.current.uniform, playerPed)
		elseif data.current.value == 'freemode_ped' then
			local modelHash

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)
					SetPedDefaultComponentVariation(PlayerPedId())

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end


function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if uniforme[job].male then
				TriggerEvent('skinchanger:loadClothes', skin, uniforme[job].male)
			else
				ESX.ShowNotification("Nema odjece")
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if uniforme[job].female then
				TriggerEvent('skinchanger:loadClothes', skin, uniforme[job].female)
			else
				ESX.ShowNotification("Nema odjece")
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

RegisterCommand("izlijeci", function()
    
    if not vecLijeci and PlayerData.job.name == "bolnica" then

        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer ~= -1 and closestPlayerDistance < 3.0 then
            vecLijeci = true
            
            TriggerServerEvent("bBolnica:Lijecenje", GetPlayerServerId(closestPlayer))
        else
            TriggerServerEvent("bBolnica:Lijecenje")
        end

    end
    
end, false)

RegisterCommand("obrisibolnicarski", function()
    
    if not vecLijeci and PlayerData.job.name == "bolnica" then

        local najblizeauto = ESX.Game.GetClosestVehicle()

        if najblizeauto ~= -1 and GetEntityModel(najblizeauto) == GetHashKey("bol350") then
            TriggerServerEvent("bBolnica:ObrisiBolnicarskoAuto", NetworkGetNetworkIdFromEntity(najblizeauto))
        end

    end
    
end, false)

RegisterCommand("popravibolnicarski", function()
    
    if not vecLijeci and PlayerData.job.name == "bolnica" then

        local najblizeauto = ESX.Game.GetClosestVehicle()

        if #( GetEntityCoords(PlayerPedId()) - GetEntityCoords(najblizeauto) ) < 3 then
            if najblizeauto ~= -1 and ( GetEntityModel(najblizeauto) == GetHashKey("bol350") or GetEntityModel(najblizeauto) == GetHashKey("skoda") or GetEntityModel(najblizeauto) == GetHashKey("sanitet") ) then
                TriggerEvent("esx_repairkit:onUse")
            else
                ESX.ShowNotification('Mozes popravljati samo bolnicarska vozila!')
            end
        else
            ESX.ShowNotification('Nema bolnicarskih vozila u blizini!')
        end

    end
    
end, false)

RegisterNetEvent("bBolnica:PocniProcesLijecenja_pacijent")
AddEventHandler("bBolnica:PocniProcesLijecenja_pacijent", function()

    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("bfunkcije:tajmerdosto", "Neko te lijeci...", 30, false, function()
        ClearPedTasksImmediately(PlayerPedId())
        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
        ClearPedBloodDamage(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerEvent("stifi:napunistatsBolnica")
        vecLijeci = false
    end)

end)

RegisterNetEvent("bBolnica:PocniProcesLijecenja_doktor")
AddEventHandler("bBolnica:PocniProcesLijecenja_doktor", function()

    FreezeEntityPosition(PlayerPedId(), true)

    RequestAnimDict("amb@medic@standing@tendtodead@base")
    while not HasAnimDictLoaded("amb@medic@standing@tendtodead@base") do 
        Wait(100)
    end
    TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -1, 1)
    TriggerEvent("bfunkcije:tajmerdosto", "Lijecenje osobe...", 30, false, function()
        ClearPedTasksImmediately( PlayerPedId() )
        FreezeEntityPosition(PlayerPedId(), false)
        vecLijeci = false
    end)

end)

RegisterNetEvent("bBolnica:PocniProcesLijecenja_sebe")
AddEventHandler("bBolnica:PocniProcesLijecenja_sebe", function()

    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("bfunkcije:tajmerdosto", "Lijecenje...", 15, false, function()
        print( GetEntityMaxHealth(PlayerPedId()) )
        ClearPedTasksImmediately(PlayerPedId())
        SetEntityHealth(PlayerPedId(), 200)
        ClearPedBloodDamage(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerEvent("stifi:napunistatsBolnica")
        vecLijeci = false
    end)

end)



Citizen.CreateThread(function()
	OnEnterMp() -- required to load heist ipl?
	RequestAllIpls()
end)

Citizen.CreateThread(function()
	for k,ipl in pairs(allIpls) do
		loadInterior(ipl.coords, ipl.interiorsProps, ipl.interiorsPropColors)
	end
end)

function loadInterior(coords, interiorProps, interiorsPropColors)
	for k,coords in pairs(coords) do

		local interiorID = GetInteriorAtCoords(coords[1], coords[2], coords[3])

		if IsValidInterior(interiorID) then
			PinInteriorInMemory(interiorID)

			for index,propName in pairs(interiorProps) do
				ActivateInteriorEntitySet(interiorID, propName)
			end

			if interiorsPropColors then
				for i=1, #interiorsPropColors, 1 do
					SetInteriorEntitySetColor(interiorID, interiorsPropColors[i][1], interiorsPropColors[i][2])
				end
			end

			RefreshInterior(interiorID)
		end
	end
end

-- https://wiki.gtanet.work/index.php?title=Online_Interiors_and_locations
-- IPL list 1.0.1290: https://pastebin.com/iNGLY32D
-- Extra IPL info: https://pastebin.com/SE5t8CnE
function RequestAllIpls()
	-- Simeon: -47.162, -1115.333, 26.5
	RequestIpl('shr_int')

	-- Trevor: 1985.481, 3828.768, 32.5
	-- Trash or Tidy. Only choose one.
	RequestIpl('TrevorsTrailerTrash')
	--RequestIpl('TrevorsTrailerTidy')

	-- Vangelico Jewelry Store: -637.202, -239.163, 38.1
	RequestIpl('post_hiest_unload')

	-- Max Renda: -585.825, -282.72, 35.455
	RequestIpl('refit_unload')

	-- Heist Union Depository: 2.697, -667.017, 16.130
	RequestIpl('FINBANK')

	-- Morgue: 239.752, -1360.650, 39.534
	RequestIpl('Coroner_Int_on')
	RequestIpl('coronertrash')

	-- Cluckin Bell: -146.384, 6161.5, 30.2
	RequestIpl('CS1_02_cf_onmission1')
	RequestIpl('CS1_02_cf_onmission2')
	RequestIpl('CS1_02_cf_onmission3')
	RequestIpl('CS1_02_cf_onmission4')

	-- Grapeseed Cow Farm: 2447.9, 4973.4, 47.7
	RequestIpl('farm')
	RequestIpl('farmint')
	RequestIpl('farm_lod')
	RequestIpl('farm_props')
	RequestIpl('des_farmhouse')

	-- FIB lobby: 105.456, -745.484, 44.755
	RequestIpl('FIBlobby')

	-- Billboard: iFruit
	RequestIpl('FruitBB')
	RequestIpl('sc1_01_newbill')
	RequestIpl('hw1_02_newbill')
	RequestIpl('hw1_emissive_newbill')
	RequestIpl('sc1_14_newbill')
	RequestIpl('dt1_17_newbill')

	-- Lester's factory: 716.84, -962.05, 31.59
	RequestIpl('id2_14_during_door')
	RequestIpl('id2_14_during1')

	-- Life Invader lobby: -1047.9, -233.0, 39.0
	RequestIpl('facelobby')

	-- Tunnels
	RequestIpl('v_tunnel_hole')

	-- Carwash: 55.7, -1391.3, 30.5
	RequestIpl('Carwash_with_spinners')

	-- Stadium 'Fame or Shame': -248.492, -2010.509, 34.574
	RequestIpl('sp1_10_real_interior')
	RequestIpl('sp1_10_real_interior_lod')

	-- House in Banham Canyon: -3086.428, 339.252, 6.372
	RequestIpl('ch1_02_open')

	-- Garage in La Mesa (autoshop): 970.275, -1826.570, 31.115
	RequestIpl('bkr_bi_id1_23_door')

	-- Hill Valley church - Grave: -282.464, 2835.845, 55.914
	RequestIpl('lr_cs6_08_grave_closed')

	-- Lost's trailer park: 49.494, 3744.472, 46.386
	RequestIpl('methtrailer_grp1')

	-- Lost safehouse: 984.155, -95.366, 74.50
	RequestIpl('bkr_bi_hw1_13_int')

	-- Raton Canyon river: -1652.83, 4445.28, 2.52
	RequestIpl('CanyonRvrShallow')

	-- Zancudo Gates (GTAO like): -1600.301, 2806.731, 18.797
	RequestIpl('CS3_07_MPGates')

	-- Pillbox hospital: 356.8, -590.1, 43.3
	RequestIpl('RC12B_Default')
	-- RequestIpl('RC12B_Fixed')

	-- Josh's house: -1117.163, 303.1, 66.522
	RequestIpl('bh1_47_joshhse_unburnt')
	RequestIpl('bh1_47_joshhse_unburnt_lod')

	-- Zancudo River (need streamed content): 86.815, 3191.649, 30.463
	RequestIpl('cs3_05_water_grp1')
	RequestIpl('cs3_05_water_grp1_lod')
	RequestIpl('cs3_05_water_grp2')
	RequestIpl('cs3_05_water_grp2_lod')

	-- Cassidy Creek (need streamed content): -425.677, 4433.404, 27.325
	RequestIpl('canyonriver01')
	RequestIpl('canyonriver01_lod')

	-- Graffitis
	RequestIpl('ch3_rd2_bishopschickengraffiti') -- 1861.28, 2402.11, 58.53
	RequestIpl('cs5_04_mazebillboardgraffiti') -- 2697.32, 3162.18, 58.1
	RequestIpl('cs5_roads_ronoilgraffiti') -- 2119.12, 3058.21, 53.25

	-- Aircraft Carrier (USS Luxington): 3082.312 -4717.119 15.262
	RequestIpl('hei_carrier')
	RequestIpl('hei_carrier_distantlights')
	RequestIpl('hei_Carrier_int1')
	RequestIpl('hei_Carrier_int2')
	RequestIpl('hei_Carrier_int3')
	RequestIpl('hei_Carrier_int4')
	RequestIpl('hei_Carrier_int5')
	RequestIpl('hei_Carrier_int6')
	RequestIpl('hei_carrier_lodlights')
	RequestIpl('hei_carrier_slod')

	-- Galaxy Super Yacht: -2043.974,-1031.582, 11.981
	RequestIpl('hei_yacht_heist')
	RequestIpl('hei_yacht_heist_Bar')
	RequestIpl('hei_yacht_heist_Bedrm')
	RequestIpl('hei_yacht_heist_Bridge')
	RequestIpl('hei_yacht_heist_DistantLights')
	RequestIpl('hei_yacht_heist_enginrm')
	RequestIpl('hei_yacht_heist_LODLights')
	RequestIpl('hei_yacht_heist_Lounge')

	-- Bahama Mamas: -1388, -618.420, 30.820
	--RequestIpl('hei_sm_16_interior_v_bahama_milo_')

	-- Red Carpet: 300.593, 199.759, 104.378
	--RequestIpl('redCarpet')

	-- UFO
	-- Zancudo: -2052, 3237, 1457
	-- Hippie base: 2490.5, 3774.8, 2414
	-- Chiliad: 501.53, 5593.86, 796.23
	-- RequestIpl('ufo')
	-- RequestIpl('ufo_eye')
	-- RequestIpl('ufo_lod')

	--
	-- Appartments & Offices
	-- Some have multiple choices, in that case pick one
	--

	--
	-- Arcadius Business Centre: -141.29, -621, 169
	--

	-- RequestIpl('ex_dt1_02_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_dt1_02_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_dt1_02_office_01c')	-- Old Spice: Vintage

	-- RequestIpl('ex_dt1_02_office_02a')	-- Executive: Contrast
	-- RequestIpl('ex_dt1_02_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_dt1_02_office_02c')	-- Executive: Cool

	-- RequestIpl('ex_dt1_02_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_dt1_02_office_03b')	-- Power Broker: Conservative
	-- RequestIpl('ex_dt1_02_office_03c')	-- Power Broker: Polished

	--
	-- Maze Bank Building: -75.498, -827.189, 243.386
	--

	-- RequestIpl('ex_dt1_11_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_dt1_11_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_dt1_11_office_01c')	-- Old Spice: Vintage

	-- RequestIpl('ex_dt1_11_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_dt1_11_office_02c')	-- Executive: Cool
	-- RequestIpl('ex_dt1_11_office_02a')	-- Executive: Contrast

	-- RequestIpl('ex_dt1_11_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_dt1_11_office_03b')	-- Power Broker: Conservative
	-- RequestIpl('ex_dt1_11_office_03c')	-- Power Broker: Polished

	--
	-- Lom Bank: -1579.756, -565.066, 108.523
	--

	-- RequestIpl('ex_sm_13_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_sm_13_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_sm_13_office_01c')	-- Old Spice: Vintage
	-- RequestIpl('ex_sm_13_office_02a')	-- Executive: Contrast
	-- RequestIpl('ex_sm_13_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_sm_13_office_02c')	-- Executive: Cool
	-- RequestIpl('ex_sm_13_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_sm_13_office_03b')	-- Power Broker: Conservative
	-- RequestIpl('ex_sm_13_office_03c')	-- Power Broker: Polished

	--
	-- Maze Bank West: -1392.667, -480.474, 72.042
	--

	-- RequestIpl('ex_sm_15_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_sm_15_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_sm_15_office_01c')	-- Old Spice: Vintage
	-- RequestIpl('ex_sm_15_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_sm_15_office_02c')	-- Executive: Cool
	-- RequestIpl('ex_sm_15_office_02a')	-- Executive: Contrast
	-- RequestIpl('ex_sm_15_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_sm_15_office_03b')	-- Power Broker: Convservative
	-- RequestIpl('ex_sm_15_office_03c')	-- Power Broker: Polished

	--
	-- Apartment 1: -786.866, 315.764, 217.638
	--

	RequestIpl('apa_v_mp_h_01_a') -- Modern
	-- RequestIpl('apa_v_mp_h_02_a') -- Mody
	-- RequestIpl('apa_v_mp_h_03_a') -- Vibrant
	-- RequestIpl('apa_v_mp_h_04_a') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_a') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_a') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_a') -- Regal
	-- RequestIpl('apa_v_mp_h_08_a') -- Aqua

	--
	-- Apartment 2: -786.956, 315.622, 187.913
	--

	-- RequestIpl('apa_v_mp_h_01_c') -- Modern
	RequestIpl('apa_v_mp_h_02_c') -- Mody
	-- RequestIpl('apa_v_mp_h_03_c') -- Vibrant
	-- RequestIpl('apa_v_mp_h_04_c') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_c') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_c') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_c') -- Regal
	-- RequestIpl('apa_v_mp_h_08_c') -- Aqua

	--
	-- Apartment 3: -774.012, 342.042, 196.686
	--

	-- RequestIpl('apa_v_mp_h_01_b') -- Modern
	-- RequestIpl('apa_v_mp_h_02_b') -- Mody
	-- RequestIpl('apa_v_mp_h_03_b') -- Vibrant
	RequestIpl('apa_v_mp_h_04_b') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_b') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_b') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_b') -- Regal
	-- RequestIpl('apa_v_mp_h_08_b') -- Aqua

	--
	-- Bunkers, Biker clubhouses & Warehouses
	--

	-- Clubhouse 1: 1107.04, -3157.399, -37.519
	RequestIpl('bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo')

	-- Clubhouse 2: 998.4809, -3164.711, -38.907
	RequestIpl('bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo')

	-- Warehouse 1: 1009.5, -3196.6, -39
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware02_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware03_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware04_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware05_milo')

	-- Warehouse 2: 1051.491, -3196.536, -39.148
	RequestIpl('bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo')

	-- Warehouse 3: 1093.6, -3196.6, -38.998
	RequestIpl('bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo')

	-- Warehouse 4: 1121.897, -3195.338, -40.4025
	RequestIpl('bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo')

	-- Warehouse 5: 1165, -3196.6, -39.013
	RequestIpl('bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo')

	-- Warehouse Small: 1094.988, -3101.776, -39
	RequestIpl('ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo')

	-- Warehouse Medium: 1056.486, -3105.724, -39
	RequestIpl('ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo')

	-- Warehouse Large: 1006.967, -3102.079, -39.0035
	RequestIpl('ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo')

	-- Import / Export Garage: 994.593, -3002.594, -39.647
	RequestIpl('imp_impexp_interior_placement')
	RequestIpl('imp_impexp_interior_placement_interior_0_impexp_int_01_milo_')
	RequestIpl('imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_')
	RequestIpl('imp_impexp_interior_placement_interior_2_imptexp_mod_int_01_milo_')
	RequestIpl('imp_impexp_interior_placement_interior_3_impexp_int_02_milo_')

	-- Import / Export Garages: Interiors
	RequestIpl('imp_dt1_02_modgarage')
	RequestIpl('imp_dt1_02_cargarage_a')
	RequestIpl('imp_dt1_02_cargarage_b')
	RequestIpl('imp_dt1_02_cargarage_c')

	RequestIpl('imp_dt1_11_modgarage')
	RequestIpl('imp_dt1_11_cargarage_a')
	RequestIpl('imp_dt1_11_cargarage_b')
	RequestIpl('imp_dt1_11_cargarage_c')

	RequestIpl('imp_sm_13_modgarage')
	RequestIpl('imp_sm_13_cargarage_a')
	RequestIpl('imp_sm_13_cargarage_b')
	RequestIpl('imp_sm_13_cargarage_c')

	RequestIpl('imp_sm_15_modgarage')
	RequestIpl('imp_sm_15_cargarage_a')
	RequestIpl('imp_sm_15_cargarage_b')
	RequestIpl('imp_sm_15_cargarage_c')

	-- Bunkers: Exteriors
	RequestIpl('gr_case0_bunkerclosed') -- 848.6175, 2996.567, 45.81612
	RequestIpl('gr_case1_bunkerclosed') -- 2126.785, 3335.04, 48.21422
	RequestIpl('gr_case2_bunkerclosed') -- 2493.654, 3140.399, 51.28789
	RequestIpl('gr_case3_bunkerclosed') -- 481.0465, 2995.135, 43.96672
	RequestIpl('gr_case4_bunkerclosed') -- -391.3216, 4363.728, 58.65862
	RequestIpl('gr_case5_bunkerclosed') -- 1823.961, 4708.14, 42.4991
	RequestIpl('gr_case6_bunkerclosed') -- 1570.372, 2254.549, 78.89397
	RequestIpl('gr_case7_bunkerclosed') -- -783.0755, 5934.686, 24.31475
	RequestIpl('gr_case9_bunkerclosed') -- 24.43542, 2959.705, 58.35517
	RequestIpl('gr_case10_bunkerclosed') -- -3058.714, 3329.19, 12.5844
	RequestIpl('gr_case11_bunkerclosed') -- -3180.466, 1374.192, 19.9597

	-- Smugglers run / Doomsday interiors

	RequestIpl('xm_siloentranceclosed_x17')
	RequestIpl('sm_smugdlc_interior_placement')
	RequestIpl('sm_smugdlc_interior_placement_interior_0_smugdlc_int_01_milo_')
	RequestIpl('xm_x17dlc_int_placement')

	RequestIpl('xm_x17dlc_int_placement_interior_0_x17dlc_int_base_ent_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_1_x17dlc_int_base_loop_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_2_x17dlc_int_bse_tun_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_3_x17dlc_int_base_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_4_x17dlc_int_facility_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_5_x17dlc_int_facility2_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_6_x17dlc_int_silo_01_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_7_x17dlc_int_silo_02_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_8_x17dlc_int_sub_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_9_x17dlc_int_01_milo_')

	RequestIpl('xm_x17dlc_int_placement_interior_10_x17dlc_int_tun_straight_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_11_x17dlc_int_tun_slope_flat_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_12_x17dlc_int_tun_flat_slope_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_13_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_14_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_15_x17dlc_int_tun_straight_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_16_x17dlc_int_tun_straight_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_17_x17dlc_int_tun_slope_flat_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_18_x17dlc_int_tun_slope_flat_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_19_x17dlc_int_tun_flat_slope_milo_')

	RequestIpl('xm_x17dlc_int_placement_interior_20_x17dlc_int_tun_flat_slope_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_21_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_22_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_23_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_24_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_25_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_26_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_27_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_28_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_29_x17dlc_int_tun_30d_l_milo_')

	RequestIpl('xm_x17dlc_int_placement_interior_30_v_apart_midspaz_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_31_v_studio_lo_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_32_v_garagem_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_33_x17dlc_int_02_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_34_x17dlc_int_lab_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_35_x17dlc_int_tun_entry_milo_')

	RequestIpl('xm_x17dlc_int_placement_strm_0')
	RequestIpl('xm_bunkerentrance_door')
	RequestIpl('xm_hatch_01_cutscene')
	RequestIpl('xm_hatch_02_cutscene')
	RequestIpl('xm_hatch_03_cutscene')
	RequestIpl('xm_hatch_04_cutscene')
	RequestIpl('xm_hatch_06_cutscene')
	RequestIpl('xm_hatch_07_cutscene')
	RequestIpl('xm_hatch_08_cutscene')
	RequestIpl('xm_hatch_09_cutscene')
	RequestIpl('xm_hatch_10_cutscene')
	RequestIpl('xm_hatch_closed')
	RequestIpl('xm_hatches_terrain')
	RequestIpl('xm_hatches_terrain_lod')
	RequestIpl('xm_mpchristmasadditions')

	-- Bunkers: Interior: 892.638, -3245.866, -98.265
	--[[
	RequestIpl('gr_entrance_placement')
	RequestIpl('gr_grdlc_interior_placement')
	RequestIpl('gr_grdlc_interior_placement_interior_0_grdlc_int_01_milo_')
	RequestIpl('gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_')
	--]]

	-- North Yankton: 3217.697, -4834.826, 111.815
	--[[
	RequestIpl('prologue01')
	RequestIpl('prologue01c')
	RequestIpl('prologue01d')
	RequestIpl('prologue01e')
	RequestIpl('prologue01f')
	RequestIpl('prologue01g')
	RequestIpl('prologue01h')
	RequestIpl('prologue01i')
	RequestIpl('prologue01j')
	RequestIpl('prologue01k')
	RequestIpl('prologue01z')
	RequestIpl('prologue02')
	RequestIpl('prologue03')
	RequestIpl('prologue03b')
	RequestIpl('prologue04')
	RequestIpl('prologue04b')
	RequestIpl('prologue05')
	RequestIpl('prologue05b')
	RequestIpl('prologue06')
	RequestIpl('prologue06b')
	RequestIpl('prologue06_int')
	RequestIpl('prologuerd')
	RequestIpl('prologuerdb')
	RequestIpl('prologue_DistantLights')
	RequestIpl('prologue_LODLights')
	RequestIpl('prologue_m2_door')
	--]]
end
