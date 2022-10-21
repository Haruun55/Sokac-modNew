RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 or source == "Console" then return end

	args = table.concat(args, ' ')
	TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, source, args, "me")
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then return end

	args = table.concat(args, ' ')
	TriggerClientEvent('bb-3dme:client:triggerDisplay', -1, source, args, "do")
end, false)

GlobalState["BrojIgraca"] = 0
  
Citizen.CreateThread(function()
	while true do
		local igraci = GetPlayers()
		GlobalState["BrojIgraca"] = #igraci
		Citizen.Wait(5000)
	end
end)