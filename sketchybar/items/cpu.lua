local colors = require("colors")

local ICON_PATH = os.getenv("HOME") .. "/.config/sketchybar/app-icons/cpu.png"

local function update()
  sbar.exec("top -l 2 -n 0 -F 2>/dev/null | grep '^CPU usage:' | tail -1 | awk '{gsub(/[%,]/,\"\"); printf \"%.0f\\n\", $3+$5}'", function(pct)
    pct = tonumber(pct) or 0

    local color = colors.green
    if pct > 70 then color = colors.red
    elseif pct > 40 then color = colors.yellow
    end

    sbar.set("widgets.cpu.label", {
      label = { string = tostring(pct) .. "%", color = color },
    })
  end)
end

sbar.add("item", "widgets.cpu.label", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = true },
  update_freq  = 10,
  padding_left = 0,
  padding_right = 15,
})

sbar.add("item", "widgets.cpu.icon", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = false },
  background   = {
    image           = ICON_PATH,
    drawing         = true,
    height          = 28,
    color           = 0x00000000,
  },
  padding_left  = 2,
  padding_right = 2,
  width         = 28,
})

update()
sbar.subscribe("widgets.cpu.label", "routine", update)
sbar.subscribe("widgets.cpu.label", "system_woke", update)
