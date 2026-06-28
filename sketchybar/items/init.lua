local colors = require("colors")

require("items.apple")
require("items.spaces")

require("items.media")

sbar.add("item", "center.notch", {
  position = "center",
  width    = 200,
  icon     = { drawing = false },
  label    = { drawing = false },
  background = { color = colors.transparent },
})

require("items.weather")
require("items.calendar")
require("items.battery")
require("items.volume")
require("items.wifi")

local radius = 16

sbar.add("bracket", "bracket.left", { "apple.logo", "/space\\..*/", "spaces.right_pad" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 28, border_width = 0 },
})

sbar.add("bracket", "bracket.media", {
  "/^center\\.media.*/", "center.notch", "center.weather", "center.time", "center.date",
}, {
  background = { color = colors.bg3, corner_radius = 4, height = 24, border_width = 0 },
})

sbar.add("bracket", "bracket.right", {
  "widgets.wifi", "widgets.volume", "widgets.battery",
}, {
  background = { color = colors.bg1, corner_radius = radius, height = 28, border_width = 0 },
})
