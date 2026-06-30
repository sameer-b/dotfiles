local colors = require("colors")

sbar.bar({
  topmost = "window",
  height = 41,
  color = colors.transparent,
  border_width = 0,
  shadow = true,
  position = "top",
  sticky = true,
  padding_right = 0,
  padding_left = 0,
  y_offset = 9,
  margin = 155,
  blur_radius = 50,
  corner_radius = 13,
})
