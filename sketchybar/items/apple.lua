local icon_path = os.getenv("HOME") .. "/.config/sketchybar/app-icons/apple.png"

sbar.add("item", "apple.logo", {
  icon = { drawing = false },
  label = { drawing = false },
  background = {
    image           = icon_path,
    ["image.scale"] = 0.75,
    drawing         = true,
    height          = 31,
    color           = 0x00000000,
  },
  position   = "left",
  padding_left = 15,
  padding_right = 12,
  click_script = 'osascript -e "tell app \\\"System Settings\\\" to activate"',
})
