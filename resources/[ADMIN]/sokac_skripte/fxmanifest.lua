fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'

file "training.xml"
object_file("training.xml")

data_file 'HANDLING_FILE' 'handling.meta'


shared_script {'@es_extended/imports.lua'}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	"server/*"
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	'client/*',
}

	
files {
	"html/index.html",
	"html/glavno.js",
	"html/AllTattoos.json",
	"handling.meta",
	"html/Industry-Bold.ttf",
}


export "GetExternalFuel"
export "SetbFuelFuel"
export "GetGlobalCD"
server_export "GlobalCDReturn"
server_export "SviClanoviOrg"
server_export "BrojClanovaOrg"

export "Start"
