local colors = require("colors")

function menubar_section(items)
  sbar.add("bracket", items, {
    background = {
      color        = colors.bar.bg,
      corner_radius = 20,
      height       = 35,
      border_width = 1,
      border_color = colors.bar.border,
    },
  })
end

return {}
