local osd = "qs ipc call osd"

-- stylua: ignore start
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(osd .. " outputMute"), { description = "Toggle mute", locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(osd .. " outputLower"), { description = "Decrease volume", locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(osd .. " outputRaise"), { description = "Increase volume", locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(osd .. " inputMute"), { description = "Toggle mic mute", locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osd .. " brightnessLower"), { description = "Decrease brightness", locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osd .. " brightnessRaise"), { description = "Increase brightness", locked = true, repeating = true })
-- stylua: ignore end
