local catpuccin = require "catppuccin"
local mocha = require("catppuccin.palettes").get_palette "mocha"

vim.g.catppuccin_flavour = "mocha"

catpuccin.setup {
  highlight_overrides = {
    mocha = {
      TelescopeBorder = { fg = mocha.surface2 },
      Todo = { fg = mocha.yellow, bg = mocha.base, style = { "italic" } },
      VertSplit = { fg = mocha.surface1 },
      commentTSDanger = { fg = mocha.red, bg = mocha.base, style = { "italic" } },
      commentTSNote = { fg = mocha.blue, bg = mocha.base, style = { "italic" } },
      commentTSWarning = { fg = mocha.yellow, bg = mocha.base, style = { "italic" } },
    },
  },
}

vim.cmd [[colorscheme catppuccin]]
