-- stylua: ignore start
hl.bind("SUPER + W", hl.dsp.window.close(), { description = "Close active window" })

hl.bind("SUPER + F", hl.dsp.window.fullscreen { mode = 1 }, { description = "Toggle fullscreen" })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen { mode = 0 }, { description = "Toggle force fullscreen" })
hl.bind("SUPER + J", hl.dsp.layout "togglesplit", { description = "Toggle split" })
hl.bind("SUPER + V", hl.dsp.window.float { action = "toggle" }, { description = "Toggle floating" })

hl.bind("SUPER + left", hl.dsp.focus { direction = "left" }, { description = "Move window focus left" })
hl.bind("SUPER + down", hl.dsp.focus { direction = "down" }, { description = "Move window focus down" })
hl.bind("SUPER + up", hl.dsp.focus { direction = "up" }, { description = "Move window focus up" })
hl.bind("SUPER + right", hl.dsp.focus { direction = "right" }, { description = "Move window focus right" })

for i = 1, 10 do
  local key = i % 10
  hl.bind("SUPER + " .. key, hl.dsp.focus { workspace = i }, { description = "Switch to workspace " .. i })
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move { workspace = i }, { description = "Move window to workspace " .. i })
end

hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap { direction = "left" }, { description = "Swap window to the left" })
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap { direction = "down" }, { description = "Swap window down" })
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap { direction = "up" }, { description = "Swap window up" })
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap { direction = "right" }, { description = "Swap window to the right" })

hl.bind("SUPER + TAB", hl.dsp.window.cycle_next(), { description = "Cycle to the next window" })
hl.bind("SUPER + TAB", hl.dsp.window.bring_to_top(), { description = "Raise active window to the top" })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
-- stylua: ignore end
