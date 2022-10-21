CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(250) end
	while ESX.GetPlayerData().job == nil do Wait(250) end
	PlayerData = ESX.GetPlayerData()
	Wait(1000)
	TSE("registrujstashove")
end)

----drzanje ruku gore
RegisterCommand('+handsup', function()
	local ped = PlayerPedId()
	local dict = "missminuteman_1ig_2"
	local anim = "handsup_base"
  
	if not IsDead then
	  if not handsup then
		  RequestAnimDict(dict)
		  while not HasAnimDictLoaded(dict) do
			  Citizen.Wait(100)
		  end
  
		  TaskPlayAnim(ped, dict, anim, 2.0, 2.0, -1, 51, 0, false, false, false)
		  handsup = true
	  else
		  handsup = false
		  ClearPedTasks(ped)
	  end
	end
  end, false)
  
  RegisterCommand('-handsup', function()
  end, false)
  
  RegisterKeyMapping('+handsup', 'Podignite ruke u vis', 'keyboard', 'x')





local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function GetClosestPlayer(radius)
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _,playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords-playerCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

RegisterNetEvent("qtarget:carrymrtvi", function()
	if not carry.InProgress then
		local closestPlayer = GetClosestPlayer(3)
		if closestPlayer then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				carry.InProgress = true
				carry.targetSrc = targetSrc
				TriggerServerEvent("CarryPeople:sync",targetSrc)
				ensureAnimDict(carry.personCarrying.animDict)
				carry.type = "carrying"
			else
				drawNativeNotification("~r~Nema nikoga u blizini da nosite osobu!")
			end
		else
			drawNativeNotification("~r~Nema nikoga u blizini da nosite osobu!")
		end
	else
		carry.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
		carry.targetSrc = 0
	end
end)

RegisterKeyMapping('uncarryy', 'Uncarry', 'keyboard', 'BACK')


RegisterCommand("uncarryy", function()
	local closestPlayer = GetClosestPlayer(3)
	local targetSrc = GetPlayerServerId(closestPlayer)
	if carry.InProgress then
	    carry.InProgress = false
	    ClearPedSecondaryTask(PlayerPedId())
	    DetachEntity(PlayerPedId(), true, false)
	    TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
	    carry.targetSrc = 0
	end
end)

RegisterCommand('-uncarry', function()
end, false)


RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
	CreateThread(function()
		while carry.InProgress do
			local pedara = GetPlayerPed(GetPlayerFromServerId(targetSrc))
			local pedic = PlayerPedId()
			local koord1 = GetEntityCoords(pedara)
			local koord2 = GetEntityCoords(pedic)
			if #(koord1-koord2) > 5.0 then
				DetachEntity(PlayerPedId(), true, false)
				AttachEntityToEntity(pedic, pedara, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
			end
			Citizen.Wait(100)
		end
	end)
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
		else
			Wait(500)
		end
		Wait(0)
	end
end)


  TabelaZaPedove = {
	{'s_m_m_armoured_02'--[[HASH ZA PEDA]], 458.24315--[[X KORDINATA]], -1022.6103 --[[Y KORDINATA]],27.33--[[Z KORDINATA]],101.0--[[HEADING]]},
	{'s_m_y_armymech_01'--[[HASH ZA PEDA]], 442.95--[[X KORDINATA]], -1014.07 --[[Y KORDINATA]],27.63--[[Z KORDINATA]],180.0--[[HEADING]]},
	{'s_m_m_doctor_01'--[[HASH ZA PEDA]], -825.95--[[X KORDINATA]], -1226.07 --[[Y KORDINATA]],6.03--[[Z KORDINATA]],54.0--[[HEADING]]},

	{'u_m_y_baygor'--[[HASH ZA PEDA]], -698.24315--[[X KORDINATA]], -932.6103 --[[Y KORDINATA]],18.0--[[Z KORDINATA]],101.0--[[HEADING]]},
	{'u_m_y_baygor'--[[HASH ZA PEDA]], 11.95--[[X KORDINATA]], -1389.07 --[[Y KORDINATA]],28.33--[[Z KORDINATA]],180.0--[[HEADING]]},
	{'u_m_y_baygor'--[[HASH ZA PEDA]], 175.95--[[X KORDINATA]], -1728.07 --[[Y KORDINATA]],28.33--[[Z KORDINATA]],151.0--[[HEADING]]},
	
	{'s_m_y_construct_01'--[[HASH ZA PEDA]], 1390.95--[[X KORDINATA]], -749.07 --[[Y KORDINATA]],66.33--[[Z KORDINATA]],99.0--[[HEADING]]},

	{'s_m_y_robber_01'--[[HASH ZA PEDA]], -321.95--[[X KORDINATA]], -1545.07 --[[Y KORDINATA]],30.03--[[Z KORDINATA]],0.05--[[HEADING]]},
  }
  
  Citizen.CreateThread(function()
	--[[vuce sve pedove iz tabele i requestuje ih]]
	for _,v in pairs(TabelaZaPedove) do
	  RequestModel(GetHashKey(v[1]))
	  while not HasModelLoaded(GetHashKey(v[1])) do
		Wait(1)
	  end
		--[[postavlja sve pedove iz tabele]]
	  PostaviPeda =  CreatePed(4, v[1],v[2],v[3],v[4],v[5], false, true)
	  FreezeEntityPosition(PostaviPeda, true) -- Drzi peda na jednoj lokaciji
	  SetEntityInvincible(PostaviPeda, true) -- Da ped mirno stoji 
	  SetBlockingOfNonTemporaryEvents(PostaviPeda, true) -- Taakodje i ovaj native ga drzi mirno
	end
  end)


-- Npcevi
local NPC = {
	{model = "s_m_m_gaffer_01",  x = -214.3514, y = -1324.1274, z = 29.9, h = 278.8047}, 
    {model = "a_m_m_bevhills_02",  x = 12.3514, y = 6513.1274, z = 30.8778, h = 45.8047}, 
    {model = "a_m_m_bevhills_02",  x = 1697.7291, y = 4829.5552, z = 41.0631, h = 99.6116},
    {model = "a_m_m_bevhills_02",  x = 617.6696, y = 2766.7561, z = 41.0881, h = 173.7814}, 
    {model = "a_m_m_bevhills_02",  x = -3175.7009, y = 1041.5458, z = 19.8632, h = 317.0905}, 
    {model = "a_m_m_bevhills_02",  x = 953.4153, y = 25.7622, z = 73.8769, h = 337.8144},  
    {model = "a_m_m_bevhills_02",  x = -1455.3584, y = -243.9198, z = 48.8117, h = 11.1279}, 
    {model = "a_m_m_bevhills_02",  x = -705.1901, y = -159.7506, z = 36.4152, h = 73.4642}, 
    {model = "a_m_m_bevhills_02",  x = -161.4640, y = -294.6904, z = 38.7333, h = 195.7488}, 
    {model = "a_m_m_bevhills_02",  x = 120.6843, y = -226.6505, z = 53.5579, h = 328.4065}, 
    {model = "a_m_m_bevhills_02",  x = -1187.2831, y = -768.2809, z = 16.3255, h = 119.8569}, 
    {model = "a_m_m_bevhills_02",  x = 430.3335, y = -800.2498, z = 28.4912, h = 85.1897}, 
    {model = "a_m_m_bevhills_02",  x = -830.2383, y = -1072.6389, z = 10.3281, h = 208.8596}, 
    {model = "a_m_m_bevhills_02",  x = 70.3860, y = -1399.0776, z = 28.3867, h = 268.1058}, 
    {model = "a_m_m_bevhills_02",  x = 1190.6575, y = 2714.8225, z = 37.2226, h = 179.4312}, 
    {model = "a_m_m_bevhills_02",  x = -1109.2828, y = 2710.0188, z = 18.1091, h = 224.8234}, 
}



CreateThread(function()
    for _, v in pairs(NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do 
            Wait(1)
        end
        local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)






  RegisterCommand('fps', function()
	fpsmenu()
  end)
function fpsmenu()


	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "🔝 >> Normalan fps",
			txt = "Ljepse texture i svjetlija igrica",
			params = {
				event = "normalfps",
			}
			
		},
		{
			id = 2,
			header = "🚀 >> Povecaj fps",
			txt = "Losije texutre i tamnija!",
			params = {
				event = "vecifps",
			}
			
		},
	})
end
AddEventHandler('normalfps', function()
	SetTimecycleModifier()
	ClearTimecycleModifier()
	ClearExtraTimecycleModifier()
end)

AddEventHandler('vecifps', function()
	SetTimecycleModifier('yell_tunnel_nodirect')
end)


--apartmani
exports.qtarget:AddBoxZone("apartmanulaz", vector3(-272.0, -958.35, 31.22), 2, 2, {
    name="apartmanulaz",
    heading=11.0,
    debugPoly=false,
    }, {
        options = {
            {
                event = "udiunutra",
                icon = "fas fa-sign-in-alt",
                label = "Udji u apartman",
            
            },

        },
        distance = 3.5
})


AddEventHandler('udiunutra', function()
	local id = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
	DoScreenFadeOut(405)
	Wait(1000)
	SetEntityCoords(PlayerPedId(), vector3(-272.16, -960.27, 77.24))	
	TriggerServerEvent('napraviBucketapartman', id)
	DoScreenFadeIn(300)
end)

AddEventHandler('identitispawn', function()
	local id = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
	SetEntityCoords(PlayerPedId(), vector3(-272.16, -960.27, 77.24))	
	TriggerServerEvent('napraviBucketapartman', id)
end)
--apartmani
exports.qtarget:AddBoxZone("izadjiapartman", vector3(-271.0, -967.35, 77.22), 2, 2, {
    name="izadjiapartman",
    heading=11.0,
    debugPoly=false,
    }, {
        options = {
            {
                event = "izadjiapartma",
                icon = "fas fa-sign-in-alt",
                label = "Izadji iz apartman",
            
            },

        },
        distance = 3.5
})


AddEventHandler('izadjiapartma', function()
	local id = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
	DoScreenFadeOut(405)
	Wait(1000)
	SetEntityCoords(PlayerPedId(), vector4(-268.16, -957.27, 31.24, 201.00))	
	TriggerServerEvent('obrisibucketapartman')
	DoScreenFadeIn(500)
end)

exports.qtarget:AddBoxZone("sefapartman", vector3(-272.0, -957.35, 77.22), 2, 2, {
    name="sefapartman",
    heading=11.0,
    debugPoly=false,
    }, {
        options = {
            {
                event = "oxsefapartman",
                icon = "fas fa-box",
                label = "Ostava",
            },

        },
        distance = 3.5
})


AddEventHandler('oxsefapartman', function()
TriggerEvent('ox_inventory:openInventory', 'stash', {id=LocalPlayer.state.identifikacija, owner = true})
end)


--mehanicarske akcije

AddEventHandler('mehanicarskeakcije', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "🧰 >> Popravi",
			txt = "Popravljanje vozila",
			params = {
				event = "popravimehanicar",
			}
			
		},
		{
			id = 2,
			header = "🧽 >> Ocisti",
			txt = "Ciscenje auta",
			params = {
				event = "ocistimehanicar",
			}
			
		},
		{
			id = 3,
			header = "🚲 >> Impoundaj",
			txt = "Brisanje vozila",
			params = {
				event = "impoundmehanicar",
			}
			
		},
		{
			id = 3,
			header = "🔑 >> Odkljucaj",
			txt = "Odkljucaj vozilo",
			params = {
				event = "unlockmehanicar",
			}
			
		},
	})
end)
RegisterCommand('otvorilicne', function()
TriggerEvent('otvorilicne')
end)
RegisterKeyMapping('otvorilicne', 'licne karte', 'KEYBOARD', 'F5')
AddEventHandler('otvorilicne', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "📄 >> Pogledaj licnu",
			txt = "Licna karta",
			params = {
				event = "poglelicnu",
			}
			
		},
		{
			id = 2,
			header = "📄 >> Pokazi licnu",
			txt = "Licna karta",
			params = {
				event = "pokazilicnu",
			}
			
		},
		{
			id = 3,
			header = "🚗 >> Pogledaj vozacku",
			txt = "Vozacka dozvola",
			params = {
				event = "poglevozacku",
			}
			
		},
		{
			id = 3,
			header = "🚗 >> Pokazi vozacku",
			txt = "Vozacka dozvola",
			params = {
				event = "pokazivozacku",
			}
			
		},
	})
end)
AddEventHandler('poglelicnu', function()
	TriggerEvent('jsfour:vidilicnu')
end)
AddEventHandler('popravimehanicar', function()
	TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_BUM_BIN', 0, true)
	Wait(5000)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)
	SetVehicleUndriveable(vehicle, false)
	SetVehicleEngineOn(vehicle, true, true)
	ClearPedTasksImmediately(playerPed)
	ESX.ShowNotification('Vozilo popravljeno')
end)
RegisterCommand('notiftest', function()
	ESX.ShowNotification('TEST AAHAHASHAH')
end)

AddEventHandler('ocistimehanicar', function()
	TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_MAID_CLEAN', 0, true)
	Wait(5000)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

	SetVehicleDirtLevel(vehicle, 0)
	ClearPedTasksImmediately(playerPed)
	ESX.ShowNotification('Vozilo ocisceno')
end)

AddEventHandler('impoundmehanicar', function()
	local igrac = PlayerPedId()
	TaskStartScenarioInPlace(igrac, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
	Wait(6500)
	ClearPedTasksImmediately(igrac)
	local coords = GetEntityCoords(igrac)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 2.0, 0, 71)
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification('Vozilo obrisano')
end)


AddEventHandler('unlockmehanicar', function()
	local igrac = PlayerPedId()
	local coords = GetEntityCoords(igrac)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 2.0, 0, 71)
	TaskStartScenarioInPlace(igrac, 'WORLD_HUMAN_WELDING', 0, true)
	Wait(20000)
	ClearPedTasksImmediately(igrac)

	SetVehicleDoorsLocked(vehicle, 1)
	SetVehicleDoorsLockedForAllPlayers(vehicle, false)
	ESX.ShowNotification('Vozilo obrisano')
end)


--blipovi 
local blips = {

	{title="Mehanicarska", colour = 1, id = 566, x = -212.99,  y = -1328.59, z = 30.95},
	
	{title="Apartman", colour = 4, id = 475, x = -268.99,  y = -958.59, z = 30.95},

	{title="Car Wash", colour = 0, id = 100, x = 14.99,  y = -1392.59, z = 30.95},
	{title="Car Wash", colour = 0, id = 100, x = 176.99,  y = -1737.59, z = 30.95},

	{title="Auto skola", colour = 54, id = 225, x = 218.99,  y = 365.59, z = 30.95},
   }
 
   Citizen.CreateThread(function()
	for _, info in pairs(blips) do
	  info.blip = AddBlipForCoord(info.x, info.y, info.z)
	  SetBlipSprite(info.blip, info.id)
	  SetBlipDisplay(info.blip, 4)
	  SetBlipScale(info.blip, 0.9)
	  SetBlipColour(info.blip, info.colour)
	  SetBlipAsShortRange(info.blip, true)
	BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(info.title)
	  EndTextCommandSetBlipName(info.blip)
	end
 end)



 ----minimapa
 Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
            SetRadarZoom(1100)


end)