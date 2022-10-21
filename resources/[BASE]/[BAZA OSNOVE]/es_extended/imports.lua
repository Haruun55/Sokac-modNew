ESX = exports['es_extended']:getSharedObject()
------------------------------------------------------------------------

RNE = function(e, ...) RegisterNetEvent(e) AddEventHandler(e, ...) end
CT = function(h) Citizen.CreateThread(h) end
CW = function(a) Citizen.Wait(a) end
TE = function(e, ...) TriggerEvent(e, ...) end
TSE = function(e, ...) TriggerServerEvent(e, ...) end
TCE = function(e, ...) TriggerClientEvent(e, ...) end
EH = function(e, ...) AddEventHandler(e, ...) end
RSCB = function(e, ...) ESX.RegisterServerCallback(e, ...) end
TSCB = function(e, ...) ESX.TriggerServerCallBACK(e, ...) end
-----------------



------------------------------------------------------------------------

-- SHARED

------------------------------------------------------------------------


function RandomSansa(tabela)

  local poolsize = 0
  for ime, sansa in pairs(tabela) do
     poolsize = poolsize + sansa
  end

  local selection = math.random(1, poolsize)

  for ime, sansa in pairs(tabela) do
     selection = selection - sansa
     if (selection <= 0) then
       return ime
     end
  end

end


function RequestModelLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(4)
		end
	end

  return
end

local function bitwise(x, y, matrix)
    local z, pow = 0, 1

    while x > 0 or y > 0 do
        z = z + (matrix[x %2 + 1][y %2 + 1] * pow)
        pow = pow * 2
        x = math.floor(x / 2)
        y = math.floor(y / 2)
    end

    return z
end


local function tohex(x)

    local s, base, d = '', 16

    while x > 0 do
        d = x % base + 1
        x = math.floor(x / base)
        s = string.sub('0123456789abcdef', d, d) .. s
    end

    while #s < 2 do s = ('0%s'):format(s) end

    return s
end


function RandomID()
    math.randomseed(GetGameTimer() + math.random(30720, 92160))

    ---@type number[]
    local bytes = {
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255),
    }

    bytes[7] = bitwise(bytes[7], 0x0f, {{0,0},{0,1}})
    bytes[7] = bitwise(bytes[7], 0x40, {{0,1},{1,1}})

    return ('%s%s%s%s%s%s%s'):format(
        tohex(bytes[1]), tohex(bytes[2]), tohex(bytes[3]), tohex(bytes[4]),
        tohex(bytes[5]), tohex(bytes[6]),
        tohex(bytes[7])
    )
end


if not IsDuplicityVersion() then -- Only register this event for the client
	plstate = LocalPlayer.state
  
	function edraw(coords, text, scale2)
		local camCoords = GetGameplayCamCoord()
		local dist = #(coords - camCoords)
  
		-- Experimental math to scale the text down
		local scale = 200 / (GetGameplayCamFov() * dist)
  
		-- Format the text
		SetTextScale(0.0, scale2 * scale)
		SetTextFont(6)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextOutline()
		SetTextDropShadow()
		SetTextCentre(true)
  
		-- Diplay the text
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringPlayerName(text)
		SetDrawOrigin(coords, 0)
		EndTextCommandDisplayText(0.0, 0.0)
		ClearDrawOrigin()
	end
  
	function RequestModelLoad(modelHash)
		modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))
  
		if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
			RequestModel(modelHash)
  
			while not HasModelLoaded(modelHash) do
				Citizen.Wait(4)
			end
		end
  
	  return
	end
  
	function RequestAnimLoad(animHash)
	  if not HasAnimDictLoaded(animHash) then
		  RequestAnimDict(animHash)
  
		  while not HasAnimDictLoaded(animHash) do
			  Citizen.Wait(4)
		  end
	  end
  
	  return
	end
  
  end




-- SHARED
------------------------------------------------------------------------
local Intervals = {}
SetInterval = function(id, msec, callback, onclear)
	if not Intervals[id] and msec then
		Intervals[id] = msec
		CreateThread(function()
			repeat
				local interval = Intervals[id]
				Wait(interval)
				callback(interval)
			until interval == -1 and (onclear and onclear() or true)
			Intervals[id] = nil
		end)
	elseif msec then Intervals[id] = msec end
end

ClearInterval = function(id)
	if Intervals[id] then Intervals[id] = -1 end
end

------------------------------------------------------------------------
if IsDuplicityVersion() then
------------------------------------------------------------------------

------------------------------------------------------------------------
else -- CLIENT
------------------------------------------------------------------------
	ESX.UI.RegisteredTypes, ESX.PlayerData.inventory = nil, {}

	AddEventHandler('esx:setPlayerData', function(key, val, last)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if OnPlayerData ~= nil then OnPlayerData(key, val, last) end
		end
	end)

------------------------------------------------------------------------
end
------------------------------------------------------------------------


---Pcc


-- SERVER-SIDE
if IsDuplicityVersion() then
	_G.RegisterServerCallback = function(eventName, fn)
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
		assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got '..type(fn))

		AddEventHandler(('s__pmc_callback:%s'):format(eventName), function(cb, s, ...)
			local result = {fn(s, ...)}
			cb(table.unpack(result))
		end)
	end

	_G.TriggerClientCallback = function(src, eventName, ...)
		assert(type(src) == 'number', 'Invalid Lua type at argument #1, expected number, got '..type(src))
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #2, expected string, got '..type(eventName))

		local p = promise.new()
	
		RegisterNetEvent('__pmc_callback:server:'..eventName)
		local e = AddEventHandler('__pmc_callback:server:'..eventName, function(...)
			local s = source
			if src == s then
				p:resolve({...})
			end
		end)
	
		TriggerClientEvent('__pmc_callback:client', src, eventName, ...)
	
		local result = Citizen.Await(p)
		RemoveEventHandler(e)
		return table.unpack(result)
	end
end

-- CLIENT-SIDE
if not IsDuplicityVersion() then
	_G.TriggerServerCallback = function(eventName, ...)
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))

		local p = promise.new()
		local ticket = GetGameTimer()
	
		RegisterNetEvent(('__pmc_callback:client:%s:%s'):format(eventName, ticket))
		local e = AddEventHandler(('__pmc_callback:client:%s:%s'):format(eventName, ticket), function(...)
			p:resolve({...})
		end)
	
		TriggerServerEvent('__pmc_callback:server', eventName, ticket, ...)
	
		local result = Citizen.Await(p)
		RemoveEventHandler(e)
		return table.unpack(result)
	end
	
	_G.RegisterClientCallback = function(eventName, fn)
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
		assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got '..type(fn))

		AddEventHandler(('c__pmc_callback:%s'):format(eventName), function(cb, ...)
			cb(fn(...))
		end)
	end
end


------