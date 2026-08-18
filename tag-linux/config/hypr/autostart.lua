hl.on("hyprland.start", function()
  hl.exec_cmd "uwsm app -- qs --no-duplicate"
  hl.exec_cmd "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
end)
