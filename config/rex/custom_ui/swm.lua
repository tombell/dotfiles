-- swm: picker of real swm CLI commands; swm_reload is a one-shot version.
--
-- Every command below exists in github.com/starkwm/swm (checked against main at 56e2054):
--   docs/cli.md           swm reload [--config <path>]; swm display / window / space / config /
--                         rule / signal / query domains
--   docs/configuration.md swm config layout <float|master|monocle|dwindle>  (+ --space current),
--                         swm config gap [--space current] <points|+n|-n>,
--                         swm config focus-follows-mouse <off|autofocus|autoraise>
--   docs/windows.md       swm window float [--window <id|recent>] <on|off|toggle>
--   docs/displays.md      swm display focus <next|prev|first|last|recent|mouse|left|right|up|down|n>
--   docs/spaces.md        swm space activate <space-index>; swm query spaces
--   docs/query.md         swm query windows (JSON: id, app, title, space, is-minimized, ...)
--   Sources/Swm/WindowCommand.swift  swm window focus <left|right|up|down|next|prev|recent|master|window-id>

local util = require("custom_ui.util")

local function swm(argv, opts)
  local full = { "swm" }
  for _, a in ipairs(argv) do full[#full + 1] = a end
  local r, err = util.exec(full, { timeout = (opts and opts.timeout) or 10 })
  if r == nil then error("couldn't run swm: " .. tostring(err), 0) end
  if not r.ok then
    local msg = util.trim(r.stderr)
    if msg == "" then msg = util.trim(r.stdout) end
    if msg == "" then msg = "exit " .. tostring(r.code) end
    util.report("error", "swm " .. argv[1], util.first_line(msg))
    error("swm " .. table.concat(argv, " ") .. ": " .. msg, 0)
  end
  return util.trim(r.stdout)
end

local function pick_value(title, values, icon)
  local items = {}
  for _, v in ipairs(values) do items[#items + 1] = { id = v, title = v, icon = icon } end
  local v, why = rex.ui.pick{ title = title, items = items }
  if v == nil then return nil, why end
  return v
end

local SWM_ITEMS = {
  { id = "reload", title = "Reload configuration", subtitle = "swm reload", icon = "gear",
    run = function()
      swm({ "reload" }, { timeout = 25 })
      util.report("info", "swm", "configuration reloaded")
    end },
  { id = "layout", title = "Set layout (current Space)…", subtitle = "swm config layout --space current <layout>",
    icon = "gear",
    run = function()
      local v, why = pick_value("Layout for current Space", { "dwindle", "master", "monocle", "float" }, "gear")
      if v == nil then return util.bail("swm", why) end
      swm({ "config", "layout", "--space", "current", v })
      util.report("info", "swm", "layout: " .. v)
    end },
  { id = "float_toggle", title = "Toggle floating (focused window)", subtitle = "swm window float toggle",
    icon = "gear",
    run = function() swm({ "window", "float", "toggle" }) end },
  { id = "gap_up", title = "Gap +2 (current Space)", subtitle = "swm config gap --space current +2",
    icon = "plus",
    run = function() swm({ "config", "gap", "--space", "current", "+2" }) end },
  { id = "gap_down", title = "Gap −2 (current Space)", subtitle = "swm config gap --space current -2",
    icon = "gear",
    run = function() swm({ "config", "gap", "--space", "current", "-2" }) end },
  { id = "ffm", title = "Focus follows mouse…", subtitle = "swm config focus-follows-mouse <mode>", icon = "gear",
    run = function()
      local v, why = pick_value("Focus follows mouse", { "off", "autofocus", "autoraise" }, "gear")
      if v == nil then return util.bail("swm", why) end
      swm({ "config", "focus-follows-mouse", v })
    end },
  { id = "display_next", title = "Focus next display", subtitle = "swm display focus next", icon = "globe",
    run = function() swm({ "display", "focus", "next" }) end },
  { id = "display_prev", title = "Focus previous display", subtitle = "swm display focus prev", icon = "globe",
    run = function() swm({ "display", "focus", "prev" }) end },
  { id = "space", title = "Activate Space…", subtitle = "swm query spaces → swm space activate N", icon = "globe",
    run = function()
      local spaces, err = rex.json.decode(swm({ "query", "spaces" }))
      if type(spaces) ~= "table" then error("couldn't read swm query spaces: " .. tostring(err), 0) end
      local items = {}
      for _, s in ipairs(spaces) do
        local n = #(s.windows or {})
        items[#items + 1] = {
          id = tostring(s.index), title = "Space " .. tostring(s.index),
          subtitle = tostring(s.type or ""), icon = "globe",
          detail = n .. " window" .. (n == 1 and "" or "s") .. ((s["has-focus"] and "  (current)") or ""),
        }
      end
      local v, why = rex.ui.pick{ title = "Activate Space", items = items }
      if v == nil then return util.bail("swm", why) end
      swm({ "space", "activate", v })
    end },
  { id = "window", title = "Focus window…", subtitle = "swm query windows → swm window focus ID", icon = "terminal",
    run = function()
      local wins, err = rex.json.decode(swm({ "query", "windows" }))
      if type(wins) ~= "table" then error("couldn't read swm query windows: " .. tostring(err), 0) end
      local items = {}
      for _, w in ipairs(wins) do
        if w.app and w["is-minimized"] ~= true then
          local title = (type(w.title) == "string" and w.title ~= "") and w.title or w.app
          items[#items + 1] = {
            id = tostring(w.id), title = title, subtitle = w.app, icon = "terminal",
            detail = w.space and ("Space " .. tostring(w.space)) or nil,
          }
        end
      end
      local v, why = rex.ui.pick{ title = "Focus window", placeholder = "Filter windows", items = items }
      if v == nil then return util.bail("swm", why) end
      swm({ "window", "focus", v })
    end },
}

rex.action{
  name = "swm", title = "swm: Commands…",
  description = "Pick from useful swm CLI commands (reload, layout, float, gap, displays, Spaces, windows).",
  category = "Tom", keywords = "swm window manager reload layout tiling",
  run = function(ctx, args)
    local items, by_id = {}, {}
    for _, it in ipairs(SWM_ITEMS) do
      items[#items + 1] = { id = it.id, title = it.title, subtitle = it.subtitle, icon = it.icon }
      by_id[it.id] = it
    end
    local id, why = rex.ui.pick{ title = "swm", placeholder = "Filter commands", items = items }
    if id == nil then return util.bail("swm", why) end
    -- Called directly (not via pcall) so nested rex.ui prompts keep working.
    by_id[id].run()
  end,
}

rex.action{
  name = "swm_reload", title = "swm: Reload Configuration",
  description = "Runs `swm reload` (all-or-nothing for rules and signals).",
  category = "Tom", keywords = "swm reload config",
  run = function() SWM_ITEMS[1].run() end,
}
