fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

shared_script {
    'config.lua',
    '@es_extended/imports.lua',
    '@pe-lualib/init.lua'
}

client_scripts {
    'client/*.lua',
}
server_script {
    'server/*.lua'
}