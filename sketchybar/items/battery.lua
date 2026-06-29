local colors = require("colors")

local ICON_PATH = os.getenv("HOME") .. "/.config/sketchybar/app-icons/battery.png"

local function update()
  sbar.exec("pmset -g batt | grep -Eo '\\d+%' | tr -d '%'", function(pct)
    pct = tonumber(pct) or 0
    sbar.exec("pmset -g batt | grep 'charging' >/dev/null 2>&1 && echo 1 || echo 0", function(charging)
      local color = colors.text
      if pct <= 15 then color = colors.red
      elseif pct <= 25 then color = colors.orange end

      local label = tostring(pct) .. "%"
      if charging == "1" then label = label .. " " end

      sbar.set("widgets.battery.label", {
        label = { string = label, color = color },
      })
    end)
  end)
end

sbar.add("item", "widgets.battery.label", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = true },
  update_freq  = 120,
  padding_left = 0,
  padding_right = 2,
})

sbar.add("item", "widgets.battery.icon", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = false },
  background   = {
    image           = ICON_PATH,
    drawing         = true,
    height          = 28,
    color           = 0x00000000,
  },
  padding_left  = 1,
  padding_right = 2,
  width         = 36,
})

update()
sbar.subscribe("widgets.battery.label", "routine", update)
sbar.subscribe("widgets.battery.label", "power_source_change", update)
sbar.subscribe("widgets.battery.label", "system_woke", update)
