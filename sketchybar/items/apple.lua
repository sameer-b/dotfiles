local icons = require("icons")

sbar.add("item", "apple.logo", {
  icon = {
    string = icons.apple,
    color  = 0xffffffff,
    size   = 13,
  },
  position   = "left",
  padding_left = 6,
  padding_right = 3,
  shadow     = { drawing = true, color = 0xff6600ff, blur = 30 },
  click_script = 'osascript -e "tell app \\\"System Settings\\\" to activate"',
})
