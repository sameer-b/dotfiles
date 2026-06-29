local colors = require("colors")

sbar.bar({
  topmost = "window",
  height = 34,
  color = colors.transparent,
  border_width = 0,
  shadow = true,
  position = "top",
  sticky = true,
  padding_right = 0,
  padding_left = 0,
  y_offset = 8,
  margin = 128,
  blur_radius = 30,
  corner_radius = 10,
})
