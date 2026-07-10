local colors = require("colors")

sbar.bar({
  topmost = "window",
  height = 30,
  notch_display_height = 45,
  color = colors.bg2,
  border_width = 0,
  shadow = true,
  position = "top",
  sticky = true,
  padding_right = 10,
  padding_left = 10,
  y_offset = 5,
  notch_offset = 5,
  margin = 155,
  blur_radius = 2,
  corner_radius = 13,
})
