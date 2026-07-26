-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 4,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = {
                colors = { NEON_PINK, NEON_PURPLE, NEON_BLUE, NEON_CYAN, NEON_GREEN, NEON_YELLOW, NEON_RED },
                angle = 0,
            },
            inactive_border = CACHYGRAY,
        },
    },
    group = {
        col = {
            border_active = NEON_CYAN,
            border_inactive = CACHYGRAY,
            border_locked_active = NEON_PURPLE,
            border_locked_inactive = CACHYGRAY,
        },
        groupbar = {
            col = {
                active = NEON_GREEN,
                inactive = CACHYGRAY,
                locked_active = NEON_PURPLE,
                locked_inactive = CACHYGRAY,
            },
        },
    },
    decoration = {
        dim_special = 0.3,
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1,
        blur = {
            size = 5,
            passes = 4,
            special = true,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 1,
            color = "rgba(ff006e22)",
            color_inactive = "rgba(00000000)",
        },
    },
})
