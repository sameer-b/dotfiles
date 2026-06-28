local colors = require("colors")

local space_items = {}

sbar.add("event", "space_change")

local function update()
  sbar.exec("yabai -m query --spaces", function(result)
    local spaces = sbar.parse(result)
    for _, space in ipairs(spaces) do
      local sid = space.index
      local item = space_items[sid]

      if not item then
        item = sbar.add("item", "space." .. sid, {
          icon = { drawing = false },
          label = {
            string    = tostring(sid),
            padding_left = 6,
            padding_right = 6,
          },
          click_script = "yabai -m space --focus " .. sid,
          position = "left",
        })
        space_items[sid] = item
      end

      if space.focused then
        sbar.set("space." .. sid, { label = { color = colors.accent } })
      else
        sbar.set("space." .. sid, { label = { color = colors.subtle } })
      end
    end
  end)
end

update()
sbar.subscribe("space_change", update)
