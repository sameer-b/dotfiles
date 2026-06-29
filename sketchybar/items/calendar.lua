local colors = require("colors")

local function update()
  local date = os.date("%a %b %d"):gsub(" 0", " ")
  local time = os.date("%I:%M %p")
  sbar.set("widgets.date", { label = date })
  sbar.set("widgets.time", { label = { string = time, color = colors.accent } })
end

sbar.add("item", "widgets.time", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", font = { size = 15 } },
  padding_left = 2,
  padding_right = 4,
})

sbar.add("item", "widgets.date", {
  position  = "right",
  icon      = { drawing = false },
  label     = { string = "", font = { size = 15 } },
  padding_left = 4,
  padding_right = 2,
})

update()
sbar.subscribe("widgets.date", "routine", update)
sbar.subscribe("widgets.date", "forced", update)
sbar.subscribe("widgets.date", "system_woke", update)
