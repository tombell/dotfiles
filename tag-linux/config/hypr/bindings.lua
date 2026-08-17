local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd "uwsm app -- ghostty", { description = "Terminal" })
hl.bind(
  mainMod .. " + SPACE",
  hl.dsp.exec_cmd "qs ipc call launcher toggle",
  { description = "Launcher" }
)
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd "uwsm app -- 1password", { description = "Passwords" })

-- TODO: app shortcuts

-- TODO: web app shortcuts
