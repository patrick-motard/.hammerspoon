
hs.loadSpoon('HSKeybindings')
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("KSheet")
hs.loadSpoon("SpoonInstall")
Install = spoon.SpoonInstall
spaces = require("hs._asm.undocumented.spaces")
spoon.ReloadConfiguration:start()

-- START OPTIONAL SETTINGS
-- ///////////////////////
-- Uncomment when debugging:
-- Install.use_syncinstall = true
-- hs.window.animationDuration = 0
-- \\\\\\\\\\\\\\\\\\\\\\
-- END OPTIONAL SETTINGS
require 'scripts/test'

-- TODO: Get VPN Connection working
-- require 'scripts/connect_to_vpn'

hyper = { "cmd", "alt" }
meh = { "alt", "shift", "ctrl" }
cmd = { "cmd" }
leader = { 'alt' }

Install:andUse('KSheet', {
  hotkeys = {
    toggle = { leader, '/' }
  }
})

local cheatsheetToggle = true
function toggleCheatSheet()
  if cheatsheetToggle then
    spoon.HSKeybindings:show()
  else
    spoon.HSKeybindings:hide()
  end
  cheatsheetToggle = not cheatsheetToggle
end
hs.hotkey.bind(leader, 'h', 'Show Keybinds', toggleCheatSheet)

-- title is optional
function notify(message, title)
  hs.notify.new({title=title, informativeText=message}):send()
end

hs.hotkey.bind(hyper, 'k', 'Window ← 1/2', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToUnit(hs.layout.left50)
end)

hs.hotkey.bind(hyper, ";", 'Window → Screen', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(hyper, "j", 'Window ← Screen', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToScreen(win:screen():previous())
end)

hs.hotkey.bind(hyper, "l", 'Window → 1/2', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToUnit(hs.layout.right50)
end)

hs.hotkey.bind(hyper, "m", 'Window Maximize', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToUnit(hs.layout.maximized)
end)


-- set up your windowfilter
switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

switcher.ui.textsize = 10
switcher.ui.fontName = 'JetBrains Mono'

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab','Next window',function()switcher:next()end)
hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher:previous()end)

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
hs.hotkey.bind('alt','tab','Next window',hs.window.switcher.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
hs.hotkey.bind('alt-shift','tab','Prev window',hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)

hs.hotkey.bind(hyper, '1', 'VSCode', function()
  hs.application.launchOrFocus('Visual Studio Code')
end)

hs.hotkey.bind(hyper, '2', 'Iterm', function()
  hs.application.launchOrFocus('Iterm')
end)

hs.hotkey.bind(hyper, '3', 'Firefox', function()
  hs.application.launchOrFocus('Firefox')
end)

hs.hotkey.bind(hyper, '4', 'Slack', function()
  hs.application.launchOrFocus('Slack')
end)

hs.hotkey.bind(hyper, '0', 'Spotify', function()
  hs.application.launchOrFocus('Spotify')
end)

-- Use to get name of application
-- hs.hotkey.bind(hyper, '8', function()
--   print(hs.application.find('code'))
-- end)

-- START WORKS IN PROGRESS
hs.hotkey.bind(hyper, "r", 'wip', function()
  current_space = spaces.activeSpace()
  space_name = spaces.spaceName(current_space)
  text = current_space .. space_name
  hs.notify.new({title="current space", informativeText=space_name}):send()
end)

function main()
  space_id = spaces.activeSpace()
  space_name = spaces.spaceName(space_id)
  text = space_id .. space_name
  win = spaces.allWindowsForSpace(space_id)
  -- for i in pairs(win) do print(win[i]) end
  apps = hs.application.runningApplications()
  for i in pairs(apps) do print(apps[i]) end

  out = text
  notify(out)
end

hs.hotkey.bind(meh, 'd', 'wip', function()
  main()
end)
-- main()

hs.hotkey.bind(hyper, 'w', 'wip', function()
  space_id = spaces.activeSpace()
  win = spaces.allWindowsForSpace(space_id)
  for i in pairs(win) do print(win[i]:title()) end
end)

