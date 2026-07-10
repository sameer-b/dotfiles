local colors = require("colors")

local WORKSPACE_COUNT = 9
local MAX_APP_SLOTS   = 4
local HELPER_SCRIPT   = os.getenv("HOME") .. "/.config/sketchybar/helpers/spaces_helper.py"

for ws = 1, WORKSPACE_COUNT do
  sbar.add("item", "space." .. ws, {
    label = {
      string    = tostring(ws),
      color     = colors.subtle,
      padding_left  = 7,
      padding_right = 2,
    },
    click_script = "aerospace workspace " .. tostring(ws),
    position = "left",
  })

  for slot = 1, MAX_APP_SLOTS do
    sbar.add("item", string.format("space.%s.app.%s", ws, slot), {
      drawing  = false,
      icon     = { drawing = false },
      label    = { drawing = false },
      background = {
        image            = "",
        ["image.scale"]  = 0.8,
        drawing          = true,
        height           = 36,
        color            = colors.transparent,
      },
      width      = 24,
      padding_left  = 0,
      padding_right = 0,
      position   = "left",
    })
  end

  sbar.add("item", string.format("space.%s.pad", ws), {
    label    = { string = "", width = 7 },
    icon     = { drawing = false },
    position = "left",
  })
end

sbar.add("item", "spaces.right_pad", {
  label = { string = "", width = 6 },
  position = "left",
})

sbar.add("item", "spaces.handler", {
  drawing = false,
})

for ws = 1, WORKSPACE_COUNT do
  local members = {
    "space." .. ws,
    string.format("space.%s.pad", ws),
  }
  for slot = 1, MAX_APP_SLOTS do
    table.insert(members, string.format("space.%s.app.%s", ws, slot))
  end
  sbar.add("bracket", "group." .. ws, members, {
    background = {
      color         = colors.transparent,
      corner_radius = 16,
      height        = 28,
      border_width  = 0,
    },
  })
end

local function parse_result(result)
  if not result then return nil end
  local lines = {}
  for line in result:gmatch("[^\n]+") do
    table.insert(lines, line)
  end
  return lines
end

local function active_workspace(lines)
  return tonumber((lines[1] or ""):match("active:(%-?%d+)")) or -1
end

local function parse_apps(line)
  local _, csv = line:match("(%d+):(.*)")
  if not csv or csv == "" then return {} end
  local apps = {}
  for entry in csv:gmatch("[^,]+") do
    local _, path = entry:match("([^|]+)|(.+)")
    if path then table.insert(apps, path) end
  end
  return apps
end

local function update()
  sbar.exec("python3 " .. HELPER_SCRIPT .. " 2>/dev/null", function(result)
    local lines = parse_result(result)
    if not lines then return end

    local active = active_workspace(lines)

    for ws = 1, WORKSPACE_COUNT do
      local active_color = (ws == active) and colors.text or colors.subtle
      local underline    = (ws == active) and colors.love or colors.transparent

      sbar.set("space." .. ws, {
        label = { color = active_color },
      })

      sbar.set("group." .. ws, {
        background = { color = underline },
      })

      local apps = parse_apps(lines[ws + 1])
      for slot = 1, MAX_APP_SLOTS do
        local item = string.format("space.%s.app.%s", ws, slot)
        local icon = apps[slot]
        if icon then
          sbar.set(item, {
            drawing    = true,
            background = { image = icon, drawing = true },
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
sbar.subscribe("spaces.handler", "space_update", update)
