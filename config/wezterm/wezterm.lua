local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.font = wezterm.font("Iosevka NFM", { weight = "Bold", italic = false })
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = { left = 30, right = 30, top = 30, bottom = 30 }
config.window_close_confirmation = "NeverPrompt"

return config
