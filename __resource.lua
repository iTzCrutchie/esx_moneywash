-------------------------------------------
------- [ Money Wash by Crutchie ] --------
------------ [ Version 0.0.2 ] ------------
-------------------------------------------

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Money Washing'

version '0.0.2'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
}

dependencies {
	'es_extended',
}