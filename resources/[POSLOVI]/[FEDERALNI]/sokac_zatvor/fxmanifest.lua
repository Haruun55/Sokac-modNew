fx_version 'cerulean'
game 'gta5'

author 'STIFLER'
description 'Zatvor'
version '1.1.0'

ui_page 'html/index.html'

shared_scripts {'@es_extended/imports.lua'}
client_scripts {
    'client.lua',
}


server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'srv.lua',
}

files {
    "html/main.js",
    "html/stil.css",
    'html/index.html'
}
