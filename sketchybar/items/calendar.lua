local colors = require("colors")

local function update()
  local date = os.date("%a %b %d"):gsub(" 0", " ")
  local time = os.date("%H:%M")
  sbar.set("center.date", { label = date })
  sbar.set("center.time", { label = { string = time, color = colors.accent } })
end

sbar.add("item", "center.date", {
  position  = "center",
  icon      = { drawing = false },
  label     = { string = "", font = { size = 12 } },
  padding_left = 4,
  padding_right = 4,
})

sbar.add("item", "center.time", {
  position  = "center",
  icon      = { drawing = false },
  label     = { string = "", font = { size = 12 } },
  padding_left = 4,
  padding_right = 4,
})

update()
sbar.subscribe("center.date", "routine", update)
sbar.subscribe("center.date", "forced", update)
sbar.subscribe("center.date", "system_woke", update)
