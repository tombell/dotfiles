local catpuccin = require "catppuccin"
local mocha = require("catppuccin.palettes").get_palette "mocha"

vim.g.catppuccin_flavour = "mocha"

catpuccin.setup {
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin",
  },
  highlight_overrides = {
    mocha = {
      VertSplit = { fg = mocha.surface0 },
      commentTSDanger = { fg = mocha.red, bg = mocha.base },
      commentTSNote = { fg = mocha.blue, bg = mocha.base },
      commentTSWarning = { fg = mocha.yellow, bg = mocha.base },
    },
  },
}

vim.cmd [[colorscheme catppuccin]]
