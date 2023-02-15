local catpuccin = require "catppuccin"

catpuccin.setup {
  no_italic = true,
  highlight_overrides = {
    mocha = function(mocha)
      return {
        Folded = { fg = mocha.blue, bg = mocha.mantle },
        VertSplit = { fg = mocha.surface0, bg = mocha.base },
      }
    end,
  },
}

vim.cmd.colorscheme "catppuccin"
