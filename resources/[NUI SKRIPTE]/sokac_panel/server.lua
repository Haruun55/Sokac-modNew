ESX = nil
local connectedPlayers = {}
local cooldown = false

local allowedGrades = {
	'boss',
	'underboss'
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('_plane_glavni:cb', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name
	TriggerClientEvent('_panel:KonektovaniIgraci', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	DodajNaPanel(xPlayer, true)
	ID = GetPlayerIdentifier(source)
	local xPlayer = ESX.GetPlayerFromId(source)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil
	TriggerClientEvent('_panel:KonektovaniIgraci', -1, connectedPlayers)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			IgraciNaPanelu()
		end)
	end
end)

function DodajNaPanel(xPlayer, update)
	local playerId = xPlayer.source
	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].job = xPlayer.job.name
	if update then
		TriggerClientEvent('_panel:KonektovaniIgraci', -1, connectedPlayers)
	end

end
function IgraciNaPanelu()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		DodajNaPanel(xPlayer, false)
	end

	TriggerClientEvent('_panel:KonektovaniIgraci', -1, connectedPlayers)
end

function getAccounts(data, xPlayer)
	local result = {}
	for i=1, #data do
		if(data[i] ~= 'money') then
			if(data[i] == 'black_money') and not Config.showBlackMoney then
				result[i] = nil
			else
				result[i] = xPlayer.getAccount(data[i])['money']
			end
		else
			result[i] = xPlayer.getMoney()
		end
	end
	return result
end


function tableIncludes(table, data)
	for _,v in pairs(table) do
		if v == data then
			return true
		end
	end
	return false
end


RegisterServerEvent('elePanel:povuciPodatke')
AddEventHandler('elePanel:povuciPodatke', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local money,bank,black_money = table.unpack(getAccounts({'money', 'bank', 'black_money'}, xPlayer))

		local society = nil
		if tableIncludes(allowedGrades, xPlayer.job.grade_name) then
			TriggerEvent('esx_society:getSociety', xPlayer.job.name, function(data)
				if data ~= nil then
					TriggerEvent('esx_addonaccount:getSharedAccount', data.account, function(account)
							society = account['money']
					end)
				end
			end)
		end
	  TriggerClientEvent('elePanel:povuciPodatke', source, {cash = money, bank = bank, black_money = black_money, society = society})
	end
end)


