-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
  name = "ignore-maximize-windows",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name = "fix-dragging-xwayland",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

-- App-specific tweaks
require("apps.1password")
require("apps.browser")
require("apps.hyprshot")
require("apps.pip")
require("apps.system")
require("apps.waybar")
