local colors = require("colors")
local icons  = require("icons")

local function update()
  local date = os.date("%a %b %d"):gsub(" 0", " ")
  local time = os.date("%I:%M %p"):gsub("^0", "")
  sbar.set("widgets.date", {
    icon  = { string = icons.calendar, color = colors.gold },
    label = { string = date, color = colors.text },
  })
  sbar.set("widgets.time", {
    icon  = { string = icons.clock, color = colors.pine },
    label = { string = time, color = colors.iris },
  })
end

sbar.add("item", "widgets.date", {
  position     = "right",
  icon         = { drawing = true, font = { size = 12 } },
  label        = { string = "", font = { size = 12 } },
  padding_left = 6,
  padding_right = 2,
})

sbar.add("item", "widgets.time", {
  position     = "right",
  icon         = { drawing = true, font = { size = 12 } },
  label        = { string = "", font = { size = 12 } },
  padding_left = 2,
  padding_right = 6,
})

update()
sbar.subscribe("widgets.date", "routine", update)
sbar.subscribe("widgets.date", "forced", update)
sbar.subscribe("widgets.date", "system_woke", update)
