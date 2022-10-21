ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function MakePlayerData(source)
    --Wait(9000)
  --  while xPlayer == nil do Wait(100) end 
  --  if xPlayer ~= nil then 
      local xPlayer = ESX.GetPlayerFromId(source)
      local userData = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @id", {["id"] = xPlayer.identifier})
      local playerData = Player(source).state
    
      playerData.firstname = playerData.firstname
      playerData.lastname = playerData.lastname
      playerData.job = xPlayer.getJob()
      playerData.nickname = GetPlayerName(source)
      playerData.identifier = xPlayer.identifier
   -- else
  --    print("nije ucito")
  --  end
  
  end
  Citizen.CreateThread(function()
    Wait(9000)
    local players = ESX.GetPlayers()
    for i = 1, #players do
      MakePlayerData(players[i])

    end

  end)

  
  AddEventHandler("esx:playerLoaded", function(source, xPlayer)

      Wait(9000)
      local players = ESX.GetPlayers()
      for i = 1, #players do
        MakePlayerData(players[i])

      end
  end)
  
  AddEventHandler('esx:setJob', function(source, newJob, oldJob)
      local src = source
      Player(src).state.job = newJob
  end)
  