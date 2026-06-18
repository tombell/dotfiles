-- Browser types
hl.window_rule({
  name = "chromium-based",
  match = { class = "([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable)" },
  tag = "+chromium-based-browser",
})

hl.window_rule({
  name = "firefox-based",
  match = { class = "([fF]irefox|zen|librewolf)" },
  tag = "+firefox-based-browser",
})

-- Force chromium-based browsers into a tile to deal with --app bug
hl.window_rule({
  name = "chromium-based-tile",
  match = { tag = "chromium-based-browser" },
  tile = true,
})
