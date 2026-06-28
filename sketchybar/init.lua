sbar = require("sketchybar")

sbar.begin_config()
require("bar")
require("default")
require("items")
sbar.end_config()

sbar.exec("nohup bash -c 'exec omniwmctl watch active-workspace,windows-changed --exec sketchybar --trigger space_update' &>/dev/null &")

sbar.event_loop()
