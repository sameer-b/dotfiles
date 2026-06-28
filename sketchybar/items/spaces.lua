local colors = require("colors")
local icons  = require("icons")

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
  sbar.add("item", "space." .. index, props)
end

sbar.add("item", "spaces.right_pad", {
  label = { string = "", width = 4 },
  position = "left",
})

local function build_label(label, apps)
  local s = label
  for i = 1, #apps do
    if i > 4 then
      s = s .. " +" .. tostring(#apps - 4)
      break
    end
    local ic = icons.app[apps[i]] or "·"
    s = s .. " " .. ic
  end
  return s
end

local function update()
  sbar.exec([[
python3 -c "
import subprocess, json, sys
try:
    ws = json.loads(subprocess.check_output(['omniwmctl', 'query', 'workspaces', '--current', '--format', 'json'], stderr=subprocess.DEVNULL))
    print('active:' + str(ws['result']['payload']['workspaces'][0]['number']))
except:
    print('active:-1')
try:
    wins = json.loads(subprocess.check_output(['omniwmctl', 'query', 'windows', '--fields', 'app,workspace', '--format', 'json'], stderr=subprocess.DEVNULL))
    by_ws = {}
    for w in wins['result']['payload']['windows']:
        n = w.get('workspace', {}).get('number')
        app = w.get('app', {}).get('name', '')
        if n is not None and app:
            by_ws.setdefault(n, set()).add(app)
    for i in range(1, 10):
        apps = sorted(by_ws.get(i, []))
        print(str(i) + ':' + ','.join(apps))
except:
    for i in range(1, 10):
        print(str(i) + ':')
" 2>/dev/null
  ]], function(result)
    if not result then return end
    local lines = {}
    for line in result:gmatch("[^\n]+") do
      table.insert(lines, line)
    end

    local active_line = lines[1] or ""
    local active = tonumber(active_line:match("active:(%-?%d+)")) or -1

    for i = 1, workspace_count do
      local ws_info = lines[i + 1] or ""
      local ws_num, apps_csv = ws_info:match("(%d+):(.*)")
      ws_num = tonumber(ws_num) or i

      local apps = {}
      if apps_csv and apps_csv ~= "" then
        for app in apps_csv:gmatch("[^,]+") do
          table.insert(apps, app)
        end
      end

      local label_str = build_label(tostring(ws_num), apps)

      sbar.set("space." .. ws_num, {
        label = { string = label_str, color = (ws_num == active) and colors.text or colors.subtle },
        background = { color = (ws_num == active) and colors.love or colors.transparent },
      })
    end
  end)
end

sbar.add("event", "space_update")
update()
sbar.subscribe("space.1", "space_update", update)
