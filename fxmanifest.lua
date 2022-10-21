fx_version 'cerulean'
game 'gta5'

name "UNIK VIP SYSTEM"
author "github.com/Liridon69"
version "1.0"


shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- change en to your language
	'config.lua',
}

client_scripts {
	'client/main.lua',
	'config.lua'
}

server_scripts {
	'server/main.lua',
	'config.lua'
}
