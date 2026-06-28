local colors = require("colors")
local icons  = require("icons")

local function update()
  sbar.exec("pmset -g batt | grep -Eo '\\d+%' | tr -d '%'", function(pct)
    pct = tonumber(pct) or 0
    sbar.exec("pmset -g batt | grep 'charging' >/dev/null 2>&1 && echo 1 || echo 0", function(charging)
      local icon
      if charging == "1" then
        icon = icons.battery.charging
      elseif pct >= 75 then
        icon = icons.battery._100
      elseif pct >= 50 then
        icon = icons.battery._75
      elseif pct >= 25 then
        icon = icons.battery._50
      else
        icon = icons.battery._25
      end

      local color = colors.text
      if pct <= 15 then color = colors.red
      elseif pct <= 25 then color = colors.orange end

      sbar.set("widgets.battery", {
        icon       = icon,
        icon_color = color,
        label      = tostring(pct) .. "%",
      })
    end)
  end)
end

sbar.add("item", "widgets.battery", {
  position     = "right",
  icon         = { drawing = true },
  label        = { drawing = true },
  update_freq  = 120,
  padding_left = 4,
  padding_right = 8,
})

update()
sbar.subscribe("routine", update)
sbar.subscribe("power_source_change", update)
sbar.subscribe("system_woke", update)
