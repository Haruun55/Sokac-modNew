fx_version 'bodacious'
game 'gta5'

author 'Alzar'
description 'Mythic Framework Progress Bar'
version 'v1.0.1'

ui_page('html/index.html') 

client_scripts {
    'client/functions.lua',
    'client/events.lua',
}
shared_script {'@es_extended/imports.lua'}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',

    'html/css/bootstrap.min.css',
    'html/js/jquery.min.js',
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}
