resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.1.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/bg.jpg'
}
