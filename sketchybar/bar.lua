local colors = require("colors")

sbar.bar({
  topmost    = "window",
  height     = 28,
  color      = 0x04080a10,
  border_width  = 1,
  border_color  = 0x40cba6f7,
  shadow     = { drawing = true, color = 0x60cba6f7, blur = 30 },
  position   = "top",
  sticky     = true,
  padding_right = 0,
  padding_left  = 0,
  y_offset   = 0,
  margin     = 0,
  blur_radius   = 60,
  corner_radius = 0,
})
