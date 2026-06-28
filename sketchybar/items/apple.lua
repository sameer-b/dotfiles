local icons = require("icons")

sbar.add("item", "apple.logo", {
  icon       = icons.apple,
  icon_color = 0xffcba6f7,
  icon_size  = 18,
  position   = "left",
  padding_left = 10,
  padding_right = 8,
  click_script = 'osascript -e "tell app \\\"System Settings\\\" to activate"',
})
