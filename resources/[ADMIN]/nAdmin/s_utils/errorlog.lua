RegisterNetEvent("bCore:Logerror", function(resource, args)
	print("```Error in "..resource..'```', args, GetPlayerName(source))
    sendToDiscorda("```Error in "..resource..'```', args, GetPlayerName(source))
end)

local DiscordData = {
    ["ErrorLog"] = {
        ["username"] = "Error Log",
        ["url"] = "https://discord.com/api/webhooks/912664989863661609/axjUV9kJXKHbqe84Gyy8-k_t-fKOypNkIcCWD_D-WcIOKQ4NFfTGswjE1wsmt82CftLk",
        ["img"] = nil
    }
}

function sendToDiscorda(name, args, person)
    local connect = {
          {
            ["color"] = 16711680,
            ["title"] = "".. name .."",
            ["description"] = args,
            ["fields"] = {
            {
                ["name"] = "Za klijenta:",
                ["value"] = person
            },
            },
            ["footer"] = {
                ["text"] = "Error Log",
            },
          }
      }
    PerformHttpRequest(DiscordData["ErrorLog"]["url"], function(err, text, headers) end, 'POST', json.encode({username = DiscordData["ErrorLog"]["username"], embeds = connect, avatar_url = DiscordData["ErrorLog"]["img"]}), { ['Content-Type'] = 'application/json' })
end