local colors = require("colors")

-- Show 5 workspace indicators using OmniWM or static fallback
local workspace_count = 9

for i = 1, workspace_count do
  local index = i
  local props = {
    label = {
      string    = tostring(index),
      color     = colors.subtle,
      padding_left = 6,
      padding_right = 6,
    },
    background = {
      color    = colors.transparent,
      height   = 3,
      y_offset = 12,
    },
    click_script = "omniwmctl workspace focus-name " .. tostring(index),
    position = "left",
  }
  if i == 1 then props.update_freq = 1 end
  sbar.add("item", "space." .. index, props)
end

sbar.add("item", "spaces.right_pad", {
  label = { string = "", width = 4 },
  position = "left",
})

-- Highlight active workspace via OmniWM IPC
local function update()
  sbar.exec("omniwmctl query workspaces --current 2>/dev/null | grep -o '\"number\" : [0-9]*' | head -1 | cut -d: -f2 | tr -d ' '", function(result)
    local active = tonumber(result) or -1
    for i = 1, workspace_count do
      local active_color = i == active
      sbar.set("space." .. i, {
        label      = { color = active_color and colors.text or colors.subtle },
        background = { color = active_color and colors.love or colors.transparent },
      })
    end
  end)
end

update()
sbar.subscribe("space.1", "routine", update)
