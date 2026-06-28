local colors = require("colors")
local icons  = require("icons")

local function get_icon(vol, muted)
  if muted == "true" then
    return icons.volume._0
  elseif vol > 66 then
    return icons.volume._100
  elseif vol > 33 then
    return icons.volume._66
  elseif vol > 0 then
    return icons.volume._33
  else
    return icons.volume._0
  end
end

local function update()
  sbar.exec("osascript -e 'output volume of (get volume settings)' 2>/dev/null", function(vol)
    sbar.exec("osascript -e 'output muted of (get volume settings)' 2>/dev/null", function(muted)
      vol = tonumber(vol) or 0
      local icon = get_icon(vol, muted)
      local color = (muted == "true") and colors.red or colors.text
      sbar.set("widgets.volume", {
        icon  = { string = icon, color = color },
        label = vol .. "%",
      })
    end)
  end)
end

sbar.add("item", "widgets.volume", {
  position     = "right",
  icon         = { drawing = true },
  label        = { drawing = true },
  padding_left = 4,
  padding_right = 4,
  click_script = "osascript -e 'set volume output muted not (output muted of (get volume settings))'",
})

update()
sbar.subscribe("widgets.volume", "volume_change", update)
