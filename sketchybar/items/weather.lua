local colors   = require("colors")
local icons    = require("icons")
local settings = require("settings")

local function update()
  sbar.exec("curl -s 'wttr.in/" .. settings.weather_location .. "?format=%c+%t' 2>/dev/null", function(result)
    if not result or result == "" then
      sbar.set("center.weather", { label = { string = "??", drawing = true } })
      return
    end
    sbar.set("center.weather", {
      icon  = { string = icons.weather, color = colors.yellow },
      label = { string = result, drawing = true },
    })
  end)
end

sbar.add("item", "center.weather", {
  position     = "center",
  icon         = { drawing = true },
  label        = { string = "", font = { size = 11 } },
  update_freq  = 1800,
  padding_left = 4,
  padding_right = 4,
})

update()
