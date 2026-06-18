-- Remove 1px border around hyprshot screenshots
hl.layer_rule({
  name = "hyprshot",
  match = { namespace = "selection" },
  no_anim = true,
})
