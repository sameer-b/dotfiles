local settings = require("settings")
local colors   = require("colors")

sbar.default({
  updates = "when_shown",
  icon = {
    font = settings.font.text .. ":Bold:16.0",
    color        = colors.text,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = settings.font.text .. ":Bold:15.0",
    color        = colors.text,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
      height       = 35,
      corner_radius = 17,
    border_color = colors.transparent,
    border_width = 0,
    color        = colors.transparent,
  },
  popup = {
    background = {
      border_width  = 1,
      corner_radius = 15,
      border_color  = colors.popup.border,
      color         = colors.popup.bg,
      shadow        = { drawing = true },
    },
    blur_radius = 50,
  },
  padding_left  = 5,
  padding_right = 5,
  scroll_texts  = true,
})
