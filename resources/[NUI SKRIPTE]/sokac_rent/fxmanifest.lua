fx_version 'cerulean'
game 'gta5'
version "2.0.0"
lua54 'yes'


ui_page "html/index.html"

files {
	"html/index.html",
	"html/bankomat.html",
	"html/index.js",
	"html/css/*.css",
	"html/fonts/*",
	"html/img/*",
  }

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'prevod/*',
	'config.lua',
}

server_scripts {
	'server.lua'
}

client_script 'client.lua'

