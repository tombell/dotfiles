local catpuccin = require "catppuccin"

vim.g.catppuccin_flavour = "mocha"

catpuccin.setup()

vim.cmd [[colorscheme catppuccin]]

vim.cmd [[highlight VertSplit guifg=#302D41]]
