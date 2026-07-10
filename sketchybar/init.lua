sbar = require("sketchybar")

sbar.begin_config()
require("bar")
require("default")
require("items")
sbar.end_config()

sbar.exec("nohup bash -c 'exec aerospace subscribe focused-workspace-changed focus-changed 2>/dev/null | while read -r _; do sketchybar --trigger space_update; done' &>/dev/null &")
sbar.exec("pkill -x sketchybar-toggle 2>/dev/null; sketchybar-toggle --y-offset 5 &")

sbar.event_loop()
