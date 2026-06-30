local colors = require("colors")

local TEMP_ICON = os.getenv("HOME") .. "/.config/sketchybar/app-icons/temperature.png"
local GPU_ICON   = os.getenv("HOME") .. "/.config/sketchybar/app-icons/gpu.png"

local function update()
  sbar.exec("macmon pipe -s 1 -i 100 2>/dev/null | jq -r '\"\\(.temp.gpu_temp_avg | floor) \\(.gpu_usage[1] * 100 | floor)\"'", function(result)
    local temp_str, usage_str = result:match("(%d+)%s+(%d+)")
    local temp = tonumber(temp_str) or 0
    local usage = tonumber(usage_str) or 0

    local temp_color = colors.green
    if temp > 90 then temp_color = colors.red
    elseif temp > 75 then temp_color = colors.yellow
    end

    local usage_color = colors.green
    if usage > 70 then usage_color = colors.red
    elseif usage > 40 then usage_color = colors.yellow
    end

    sbar.set("widgets.gpu.temp.label", {
      label = { string = tostring(temp) .. "°", color = temp_color },
    })
    sbar.set("widgets.gpu.label", {
      label = { string = tostring(usage) .. "%", color = usage_color },
    })
  end)
end

sbar.add("item", "widgets.gpu.temp.label", {
  position      = "right",
  icon          = { drawing = false },
  label         = { drawing = true },
  update_freq   = 15,
  padding_left  = 0,
  padding_right = 5,
})

sbar.add("item", "widgets.gpu.temp.icon", {
  position      = "right",
  icon          = { drawing = false },
  label         = { drawing = false },
  background    = {
    ["image.scale"] = "0.6",
    image           = TEMP_ICON,
    drawing         = true,
    height          = 28,
    color           = 0x00000000,
  },
  padding_left  = 8,
  padding_right = 0,
})

sbar.add("item", "widgets.gpu.label", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = true },
  update_freq  = 15,
  padding_left = 0,
  padding_right = 10,
})

sbar.add("item", "widgets.gpu.icon", {
  position     = "right",
  icon         = { drawing = false },
  label        = { drawing = false },
  background   = {
    image           = GPU_ICON,
    drawing         = true,
    height          = 28,
    color           = 0x00000000,
  },
  padding_left  = 10,
  padding_right = 0,
})

update()
sbar.subscribe("widgets.gpu.temp.label", "routine", update)
sbar.subscribe("widgets.gpu.temp.label", "system_woke", update)
