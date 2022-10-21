ESX.RegisterServerCallback("bSpeedometer:JelVlasnik", function(source, cb, tablice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local VlasnickaVozila = exports.oxmysql:executeSync('SELECT * FROM owned_vehicles where (owner = @id OR owner = @posao) and plate = @tablice', {
        ["id"] = xPlayer.identifier,
        ["tablice"] = tablice,
        ["posao"] = xPlayer.getJob().name
    })

    if #VlasnickaVozila > 0 then
        cb(true)
    else
        cb(false)
    end

end)