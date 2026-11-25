
fx_version "bodacious"
lua54 'yes'
version '1.0'
games {
  "gta5"
}
ui_page 'interface/build/index.html'
shared_script 'lib/utils.lua'
client_scripts {
  'client-side/config.lua',
  'client-side/core.lua',
}
server_scripts {
  'server/config.lua',
  'server/framework.lua',
  'server/database.lua',
  'server/core.lua',
}
files {
  'interface/build/index.html',
  'interface/build/assets/*',
  'interface/build/*'
}