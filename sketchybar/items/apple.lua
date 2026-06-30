local icons = require("icons")

sbar.add("item", "apple.logo", {
  icon = {
    string = icons.apple,
    color  = 0xffcba6f7,
    size   = 48,
  },
  position   = "left",
  padding_left = 13,
  padding_right = 9,
  click_script = 'osascript -e "tell app \\\"System Settings\\\" to activate"',
})
