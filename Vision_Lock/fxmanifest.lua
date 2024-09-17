fx_version "cerulean"
games { "gta5" }

author "Kugelspitzer"
name 'Vision_CarLock'
discription 'a Simple Car Lock System'
version '1.0.0'

shared_script {
    "@es_extended/imports.lua",
    "config.lua"
}

client_scripts {
    "config.lua",
    "client/cl_main.lua",
    "client/cl_amain.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/sv_main.lua"
}

dependencies {
    'es_extended'
}