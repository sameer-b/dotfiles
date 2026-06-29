local colors = require("colors")

local function update()
  sbar.set("widgets.time",    { label = { string = os.date("%I:%M"), color = colors.love } })
  sbar.set("widgets.ampm",   { label = { string = os.date("%p"), color = colors.yellow } })
  sbar.set("widgets.daynum", { label = os.date("%d"):gsub("^0", "") })
  sbar.set("widgets.month",  { label = os.date("%b") })
  sbar.set("widgets.day",    { label = os.date("%a") })
end

sbar.add("item", "widgets.ampm", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", font = { size = 15 } },
  padding_left = 0,
  padding_right = 4,
})

sbar.add("item", "widgets.time", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", font = { size = 15 } },
  padding_left = 2,
  padding_right = 2,
})

sbar.add("item", "widgets.daynum", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", color = colors.green, font = { size = 15 } },
  padding_left = 2,
  padding_right = 2,
})

sbar.add("item", "widgets.month", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", color = colors.blue, font = { size = 15 } },
  padding_left = 2,
  padding_right = 1,
})

sbar.add("item", "widgets.day", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", color = colors.yellow, font = { size = 15 } },
  padding_left = 4,
  padding_right = 0,
})

update()
sbar.subscribe("widgets.day", "routine", update)
sbar.subscribe("widgets.day", "forced", update)
sbar.subscribe("widgets.day", "system_woke", update)
