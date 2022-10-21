ESX = {}
ESX.Jobs = {}
ESX.Players = {}
Core = {}
Core.UsableItemsCallbacks = {}
Core.ServerCallbacks = {}
Core.TimeoutCount = -1
Core.CancelledTimeouts = {}
Core.RegisteredCommands = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

exports('getSharedObject', function()
	return ESX
end)

Core.LoadJobs = function()
	local Jobs = {}
	exports.oxmysql:execute('SELECT * FROM jobs', {}, function(jobs)
		for _, v in pairs(jobs) do
			Jobs[v.name] = v
			Jobs[v.name].grades = {}
		end

		exports.oxmysql:execute('SELECT * FROM job_grades', {}, function(grades)
			for _, v in pairs(grades) do
				if Jobs[v.job_name] then
					Jobs[v.job_name].grades[v.grade] = v
				else
					print(('[^3WARNING^7] Ignoring job grades for ^5"%s"^0 due to missing job'):format(v.job_name))
				end
			end

			for _, v in pairs(Jobs) do
				if ESX.Table.SizeOf(v.grades) == 0 then
					Jobs[v.name] = nil
					print(('[^3WARNING^7] Ignoring job ^5"%s"^0due to no job grades found'):format(v.name))
				end
			end
			ESX.Jobs = table.clone(Jobs)
		end)
	end)
end

RegisterServerEvent('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('esx:triggerServerCallback', function(name, requestId, ...)
	local source = source

	Core.TriggerServerCallback(name, requestId, source, function(...)
		TriggerClientEvent('esx:serverCallback', source, requestId, ...)
	end, ...)
end)

SetInterval(function()
	for _, xPlayer in pairs(ESX.Players) do
		local job     = xPlayer.job.grade_name
		local salary  = xPlayer.job.grade_salary
		if salary > 0 then
			if job == 'unemployed' then -- unemployed
				xPlayer.addAccountMoney('bank', salary)
				TriggerClientEvent('phone:notify', xPlayer.source, 'messages','Banka', 'Dobio si pomoć od države $'..salary, {sound = 'notify.mp3'})
			end
		end
	end
end, Config.PaycheckInterval)

Core.LoadJobs()
print('[^INFORMACIJA^7] Sokac UCITANA')