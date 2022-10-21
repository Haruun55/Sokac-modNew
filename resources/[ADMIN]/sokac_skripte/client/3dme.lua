

RegisterCommand("odbagujme", function()
	SetNuiFocus(false,false)
end)


local pedDisplaying = {}
local displayTime = 8000

Citizen.CreateThread(function()
    local strin = ""

	while true do
		local lastSleep = true 
		BlockWeaponWheelThisFrame()
          DisableControlAction(0, 37, true)
          DisableControlAction(0, 199, true)
		local currentTime, html = GetGameTimer(), ""
		for k, v in pairs(pedDisplaying) do
			lastSleep = false
            
			local player = GetPlayerFromServerId(k)
			if NetworkIsPlayerActive(player) then
			    local sourcePed, targetPed = GetPlayerPed(player), PlayerPedId()
        	    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
        	    local pedCoords = GetPedBoneCoords(sourcePed, 0x2e28, 0.0, 0.0, 0.0)
    
                if player == source or #(sourceCoords - targetCoords) < 25 then
			        if v.type == "me" then
                    	local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 0.35)
                        if not onScreen then
                    	   html = html .. "<p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 100 .."%;;text-shadow: 1px 0px 5px #000000FF, -1px 0px 0px #000000FF, 0px -1px 0px #000000FF, 0px 1px 5px #000000FF;-webkit-transform: translate(-50%, 0%);max-width: 100%;position: fixed;text-align: center;color:rgb(240, 240, 240);background: rgba(18, 18, 18, 0.5);border-radius:3px;font-size: 20px;\"><b style=\"opacity: 1.0;\">⠀"..v.msg.."⠀</b></p>"
                        end
        	        elseif v.type == "do" then
                    	local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 1.1)
                        if not onScreen then
                    	   html = html .. "<p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 100 .."%;;text-shadow: 1px 0px 5px #000000FF, -1px 0px 0px #000000FF, 0px -1px 0px #000000FF, 0px 1px 5px #000000FF;-webkit-transform: translate(-50%, 0%);max-width: 100%;position: fixed;text-align: center;color: #FFFFFF;background: rgba(18, 18, 18, 0.5);border-radius:3px;font-size: 20px;\"><b style=\"opacity: 1.0;color: rgba(255, 165, 0)\">⠀"..v.msg.."⠀</b></p>"
                        end
        	        end
                end
        	end
        	if v.time <= currentTime then
        		pedDisplaying[k] = nil
        	end
        end
		if lastSleep then 
			Wait(1000)
		end
        if strin ~= html then
            SendNUIMessage({
                type = "txt", 
                html = html
            })
            strin = html
        end
        
		Wait(20)
    end
end)

RegisterNetEvent("bb-3dme:client:triggerDisplay")
AddEventHandler("bb-3dme:client:triggerDisplay", function(playerId, message, typ)
	pedDisplaying[tonumber(playerId)] = {type = typ, msg = message, time = GetGameTimer() + displayTime}
end)



