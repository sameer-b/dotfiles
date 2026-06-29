local colors = require("colors")

require("items.apple")
require("items.spaces")
require("items.calendar")
require("items.battery")

local radius = 8

sbar.add("item", "widgets.separator", {
  position      = "right",
  width         = 1,
  background    = { color = 0x40cba6f7, height = 16, corner_radius = 1, drawing = true },
  padding_left  = 4,
  padding_right = 4,
  icon          = { drawing = false },
  label         = { drawing = false },
})

local glow = { drawing = true, blur = 40 }

sbar.add("bracket", "bracket.left", { "apple.logo", "/space\\..*/", "spaces.right_pad" }, {
  background = {
    color            = 0x18131826,
    corner_radius    = radius,
    height           = 22,
    border_width     = 1,
    border_color     = 0x40cba6f7,
    blur_radius      = 30,
    shadow           = glow,
  },
})

sbar.add("bracket", "bracket.right", {
  "widgets.separator", "widgets.battery", "widgets.date", "widgets.time",
}, {
  background = {
    color            = 0x40cba6f7,
    gradient         = "on",
    gradient_color_1 = colors.green,
    gradient_color_2 = colors.blue,
    gradient_angle   = 0,
    corner_radius    = radius,
    height           = 22,
    border_width     = 1,
    border_color     = 0x50ffffff,
    blur_radius      = 30,
    shadow           = glow,
  },
})
