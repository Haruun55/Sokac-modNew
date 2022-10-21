resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'client/smece_cl.lua',
    'client/gradjevinar_cl.lua',
    'client/grudve_cl.lua',
    'client/cistac_cl.lua',
    'client/smetlar_cl.lua',
    'client/pecanje_cl.lua',
    'client/ronilac_cl.lua',
    'client/rudar_cl.lua',
    'client/kamiondzija_cl.lua',
    'client/taxi_cl.lua',
    'client/frizerski_cl.lua',
}



server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'server/smece_sv.lua',
    'server/gradjevinar_sv.lua',
    'server/cistac_sv.lua',
    'server/smetlar_sv.lua',
    'server/pecanje_sv.lua',
    'server/ronilac_sv.lua',
    'server/rudar_sv.lua',
    'server/kamiondzija_sv.lua',
    'server/taxi_sv.lua',
    'server/frizerski_sv.lua'
    

  
}