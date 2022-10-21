fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Element'
description 'Job menus'
version '1.0.0'

ui_page 'html/ui.html'

files {
  'html/ui.html',
  'html/script.js',
  'html/main.css',
  'html/img/*.png',
  'html/sortable.js',
  'html/fonts/*'
}

shared_script {'@es_extended/imports.lua'}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
	'server.lua',
  'config.lua',
  'playerinfo.lua'
}

client_scripts {
    'client.lua',
    'util/*.lua',
    'config.lua'
}
