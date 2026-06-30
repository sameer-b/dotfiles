local colors = require("colors")

local ICON_PATH = os.getenv("HOME") .. "/.config/sketchybar/app-icons/temperature.png"

local function update()
  sbar.exec("macmon pipe -s 1 -i 100 2>/dev/null | jq -r '.temp.cpu_temp_avg | floor'", function(temp)
    local pct = tonumber(temp) or 0

    local color = colors.green
    if pct > 90 then color = colors.red
    elseif pct > 75 then color = colors.yellow
    end

    sbar.set("widgets.temp.label", {
      label = { string = tostring(pct) .. "°", color = color },
    })
  end)
end

sbar.add("item", "widgets.temp.label", {
  position      = "right",
  icon          = { drawing = false },
  label         = { drawing = true },
  update_freq   = 15,
  padding_left  = 0,
  padding_right = 0,
})

sbar.add("item", "widgets.temp.icon", {
  position      = "right",
  icon          = { drawing = false },
  label         = { drawing = false },
  background    = {
    ["image.scale"] = 0.6,
    image           = ICON_PATH,
    drawing         = true,
    height          = 28,
    color           = 0x00000000,
  },
  padding_left  = 8,
  padding_right = 0,
})

update()
sbar.subscribe("widgets.temp.label", "routine", update)
sbar.subscribe("widgets.temp.label", "system_woke", update)
