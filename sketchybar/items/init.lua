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

sbar.add("item", "spacer.batt.cal", {
  position = "right",
  width = 15,
  icon = { drawing = false },
  label = { drawing = false },
  background = { color = colors.transparent },
  padding_left = 10,
  padding_right = 10,
})

require("items.battery")

sbar.add("item", "spacer.mem.batt", {
  position = "right",
  width = 15,
  icon = { drawing = false },
  label = { drawing = false },
  background = { color = colors.transparent },
  padding_left = 10,
  padding_right = 10,
})

require("items.memory")

sbar.add("item", "spacer.cpu.mem", {
  position = "right",
  width = 15,
  icon = { drawing = false },
  label = { drawing = false },
  background = { color = colors.transparent },
  padding_left = 10,
  padding_right = 10,
})

require("items.cpu")

local radius = 20

sbar.add("bracket", "bracket.left", { "apple.logo", "/space\\..*/", "spaces.right_pad" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})

sbar.add("bracket", "bracket.right.cpu", { "widgets.cpu.icon", "widgets.cpu.label" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})

sbar.add("bracket", "bracket.right.memory", { "widgets.memory.icon", "widgets.memory.label" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})

sbar.add("bracket", "bracket.right.battery", { "widgets.battery.icon", "widgets.battery.label" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})

sbar.add("bracket", "bracket.right.calendar", { "widgets.day", "widgets.month", "widgets.daynum", "widgets.time", "widgets.ampm" }, {
  background = { color = colors.bg1, corner_radius = radius, height = 33, border_width = 0 },
})
