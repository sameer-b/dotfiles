local colors = require("colors")

sbar.bar({
  topmost = "window",
  height = 30,
  notch_display_height = 50,
  color = colors.bg2,
  border_width = 0,
  shadow = true,
  position = "top",
  sticky = true,
  padding_right = 10,
  padding_left = 10,
  y_offset = 0,
  notch_offset = 0,
  margin = 0,
  blur_radius = 0,
  corner_radius = 0,
})
