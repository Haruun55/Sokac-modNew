fx_version 'cerulean'
game 'gta5'

author 'Element'
description 'Bolnica'
version '1.1.0'

ui_page 'html/index.html'

client_scripts {
    'client.lua',
    'iplList.lua',
    'npcdoktor.lua',
    'holster.lua',
    'deathevents.lua',
    'vehiclechecker.lua'

}



server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'srv.lua',
    'server.lua'
}

files {
    "html/mrtav.webm",
    "html/main.js",
    "html/stil.css",
    'html/index.html'
}

export "JelMrtvaOsoba"
export "MrtveOsobe"