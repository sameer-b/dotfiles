local colors = require("colors")

local ICON_PATH = os.getenv("HOME") .. "/.config/sketchybar/app-icons/memory.png"

local function update()
  sbar.exec("memory_pressure | awk '/free percentage/ {gsub(/%/,\"\",$5); printf \"%.0f\\n\", 100-$5}'", function(pct)
    pct = tonumber(pct) or 0

    local color = colors.green
    if pct > 80 then color = colors.red
    elseif pct > 60 then color = colors.yellow
    end

    sbar.set("widgets.memory.label", {
      label = { string = tostring(pct) .. "%", color = color },
    })
  end)
end

sbar.add("item", "widgets.memory.label", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = true },
  update_freq  = 15,
  padding_left = 0,
  padding_right = 8,
})

sbar.add("item", "widgets.memory.icon", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = false },
  background   = {
    image           = ICON_PATH,
    drawing         = true,
    height          = 28,
    color           = 0x00000000,
  },
  padding_left  = 12,
  padding_right = 0,
  width         = 28,
})

update()
sbar.subscribe("widgets.memory.label", "routine", update)
sbar.subscribe("widgets.memory.label", "system_woke", update)
