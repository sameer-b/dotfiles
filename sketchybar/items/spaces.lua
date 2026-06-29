local colors = require("colors")

local WORKSPACE_COUNT = 9
local MAX_APP_SLOTS   = 4
local HELPER_SCRIPT   = os.getenv("HOME") .. "/.config/sketchybar/helpers/spaces_helper.py"

local rainbow = { colors.red, colors.love, colors.orange, colors.yellow, colors.green, colors.pine, colors.blue, colors.iris, colors.magenta }

for ws = 1, WORKSPACE_COUNT do
  sbar.add("item", "space." .. ws, {
    label = {
      string    = tostring(ws),
      color     = rainbow[ws],
      font      = "Hack Nerd Font Mono:Bold:12.0",
      padding_left  = 5,
      padding_right = 2,
    },
    click_script = "omniwmctl workspace focus-name " .. tostring(ws),
    position = "left",
  })

  for slot = 1, MAX_APP_SLOTS do
    sbar.add("item", string.format("space.%s.app.%s", ws, slot), {
      drawing  = false,
      icon     = { drawing = false },
      label    = { drawing = false },
      background = {
        image            = "",
        ["image.scale"]  = 0.35,
        drawing          = true,
        height           = 16,
        color            = 0x00000000,
      },
      width      = 12,
      padding_left  = 0,
      padding_right = 0,
      position   = "left",
    })
  end

  sbar.add("item", string.format("space.%s.pad", ws), {
    label    = { string = "", width = 6 },
    icon     = { drawing = false },
    position = "left",
  })
end

sbar.add("item", "spaces.right_pad", {
  label = { string = "", width = 3 },
  position = "left",
})

for ws = 1, WORKSPACE_COUNT do
  local members = {
    "space." .. ws,
    string.format("space.%s.pad", ws),
  }
  for slot = 1, MAX_APP_SLOTS do
    table.insert(members, string.format("space.%s.app.%s", ws, slot))
  end
  sbar.exec("sketchybar --add bracket group." .. ws .. " " .. table.concat(members, " ") .. " 2>/dev/null")
  sbar.set("group." .. ws, {
    background = {
      color         = colors.transparent,
      height        = 18,
      y_offset      = 0,
      corner_radius = 9,
    },
  })
end

local function parse_result(result)
  if not result then return nil end
  local lines = {}
  for line in result:gmatch("[^\n]+") do
    table.insert(lines, line)
  end
  return #lines > 1 and lines or nil
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

    sbar.anim("ease_in_out", 6, function()
      for ws = 1, WORKSPACE_COUNT do
        local active_color = (ws == active) and colors.text or rainbow[ws]
        local active_bg    = (ws == active) and 0x30ffffff or colors.transparent
        local active_brdr  = (ws == active) and rainbow[ws] or colors.transparent
        local has_shadow   = (ws == active)

        sbar.set("space." .. ws, {
          label  = { color = active_color },
        })

        sbar.set("group." .. ws, {
          background = {
            color         = active_bg,
            height        = 18,
            y_offset      = 0,
            corner_radius = 9,
            border_width  = (ws == active) and 1 or 0,
            border_color  = active_brdr,
            shadow        = has_shadow and { drawing = true, color = rainbow[ws] } or { drawing = false },
          },
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
  end)
end

sbar.add("event", "space_update")
update()
sbar.subscribe("space.1", "space_update", update)
