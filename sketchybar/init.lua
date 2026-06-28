sbar = require("sketchybar")

sbar.begin_config()
require("bar")
require("default")
require("items")
sbar.end_config()

sbar.exec("nohup bash -c 'exec omniwmctl watch active-workspace,windows-changed --exec sketchybar --trigger space_update' &>/dev/null &")
sbar.exec("pkill -x sketchybar-toggle 2>/dev/null; sketchybar-toggle &")

sbar.event_loop()
