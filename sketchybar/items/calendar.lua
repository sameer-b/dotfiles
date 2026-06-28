local colors = require("colors")

local function update()
  local date = os.date("%a %b %-d")
  local time = os.date("%H:%M")
  sbar.set("center.date", { label = date })
  sbar.set("center.time", { label = time, label_color = colors.accent })
end

sbar.add("item", "center.date", {
  position  = "center",
  icon      = { drawing = false },
  label     = { string = "", font_size = 12 },
  padding_left = 4,
  padding_right = 4,
})

sbar.add("item", "center.time", {
  position  = "center",
  icon      = { drawing = false },
  label     = { string = "", font_size = 12 },
  padding_left = 4,
  padding_right = 4,
})

update()
sbar.subscribe("routine", update)
sbar.subscribe("forced", update)
sbar.subscribe("system_woke", update)
