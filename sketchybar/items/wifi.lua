local colors = require("colors")
local icons  = require("icons")

local function update()
  sbar.exec("ifconfig en0 2>/dev/null | grep 'status: active' >/dev/null && echo 1 || echo 0", function(active)
    if active == "1" then
      sbar.exec("ipconfig getifaddr en0 2>/dev/null", function(ip)
        sbar.set("widgets.wifi", {
          icon       = icons.wifi.connected,
          icon_color = colors.rose,
          label      = ip or "",
        })
      end)
    else
      sbar.set("widgets.wifi", {
        icon       = icons.wifi.disconnected,
        icon_color = colors.grey,
        label      = "",
      })
    end
  end)
end

sbar.add("item", "widgets.wifi", {
  position     = "right",
  icon         = { drawing = true },
  label        = { drawing = true, font_size = 10 },
  update_freq  = 60,
  padding_left = 8,
  padding_right = 4,
})

update()
sbar.subscribe("routine", update)
sbar.subscribe("wifi_change", update)
sbar.subscribe("system_woke", update)
