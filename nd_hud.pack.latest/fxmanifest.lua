fx_version 'cerulean'
games { 'gta5' }

author 'Drazox#8271'
description 'nd-hud Update: ESX Support, Basic stress system included from qb-hud.'
version '0.2.4'
lua54 'yes'

client_script {
    'cl_main.lua',
    'speedometer.lua'
}

server_script 'sv_main.lua'

shared_script {
    'config.lua',
    '@ox_lib/init.lua',
}

ui_page 'ui/index.html'
files {
    'ui/*.html',
    'ui/*.css',
    'ui/script.js'
}



escrow_ignore {
    'config.lua',
    'stream/*',
    'cl_main.lua',
    'sv_main.lua',
}
