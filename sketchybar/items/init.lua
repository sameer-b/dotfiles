local colors = require("colors")

local function add_right_spacer(name)
  sbar.add("item", name, {
    position = "right",
    width = 15,
    icon = { drawing = false },
    label = { drawing = false },
    background = { color = colors.transparent },
    padding_left = 10,
    padding_right = 10,
  })
end

local function add_bracket(name, members)
  sbar.add("bracket", name, members, {
    background = {
      color = colors.bg1,
      corner_radius = 20,
      height = 33,
      border_width = 0,
    },
  })
end

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

add_right_spacer("spacer.batt.cal")

require("items.battery")

add_right_spacer("spacer.mem.batt")

require("items.memory")

add_right_spacer("spacer.cpu.mem")

require("items.cpu")
require("items.temperature")

add_bracket("bracket.left", { "apple.logo", "/space\\..*/", "spaces.right_pad" })
add_bracket("bracket.right.cpu", { "widgets.cpu.icon", "widgets.cpu.label", "widgets.temp.icon", "widgets.temp.label" })
add_bracket("bracket.right.memory", { "widgets.memory.icon", "widgets.memory.label" })
add_bracket("bracket.right.battery", { "widgets.battery.icon", "widgets.battery.label" })
add_bracket("bracket.right.calendar", { "widgets.day", "widgets.month", "widgets.daynum", "widgets.time", "widgets.ampm" })
