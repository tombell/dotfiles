local screenshot = "hyprshot"

hl.bind("ALT + SHIFT + 3", hl.dsp.exec_cmd(screenshot .. " -m output -m eDP-1"), { description = "Screenshot of display" })
hl.bind("ALT + SHIFT + 4", hl.dsp.exec_cmd(screenshot .. " -m window"), { description = "Screenshot of window" })
hl.bind("ALT + SHIFT + 5", hl.dsp.exec_cmd(screenshot .. " -m region"), { description = "Screenshot of region" })
