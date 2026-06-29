local icons = require("icons")

sbar.add("item", "apple.logo", {
  icon = {
    string = icons.apple,
    color  = 0xffcba6f7,
    size   = 18,
  },
  position   = "left",
  padding_left = 10,
  padding_right = 8,
  click_script = 'osascript -e "tell app \\\"System Settings\\\" to activate"',
})
