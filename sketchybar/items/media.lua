local colors = require("colors")

local function update()
  sbar.exec("nowplaying-cli get title,artist,isPlaying 2>/dev/null", function(result)
    if not result or result == "" then
      sbar.set("center.media", {
        label = { string = "♫ No media", drawing = true },
      })
      return
    end

    local parts = {}
    for part in result:gmatch("[^\n]+") do
      table.insert(parts, part)
    end

    local title = parts[1] or ""
    local artist = parts[2] or ""
    local playing = parts[3] == "1"

    local display = title
    if artist ~= "" then
      display = title .. "  -  " .. artist
    end

    sbar.set("center.media", {
      label = {
        string = (playing and "▶" or "⏸") .. "  " .. display,
        drawing = true,
      },
    })
  end)
end

sbar.add("item", "center.media", {
  position  = "center",
  icon      = { drawing = false },
  label     = { string = "", max_chars = 40 },
  padding_left = 4,
  padding_right = 4,
  click_script = "nowplaying-cli togglePlayPause",
})

sbar.add("event", "media_change")
update()
sbar.subscribe("center.media", "media_change", update)
sbar.subscribe("center.media", "routine", update)
