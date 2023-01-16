local catpuccin = require "catppuccin"
local mocha = require("catppuccin.palettes").get_palette "mocha"

catpuccin.setup {
  flavour = "mocha",
  no_italic = true,
  highlight_overrides = {
    mocha = {
      Folded = { fg = mocha.blue, bg = mocha.mantle },
      VertSplit = { fg = mocha.surface0, bg = mocha.base },
    },
  },
}

vim.cmd.colorscheme "catppuccin"
