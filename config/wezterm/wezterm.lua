local wezterm = require "wezterm"

local function recompute_padding(window)
  local window_dims = window:get_dimensions()
  local factor = 144 / window_dims.dpi
  local padding = 36 / factor

  local overrides = window:get_config_overrides() or {}

  overrides.window_padding = { left = padding, right = padding, top = padding, bottom = padding }

  window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window)
  recompute_padding(window)
end)

wezterm.on("window-config-reloaded", function(window)
  recompute_padding(window)
end)

local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.font = wezterm.font("Iosevka NFM", { weight = "Bold" })
config.font_size = 12
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

config.keys = {
  {
    key = "k",
    mods = "SUPER",
    action = wezterm.action.SendKey { key = "l", mods = "CTRL" },
  },
  {
    key = "3",
    mods = "META",
    action = wezterm.action.SendKey { key = "#" },
  },
}

return config
