-- Floating windows
hl.window_rule({
  name = "floating-windows",
  match = { tag = "floating-window" },
  float = true,
  center = true,
  size = "800 600",
})

hl.window_rule({
  name = "tui-apps",
  match = { class = "(tlpui|dev.tombell.wiremix|dev.tombell.bluetui|dev.tombell.impala)" },
  tag = "+floating-window",
})

hl.window_rule({
  name = "gui-apps",
  match = { class = "(xdg-desktop-portal-gtk|org.gnome.Nautilus|org.gnome.NautilusPreviewer)" },
  tag = "+floating-window",
})
