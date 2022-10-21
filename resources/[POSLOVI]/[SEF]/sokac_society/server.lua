ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local JobsWhichGetPayCheck = {"ambulance", "police","mechanic"}
local PayCheckInterval = 3600 -- this one is in seconds
local JobGrades = {}



Citizen.CreateThread(function()

	local jobs = 	MySQL.Sync.fetchAll("SELECT * FROM job_grades", {})
	for i = 1, #jobs do
		if not JobGrades[jobs[i].job_name] then
			JobGrades[jobs[i].job_name] = {}
		end

		JobGrades[jobs[i].job_name][tostring(jobs[i].grade)] = jobs[i].label
	end

end)

RegisterServerCallback("society:fetchPerms", function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local otherUsers = 	MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name = @imePosla AND grade = @grade", {
		["imePosla"] = xPlayer.getJob().name,
		["grade"] = xPlayer.getJob().grade
	})

	return otherUsers[1]
end)

RegisterServerCallback("society:fetchAllMembers", function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local mainJob = Player(src).state.job.name
	local igraci = GetPlayers()
	local noQuery = "SELECT * FROM users WHERE job = '" .. mainJob .. "' AND identifier <> '" .. xPlayer.identifier .. "'"
	local resp = {}

	for i = 1, #igraci do
		local tempSrc = tonumber(igraci[i])
		if not tempSrc == src then
			if Player(tempSrc).state.job then
				local playerData = Player(tempSrc).state

				if playerData.job.name == mainJob then
					noQuery = noQuery .. " AND identifier <> '" .. playerData.identifier.. "'"
					table.insert(resp, {
						firstname = playerData.name,
						lastname = playerData.lastname,
						identifier = playerData.identifier,
						grade_label = playerData.job.grade_label,
						grade_number = playerData.job.grade
					})
				end
			end
		end
	end

	local otherUsers = MySQL.Sync.fetchAll(noQuery, {})

	if otherUsers then
		for i = 1, #otherUsers do
			table.insert(resp, {
				firstname = otherUsers[i].firstname,
				lastname = otherUsers[i].lastname,
				identifier = otherUsers[i].identifier,
				grade_label = JobGrades[mainJob][tostring(otherUsers[i].job_grade)],
				grade_number = otherUsers[i].job_grade
			})
		end
	end

	return resp

end)

RegisterServerCallback("society:fetchRankPerms", function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local otherUsers = 	MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name = @imePosla", {
		["imePosla"] = xPlayer.getJob().name
	})

	return otherUsers
end)

RegisterNetEvent("society:UpdatePerms", function(rank, vrsta)

	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local sql = string.format(
		"UPDATE job_grades SET %s = !%s WHERE job_name = '%s' AND grade = %d", vrsta, vrsta, xPlayer.getJob().name, rank
	)

	MySQL.Sync.execute(sql, {})

end)


RegisterNetEvent("society:zaposliOsobu", function(ident)
	local xPlayer = ESX.GetPlayerFromIdentifier(ident)
	local srcPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and srcPlayer.getJob().grade_name == 'boss' then
		xPlayer.setJob(srcPlayer.getJob().name, 0)

		local sql = string.format(
			"UPDATE users SET job = '%s', job_grade = 0 WHERE identifier = '%s'", srcPlayer.getJob().name, ident
		)

		MySQL.Sync.execute(sql, {})

		TriggerClientEvent('chatMessage', xPlayer.source, "^3[Organizacija]^0: Zaposlen si u organizaciju " .. srcPlayer.getJob().label .. "!")
		TriggerClientEvent('chatMessage', srcPlayer.source, "^3[Organizacija]^0: Zaposlio si " .. Player(xPlayer.source).state.name .. "!")
	end

end)

RegisterNetEvent("society:unaprijedi", function(ident, grade)

	local maxGrade = -1
	local nowGrade = tonumber(grade)

	local aPlayer = ESX.GetPlayerFromIdentifier(ident)
	local xPlayer = ESX.GetPlayerFromId(source)

	for k,v in pairs(JobGrades[xPlayer.getJob().name]) do
		maxGrade = maxGrade + 1
	end

	if aPlayer then
		if nowGrade + 1 <= maxGrade then
			aPlayer.setJob(aPlayer.getJob().name, nowGrade + 1)

			local sql = string.format(
				"UPDATE users SET job_grade = job_grade + 1 WHERE identifier = '%s'", ident
			)

				MySQL.Sync.execute(sql, {})
		end
	else
		if nowGrade + 1 <= maxGrade then
			local sql = string.format(
				"UPDATE users SET job_grade = job_grade + 1 WHERE identifier = '%s'", ident
			)

				MySQL.Sync.execute(sql, {})
		end
	end

end)

RegisterNetEvent("society:spusti", function(ident, nowGrade)

	local srcPlayer = ESX.GetPlayerFromIdentifier(ident)
	local xPlayer = ESX.GetPlayerFromId(source)

	if srcPlayer then
		if (srcPlayer.getJob().grade - 1) >= 0 then
			srcPlayer.setJob(srcPlayer.getJob().name, srcPlayer.getJob().grade - 1)

			local sql = string.format(
				"UPDATE users SET job_grade = job_grade - 1 WHERE identifier = '%s'", ident
			)

			MySQL.Sync.execute(sql, {})
		end
	else
		if nowGrade - 1 >= 0 then
			local sql = string.format(
				"UPDATE users SET job_grade = job_grade - 1 WHERE identifier = '%s'", ident
			)

			MySQL.Sync.execute(sql, {})
		end
	end

end)

RegisterNetEvent("society:otpustiClana", function(ident)
	local srcPlayer = ESX.GetPlayerFromIdentifier(ident)
	if srcPlayer then
		srcPlayer.setJob("unemployed", 0)

		local sql = string.format(
			"UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = '%s'", ident
		)

			MySQL.Sync.execute(sql, {})
	else
		local sql = string.format(
			"UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = '%s'", ident
		)

			MySQL.Sync.execute(sql, {})
	end
end)

RegisterServerCallback("society:GetOrgMoney", function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local money = 	MySQL.Sync.fetchAll("SELECT * FROM jobs WHERE name = @imeposla", {
		["imeposla"] = xPlayer.getJob().name
	})

	return money[1]
end)


RegisterNetEvent("society:PodigniNovac", function(vrsta, kolicina)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local money = MySQL.Sync.fetchAll("SELECT * FROM jobs WHERE name = @imeposla", {
		["imeposla"] = xPlayer.getJob().name
	})

	if money[1][vrsta] >= kolicina then
		MySQL.Sync.execute("UPDATE jobs SET ".. vrsta .." = ".. vrsta .." - @kolicina WHERE name = @imeposla", {
			["imeposla"] = xPlayer.getJob().name,
			["kolicina"] = kolicina
		})

		if vrsta == "money" then
			xPlayer.addMoney(kolicina)
		else
			xPlayer.addAccountMoney("black_money", kolicina)
		end

	end

end)

RegisterNetEvent("society:UplatiNovac", function(vrsta, kolicina)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local requestedMoney = 0

	if vrsta == "money" then
		requestedMoney = xPlayer.getMoney()

	elseif vrsta == "black" then
		requestedMoney = xPlayer.getAccount("black_money").money
	end

	if requestedMoney >= kolicina then

		MySQL.Sync.execute("UPDATE jobs SET ".. vrsta .." = ".. vrsta .." + @kolicina WHERE name = @imeposla", {
			["imeposla"] = xPlayer.getJob().name,
			["kolicina"] = kolicina
		})

		if vrsta == "money" then
			xPlayer.removeMoney(kolicina)
		else
			xPlayer.removeAccountMoney("black_money", kolicina)
		end
	end

end)

exports("OrgMoney", function(org)
	local money = 	MySQL.Sync.fetchAll("SELECT * FROM jobs WHERE name = @imeposla", {
		["imeposla"] = org
	})

	return money[1]
end)

exports("UseMoney", function(org, vrsta, money)
		MySQL.Sync.execute("UPDATE jobs SET ".. vrsta .." = ".. vrsta .." - @kolicina WHERE name = @imeposla", {
		["imeposla"] = org,
		["kolicina"] = money
	})
end)

exports("AddMoney", function(org, vrsta, money)
	MySQL.Sync.execute("UPDATE jobs SET ".. vrsta .." = ".. vrsta .." + @kolicina WHERE name = @imeposla", {
		["imeposla"] = org,
		["kolicina"] = money
	})
end)

RegisterServerCallback("borgmeni:FetchPlate", function(source)
  local src = source

  local grade = MySQL.Sync.fetchAll('SELECT * FROM job_grades WHERE job_name = @posao', {
    ["posao"] = Player(src).state.job.name
  })

  return grade
end)

RegisterServerEvent("borgmeni:SetPlata", function(data)
	local src = source
	local grade = tonumber(data.grade)
	local novaplata = tonumber(data.novaplata)

	MySQL.Sync.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job AND grade = @grade', {
		["salary"] = novaplata,
		["job"] = Player(src).state.job.name,
		["grade"] = grade
	})

end)


local koPlate = JobsWhichGetPayCheck
local NowPlateTime = os.time() + PayCheckInterval

Citizen.CreateThread(function()
  while true do
    Wait(1000)

    if NowPlateTime <= os.time() then

      NowPlateTime = os.time() + PayCheckInterval
      local allPlayers = GetPlayers()

			for ad = 1, #koPlate do

	      local grade = MySQL.Sync.fetchAll('SELECT * FROM job_grades WHERE job_name = "'.. koPlate[ad] ..'"', {})
	      local grade2 = {}

	      for i = 1, #grade do
	        grade2[tostring(grade[i].grade)] = grade[i].salary
	      end

	      for i = 1, #allPlayers do
	        local src = tonumber(allPlayers[i])
	        local xPlayer = ESX.GetPlayerFromId(src)

	        if xPlayer and xPlayer.getJob().name == koPlate[ad] then
	          local job = xPlayer.getJob()
	          local pare = exports["element_society"]:OrgMoney(koPlate[ad]).money

	          if pare <= grade2[tostring(job.grade)] then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { length = 10000, type = 'inform', text = 'Uprava nema dovoljno novca u trezoru za tvoju platu!'})
	          else
	            xPlayer.addAccountMoney("bank", grade2[tostring(job.grade)])
	            exports["element_society"]:UseMoney(koPlate[ad], "money", grade2[tostring(job.grade)])

	            TriggerClientEvent('mythic_notify:client:SendAlert', src, { length = 10000, type = 'inform', text = 'Dobio si platu od $' .. grade2[tostring(job.grade)]})
	          end
	          Wait(200)
	        end

	      end

		end

    end
  end
end)

