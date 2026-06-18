local osdclient = "swayosd-client --monitor \"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')\""

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"), { description = "Toggle mute", locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume lower"), { description = "Decrease volume", locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume raise"), { description = "Increase volume", locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(osdclient .. " --input-volume mute-toggle"), { description = "Toggle mic mute", locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. " --brightness lower"), { description = "Decrease brightness", locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. " --brightness raise"), { description = "Increase brightness", locked = true })
