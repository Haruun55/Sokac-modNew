ESX = nil
local Objekti = {}
local Radis = false
local ObjBr = 1
local UzmiCiglu = false
local OstaviCiglu = false
local ZadnjaCigla = nil
local PrvaCigla = nil
local OstaviKoord = nil
local prop = nil
local RandomPosao = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	ProvjeriPosao()
end)
--------------------------------------------------------------------------------
-- Ne diraj
--------------------------------------------------------------------------------
local isInService = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil

local plaquevehicule = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
--------------------------------------------------------------------------------
function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
end
-- Menu

function PokreniPosao()
	ObjBr = 1
	Radis = true
	TriggerEvent("dpemotes:Radim", true)
	Objekti = {}
	UzmiCiglu = true
	RandomPosao = math.random(1,2)
	if RandomPosao == 1 then
		OstaviKoord = vector3(1373.4049072266, -781.62121582031, 66.773597717285)
	elseif RandomPosao == 2 then
		OstaviKoord = vector3(1367.0717773438, -780.54565429688, 66.745780944824)
	end

end

function dajUniformu(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if ConfigL.Uniforms["uniforma"].male then
				TriggerEvent('skinchanger:loadClothes', skin, ConfigL.Uniforms["uniforma"].male)
				else
					exports['okokNotify']:Alert("SICILIA", "'Nema postavljene uniforme!", 2500, 'info')
				end
			
		else
			if ConfigL.Uniforms["uniforma"].female then
				TriggerEvent('skinchanger:loadClothes', skin, ConfigL.Uniforms["uniforma"].female)
				else
					exports['okokNotify']:Alert("SICILIA", "'Nije moguće pronaći outfit!", 2500, 'info')
				end


		end
	end)
end
local blip = AddBlipForCoord(vector3(1380.8416748047, -773.89587402344, 65.999649047852))
	
SetBlipSprite(blip, 183)
SetBlipScale (blip, 0.5)
SetBlipColour(blip, 81)
SetBlipAsShortRange(blip, true)
	 
BeginTextCommandSetBlipName('STRING')
AddTextComponentSubstringPlayerName('Gradiliste')
EndTextCommandSetBlipName(blip)

local blip = AddBlipForCoord(vector3(1382.96, -741.55, 67.22))
	
SetBlipSprite(blip, 183)
SetBlipScale (blip, 0.9)
SetBlipColour(blip, 81)
SetBlipAsShortRange(blip, true)
	 
BeginTextCommandSetBlipName('STRING')
AddTextComponentSubstringPlayerName('Gradiliste')
EndTextCommandSetBlipName(blip)

exports.qtarget:AddBoxZone("gradjevinarcigla", vector3(1381.05, -774.04, 67.31), 1.8, 1.99, {
    name="gradjevinarcigla",
	heading=125.0,
	debugPoly=false,

    }, {
        options = {
            {
                event = "uzmiciglugradjevinar",
                icon = "fas fa-sign-in-alt",
                label = "Uzmi ciglu",
            },
  
        },
        distance = 3.5
})
poceo = false
AddEventHandler('uzmiciglugradjevinar', function()
	if  poceo then
	UzmiCiglu = false
	OstaviCiglu = true
	uzeo = true
	ESX.Streaming.RequestAnimDict('creatures@rottweiler@tricks@', function()
		FreezeEntityPosition(PlayerPedId(), true)
		TaskPlayAnim(PlayerPedId(), 'creatures@rottweiler@tricks@', 'petting_franklin', 8.0, -8, -1, 36, 0, 0, 0, 0)
		Citizen.Wait(2000)
		ClearPedSecondaryTask(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(), false)
		RemoveAnimDict("creatures@rottweiler@tricks@")
	end)
	ESX.Streaming.RequestAnimDict('amb@world_human_bum_freeway@male@base', function()
		TaskPlayAnim(PlayerPedId(), 'amb@world_human_bum_freeway@male@base', 'base', 8.0, -8, -1, 49, 0, 0, 0, 0)
	end)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	prop = CreateObject(GetHashKey("prop_wallbrick_01"), x, y, z+2, false, false, false)
	local boneIndex = GetPedBoneIndex(playerPed, 57005)
	AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.068, -0.241, 0.0, 90.0, 20.0, true, true, false, true, 1, true)
	ESX.ShowNotification("Idite do zadnjeg zida da ostavite blok!")
	else
		return
	end
end)

AddEventHandler('SICILIA_gradjevinar:hasEnteredMarker', function(zone)
	

	
	if zone == 'Ostaviciglu' then
		OstaviCiglu = false
		if ObjBr == 1 then
			ESX.Streaming.RequestAnimDict('random@domestic', function()
				FreezeEntityPosition(PlayerPedId(), true)
				TaskPlayAnim(PlayerPedId(), 'random@domestic', 'pickup_low', 8.0, -8, -1, 36, 0, 0, 0, 0)
				Wait(500)
				DeleteObject(prop)
				prop = nil
				Citizen.Wait(1700)
				ClearPedSecondaryTask(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), false)
				RemoveAnimDict("random@domestic")
			end)
			if RandomPosao == 1 then
				ESX.Game.SpawnLocalObject('prop_wallbrick_01', {
							x = 1373.352,
							y =  -781.0687,
							z = 66.01108
				}, function(obj)
					--PlaceObjectOnGroundProperly(obj)
					SetEntityRotation(obj, -0.08805062, -0.0002665851, -9.770086, 2, true)
					FreezeEntityPosition(obj, true)
					table.insert(Objekti, obj)
					ZadnjaCigla = obj
					PrvaCigla = obj
					local prvioffset = GetOffsetFromEntityInWorldCoords(obj, -0.42, -0.4, 0.0) --lijevo
					OstaviKoord = prvioffset
				end)
			elseif RandomPosao == 2 then
				ESX.Game.SpawnLocalObject('prop_wallbrick_01', {
							x = 1367.143,
							y =  -779.98,
							z = 66.02597
				}, function(obj)
					--PlaceObjectOnGroundProperly(obj)
					SetEntityRotation(obj, -0.08805062, -0.0002665851, -9.770086, 2, true)
					FreezeEntityPosition(obj, true)
					table.insert(Objekti, obj)
					ZadnjaCigla = obj
					PrvaCigla = obj
					local prvioffset = GetOffsetFromEntityInWorldCoords(obj, -0.42, -0.4, 0.0) --lijevo
					OstaviKoord = prvioffset
				end)
			end
			ObjBr = ObjBr+1
			UzmiCiglu = true
			TriggerServerEvent('SICILIA_gradjevinar:gmoney')
			exports['okokNotify']:Alert("SICILIA", "Uspješno ste položili ciglu i dobili 30 dolara!", 2500, 'info')
		else
			if ObjBr > 1 and ObjBr ~= 16 and ObjBr ~= 31 and ObjBr ~= 46 and ObjBr ~= 61 then
				local prvioffset = GetOffsetFromEntityInWorldCoords(ZadnjaCigla, -0.42, 0.0, -0.073) --lijevo
				ESX.Streaming.RequestAnimDict('random@domestic', function()
					FreezeEntityPosition(PlayerPedId(), true)
					TaskPlayAnim(PlayerPedId(), 'random@domestic', 'pickup_low', 8.0, -8, -1, 36, 0, 0, 0, 0)
					Wait(500)
					DeleteObject(prop)
					prop = nil
					Citizen.Wait(1700)
					ClearPedSecondaryTask(PlayerPedId())
					FreezeEntityPosition(PlayerPedId(), false)
					RemoveAnimDict("random@domestic")
				end)
				ESX.Game.SpawnLocalObject('prop_wallbrick_01', {
							x = prvioffset.x,
							y =  prvioffset.y,
							z = prvioffset.z
				}, function(obj)
					--PlaceObjectOnGroundProperly(obj)
					SetEntityRotation(obj, -0.08805062, -0.0002665851, -9.770086, 2, true)
					FreezeEntityPosition(obj, true)
					table.insert(Objekti, obj)
					ZadnjaCigla = obj
					if ObjBr == 16 or ObjBr == 31 or ObjBr == 46 or ObjBr == 61 then
						if RandomPosao == 1 then
							OstaviKoord = vector3(1373.4049072266, -781.62121582031, 66.773597717285)
						elseif RandomPosao == 2 then
							OstaviKoord = vector3(1367.0717773438, -780.54565429688, 66.745780944824)
						end
					else
						local prvioffset2 = GetOffsetFromEntityInWorldCoords(obj, -0.42, -0.4, 0.0) --lijevo
						OstaviKoord = prvioffset2
					end
				end)
				ObjBr = ObjBr+1
				if ObjBr == 76 then
					exports['okokNotify']:Alert("SICILIA", "Zavrsili ste sa poslom!", 2500, 'info')
					TriggerServerEvent("SICILIA_gradjevinar:greward")
					exports['okokNotify']:Alert("SICILIA", "Da ponovo počnete raditi, otiđite i uzmite opremu!", 2500, 'info')
				else
					UzmiCiglu = true
				end
				TriggerServerEvent("SICILIA_gradjevinar:gmoney")
				exports['okokNotify']:Alert("SICILIA", "Uspješno ste položili ciglu i dobili 30 dolara!", 2500, 'info')
			elseif ObjBr == 16 or ObjBr == 31 or ObjBr == 46 or ObjBr == 61 then
				local prvioffset = GetOffsetFromEntityInWorldCoords(PrvaCigla, 0.0, 0.0, 0.07) --gore
				ESX.Streaming.RequestAnimDict('random@domestic', function()
					FreezeEntityPosition(PlayerPedId(), true)
					TaskPlayAnim(PlayerPedId(), 'random@domestic', 'pickup_low', 8.0, -8, -1, 36, 0, 0, 0, 0)
					Wait(500)
					DeleteObject(prop)
					prop = nil
					Citizen.Wait(1700)
					ClearPedSecondaryTask(PlayerPedId())
					FreezeEntityPosition(PlayerPedId(), false)
					RemoveAnimDict("random@domestic")
				end)
				ESX.Game.SpawnLocalObject('prop_wallbrick_01', {
					x = prvioffset.x,
					y =  prvioffset.y,
					z = prvioffset.z
				}, function(obj)
					--PlaceObjectOnGroundProperly(obj)
					SetEntityRotation(obj, -0.08805062, -0.0002665851, -9.770086, 2, true)
					FreezeEntityPosition(obj, true)
					table.insert(Objekti, obj)
					ZadnjaCigla = obj
					PrvaCigla = obj
					local prvioffset2 = GetOffsetFromEntityInWorldCoords(obj, -0.42, -0.4, 0.0) --lijevo
					OstaviKoord = prvioffset2
				end)
				ObjBr = ObjBr+1
				UzmiCiglu = true
				TriggerServerEvent("SICILIA_gradjevinar:gmoney")
				exports['okokNotify']:Alert("SICILIA", "Uspješno ste položili ciglu i dobili 30 dolara!", 2500, 'info')
			end
		end
	end
end)

function ZavrsiPosao()
	if Radis == true then
		for i=1, #Objekti, 1 do
			if Objekti[i] ~= nil then
				ESX.Game.DeleteObject(Objekti[i])
			end
		end
		Radis = false
		TriggerEvent("dpemotes:Radim", false)
		OstaviCiglu = false
		UzmiCiglu = false
		ZadnjaCigla = nil
		OstaviKoord = nil
	end
end

AddEventHandler('SICILIA_gradjevinar:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Crtanje markera
Citizen.CreateThread(function()
	local waitara = 500
	while true do
		Citizen.Wait(waitara)
		local naso = 0
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(ConfigL.Cloakroom) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end
			
			if Radis and UzmiCiglu and (GetDistanceBetweenCoords(coords, 1380.8416748047, -773.89587402344, 66.999649047852, true) < 1.5) then
				isInMarker  = true
				currentZone = "Uzmiciglu"
			end
			
			if Radis and OstaviCiglu and (GetDistanceBetweenCoords(coords, OstaviKoord, false) < 0.5) then
				isInMarker  = true
				currentZone = "Ostaviciglu"
			end
			
			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('SICILIA_gradjevinar:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('SICILIA_gradjevinar:hasExitedMarker', lastZone)
			end

		
		
			
			if Radis and OstaviCiglu and GetDistanceBetweenCoords(coords, OstaviKoord, true) < ConfigL.DrawDistance then
				waitara = 0
				naso = 1
				DrawMarker(0, OstaviKoord, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
			end

		end
		if naso == 0 then
			waitara = 500
		end
end)

-------------------------------------------------
-- Funkcije
-------------------------------------------------
-- Funkcije i playerLoad
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('SICILIA_gradjevinar:zavrsi')
AddEventHandler('SICILIA_gradjevinar:zavrsi', function(source)
	ZavrsiPosao()
	poceo = false
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

RegisterNetEvent('SICILIA_gradjevinar:startaj')
AddEventHandler('SICILIA_gradjevinar:startaj', function(source)
	dajUniformu(PlayerPedId())
	PokreniPosao()
	poceo = true
end)
local peds = {
    `s_m_y_construct_01`,
}
        exports["qtarget"]:AddTargetModel(peds, {
            options = {
                {
                    event = "otvorigradjevinara",
                    icon = "fas fa-hammer",
                    label = "Gradjevinar!",
					num = 1
                },
			
             },
             job = {"all"},
            distance = 2.0
        })

		AddEventHandler('otvorigradjevinara', function()
			TriggerEvent('nh-context:sendMenu', {
				{
					id = 1,
					header = "🔝 >> Zapocni posao!",
					txt = "Zapocni sa radom gradjevinara",
					params = {
						event = "SICILIA_gradjevinar:startaj",
					}
					
				},
				{
					id = 2,
					header = "🚀 >> Zavrsi posao!",
					txt = "Zavrsi posao i skini uniformu!",
					params = {
						event = "SICILIA_gradjevinar:zavrsi",
					}
					
				},
			})
		end)
