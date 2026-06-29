local colors = require("colors")

require("items.apple")
require("items.spaces")

sbar.add("item", "center.notch", {
  position = "center",
  width    = 243,
  icon     = { drawing = false },
  label    = { drawing = false },
  background = { color = colors.transparent },
})

require("items.calendar")
require("items.battery")
require("items.cpu")

local radius = 20

sbar.add("bracket", "bracket.left", { "apple.logo", "/space\\..*/", "spaces.right_pad" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})

sbar.add("bracket", "bracket.right", {
  "widgets.cpu", "widgets.battery", "widgets.date", "widgets.time",
}, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})
