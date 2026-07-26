local LAPTOP = "eDP-1"

local function has_external_monitor()
    for _, m in ipairs(hl.get_monitors()) do
        if not m.name:match("^eDP") then
            return true
        end
    end
    return false
end

local function is_laptop_disabled()
    local m = hl.get_monitor(LAPTOP)
    return m and not m.dpms_status
end

local function refresh_ui()
    hl.exec_cmd("bash -c 'sleep 0.5 && noctalia msg config-reload'")
end

-- Lid close: disable laptop screen if external monitor is connected
hl.bind("switch:on:Lid Switch", function()
    if has_external_monitor() then
        hl.monitor({ output = LAPTOP, disabled = true })
        refresh_ui()
    end
end, { locked = true })

-- Lid open: re-enable laptop screen
hl.bind("switch:off:Lid Switch", function()
    hl.monitor({ output = LAPTOP, disabled = false })
    refresh_ui()
end, { locked = true })

-- External monitor removed: re-enable laptop screen if it was disabled
hl.on("monitor.removed", function(monitor)
    if not monitor.name:match("^eDP") and is_laptop_disabled() then
        hl.monitor({ output = LAPTOP, disabled = false })
        refresh_ui()
    end
end)
