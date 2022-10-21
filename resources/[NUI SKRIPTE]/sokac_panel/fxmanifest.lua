fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'STIFLER'

ui_page 'html/index.html'

shared_scripts {'@es_extended/imports.lua'}
server_script {
	'config.lua',
	'server.lua'
	}
client_script {
	'config.lua',
	'client.lua'
	}


files {
    'html/index.html',
    'html/listener.js',
    'html/style.css',
	'html/*.png',
	'html/logo.svg',
    'html/img/*',
    'html/fonts/*.ttf'
}
