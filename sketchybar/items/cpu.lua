local colors = require("colors")
local icons  = require("icons")

local function update()
  sbar.exec("top -l 2 -n 0 -F 2>/dev/null | grep '^CPU usage:' | tail -1 | awk '{gsub(/[%,]/,\"\"); printf \"%.0f\\n\", $3+$5}'", function(pct)
    pct = tonumber(pct) or 0

    local color = colors.green
    if pct > 70 then color = colors.red
    elseif pct > 40 then color = colors.yellow
    end

    sbar.set("widgets.cpu", {
      icon  = { string = icons.cpu, color = color },
      label = { string = tostring(pct) .. "%", color = color },
    })
  end)
end

sbar.add("item", "widgets.cpu", {
  position     = "right",
  icon         = { drawing = true },
  label        = { drawing = true },
  update_freq  = 10,
  padding_left = 4,
  padding_right = 8,
})

update()
sbar.subscribe("widgets.cpu", "routine", update)
sbar.subscribe("widgets.cpu", "system_woke", update)
