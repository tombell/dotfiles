-- Blur the transparent Quickshell bar
hl.layer_rule {
  name = "quickshell-transparency",
  match = { namespace = "quickshell-bar" },
  blur = true,
}
