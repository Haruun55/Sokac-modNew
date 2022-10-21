ESX = nil
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

s = 2000

local food = 0
local thirst = 0
local stress = 0
local spavanje = 0
local bankara = 0
local kesara = 0
local jelusafeu = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local korde = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.SafeZoneLokacije) do
			if(GetDistanceBetweenCoords(korde, v, true) < 30) then
                jelusafeu = true
            else
                jelusafeu = false
            end
		end
     Wait(2000)
        TriggerEvent('esx_status:getStatus', 'hunger',
                     function(status) food = status.val / 10000 end)
                     Wait(500)
        TriggerEvent('esx_status:getStatus', 'thirst',
                     function(status) thirst = status.val / 10000 end)
                     Wait(500)
        TriggerEvent('esx_status:getStatus', 'spavanje',
                     function(status) spavanjeValue = status.val / 10000 end)
                     Wait(500)
        if Config.ShowStress == true then
            TriggerEvent('esx_status:getStatus', 'stress',
                         function(status) stress = status.val / 10000 end)
                         Wait(2000)
        end
    end
end)



Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(s)

            if (Config.HideMinimap) then
                if IsPedSittingInAnyVehicle(PlayerPedId()) then
                    DisplayRadar(true)
                else
                    DisplayRadar(false)
                end
            else
                DisplayRadar(true)
            end

            if (Config.Stress) then
                localStress = stress
            else
                localStress = false
            end

            local hudPosition

            if IsPedSittingInAnyVehicle(PlayerPedId()) or not Config.HideMinimap then
                hudPosition = "right"
            else
                hudPosition = "left"
            end

            SendNUIMessage(
                {
                    hud = Config.Hud,
                    pauseMenu = IsPauseMenuActive(),
                    armour = GetPedArmour(PlayerPedId()),
                    health = GetEntityHealth(PlayerPedId()) - 100,
                    food = food,
                    thirst = thirst,
                    stress = stress,
                    spavanje = spavanje,
                    banka = bankara,
                    kes = kesara,
                    posao = PlayerData.job.label .. ' - ' .. PlayerData.job.grade_label,
                    safezona = jelusafeu,
                    brojigraca = #GetActivePlayers(),
                    hudPosition = hudPosition
                }
            )
        end
    end
)

--Cricle Radar
Citizen.CreateThread(
    function()
        RequestStreamedTextureDict("circlemap", false)
        while not HasStreamedTextureDictLoaded("circlemap") do
            Wait(1500)
        end

        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

        SetMinimapClipType(1)
        SetMinimapComponentPosition("minimap", "L", "B", 0.025, -0.03, 0.153, 0.24)
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.135, 0.12, 0.093, 0.164)
        SetMinimapComponentPosition("minimap_blur", "L", "B", 0.012, 0.022, 0.256, 0.337)

        local minimap = RequestScaleformMovie("minimap")

        SetRadarBigmapEnabled(false, false)

        Citizen.Wait(2000)
        while true do 
            Wait(1000)
            BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
            ScaleformMovieMethodAddParamInt(3)
            EndScaleformMovieMethod()
        end
        Wait(9999)
    end)