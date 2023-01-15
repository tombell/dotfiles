local catpuccin = require "catppuccin"
local mocha = require("catppuccin.palettes").get_palette "mocha"

vim.g.catppuccin_flavour = "mocha"

catpuccin.setup {
  no_italic = true,
  highlight_overrides = {
    mocha = {
      Todo = { fg = mocha.yellow, bg = mocha.base },
      VertSplit = { fg = mocha.surface0, bg = mocha.base },
      commentTSDanger = { fg = mocha.red, bg = mocha.base },
      commentTSNote = { fg = mocha.blue, bg = mocha.base },
      commentTSWarning = { fg = mocha.yellow, bg = mocha.base },
    },
  },
}

vim.cmd [[colorscheme catppuccin]]
