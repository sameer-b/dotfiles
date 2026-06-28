local colors = require("colors")
local workspace_count = 9
local max_apps = 4
local script_path = os.getenv("HOME") .. "/.config/sketchybar/helpers/spaces_helper.py"

for i = 1, workspace_count do
  local index = i

  sbar.add("item", "space." .. index, {
    label = {
      string    = tostring(index),
      color     = colors.subtle,
      padding_left = 6,
      padding_right = 2,
    },
    background = {
      color    = colors.transparent,
      height   = 3,
      y_offset = 12,
    },
    click_script = "omniwmctl workspace focus-name " .. tostring(index),
    position = "left",
  })

  for j = 1, max_apps do
    sbar.add("item", "space." .. index .. ".app." .. j, {
      drawing  = false,
      icon     = { drawing = false },
      label    = { drawing = false },
      background = {
        image            = "",
        ["image.scale"]  = 0.5,
        drawing          = true,
        height           = 28,
        color            = 0x00000000,
      },
      width      = 18,
      padding_left = 0,
      padding_right = 0,
      position   = "left",
    })
  end
end

sbar.add("item", "spaces.right_pad", {
  label = { string = "", width = 5 },
  position = "left",
})

local function update()
  sbar.exec("python3 " .. script_path .. " 2>/dev/null", function(result)
    if not result then return end
    local lines = {}
    for line in result:gmatch("[^\n]+") do
      table.insert(lines, line)
    end

    local active_line = lines[1] or ""
    local active = tonumber(active_line:match("active:(%-?%d+)")) or -1

    for i = 1, workspace_count do
      local is_active = (i == active)
      sbar.set("space." .. i, {
        label      = { color = is_active and colors.text or colors.subtle },
        background = { color = is_active and colors.love or colors.transparent },
      })

      local ws_info = lines[i + 1] or ""
      local _, apps_str = ws_info:match("(%d+):(.*)")
      local apps = {}
      if apps_str and apps_str ~= "" then
        for entry in apps_str:gmatch("[^,]+") do
          local name, path = entry:match("([^|]+)|(.+)")
          if name and path then
            table.insert(apps, path)
          end
        end
      end

      for j = 1, max_apps do
        local item = "space." .. i .. ".app." .. j
        if j <= #apps and apps[j] ~= "" then
          sbar.set(item, {
            drawing    = true,
            background = { image = apps[j], drawing = true },
          })
        else
          sbar.set(item, { drawing = false })
        end
      end
    end
  end)
end

sbar.add("event", "space_update")
update()
sbar.subscribe("space.1", "space_update", update)
