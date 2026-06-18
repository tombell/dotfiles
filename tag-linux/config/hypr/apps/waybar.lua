-- Blur the transparant waybar
hl.layer_rule({
  name = "waybar-transparency",
  match = { namespace = "waybar" },
  blur = true,
})
